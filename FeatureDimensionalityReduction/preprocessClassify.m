%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.03.14

%%  Description:
%   function: 将动作数据与静息数据拼接在一起，动作标签与静息标签拼接在一起
%   TrainData: 待训练的特征数据，包含静息和动作,单个人的数据
%   Action_Selected: 选择的动作
%   returnData: 返回预处理后的数据； 
%%
function [allTDCoef,targetClass,Real_Class] = preprocessClassify(data)
    allTDCoef=[];               % 所有
    targetClass=[];
    Action_Selected = size(data{2,1},2);
    j=1;
    for i=1:Action_Selected                                         % 选定的动作类
        allTDCoef=[allTDCoef;data{2,1}{1,i}']; % 将每个窗的特征变成1行，按列排列
        L=length(data{2,1}{1,i});
        Train_Act_Label_Slected{2,1}{1,i}(1:L)=j;
        targetClass=[targetClass Train_Act_Label_Slected{2,1}{1,i}]; % 标签按行排列
        j=j+1;
    end
    for i=1:Action_Selected                                         % 对应的休息类
        allTDCoef=[allTDCoef;data{4,1}{1,i}']; % 将每个窗的特征变成1行，按列排列
        L=length(data{4,1}{1,i});
        Train_Rest_Label_Slected{4,1}{1,i}(1:L)=j;
        targetClass=[targetClass Train_Rest_Label_Slected{4,1}{1,i}];% 标签按行排列
    end
    Real_Class = j;
end