function feats = extractZCfeat(DataSet,frameLen)
% 提取肌电信号过零率特征(Zero Crossings)
%   此处显示详细说明
DEADZONE=3;
Ntotal = size(DataSet,1);  % winSize==frameLen
Nsig = size(DataSet,2);  % nWin

DataSet = DataSet - ones(Ntotal,Nsig)*mean(mean(DataSet));

for SigNum=1:Nsig
    clear zero_count
    zero_count=0;
    flag2=1;
    for i=1:frameLen-2
        idx=1+i;
        fst=DataSet(idx-1,SigNum);
        mid = DataSet(idx,SigNum);
        lst = DataSet(idx+1,SigNum);
         % Compute Zero Crossings
        if ((mid>=0 & fst>=0) | (mid<=0 & fst<=0))
            flag1 = flag2;
        elseif ((mid<DEADZONE) & (mid>-DEADZONE) & (fst<DEADZONE) & (fst>-DEADZONE))
            flag1 = flag2;
        else
            flag1 = (-1)*flag2;
        end
        if (flag1~=flag2);
            zero_count = zero_count + 1;
            %flag1 = flag2;
        end
        zero_count=zero_count/frameLen;
        feats(1,SigNum)=zero_count;
    end
end

