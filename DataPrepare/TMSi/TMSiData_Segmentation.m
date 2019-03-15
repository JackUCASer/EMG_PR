%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.19

%%  Description:
%   function: TMSi 数据分段，找到对应的动作起点和结束点，消除由于人反应时间造成的延迟
%                  首先找到系统动作时间，然后根据各通道数据微分绝对值的和找到动作起始点
%   data: 待分段的数据
%   downFs：现在数据所用采样率（考虑到前面可能被降采样）
%   numAction: 动作数，需要说明的是实际测量时休息数比动作数多1，但是我们取休息书等于动作数
%   Train_Act_Data,Train_Rest_Data: 返回分段后的动作数据、静息数据；  
%%
 function [Train_Act_Data,Train_Rest_Data]=TMSiData_Segmentation(data,downFs,numAction)
    % 对于TMSi,data 每个元胞只是一个动作（重复三次），需要修改分割
    len_data = length(data);
    if numAction == len_data               % 如果动作个数与数据类别数相等，那么数据全得分割，因为全是动作数据
       for c=1:len_data     
           Temp_Data=data{c};
           % 取得起始动作起始点位置
           Act_Point = Get_EMG_Action_Point(Temp_Data,downFs);
           % 分割动作数据
           len_Act_Point = length(Act_Point)/2;                          % 分了几段
           for cnt = 1:len_Act_Point
               Train_Act_Data{cnt,c} = Temp_Data(:,Act_Point(2*cnt-1):Act_Point(2*cnt));
           end
       end
    else                                   % 如果动作个数与数据类别数不相等，那么除了静息，其余全得分割
       for c=2:len_data 
           Temp_Data=data{c};
           % 取得起始动作起始点位置
           Act_Point = Get_EMG_Action_Point(Temp_Data,downFs);
           % 分割动作数据
           len_Act_Point = length(Act_Point)/2;                          % 分了几段
           for cnt = 1:len_Act_Point
               Train_Act_Data{cnt,c-1} = Temp_Data(:,Act_Point(2*cnt-1):Act_Point(2*cnt));
           end
           % 分割休息数据
           Rest_Data=data{1};
           vec = 0:1:len_Act_Point;                                      % 多少组动作就多少组休息
           len_rest = length(Rest_Data);
           vec = round(vec*len_rest/len_Act_Point);
           for cnt = 1:len_Act_Point
               Train_Rest_Data{cnt,c-1} = Rest_Data(:,1+vec(cnt):vec(cnt+1));
           end
        end
    end
 end