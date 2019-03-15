%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.19

%%  Description:
%   function: ������ȡ����
%   TrainData: ��������ȡ�Ķ�������Ϣ��������
%   win�� ����Ĵ���
%   win_inc�� ��������
%   nclass:  ������
%   Feat_Kind��ѡ���������ȡ����,����Ϊ�������
%   Remove_Mean��ȥֱ������
%   
function  [Train_Act_Feat,Train_Act_Label,Train_Rest_Feat,Train_Rest_Label]...
           =Extract_Features2(Train_Act_Data,Train_Rest_Data,win,win_inc,nclass,Feat_Kind,Remove_Mean)

        for i=1:nclass-1        % ȥ��һ����Ϣ���
            Train_Act_Feat{i}=[];
            Train_Act_Label{i}=[];
            Train_Rest_Feat{i}=[];
        end
        for c=1:length(Train_Act_Data)
            %----����������----------------------
            Temp_Data=[];
            Temp_Data=Train_Act_Data{c};
            Chs = size(Temp_Data,1);
            Feat=[];
            data_buff=[];
            for j=1:Chs                                                         % ÿ������Chs��ͨ������
                Temp=[];
                Temp=enframe(Temp_Data(j,:),win,win_inc);                       % enframe ��� ÿ��һ����
                data_buff = [];
                if(sum(strcmp(Feat_Kind,'AACfeat')))                                 % Remove_Mean=0 ��ʾ��ȥƽ��ֵ
                   data_buff = [data_buff;extractAACfeat(Temp',win)];                   % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'AR4feat')))
                   data_buff = [data_buff;extractAR4feat(Temp',win,Remove_Mean)];       % 1������������4��ֵ(����),
                end
                if(sum(strcmp(Feat_Kind,'AR6feat')))
                   data_buff = [data_buff;extractAR6feat(Temp',win)];                   % 1������������6��ֵ(����),
                end
                if(sum(strcmp(Feat_Kind,'DASDVfeat')))
                   data_buff = [data_buff;extractDASDVfeat(Temp',win)];                 % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'Kurtfeat')))
                   data_buff = [data_buff;extractKurtfeat(Temp',win)];                  % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'Lenfeat')))
                   data_buff = [data_buff;extractLenfeat(Temp',win)];                   % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'LOGDfeat')))
                   data_buff = [data_buff;extractLOGDfeat(Temp',win,Remove_Mean)];      % 1������������һ��ֵ         
                end
                if(sum(strcmp(Feat_Kind,'Mavfeat')))
                   data_buff = [data_buff;extractMavfeat(Temp',win,Remove_Mean)];       % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'MLKfeat')))
                   data_buff = [data_buff;extractMLKfeat(Temp',win)];                   % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'RMSfeat')))
                   data_buff = [data_buff;extractRMSfeat(Temp',win,Remove_Mean)];       % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'RSTAR6feat')))
                   data_buff = [data_buff;extractRSTAR6feat(Temp',win)];                % 1������������6��ֵ(����)
                end
                if(sum(strcmp(Feat_Kind,'SSIfeat')))
                   data_buff = [data_buff;extractSSIfeat(Temp',win,Remove_Mean)];       % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'StatMaxfeat')))
                   data_buff = [data_buff;extractStatMaxfeat(Temp',win)];               % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'StatMeanfeat')))
                   data_buff = [data_buff;extractStatMeanfeat(Temp',win,Remove_Mean)];  % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'StatMinfeat')))
                   data_buff = [data_buff;extractStatMinfeat(Temp',win)];               % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'StatStdfeat')))
                   data_buff = [data_buff;extractStatStdfeat(Temp',win,Remove_Mean)];   % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'TDFeats')))
                   nfeats = 2;                                                          % nfeats = 2 or 4
                   data_buff = [data_buff;extractTDFeats(Temp',win,nfeats)];            % 1������������2 or 4��ֵ(����)
                end
                if(sum(strcmp(Feat_Kind,'TM3feat')))
                   data_buff = [data_buff;extractTM3feat(Temp',win,Remove_Mean)];       % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'TM4feat')))
                   data_buff = [data_buff;extractTM4feat(Temp',win)];                   % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'TM5feat')))
                   data_buff = [data_buff;extractTM5feat(Temp',win)];                   % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'Turnfeat')))
                   data_buff = [data_buff;extractTurnfeat(Temp',win)];                  % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'VARfeat')))
                   data_buff = [data_buff;extractVARfeat(Temp',win)];                   % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'ZCfeat')))
                   data_buff = [data_buff;extractZCfeat(Temp',win)];                    % 1������������һ��ֵ
                end
                Feat = [Feat;data_buff];
            end
            Train_Act_Feat{c}  = Feat;                                          % ����������
            Train_Act_Label{c} = ones(1,length(Feat(j,:)))*c;                   % ������Ӧ�Ķ�����ǩ

            %-----��Ϣ������----------------------
            Temp_Data=[];
            Temp_Data=Train_Rest_Data{c};
            Chs = size(Temp_Data,1);
            Feat=[];
            for j=1:Chs                                                           %ÿ������4��ͨ������
                Temp=[];
                Temp=enframe(Temp_Data(j,:),win,win_inc);                       % enframe ��� ÿ��һ����
                data_buff = [];
                if(sum(strcmp(Feat_Kind,'AACfeat')))                                 % Remove_Mean=0 ��ʾ��ȥƽ��ֵ
                   data_buff = [data_buff;extractAACfeat(Temp',win)];                   % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'AR4feat')))
                   data_buff = [data_buff;extractAR4feat(Temp',win,Remove_Mean)];       % 1������������4��ֵ(����),
                end
                if(sum(strcmp(Feat_Kind,'AR6feat')))
                   data_buff = [data_buff;extractAR6feat(Temp',win)];                   % 1������������6��ֵ(����),
                end
                if(sum(strcmp(Feat_Kind,'DASDVfeat')))
                   data_buff = [data_buff;extractDASDVfeat(Temp',win)];                 % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'Kurtfeat')))
                   data_buff = [data_buff;extractKurtfeat(Temp',win)];                  % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'Lenfeat')))
                   data_buff = [data_buff;extractLenfeat(Temp',win)];                   % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'LOGDfeat')))
                   data_buff = [data_buff;extractLOGDfeat(Temp',win,Remove_Mean)];      % 1������������һ��ֵ         
                end
                if(sum(strcmp(Feat_Kind,'Mavfeat')))
                   data_buff = [data_buff;extractMavfeat(Temp',win,Remove_Mean)];       % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'MLKfeat')))
                   data_buff = [data_buff;extractMLKfeat(Temp',win)];                   % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'RMSfeat')))
                   data_buff = [data_buff;extractRMSfeat(Temp',win,Remove_Mean)];       % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'RSTAR6feat')))
                   data_buff = [data_buff;extractRSTAR6feat(Temp',win)];                % 1������������6��ֵ(����)
                end
                if(sum(strcmp(Feat_Kind,'SSIfeat')))
                   data_buff = [data_buff;extractSSIfeat(Temp',win,Remove_Mean)];       % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'StatMaxfeat')))
                   data_buff = [data_buff;extractStatMaxfeat(Temp',win)];               % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'StatMeanfeat')))
                   data_buff = [data_buff;extractStatMeanfeat(Temp',win,Remove_Mean)];  % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'StatMinfeat')))
                   data_buff = [data_buff;extractStatMinfeat(Temp',win)];               % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'StatStdfeat')))
                   data_buff = [data_buff;extractStatStdfeat(Temp',win,Remove_Mean)];   % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'TDFeats')))
                   nfeats = 2;                                                          % nfeats = 2 or 4
                   data_buff = [data_buff;extractTDFeats(Temp',win,nfeats)];            % 1������������2 or 4��ֵ(����)
                end
                if(sum(strcmp(Feat_Kind,'TM3feat')))
                   data_buff = [data_buff;extractTM3feat(Temp',win,Remove_Mean)];       % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'TM4feat')))
                   data_buff = [data_buff;extractTM4feat(Temp',win)];                   % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'TM5feat')))
                   data_buff = [data_buff;extractTM5feat(Temp',win)];                   % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'Turnfeat')))
                   data_buff = [data_buff;extractTurnfeat(Temp',win)];                  % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'VARfeat')))
                   data_buff = [data_buff;extractVARfeat(Temp',win)];                   % 1������������һ��ֵ
                end
                if(sum(strcmp(Feat_Kind,'ZCfeat')))
                   data_buff = [data_buff;extractZCfeat(Temp',win)];                    % 1������������һ��ֵ
                end
                Feat = [Feat;data_buff];
            end
            Train_Rest_Feat{c}  = Feat; 
            Train_Rest_Label{c} = [];
        end
end