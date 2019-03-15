%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.19

%%  Description:
%   function: EMG4RES4数据预处理
%   data: 待处理的数据
%   ChsChoice：需要处理的通道
%   fs: 原始数据采样率
%   downFs: 降采样率
%   numAction: 动作数，需要说明的是实际测量时休息数比动作数多1，但是我们取休息书等于动作数
%   returnData: 返回预处理后的数据；
%               元胞(cell)形式，第一行为受试者名称，第二行为 组数*numAction 个动作数据，第三行为 组数*numAction个 休息数据
%                 sub_x
%              组数*numAction  动作
%              组数*numAction  休息
function returnData = EMG4RES4data_preprocess(data,ChsChoice,fs,downFs,numAction)
    %% 数据预处理：重新采样-> 去坏点（平滑） -> 对时间和动作下采样
    [m n] = size(data);     % 获取数据结构，对与该设备，第一行为受试者，第二行为受试者的几组动作
    for cnt1 = 1:n          % 列遍历
        [m2 n2] = size(data{2,cnt1});                           % 获取受试者动作组数n2
        Pre_Data{1,cnt1} = data{1,cnt1};                        % 受试者不变
        for cnt2 = 1:n2
           if isempty(data{2,cnt1}{1,cnt2}) ~=1
                Pre_Data{2,cnt1}{1,cnt2} = EMG4RES4Data_Pre_Proc(data{2,cnt1}{1,cnt2},fs,downFs);  
           end
        end   
    end
    %% 数据分段，把每组每个动作分割出来
    [m n] = size(Pre_Data);     % 获取数据结构，对与该设备，第一行为受试者，第二行为受试者的几组动作
    dataSeg = cell(3,n);
    for cnt1 = 1:n          % 列遍历
        dataSeg{1,cnt1} = Pre_Data{1,cnt1};
        [dataSeg{2,cnt1},dataSeg{3,cnt1}] = EMG4RES4Data_Segmentation(Pre_Data{2,cnt1},downFs,numAction,ChsChoice);  % 一下子送进去好几组
    end
    returnData = dataSeg;
end