%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.23

%%  Description:
%   function:        ��������
%   path��           ԭʼ���ݴ洢λ��
%   savePath��       ��ȡ�����ݱ���λ�ã���.mat��ʽ��
%   EMGpos��         ѡ�񼡵�ͨ������λ�ã�Ĭ����0����Ӱ��
%   ChsChoice��      ͨ��ѡ��(������ʽ)��Ϊ��ʱ��ѡ������ͨ����
%   ActChoice��      ����ѡ�񣬿ռ�ѡ�����ж������������߱���(������)��ʽ
%   Fs��             ������  һ�㣺TMSi 2048; Delsys:1926; RES4&EMG4:1000��
%   numAction��      numAction����������������Ϣ������ʾ�ɼ������ж����ĸ�����������ʵ���������
%   win_time��       ������ʱ�� ��λ��s
%   Remove_Mean��    ���ݾ�ֵ���������
%   Feat_Kind_Chose����������ѡ��
%%
function [path,savePath,EMGpos,ChsChoice,ActChoice,Fs,numAction,win_time,Feat_Kind_Chose] = parameterSetting(deviceName)
    cd ..;
    switch deviceName
        case 'TMSi'
            path = [pwd,'\Data\TMSi'];
            savePath = [pwd,'\Data\loaddedData'];
            EMGpos = 2;                         % ѡ�񼡵�ͨ������λ�ã�Ĭ����0����Ӱ��
            ChsChoice = [];                     % ͨ��ѡ��(������ʽ)��Ϊ��ʱ��ѡ������ͨ����
            ActChoice = [];                     % ����ѡ�񣬿ռ�ѡ�����ж������������߱���(������)��ʽ
            Fs = 2048;                          % ������  һ�㣺TMSi 2048; Delsys:1926; RES4&EMG4:1000��
            numAction = 7;                      % numAction����������������Ϣ������ʾѵ�����ж����ĸ���
        case 'Delsys'
            path = [pwd,'\Data\Delsys'];
            savePath = [pwd,'\Data\loaddedData'];
            EMGpos = 2;                         % ѡ�񼡵�ͨ������λ�ã�Ϊ����������������ΪDelsys�ɼ������ݿ��ܰ������ٶ�����
            ChsChoice = [];                     % ͨ��ѡ��(������ʽ)��Ϊ��ʱ��ѡ������ͨ����
            ActChoice = [];                     % ����ѡ�񣬿ռ�ѡ�����ж������������߱���(������)��ʽ
            Fs = 1926;                          % ������  һ�㣺TMSi 2048; Delsys:1926; RES4&EMG4:1000��
            numAction = 7;                      % numAction����������������Ϣ������ʾѵ�����ж����ĸ���
        case {'EMG4RES4','EMG4','RES4'}         % �������豸���ƶ���ָһ���豸��ֻ����;��һ��
            path = [pwd,'\Data\EMG4RES4'];
            savePath = [pwd,'\Data\loaddedData'];
            EMGpos = 2;                         % ѡ�񼡵�ͨ������λ�ã�Ĭ����0����Ӱ��
            ChsChoice = [1 2 5 8];                     % ͨ��ѡ��(������ʽ)��Ϊ��ʱ��ѡ������ͨ����
            ActChoice = [];                     % ����ѡ�񣬿ռ�ѡ�����ж������������߱���(������)��ʽ
            Fs = 1000;                          % ������  һ�㣺TMSi 2048; Delsys:1926; RES4&EMG4:1000��
            numAction = 6;                      % numAction����������������Ϣ������ʾѵ�����ж����ĸ���
    end
    win_time = 0.3;                             % ������ʱ�� 0.3s
    Feat_Kind = {'AACfeat','AR4feat','AR6feat','DASDVfeat','Kurtfeat','Lenfeat','LOGDfeat','Mavfeat',...
        'MLKfeat','RMSfeat','RSTAR6feat','SSIfeat','StatMaxfeat','StatMeanfeat','StatMinfeat',...
        'StatStdfeat','TDFeats','TM3feat','TM4feat','TM5feat','Turnfeat','VARfeat','ZCfeat'};
    Feat_Kind_Chose = Feat_Kind([1 5]);
end