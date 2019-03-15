function [ RA,AP ] = GetRand( randdata )
%UNTITLED 得到动作的随机序列
%   此处显示详细说
RA=[];
AP=[];
t=1;
len=length(randdata);
s=diff(randdata);
for i=1:len-1
    if s(1,i)>0;
        RA(1,t)=s(1,i);
        AP(1,t)=i;
        t=t+1;
    end
end
 
end

