function [predictclass] = KNNclassifier(Curcl_tr,Curcl_te,targetcl_tr,K)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
test_data = Curcl_te;
train_data = Curcl_tr;
train_label= targetcl_tr;
N_test=size(test_data,1);   %计算测试样本数
% predicted=zero(1,N_test);

models=fitcknn(train_data,train_label');
predictclass=predict(models,test_data);

end

