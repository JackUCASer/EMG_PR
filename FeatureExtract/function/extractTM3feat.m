function feats = extractTM3feat(DataSet,framelen,RemoveMean)
%extractTM3feat solute Value Third Moment (TM3)
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
   clear tm3
   tm3=0;
   range = 1:framelen;
   tm3 = abs((mean((DataSet(range,SigNum)).^3)));
   %tm3 = abs((sum((DataSet(range,SigNum)).^3)));
   feats(1,SigNum)=tm3;
end
end
