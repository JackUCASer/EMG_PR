function data= RemoveBadData( data )
%  ȥ�����ݵĻ��㣬�迹��ֵ����5000��С��-1000�ĵ㶼����Ϊ�ǻ���
%  �˴���ʾ��ϸ˵��
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

