% SVM Classifier
% Compute the SVM decisions and accuracy.
function [predictclass] = SVMclassifier(Curcl_tr,Curcl_te,targetcl_tr,targetcl_te)
% tstart = clock; % Start time
targetcl_tr = targetcl_tr'; 
Curcl_te = Curcl_te';
model = svmtrain(targetcl_tr,Curcl_tr,'-t 0 -c 4 -g 0.0313 -b 1');
[predictclass,accuracy,dec_values]=svmpredict(targetcl_te',Curcl_te',model);
%% calculate time-cost
% tend = clock;
% time = tend-tstart;
return
