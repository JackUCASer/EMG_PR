%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.24

%%  Description:
%   function: EMG4 数据分段，找到对应的动作起点和结束点
%   data:输入数据
%   Fs:采样率
%   numAction：该段数据有效动作数 
%   returnData:返回分段坐标
function returnData = EMG4RES4Get_Action_Point(data,Fs,numAction)
    [m n] = size(data);         % 读取data结构，m 通道，n 单通道样本数
    m = m-2;                    % 最后一个通道为maker,倒数第二个为时间
    returnData = zeros(1,2*numAction+1);
    diff_Temp_Data = zeros(1,n-1);
    m = 4;
    for i=1:m
       a=abs(diff(data(i,:)));
       diff_Temp_Data=diff_Temp_Data+a;
    end
    c = mean(diff_Temp_Data);
    % 滤波器参数和阈值参数：可修改
    mean_threshold = 1.0;                   % 阈值设置为均值的1.0倍
    coordinates_jump = 2000;                % 坐标跳跃值设置，用于分段得到肌电所处区间,这个还得视采样率和持续时间设置
    PassbandFrequency = 20;                 % 低通滤波取包络的通带频率 
    StopbandFrequency = 30;                 % 低通滤波取包络的阻带频率
     % 零相位低通FIR滤波器
    wf = PassbandFrequency*2/Fs;
    ws = StopbandFrequency*2/Fs;
    lpFilt = designfilt('lowpassfir','PassbandFrequency',wf, ...
         'StopbandFrequency',ws,'PassbandRipple',0.1, ...
         'StopbandAttenuation',65,'DesignMethod','kaiserwin');
    e = filtfilt(lpFilt,diff_Temp_Data);
    f=smooth(e,50);                         % 平滑
    g(:,1) = find(f> mean_threshold*c );    % 获取所有大于mean_threshold倍均值的数据
    g(2:end,2)=diff(g(:,1));
    h = find(g(:,2)>coordinates_jump);      % 找到坐标跳跃值大于阈值的地方
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
            returnData2(2*cnt1-1) = returnData1(2*cnt-1);
            returnData2(2*cnt1) = returnData1(2*cnt);
        end   
    end
    %% 画图，可屏蔽:displayFlag==1， 画出分割图；displayFlag==0， 屏蔽；
    displayFlag = 0;
    if displayFlag
        [m n] = size(data(1:4,:));
        maxdata = max(max(data(1:4,:)));
        figure;
        for cnt = 1:m
            plot(data(cnt,:)+(cnt-1)*maxdata);
            hold on;
        end
        for cnt = 1: cnt1
            plot([returnData2(2*cnt-1),returnData2(2*cnt-1)],[-maxdata,(m)*maxdata],'Linewidth',3);
            hold on;
            plot([returnData2(2*cnt),returnData2(2*cnt)],[-maxdata,(m)*maxdata],'Linewidth',3);
            hold on;
        end
        pause(1);
    end
    %% finally
    returnData(1) = 200;
    returnData(2:end) = returnData2;
end