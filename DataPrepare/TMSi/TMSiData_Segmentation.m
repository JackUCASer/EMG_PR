%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.19

%%  Description:
%   function: TMSi ���ݷֶΣ��ҵ���Ӧ�Ķ������ͽ����㣬���������˷�Ӧʱ����ɵ��ӳ�
%                  �����ҵ�ϵͳ����ʱ�䣬Ȼ����ݸ�ͨ������΢�־���ֵ�ĺ��ҵ�������ʼ��
%   data: ���ֶε�����
%   downFs�������������ò����ʣ����ǵ�ǰ����ܱ���������
%   numAction: ����������Ҫ˵������ʵ�ʲ���ʱ��Ϣ���ȶ�������1����������ȡ��Ϣ����ڶ�����
%   Train_Act_Data,Train_Rest_Data: ���طֶκ�Ķ������ݡ���Ϣ���ݣ�  
%%
 function [Train_Act_Data,Train_Rest_Data]=TMSiData_Segmentation(data,downFs,numAction)
    % ����TMSi,data ÿ��Ԫ��ֻ��һ���������ظ����Σ�����Ҫ�޸ķָ�
    len_data = length(data);
    if numAction == len_data               % ������������������������ȣ���ô����ȫ�÷ָ��Ϊȫ�Ƕ�������
       for c=1:len_data     
           Temp_Data=data{c};
           % ȡ����ʼ������ʼ��λ��
           Act_Point = Get_EMG_Action_Point(Temp_Data,downFs);
           % �ָ������
           len_Act_Point = length(Act_Point)/2;                          % ���˼���
           for cnt = 1:len_Act_Point
               Train_Act_Data{cnt,c} = Temp_Data(:,Act_Point(2*cnt-1):Act_Point(2*cnt));
           end
       end
    else                                   % ��������������������������ȣ���ô���˾�Ϣ������ȫ�÷ָ�
       for c=2:len_data 
           Temp_Data=data{c};
           % ȡ����ʼ������ʼ��λ��
           Act_Point = Get_EMG_Action_Point(Temp_Data,downFs);
           % �ָ������
           len_Act_Point = length(Act_Point)/2;                          % ���˼���
           for cnt = 1:len_Act_Point
               Train_Act_Data{cnt,c-1} = Temp_Data(:,Act_Point(2*cnt-1):Act_Point(2*cnt));
           end
           % �ָ���Ϣ����
           Rest_Data=data{1};
           vec = 0:1:len_Act_Point;                                      % �����鶯���Ͷ�������Ϣ
           len_rest = length(Rest_Data);
           vec = round(vec*len_rest/len_Act_Point);
           for cnt = 1:len_Act_Point
               Train_Rest_Data{cnt,c-1} = Rest_Data(:,1+vec(cnt):vec(cnt+1));
           end
        end
    end
 end