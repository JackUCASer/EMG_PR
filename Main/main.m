%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.18

%%
clear all;close all;clc;
%% Step 1: 路径 add path
mainPathA = which('main.m');        % 获取主函数位置
cd(mainPathA(1:end-7));             % 回到主函数所在位置,这一步是为了函数第一次运行后，第二次、第三次...运行不会出错
cd ..;addpath(genpath(pwd));        % 返回上一级路径，并添加此时路径下所有子文件夹
cd(mainPathA(1:end-7));             % 回到主函数所在位置

%% Step2:  导入数据 load data
% 需要修改的参数只有 path(路径) 、 deviceName(设备名称)、savePath(load数据保存位置); 
% 这一部分需要解决几个问题：1）、数据存储格式；2）、读出格式；
%   1）、数据存储格式：  
%           TMSi&Delsys:因为不能打maker,所以单个文件必定是某个固定的动作；TMSi为csv文件，Delsys也为csv文件，但存储格式不同；Delsys
%           除了可以采集肌电还可以采集三轴加速度，因此，需要提供额外的肌电位置信息 EMGpos（标量、向量均可），
%           自研设备(eg. 4ch肌电4ch阻抗（形变）设备)：在采集数据时，每个动作都有固定的maker,且最后一行为数据的maker
%   2)、数据读出格式：
%           统一采取元胞(cell)格式：第一行为名称；第二行为第一行中每列名称对应的数据,结果保存在 Data\loaddedData\ 文件夹
%           具体输出格式参考standard_data_format.mat文件;
deviceName1 = 'TMSi';
deviceName2 = 'Delsys';
deviceName3 = 'EMG4RES4';   
%% ------------------------------设备选择--------------------------------
deviceName = deviceName3;       % 更改这里,choise device
[path,savePath,EMGpos,ChsChoice,ActChoice,Fs,numAction,win_time,Feat_Kind_Chose] = parameterSetting(deviceName);
returnData2 = loadData(path,deviceName,savePath,EMGpos);

%% Step3 : 去坏点，分段;需要滤波和降采样的话，可以在这里添加程序
returnData3 = data_preprocess(returnData2,deviceName,ChsChoice,ActChoice,Fs,numAction);

%% Step4 : 提取特征,特征都是按通道来处理,只用设置win_time，Feat_Kind,Remove_Mean,win_inc视情况更改
win=floor(Fs*win_time);                                        % 处理的窗长
win_inc=floor(win/2);                                          % 重叠的窗长
if isempty(ActChoice)
    nclass = numAction+1;                                      % 类别 = numAction个动作 + 1个静息
else
    nclass = length(ActChoice) + 1;                            % 类别 = ActChoice个动作 + 1个静息
end
Remove_Mean =0;
returnData4 = data_feature(returnData3,win,win_inc,nclass,Feat_Kind_Chose,Remove_Mean);

%% Step5 && Step6
subNum = size(returnData4,2);   % 计算受试者数目
for cntSubNum = 1:subNum        % 遍历所有受试者
    data = returnData4(:,cntSubNum);                                % 挨个读取受试者肌电数据
    [allTDCoef,targetClass,Real_Class] = preprocessClassify(data);  % 降维或者分类前的预处理
    
    %% Step5 : 特征降维,可屏蔽
    % allTDCoef = linerPCA(allTDCoef);
    
    %% Step6 : 训练和测试,只需设置 Action_Selected 参数: 挑选用于分类的动作，默认添加一个动作（休息）
    returnData5 = data_train(allTDCoef,targetClass,Real_Class);
    
    %% Step6 :存储结果，returnData6
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