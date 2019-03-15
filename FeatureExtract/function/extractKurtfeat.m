function feats = extractKurtfeat(DataSet,framelen)
%extractKurtfeat Kurtosis (Kurt)
%   �˴���ʾ��ϸ˵��

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

