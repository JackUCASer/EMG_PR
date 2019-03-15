%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.19

%%  Description:
%   function: TMSi数据预处理：重新采样-> 去坏点（平滑） -> 对时间和动作下采样
%   data: 待预处理的数据
%   Sampling_Rate： 采样率，根据
%   ChsChoice：需要处理的通道
%   downFs:下采样所选择的频率，一般为Sampling_Rate的1/2，1/4，1/5等
%   returnData: 返回预处理后的数据；
function Pre_Data=TMSiData_Pre_Proc(data,Sampling_Rate,ChsChoice,downFs)
    if (nargin == 3)                        
        downFs = Sampling_Rate;     % 不需要降采样
    end
    if isempty(ChsChoice)==1                            
        ChsChoice = 1:1:size(data,1);
    end  
    Temp_Data  = data(ChsChoice,:);  
    %% 添加滤波器位置
    % 线性相位滤波器延迟：设滤波器阶数为N，对采样点的延迟就是N/2，N为偶数；或者(N-1)/2，N为奇数；
    %  肌电滤波  
    fs2 = 20;   fp2 = 30;           % 阻带上截至频率和通带上截至频率
    fp1 = 400;  fs1 = 500;          % 通带下截止频率和阻带下截至频率
    %  归一化角频率,单位：pi*rad/s
    ws2=fs2*2/Sampling_Rate; wp2=fp2*2/Sampling_Rate;% 阻带上截至频率和通带上截至频率
    wp1=fp1*2/Sampling_Rate; ws1=fs1*2/Sampling_Rate;% 通带下截止频率和阻带下截至频率
    %计算滤波器系数
    wc2=(ws2+wp2)/2; wc1=(ws1+wp1)/2;
    wp=[wc2,wc1];
    n_filter = 200;                                   % 阶数设置成200，那么滤完波后，原始数据应该剔除前n_filter/2个点。
    b=fir1(n_filter,wp,'bandpass');     
    freqz(b,1,512);                                   % 查看幅频响应，方便修改阶数和其它参数
    newdata=filter(b,1,Temp_Data(:,:)')';  
    
    colStart = n_filter/2+1;                          % 原始数据应该剔除前n_filter/2个点。
    newdata = newdata(:,colStart:end);
    %% 
    Temp1_Data=(resample(newdata',downFs,Sampling_Rate))';           
    Pre_Data=Temp1_Data;
end