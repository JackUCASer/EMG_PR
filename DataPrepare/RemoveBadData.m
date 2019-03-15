function data= RemoveBadData( data )
%  去除数据的坏点，阻抗的值大于5000或小于-1000的点都可认为是坏点
%  此处显示详细说明
  n=length(data);
  temp=data;
  for i=2:n-1
      if(data(i)>600||data(i)<-100)
           data(i)=data(i-1);
      end
  end
data = medfilt1(data,15);
if(abs(max(max(data)))>600)
                plot(data')
end
end

