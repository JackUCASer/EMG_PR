%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.19

%%  Description:
%   function: EMG4RES4 ���ݷֶΣ��ҵ���Ӧ�Ķ������ͽ����㣬���������˷�Ӧʱ����ɵ��ӳ�
%                  �����ҵ�ϵͳ����ʱ�䣬Ȼ����ݸ�ͨ������΢�־���ֵ�ĺ��ҵ�������ʼ��
%   data: ���ֶε�����
%   downFs�������������ò����ʣ����ǵ�ǰ����ܱ���������
%   numAction: ����������Ҫ˵������ʵ�ʲ���ʱ��Ϣ���ȶ�������1����������ȡ��Ϣ����ڶ�����
%   Train_Act_Data,Train_Rest_Data: ���طֶκ�Ķ������ݡ���Ϣ���ݣ�  
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

       % ȡ����ʼ������ʼ��λ��
       Act_Point=EMG4RES4Get_Action_Point(Temp_Data,downFs,numAction);           % �ڴ˺������޸������ļ���ͨ����ȡ����ָ��

       for i=1:numAction
%           Act_Num=Temp_Data(end,Act_Point(2*i)+1000);                            % �������,+1000��ֹ������ǰ��
          Act_Num = i;
          Train_Act_Data{c,Act_Num}=[Train_Act_Data{c,Act_Num},Temp_Data(ChsChoice,Act_Point(2*i):Act_Point(2*i+1))]; %��������
          Train_Rest_Data{c,Act_Num}=[Train_Rest_Data{c,Act_Num},Temp_Data(ChsChoice,Act_Point(2*i-1):Act_Point(2*i))];%��Ϣ����
       end
    end
 end