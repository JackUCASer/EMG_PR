%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.03.14

%%  Description:
%   function: �����������뾲Ϣ����ƴ����һ�𣬶�����ǩ�뾲Ϣ��ǩƴ����һ��
%   TrainData: ��ѵ�����������ݣ�������Ϣ�Ͷ���,�����˵�����
%   Action_Selected: ѡ��Ķ���
%   returnData: ����Ԥ���������ݣ� 
%%
function [allTDCoef,targetClass,Real_Class] = preprocessClassify(data)
    allTDCoef=[];               % ����
    targetClass=[];
    Action_Selected = size(data{2,1},2);
    j=1;
    for i=1:Action_Selected                                         % ѡ���Ķ�����
        allTDCoef=[allTDCoef;data{2,1}{1,i}']; % ��ÿ�������������1�У���������
        L=length(data{2,1}{1,i});
        Train_Act_Label_Slected{2,1}{1,i}(1:L)=j;
        targetClass=[targetClass Train_Act_Label_Slected{2,1}{1,i}]; % ��ǩ��������
        j=j+1;
    end
    for i=1:Action_Selected                                         % ��Ӧ����Ϣ��
        allTDCoef=[allTDCoef;data{4,1}{1,i}']; % ��ÿ�������������1�У���������
        L=length(data{4,1}{1,i});
        Train_Rest_Label_Slected{4,1}{1,i}(1:L)=j;
        targetClass=[targetClass Train_Rest_Label_Slected{4,1}{1,i}];% ��ǩ��������
    end
    Real_Class = j;
end