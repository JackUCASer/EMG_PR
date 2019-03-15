%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.18

%%
clear all;close all;clc;
%% Step 1: ·�� add path
mainPathA = which('main.m');        % ��ȡ������λ��
cd(mainPathA(1:end-7));             % �ص�����������λ��,��һ����Ϊ�˺�����һ�����к󣬵ڶ��Ρ�������...���в������
cd ..;addpath(genpath(pwd));        % ������һ��·��������Ӵ�ʱ·�����������ļ���
cd(mainPathA(1:end-7));             % �ص�����������λ��

%% Step2:  �������� load data
% ��Ҫ�޸ĵĲ���ֻ�� path(·��) �� deviceName(�豸����)��savePath(load���ݱ���λ��); 
% ��һ������Ҫ����������⣺1�������ݴ洢��ʽ��2����������ʽ��
%   1�������ݴ洢��ʽ��  
%           TMSi&Delsys:��Ϊ���ܴ�maker,���Ե����ļ��ض���ĳ���̶��Ķ�����TMSiΪcsv�ļ���DelsysҲΪcsv�ļ������洢��ʽ��ͬ��Delsys
%           ���˿��Բɼ����绹���Բɼ�������ٶȣ���ˣ���Ҫ�ṩ����ļ���λ����Ϣ EMGpos���������������ɣ���
%           �����豸(eg. 4ch����4ch�迹���α䣩�豸)���ڲɼ�����ʱ��ÿ���������й̶���maker,�����һ��Ϊ���ݵ�maker
%   2)�����ݶ�����ʽ��
%           ͳһ��ȡԪ��(cell)��ʽ����һ��Ϊ���ƣ��ڶ���Ϊ��һ����ÿ�����ƶ�Ӧ������,��������� Data\loaddedData\ �ļ���
%           ���������ʽ�ο�standard_data_format.mat�ļ�;
deviceName1 = 'TMSi';
deviceName2 = 'Delsys';
deviceName3 = 'EMG4RES4';   
%% ------------------------------�豸ѡ��--------------------------------
deviceName = deviceName3;       % ��������,choise device
[path,savePath,EMGpos,ChsChoice,ActChoice,Fs,numAction,win_time,Feat_Kind_Chose] = parameterSetting(deviceName);
returnData2 = loadData(path,deviceName,savePath,EMGpos);

%% Step3 : ȥ���㣬�ֶ�;��Ҫ�˲��ͽ������Ļ���������������ӳ���
returnData3 = data_preprocess(returnData2,deviceName,ChsChoice,ActChoice,Fs,numAction);

%% Step4 : ��ȡ����,�������ǰ�ͨ��������,ֻ������win_time��Feat_Kind,Remove_Mean,win_inc���������
win=floor(Fs*win_time);                                        % ����Ĵ���
win_inc=floor(win/2);                                          % �ص��Ĵ���
if isempty(ActChoice)
    nclass = numAction+1;                                      % ��� = numAction������ + 1����Ϣ
else
    nclass = length(ActChoice) + 1;                            % ��� = ActChoice������ + 1����Ϣ
end
Remove_Mean =0;
returnData4 = data_feature(returnData3,win,win_inc,nclass,Feat_Kind_Chose,Remove_Mean);

%% Step5 && Step6
subNum = size(returnData4,2);   % ������������Ŀ
for cntSubNum = 1:subNum        % ��������������
    data = returnData4(:,cntSubNum);                                % ������ȡ�����߼�������
    [allTDCoef,targetClass,Real_Class] = preprocessClassify(data);  % ��ά���߷���ǰ��Ԥ����
    
    %% Step5 : ������ά,������
    % allTDCoef = linerPCA(allTDCoef);
    
    %% Step6 : ѵ���Ͳ���,ֻ������ Action_Selected ����: ��ѡ���ڷ���Ķ�����Ĭ�����һ����������Ϣ��
    returnData5 = data_train(allTDCoef,targetClass,Real_Class);
    
    %% Step6 :�洢�����returnData6
    returnData6{1,cntSubNum} = returnData4{1, cntSubNum}(27:end-4);
    returnData6{2,cntSubNum} = 'FeatureChoice';
    returnData6{3,cntSubNum} = Feat_Kind_Chose;
    returnData6{4,cntSubNum} = 'ChannelChoice';
    returnData6{5,cntSubNum} = ChsChoice;
    returnData6{6,cntSubNum} = 'ActionChoice';
    returnData6{7,cntSubNum} = ActChoice;
    returnData6(8:13,cntSubNum)=returnData5;
end
%% Finally
% [m n] = size(returnData5);
% Average_Recognition_Rate = 0;
% for i = 1:n
%     a = returnData5{5,i};
%     Average_Recognition_Rate = Average_Recognition_Rate +a;
% end
% Average_Recognition_Rate = Average_Recognition_Rate/n