function feats = extractKurtfeat(DataSet,framelen)
%extractKurtfeat Kurtosis (Kurt)
%   此处显示详细说明

Ntotal=size(DataSet,1);
Nsig=size(DataSet,2);

DataSet = DataSet - ones(Ntotal,Nsig)*mean(mean(DataSet));

for SigNum=1:Nsig
   clear kurt
   kurt=0;
   range = 1:framelen;
   kurt = kurtosis(DataSet(range,SigNum));
   feats(1,SigNum)=kurt;
end
end

