function data=My_Diff(data)
%差分函数，两个点差分距离50个采样点
    l=length(data);
    df=50;
    s=data;
    data(1:l)=0;
    for k=df+1:l
        data(k)=(s(k)-s(k-df))/(df);
        %data(k)=(s(k)-s(k-df));
    end
end