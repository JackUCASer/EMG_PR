function feats = extractLOGDfeat(DataSet,framelen,RemoveMean)
%extractLOGDfeat Mean Logarithm Kernel (mLogdkernel)
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
   clear logd
   logd=0;
   range = 1:framelen;
   logdkernel = abs(DataSet(range,SigNum));
   
   logd = exp(mean(log(logdkernel)));
   feats(1,SigNum)=logd;
end
end


