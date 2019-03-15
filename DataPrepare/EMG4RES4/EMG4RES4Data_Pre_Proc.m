%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.19

%%  Description:
%   function: EMG4RES4����Ԥ�������²���-> ȥ���㣨ƽ���� -> ��ʱ��Ͷ����²���
%   data: ��Ԥ���������
%   Sampling_Rate�� �����ʣ�����
%   downFs:�²�����ѡ���Ƶ�ʣ�һ��ΪSampling_Rate��1/2��1/4��1/5��
%   returnData: ����Ԥ���������ݣ�
function Pre_Data=EMG4RES4Data_Pre_Proc(data,Sampling_Rate,downFs)
    if (nargin == 2)                        
        downFs = Sampling_Rate;     % ����Ҫ������
    end 
    %% ������λ�˲����ӳ٣����˲�������ΪN���Բ�������ӳپ���N/2��NΪż��������(N-1)/2��NΪ������
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
    newdata=filter(b,1,data(1:4,:)')';                % 1-4ͨ���˲�
    %  �α�ƽ��
    for i = 5:8                                       % 5-8ͨ��ƽ��
        Temp_Data1 = RemoveBadData(data(i,:))+16;             % �����迹У��ֵ
        newdata(i,:)=smooth(Temp_Data1,15);
    end
    %% ������λ���⣬���ﻹ�����
    colStart = n_filter/2+1;
    newdata = newdata(:,colStart:end);
    data = data(:,colStart:end);
    %% 
    len_ch = 8;
    for i=1:len_ch
        Temp_Data(i,:) = newdata(i,:);  
    end
    Temp1_Data=(resample(Temp_Data',downFs,Sampling_Rate))';  
    Temp1_Data(len_ch+1,:)=downsample(data(9,:),floor(Sampling_Rate/downFs)); % ʱ��
    Temp1_Data(len_ch+2,:)=downsample(data(10,:),floor(Sampling_Rate/downFs)); % �������           
    Pre_Data=Temp1_Data;
end