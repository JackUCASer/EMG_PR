function[ConfusionMatrix]= TrainANN(allTDCoef,targetClass,nclass)
%% Computation
% using 5-fold cross validation
kk=10;
indices = crossvalind('Kfold',size(allTDCoef,1),kk);
TestError = 0;
ConfusionMatrix = zeros(nclass,nclass);

for i = 1:kk
    test = (indices == i); train = ~test;
    Curcl_tr = allTDCoef(train,:);
    Curcl_te = allTDCoef(test,:);
    targetcl_tr = targetClass(train);
    targetcl_te = targetClass(test);
    % Compute the LDA decisions and accuracy.
    [predictclass] =ANNclassifier(Curcl_tr',Curcl_te',targetcl_tr,targetcl_te,nclass);
%     [PeTrain,PeTest,TrainPredict,LDAPredict,Wg,Cg] = lda(Curcl_tr',Curcl_te',targetcl_tr,targetcl_te);
%     normLDATestErr = (1-PeTest)*100;
%     normLDATestErr
    
    nValidClass = max(targetcl_te); 
    confusion = zeros(nValidClass); 
    for targetclass = 1:nValidClass   % 对于特定的动作类型，先计算训练动作目标targetTest与目标动作类型符合的总次数
        idx = find(targetcl_te==targetclass);   % 找到动作类型一致处的坐标，并计算其次数
        ndecision(targetclass) = length(idx);  % 11个动作类型最终得到1*11矩阵，数值全为nWin，即如果预测全正确的话，总次数应为nWin次
        for predictedClass = 1:nValidClass     % 再判断特定动作类型的LDA测试结果(idx对应位置)与目标动作是否一致，并计算百分率
            nMatch(targetclass,predictedClass) = sum(predictclass(idx)==predictedClass);
            percent(targetclass,predictedClass) = nMatch(targetclass,predictedClass)./ndecision(targetclass);
        end
    end
    
%     TestError = TestError + normLDATestErr;
    ConfusionMatrix = ConfusionMatrix + percent;
end
% aveLDATestErr = TestError./kk;
% aveLDATestAcc = 100-TestError./kk;
ConfusionMatrix = ConfusionMatrix./kk;
ConfusionMatrix = ConfusionMatrix';

% fprintf('\nAverage Classification Error = %5.2f',aveLDATestErr);
% fprintf('\nAverage Classification Accuracy = %5.2f',aveLDATestAcc);
% fprintf('\n Confusion Matrix \n')
% disp(ConfusionMatrix)
