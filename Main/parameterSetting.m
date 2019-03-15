%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.23

%%  Description:
%   function:        参数配置
%   path：           原始数据存储位置
%   savePath：       读取后数据保存位置，（.mat形式）
%   EMGpos：         选择肌电通道所在位置，默认填0，无影响
%   ChsChoice：      通道选择(向量格式)，为空时，选择所有通道；
%   ActChoice：      动作选择，空集选择所有动作；向量或者标量(二分类)格式
%   Fs：             采样率  一般：TMSi 2048; Delsys:1926; RES4&EMG4:1000。
%   numAction：      numAction个动作（不包含静息），表示采集样本中动作的个数，必须依实际情况设置
%   win_time：       窗长的时间 单位：s
%   Remove_Mean：    数据均值，不用理会
%   Feat_Kind_Chose：特征方法选择
%%
function [path,savePath,EMGpos,ChsChoice,ActChoice,Fs,numAction,win_time,Feat_Kind_Chose] = parameterSetting(deviceName)
    cd ..;
    switch deviceName
        case 'TMSi'
            path = [pwd,'\Data\TMSi'];
            savePath = [pwd,'\Data\loaddedData'];
            EMGpos = 2;                         % 选择肌电通道所在位置，默认填0，无影响
            ChsChoice = [];                     % 通道选择(向量格式)，为空时，选择所有通道；
            ActChoice = [];                     % 动作选择，空集选择所有动作；向量或者标量(二分类)格式
            Fs = 2048;                          % 采样率  一般：TMSi 2048; Delsys:1926; RES4&EMG4:1000。
            numAction = 7;                      % numAction个动作（不包含静息），表示训练集中动作的个数
        case 'Delsys'
            path = [pwd,'\Data\Delsys'];
            savePath = [pwd,'\Data\loaddedData'];
            EMGpos = 2;                         % 选择肌电通道所在位置，为标量或者向量，因为Delsys采集的数据可能包含加速度数据
            ChsChoice = [];                     % 通道选择(向量格式)，为空时，选择所有通道；
            ActChoice = [];                     % 动作选择，空集选择所有动作；向量或者标量(二分类)格式
            Fs = 1926;                          % 采样率  一般：TMSi 2048; Delsys:1926; RES4&EMG4:1000。
            numAction = 7;                      % numAction个动作（不包含静息），表示训练集中动作的个数
        case {'EMG4RES4','EMG4','RES4'}         % 这三个设备名称都是指一个设备，只是用途不一样
            path = [pwd,'\Data\EMG4RES4'];
            savePath = [pwd,'\Data\loaddedData'];
            EMGpos = 2;                         % 选择肌电通道所在位置，默认填0，无影响
            ChsChoice = [1 2 5 8];                     % 通道选择(向量格式)，为空时，选择所有通道；
            ActChoice = [];                     % 动作选择，空集选择所有动作；向量或者标量(二分类)格式
            Fs = 1000;                          % 采样率  一般：TMSi 2048; Delsys:1926; RES4&EMG4:1000。
            numAction = 6;                      % numAction个动作（不包含静息），表示训练集中动作的个数
    end
    win_time = 0.3;                             % 窗长的时间 0.3s
    Feat_Kind = {'AACfeat','AR4feat','AR6feat','DASDVfeat','Kurtfeat','Lenfeat','LOGDfeat','Mavfeat',...
        'MLKfeat','RMSfeat','RSTAR6feat','SSIfeat','StatMaxfeat','StatMeanfeat','StatMinfeat',...
        'StatStdfeat','TDFeats','TM3feat','TM4feat','TM5feat','Turnfeat','VARfeat','ZCfeat'};
    Feat_Kind_Chose = Feat_Kind([1 5]);
end