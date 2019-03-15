function  feats = extractAR4feat(DataSet,frameLen,RemoveMean)
%extractARfeat 此处显示有关此函数的摘要
%   此处显示详细说明
Ntotal = size(DataSet,1);   
Nsig = size(DataSet,2);   
if(RemoveMean)
    DataSet = DataSet - ones(Ntotal,Nsig)*mean(mean(DataSet));
end
for SigNum=1:Nsig
    clear ar
    range=1:frameLen;
    ar=arburg(DataSet(range,SigNum),4);
    feats(:,SigNum)=ar(2:5); 
end

