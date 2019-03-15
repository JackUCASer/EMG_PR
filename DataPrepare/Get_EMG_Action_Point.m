%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.24

%%  Description: 适用于 TMSi 和 Delsys
%   function: EMG 数据分段，找到对应的动作起点和结束点
%   mean_threshold: 待分段的数据
%   coordinates_jump：现在数据所用采样率（考虑到前面可能被降采样）
%   wf: 动作数，需要说明的是实际测量时休息数比动作数多1，但是我们取休息书等于动作数
%   ws: 
%   returnData:返回分段坐标
function returnData = Get_EMG_Action_Point(data,Fs,mean_threshold,coordinates_jump,PassbandFrequency,StopbandFrequency)
    close all;
    if (nargin == 2)
        mean_threshold = 1.5;                   % 阈值设置为均值的1.5倍
        coordinates_jump = 2000;                % 坐标跳跃值设置，用于分段得到肌电所处区间,这个还得视采样率和持续时间设置
        PassbandFrequency = 20;                 % 低通滤波取包络的通带频率 
        StopbandFrequency = 30;                 % 低通滤波取包络的阻带频率
    end
    %% 观察数据：时域差分 -- 绝对值 -- 均值线
    a = diff(data(1,:));                %% 这里选择一通道选择数据分割点，实际可以观察后再选择一个更好的通道
%     figure(1);subplot(311);plot(a);                   % 画出原始波形
    b = abs(a);
%     subplot(312);plot(b);                             % 画出绝对值波形
%     hold on; 
    c = mean(b);d=c*ones(1,length(a));
%     plot(d);                                          % 画出均值线

    %% 取包络：画包络 -- 找到>0.8*均值线的点 -- 自差分 -- 找到差分点>2000的点的位置 -- 提取分割点
    % 零相位低通FIR滤波器
    wf = PassbandFrequency*2/Fs;
    ws = StopbandFrequency*2/Fs;
    lpFilt = designfilt('lowpassfir','PassbandFrequency',wf, ...
         'StopbandFrequency',ws,'PassbandRipple',0.1, ...
         'StopbandAttenuation',65,'DesignMethod','kaiserwin');
    e = filtfilt(lpFilt,b');
%     subplot(313);plot(e);ylim([min(e),max(e)]);hold on;plot(d);      % 画出滤波后的波形
    f=smooth(e,50);
%     hold on;plot(f);
    g(:,1) = find(e> mean_threshold*c );                        % 获取所有大于mean_threshold倍均值的数据
    g(2:end,2)=diff(g(:,1));
    h = find(g(:,2)>coordinates_jump);                          % 找到坐标跳跃值大于阈值的地方
%     figure(2);
%     plot(g(:,2));
%% 获取分段点: 若果
                  % len_h == 2，那么可以得到3个区间,6个点
                  % len_h == 3，那么可以得到4个区间,8个点
                  % len_h == 4，那么可以得到5个区间,10个点；
    len_h = length(h);
    returnData1 = zeros(1,2*(len_h));
    for cnt = 1:len_h+1
        if cnt==1               % 如果是第一个
            returnData1(2*cnt-1) = g(1,1);
            returnData1(2*cnt)   = g(h(cnt)-1,1);
        elseif cnt==len_h+1     % 如果是最后一个
            returnData1(2*cnt-1) = g(h(cnt-1),1);
            returnData1(2*cnt)   = g(end,1);
        else                    % 其他点
            returnData1(2*cnt-1) = g(h(cnt-1),1);
            returnData1(2*cnt)   = g(h(cnt)-1,1);
        end
    end
    %% 消除干扰点
    cnt1 = 0;
    for cnt = 1:len_h+1
        if returnData1(2*cnt)-returnData1(2*cnt-1) > 0.1*Fs            % 设置一个间隔阈值,0.1*Fs
            cnt1 = cnt1 +1;
            returnData(2*cnt1-1) = returnData1(2*cnt-1);
            returnData(2*cnt1) = returnData1(2*cnt);
        end   
    end 
    %% 画图
    [m n] = size(data);
    maxdata = max(max(data));
    figure;
    for cnt = 1:m
        plot(data(cnt,:)+(cnt-1)*maxdata);
        hold on;
    end
    len_returnData = length(returnData);
    for cnt = 1: cnt1
        plot([returnData(2*cnt-1),returnData(2*cnt-1)],[-maxdata,(m)*maxdata],'Linewidth',3);
        hold on;
        plot([returnData(2*cnt),returnData(2*cnt)],[-maxdata,(m)*maxdata],'Linewidth',3);
        hold on;
    end
    pause(2);
end