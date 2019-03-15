%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.24

%%  Description:
%   function: EMG4 ���ݷֶΣ��ҵ���Ӧ�Ķ������ͽ�����
%   data:��������
%   Fs:������
%   numAction���ö�������Ч������ 
%   returnData:���طֶ�����
function returnData = EMG4RES4Get_Action_Point(data,Fs,numAction)
    [m n] = size(data);         % ��ȡdata�ṹ��m ͨ����n ��ͨ��������
    m = m-2;                    % ���һ��ͨ��Ϊmaker,�����ڶ���Ϊʱ��
    returnData = zeros(1,2*numAction+1);
    diff_Temp_Data = zeros(1,n-1);
    m = 4;
    for i=1:m
       a=abs(diff(data(i,:)));
       diff_Temp_Data=diff_Temp_Data+a;
    end
    c = mean(diff_Temp_Data);
    % �˲�����������ֵ���������޸�
    mean_threshold = 1.0;                   % ��ֵ����Ϊ��ֵ��1.0��
    coordinates_jump = 2000;                % ������Ծֵ���ã����ڷֶεõ�������������,��������Ӳ����ʺͳ���ʱ������
    PassbandFrequency = 20;                 % ��ͨ�˲�ȡ�����ͨ��Ƶ�� 
    StopbandFrequency = 30;                 % ��ͨ�˲�ȡ��������Ƶ��
     % ����λ��ͨFIR�˲���
    wf = PassbandFrequency*2/Fs;
    ws = StopbandFrequency*2/Fs;
    lpFilt = designfilt('lowpassfir','PassbandFrequency',wf, ...
         'StopbandFrequency',ws,'PassbandRipple',0.1, ...
         'StopbandAttenuation',65,'DesignMethod','kaiserwin');
    e = filtfilt(lpFilt,diff_Temp_Data);
    f=smooth(e,50);                         % ƽ��
    g(:,1) = find(f> mean_threshold*c );    % ��ȡ���д���mean_threshold����ֵ������
    g(2:end,2)=diff(g(:,1));
    h = find(g(:,2)>coordinates_jump);      % �ҵ�������Ծֵ������ֵ�ĵط�
    %% ��ȡ�ֶε�: ����
                  % len_h == 2����ô���Եõ�3������,6����
                  % len_h == 3����ô���Եõ�4������,8����
                  % len_h == 4����ô���Եõ�5������,10���㣻
    len_h = length(h);
    returnData1 = zeros(1,2*(len_h));
    for cnt = 1:len_h+1
        if cnt==1               % ����ǵ�һ��
            returnData1(2*cnt-1) = g(1,1);
            returnData1(2*cnt)   = g(h(cnt)-1,1);
        elseif cnt==len_h+1     % ��������һ��
            returnData1(2*cnt-1) = g(h(cnt-1),1);
            returnData1(2*cnt)   = g(end,1);
        else                    % ������
            returnData1(2*cnt-1) = g(h(cnt-1),1);
            returnData1(2*cnt)   = g(h(cnt)-1,1);
        end
    end
    %% �������ŵ�
    cnt1 = 0;
    for cnt = 1:len_h+1
        if returnData1(2*cnt)-returnData1(2*cnt-1) > 0.1*Fs            % ����һ�������ֵ,0.1*Fs
            cnt1 = cnt1 +1;
            returnData2(2*cnt1-1) = returnData1(2*cnt-1);
            returnData2(2*cnt1) = returnData1(2*cnt);
        end   
    end
    %% ��ͼ��������:displayFlag==1�� �����ָ�ͼ��displayFlag==0�� ���Σ�
    displayFlag = 0;
    if displayFlag
        [m n] = size(data(1:4,:));
        maxdata = max(max(data(1:4,:)));
        figure;
        for cnt = 1:m
            plot(data(cnt,:)+(cnt-1)*maxdata);
            hold on;
        end
        for cnt = 1: cnt1
            plot([returnData2(2*cnt-1),returnData2(2*cnt-1)],[-maxdata,(m)*maxdata],'Linewidth',3);
            hold on;
            plot([returnData2(2*cnt),returnData2(2*cnt)],[-maxdata,(m)*maxdata],'Linewidth',3);
            hold on;
        end
        pause(1);
    end
    %% finally
    returnData(1) = 200;
    returnData(2:end) = returnData2;
end