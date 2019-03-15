%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.19

%%  Description:
%   function: 特征提取函数
%   TrainData: 待特征提取的动作、休息数据数据
%   win： 处理的窗长
%   win_inc： 窗长步进
%   nclass:  分类数
%   Feat_Kind：选择的特征提取函数,可以为多个函数
%   Remove_Mean：去直流分量
%   
function  [Train_Act_Feat,Train_Act_Label,Train_Rest_Feat,Train_Rest_Label]...
           =Extract_Features2(Train_Act_Data,Train_Rest_Data,win,win_inc,nclass,Feat_Kind,Remove_Mean)

        for i=1:nclass-1        % 去掉一个休息类别
            Train_Act_Feat{i}=[];
            Train_Act_Label{i}=[];
            Train_Rest_Feat{i}=[];
        end
        for c=1:length(Train_Act_Data)
            %----动作的特征----------------------
            Temp_Data=[];
            Temp_Data=Train_Act_Data{c};
            Chs = size(Temp_Data,1);
            Feat=[];
            data_buff=[];
            for j=1:Chs                                                         % 每个动作Chs个通道数据
                Temp=[];
                Temp=enframe(Temp_Data(j,:),win,win_inc);                       % enframe 输出 每行一个窗
                data_buff = [];
                if(sum(strcmp(Feat_Kind,'AACfeat')))                                 % Remove_Mean=0 表示不去平均值
                   data_buff = [data_buff;extractAACfeat(Temp',win)];                   % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'AR4feat')))
                   data_buff = [data_buff;extractAR4feat(Temp',win,Remove_Mean)];       % 1个行向量返回4个值(按列),
                end
                if(sum(strcmp(Feat_Kind,'AR6feat')))
                   data_buff = [data_buff;extractAR6feat(Temp',win)];                   % 1个行向量返回6个值(按列),
                end
                if(sum(strcmp(Feat_Kind,'DASDVfeat')))
                   data_buff = [data_buff;extractDASDVfeat(Temp',win)];                 % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'Kurtfeat')))
                   data_buff = [data_buff;extractKurtfeat(Temp',win)];                  % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'Lenfeat')))
                   data_buff = [data_buff;extractLenfeat(Temp',win)];                   % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'LOGDfeat')))
                   data_buff = [data_buff;extractLOGDfeat(Temp',win,Remove_Mean)];      % 1个行向量返回一个值         
                end
                if(sum(strcmp(Feat_Kind,'Mavfeat')))
                   data_buff = [data_buff;extractMavfeat(Temp',win,Remove_Mean)];       % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'MLKfeat')))
                   data_buff = [data_buff;extractMLKfeat(Temp',win)];                   % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'RMSfeat')))
                   data_buff = [data_buff;extractRMSfeat(Temp',win,Remove_Mean)];       % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'RSTAR6feat')))
                   data_buff = [data_buff;extractRSTAR6feat(Temp',win)];                % 1个行向量返回6个值(按列)
                end
                if(sum(strcmp(Feat_Kind,'SSIfeat')))
                   data_buff = [data_buff;extractSSIfeat(Temp',win,Remove_Mean)];       % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'StatMaxfeat')))
                   data_buff = [data_buff;extractStatMaxfeat(Temp',win)];               % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'StatMeanfeat')))
                   data_buff = [data_buff;extractStatMeanfeat(Temp',win,Remove_Mean)];  % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'StatMinfeat')))
                   data_buff = [data_buff;extractStatMinfeat(Temp',win)];               % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'StatStdfeat')))
                   data_buff = [data_buff;extractStatStdfeat(Temp',win,Remove_Mean)];   % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'TDFeats')))
                   nfeats = 2;                                                          % nfeats = 2 or 4
                   data_buff = [data_buff;extractTDFeats(Temp',win,nfeats)];            % 1个行向量返回2 or 4个值(按列)
                end
                if(sum(strcmp(Feat_Kind,'TM3feat')))
                   data_buff = [data_buff;extractTM3feat(Temp',win,Remove_Mean)];       % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'TM4feat')))
                   data_buff = [data_buff;extractTM4feat(Temp',win)];                   % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'TM5feat')))
                   data_buff = [data_buff;extractTM5feat(Temp',win)];                   % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'Turnfeat')))
                   data_buff = [data_buff;extractTurnfeat(Temp',win)];                  % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'VARfeat')))
                   data_buff = [data_buff;extractVARfeat(Temp',win)];                   % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'ZCfeat')))
                   data_buff = [data_buff;extractZCfeat(Temp',win)];                    % 1个行向量返回一个值
                end
                Feat = [Feat;data_buff];
            end
            Train_Act_Feat{c}  = Feat;                                          % 动作的特征
            Train_Act_Label{c} = ones(1,length(Feat(j,:)))*c;                   % 特征对应的动作标签

            %-----休息的特征----------------------
            Temp_Data=[];
            Temp_Data=Train_Rest_Data{c};
            Chs = size(Temp_Data,1);
            Feat=[];
            for j=1:Chs                                                           %每个动作4个通道数据
                Temp=[];
                Temp=enframe(Temp_Data(j,:),win,win_inc);                       % enframe 输出 每行一个窗
                data_buff = [];
                if(sum(strcmp(Feat_Kind,'AACfeat')))                                 % Remove_Mean=0 表示不去平均值
                   data_buff = [data_buff;extractAACfeat(Temp',win)];                   % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'AR4feat')))
                   data_buff = [data_buff;extractAR4feat(Temp',win,Remove_Mean)];       % 1个行向量返回4个值(按列),
                end
                if(sum(strcmp(Feat_Kind,'AR6feat')))
                   data_buff = [data_buff;extractAR6feat(Temp',win)];                   % 1个行向量返回6个值(按列),
                end
                if(sum(strcmp(Feat_Kind,'DASDVfeat')))
                   data_buff = [data_buff;extractDASDVfeat(Temp',win)];                 % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'Kurtfeat')))
                   data_buff = [data_buff;extractKurtfeat(Temp',win)];                  % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'Lenfeat')))
                   data_buff = [data_buff;extractLenfeat(Temp',win)];                   % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'LOGDfeat')))
                   data_buff = [data_buff;extractLOGDfeat(Temp',win,Remove_Mean)];      % 1个行向量返回一个值         
                end
                if(sum(strcmp(Feat_Kind,'Mavfeat')))
                   data_buff = [data_buff;extractMavfeat(Temp',win,Remove_Mean)];       % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'MLKfeat')))
                   data_buff = [data_buff;extractMLKfeat(Temp',win)];                   % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'RMSfeat')))
                   data_buff = [data_buff;extractRMSfeat(Temp',win,Remove_Mean)];       % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'RSTAR6feat')))
                   data_buff = [data_buff;extractRSTAR6feat(Temp',win)];                % 1个行向量返回6个值(按列)
                end
                if(sum(strcmp(Feat_Kind,'SSIfeat')))
                   data_buff = [data_buff;extractSSIfeat(Temp',win,Remove_Mean)];       % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'StatMaxfeat')))
                   data_buff = [data_buff;extractStatMaxfeat(Temp',win)];               % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'StatMeanfeat')))
                   data_buff = [data_buff;extractStatMeanfeat(Temp',win,Remove_Mean)];  % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'StatMinfeat')))
                   data_buff = [data_buff;extractStatMinfeat(Temp',win)];               % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'StatStdfeat')))
                   data_buff = [data_buff;extractStatStdfeat(Temp',win,Remove_Mean)];   % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'TDFeats')))
                   nfeats = 2;                                                          % nfeats = 2 or 4
                   data_buff = [data_buff;extractTDFeats(Temp',win,nfeats)];            % 1个行向量返回2 or 4个值(按列)
                end
                if(sum(strcmp(Feat_Kind,'TM3feat')))
                   data_buff = [data_buff;extractTM3feat(Temp',win,Remove_Mean)];       % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'TM4feat')))
                   data_buff = [data_buff;extractTM4feat(Temp',win)];                   % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'TM5feat')))
                   data_buff = [data_buff;extractTM5feat(Temp',win)];                   % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'Turnfeat')))
                   data_buff = [data_buff;extractTurnfeat(Temp',win)];                  % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'VARfeat')))
                   data_buff = [data_buff;extractVARfeat(Temp',win)];                   % 1个行向量返回一个值
                end
                if(sum(strcmp(Feat_Kind,'ZCfeat')))
                   data_buff = [data_buff;extractZCfeat(Temp',win)];                    % 1个行向量返回一个值
                end
                Feat = [Feat;data_buff];
            end
            Train_Rest_Feat{c}  = Feat; 
            Train_Rest_Label{c} = [];
        end
end