%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.19

%%  Description:
%   function: 特征提取函数
%   TrainData: 待特征提取的动作、休息数据数据
%   win： 处理的窗长
%   win_inc： 窗长步进
%   nclass:  分类数
%   Feat_Kind：选择的特征提取函数
%   Remove_Mean：去直流分量
%   returnData: 返回预处理后的数据； 元胞(cell)形式
%                                       sub_x
%                                  Train_Act_Feat,
%                                  Train_Act_Label,
%                                  Train_Rest_Feat,
%                                  Train_Rest_Label
function returnData = data_feature(TrainData,win,win_inc,nclass,Feat_Kind,Remove_Mean)
    [m n] = size(TrainData);        % 获取数据结构，n有多少个受试者，
    returnData = cell(5,n);
    for cnt1 = 1:n                              % 遍历所有受试者    
        returnData{1,cnt1} = TrainData{1,cnt1}; % 受试者名称
        [m2 n2] = size(TrainData{2,cnt1});      % m2 表示一个受试者做了m2组的实验
        for cnt2 = 1:m2                         % 遍历单个受试者所有组数据
            [returnData{2,cnt1}{cnt2},returnData{3,cnt1}{cnt2},returnData{4,cnt1}{cnt2},returnData{5,cnt1}{cnt2}]...
            =Extract_Features2(TrainData{2,cnt1}(cnt2,:),TrainData{3,cnt1}(cnt2,:),win,win_inc,nclass,Feat_Kind,Remove_Mean);
        end 
        data = returnData(2:5,cnt1);        % 4行是固定的
        [m3 n3] = size(data{1,1});          % 获取组数
        [m4 n4] = size(data{1,1}{1,1});     % 获取每组分类数
        a =cell(1,n4);b =cell(1,n4);c =cell(1,n4);d =cell(1,n4);
        for cnt4 = 1:n4
            for cnt3 = 1:n3
                a{cnt4} = [a{cnt4},data{1,1}{1,cnt3}{1,cnt4}];
                b{cnt4} = [b{cnt4},data{2,1}{1,cnt3}{1,cnt4}];
                c{cnt4} = [c{cnt4},data{3,1}{1,cnt3}{1,cnt4}];
                d{cnt4} = [d{cnt4},data{4,1}{1,cnt3}{1,cnt4}];
            end
        end
        returnData{2,cnt1} = a;
        returnData{3,cnt1} = b;
        returnData{4,cnt1} = c;
        returnData{5,cnt1} = d;
    end
    disp('---------- 数据特征提取完成 --------');
end