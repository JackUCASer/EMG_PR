%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.03.13

%%  Description:
%   function: 数据降维
%   data: 待训练的特征数据，包含静息和动作；元胞格式
%                                       sub_x
%                                  Train_Act_Feat,
%                                  Train_Act_Label,
%                                  Train_Rest_Feat,
%                                  Train_Rest_Label

%   returnData: 返回预处理后的数据； 元胞(cell)形式
%                                       sub_x
%                                  Train_Act_Feat,
%                                  Train_Act_Label,
%                                  Train_Rest_Feat,
%                                  Train_Rest_Label
%%
function returnData = linerPCA(data)    
    %----主成分分析后画特征值的空间分布---------------------------
    % 1）、COEFF 是主成分分量，即样本协方差矩阵的特征向量(按特征值从大到小对应的特征向量排列)；
    % 2）、SCORE主成分，是样本X在低维空间的表示形式，即样本X去均值后在主成份分量COEFF上的投影，
    %                                               若需要降k维，则只需要取前k列主成分分量即可
    % 3）、latent：样本协方差矩阵的特征值(从大到小排列)；
    % score的计算方法如下：
    % data2 = bsxfun(@minus,data,mean(data,1));                 % 去除样本均值
    % 等价于下面这条语句：
    % data2 = data -  repmat(mean(data,1),size(data,1),1);      % 去除样本均值
    % score = data2 * coeff;                                    % 投影
    %%
    [coeff,score,latent]= pca(data,'Centered',false);
    theta = 1-0.001;                % 主成分提取比例
    sumLatent = sum(latent);        % 总成份
    nEigenvalue = size(latent);     % 特征值个数
    comSumLatent = 0;
    for i = 1:nEigenvalue
        comSumLatent = comSumLatent + latent(i);
        if comSumLatent/sumLatent > theta
            break;
        end
    end
    returnData = score(:,1:i);
%     %% 画图查看前两个主成分
%     figure;
%     biplot(coeff(:,1:2),'scores',score(:,1:2)});    
end

