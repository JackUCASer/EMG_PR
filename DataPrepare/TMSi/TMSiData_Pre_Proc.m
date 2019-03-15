%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.19

%%  Description:
%   function: TMSi����Ԥ�������²���-> ȥ���㣨ƽ���� -> ��ʱ��Ͷ����²���
%   data: ��Ԥ���������
%   Sampling_Rate�� �����ʣ�����
%   ChsChoice����Ҫ�����ͨ��
%   downFs:�²�����ѡ���Ƶ�ʣ�һ��ΪSampling_Rate��1/2��1/4��1/5��
%   returnData: ����Ԥ���������ݣ�
function Pre_Data=TMSiData_Pre_Proc(data,Sampling_Rate,ChsChoice,downFs)
    if (nargin == 3)                        
        downFs = Sampling_Rate;     % ����Ҫ������
    end
    if isempty(ChsChoice)==1                            
        ChsChoice = 1:1:size(data,1);
    end  
    Temp_Data  = data(ChsChoice,:);  
    %% ����˲���λ��
    % ������λ�˲����ӳ٣����˲�������ΪN���Բ�������ӳپ���N/2��NΪż��������(N-1)/2��NΪ������
    %  �����˲�  
    fs2 = 20;   fp2 = 30;           % ����Ͻ���Ƶ�ʺ�ͨ���Ͻ���Ƶ��
    fp1 = 400;  fs1 = 500;          % ͨ���½�ֹƵ�ʺ�����½���Ƶ��
    %  ��һ����Ƶ��,��λ��pi*rad/s
    ws2=fs2*2/Sampling_Rate; wp2=fp2*2/Sampling_Rate;% ����Ͻ���Ƶ�ʺ�ͨ���Ͻ���Ƶ��
    wp1=fp1*2/Sampling_Rate; ws1=fs1*2/Sampling_Rate;% ͨ���½�ֹƵ�ʺ�����½���Ƶ��
    %�����˲���ϵ��
    wc2=(ws2+wp2)/2; wc1=(ws1+wp1)/2;
    wp=[wc2,wc1];
    n_filter = 200;                                   % �������ó�200����ô���겨��ԭʼ����Ӧ���޳�ǰn_filter/2���㡣
    b=fir1(n_filter,wp,'bandpass');     
    freqz(b,1,512);                                   % �鿴��Ƶ��Ӧ�������޸Ľ�������������
    newdata=filter(b,1,Temp_Data(:,:)')';  
    
    colStart = n_filter/2+1;                          % ԭʼ����Ӧ���޳�ǰn_filter/2���㡣
    newdata = newdata(:,colStart:end);
    %% 
    Temp1_Data=(resample(newdata',downFs,Sampling_Rate))';           
    Pre_Data=Temp1_Data;
end