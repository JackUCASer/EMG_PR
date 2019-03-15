%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.19

%%  Description:
%   function: ����Ԥ����
%   numAction: ����������Ҫ˵������ʵ�ʲ���ʱ��Ϣ���ȶ�������1����������ȡ��Ϣ����ڶ�����
%   ChsChoice��ͨ��ѡ��(������ʽ)��Ϊ��ʱ��ѡ������ͨ����
%   ActChoice������ѡ�񣬿ռ�ѡ�����ж������������߱���
%   returnData: ����Ԥ���������ݣ� 
%               Ԫ��(cell)��ʽ����һ��Ϊ���������ƣ��ڶ���ΪnumAction���������ݣ�������ΪnumAction����Ϣ����
%                  sub_x
%               action data
%                rest data
function returnData = data_preprocess(data,deviceName,ChsChoice,ActChoice,fs,numAction)
    switch deviceName
        case 'EMG4RES4'
            downFs = fs;
            returnData = EMG4RES4data_preprocess(data,ChsChoice,fs,downFs,numAction);
            disp('-------- EMG4RES4 ����Ԥ�������--------');
        case 'EMG4'
            downFs = fs;
            returnData = EMG4data_preprocess(data,ChsChoice,fs,downFs,numAction);
            disp('-------- EMG4 ����Ԥ�������--------');
        case 'RES4'
            downFs = fs;
            returnData = RES4data_preprocess(data,ChsChoice,fs,downFs,numAction);
            disp('-------- RES4 ����Ԥ�������--------');
        case 'TMSi'
            downFs = fs;
            returnData = TMSidata_preprocess(data,ChsChoice,fs,downFs,numAction);
            disp('-------- TMSi ����Ԥ�������--------');
        case 'Delsys'
            downFs = fs;
            returnData = Delsysdata_preprocess(data,ChsChoice,fs,downFs,numAction);
            disp('-------- Delsys ����Ԥ�������--------');
    end
    if isempty(ActChoice)~= 1           % ���ActChoice��Ϊ��
        [m n] = size(returnData);       % ��ȡreturnData��ʽ
        for cnt = 1:n                   % ����ÿ��������
            data{1,cnt} = returnData{1,cnt};
            data{2,cnt} = returnData{2,cnt}(:,ActChoice);   % ��ȡѡ���Ķ���
            data{3,cnt} = returnData{3,cnt}(:,ActChoice);   % ��ȡѡ���Ķ���
        end
        returnData = data;
    end
end