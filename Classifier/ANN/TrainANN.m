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
    for targetclass = 1:nValidClass   % �����ض��Ķ������ͣ��ȼ���ѵ������Ŀ��targetTest��Ŀ�궯�����ͷ��ϵ��ܴ���
        idx = find(targetcl_te==targetclass);   % �ҵ���������һ�´������꣬�����������
        ndecision(targetclass) = length(idx);  % 11�������������յõ�1*11������ֵȫΪnWin�������Ԥ��ȫ��ȷ�Ļ����ܴ���ӦΪnWin��
        for predictedClass = 1:nValidClass     % ���ж��ض��������͵�LDA���Խ��(idx��Ӧλ��)��Ŀ�궯���Ƿ�һ�£�������ٷ���
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
