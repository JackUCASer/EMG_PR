%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.20

%%  Description:
%   function: 训练数据
%   TrainData: 待训练的特征数据，包含静息和动作
%   Action_Selected: 选择的动作
%   returnData: 返回预处理后的数据； 元胞(cell)形式
%                                       sub_x
%                                    ConfusionMatrix
%                                     aveLDATestAcc
%%
function returnData = data_train(allTDCoef,targetClass,Real_Class)
     %------------------------------------离线训练-------------------------------------
     [aveLDATestErr,aveLDATestAcc,ConfusionMatrix,Wg,Cg] = TrainLDA(allTDCoef,targetClass,Real_Class);
     returnData{1,1} = 'aveLDATestErr';
     returnData{2,1} = aveLDATestErr;
     returnData{3,1} = 'ConfusionMatrix';
     returnData{4,1} = ConfusionMatrix;
     returnData{5,1} = 'aveLDATestAcc';
     returnData{6,1} = aveLDATestAcc;
end