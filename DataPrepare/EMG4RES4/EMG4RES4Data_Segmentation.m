%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.19

%%  Description:
%   function: EMG4RES4 数据分段，找到对应的动作起点和结束点，消除由于人反应时间造成的延迟
%                  首先找到系统动作时间，然后根据各通道数据微分绝对值的和找到动作起始点
%   data: 待分段的数据
%   downFs：现在数据所用采样率（考虑到前面可能被降采样）
%   numAction: 动作数，需要说明的是实际测量时休息数比动作数多1，但是我们取休息书等于动作数
%   Train_Act_Data,Train_Rest_Data: 返回分段后的动作数据、静息数据；  
%%
 function [Train_Act_Data,Train_Rest_Data]=EMG4RES4Data_Segmentation(data,downFs,numAction,ChsChoice)
    if isempty(ChsChoice)
        ChsChoice = 1:1:8;
    end
    len_data = length(data);
    Train_Act_Data=cell(len_data,numAction);
    Train_Rest_Data=cell(len_data,numAction);
         
    for c=1: len_data      
       Temp_Data=data{c};

       % 取得起始动作起始点位置
       Act_Point=EMG4RES4Get_Action_Point(Temp_Data,downFs,numAction);           % 在此函数中修改利用哪几个通道提取肌电分割点

       for i=1:numAction
%           Act_Num=Temp_Data(end,Act_Point(2*i)+1000);                            % 动作序号,+1000防止动作提前做
          Act_Num = i;
          Train_Act_Data{c,Act_Num}=[Train_Act_Data{c,Act_Num},Temp_Data(ChsChoice,Act_Point(2*i):Act_Point(2*i+1))]; %动作数据
          Train_Rest_Data{c,Act_Num}=[Train_Rest_Data{c,Act_Num},Temp_Data(ChsChoice,Act_Point(2*i-1):Act_Point(2*i))];%休息数据
       end
    end
 end