function [predictclass] = ANNclassifier(Curcl_tr,Curcl_te,targetcl_tr,targetcl_te,nclass)

%% Arteficial Neural Network Classifier
% input_train = mapminmax(Curcl_tr,0,1);  % normalize the input data to [0,1]
% input_test = mapminmax(Curcl_te,0,1);  % normalize the input data to [0,1]

input_train = Curcl_tr;
input_test  = Curcl_te;
output = zeros(length(targetcl_tr), nclass) ;
for j = 1:length(targetcl_tr) 
    output(j,targetcl_tr(j)) = 1;
end
net = newff(input_train,output',[9 9],{'logsig' 'logsig'}); % Possible [6 5], [6 6]% [12 10]OptimalParameters
net.trainParam.epochs = 50;% 500 optimal val
net.trainParam.goal = 1e-6;
net.trainParam.max_fail = 25; % 25 optimal val
net.trainParam.mu = 1;
net.trainParam.lr = 0.01 ;% 0.01 optimal value
net = train(net,input_train,output');
temp_predictclass = sim(net,input_test);
[~,idx] = max(temp_predictclass);
predictclass = idx;

return
