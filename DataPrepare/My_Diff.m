function data=My_Diff(data)
%��ֺ������������־���50��������
    l=length(data);
    df=50;
    s=data;
    data(1:l)=0;
    for k=df+1:l
        data(k)=(s(k)-s(k-df))/(df);
        %data(k)=(s(k)-s(k-df));
    end
end