function feats = extractRMSfeat(DataSet,framelen,RemoveMean)
%extractRMSfeat Root Mean Square
% DataSet 为列向量,每列是一个窗
% RemoveMean 是否去掉均值
% 输出是一个行向量,即每个窗生成一个特征
%   此处显示详细说明

Ntotal=size(DataSet,1);
Nsig=size(DataSet,2);
if(RemoveMean)
    DataSet = DataSet - ones(Ntotal,Nsig)*mean(mean(DataSet));
end

for SigNum=1:Nsig
   clear rms
   rms=0;
   range = 1:framelen;
   rms = sqrt(mean((DataSet(range,SigNum)).^2));
   feats(1,SigNum)=rms;
end
end


