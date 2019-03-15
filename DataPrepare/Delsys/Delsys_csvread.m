%% Description
%   csvPath: ��ȡcsv�ļ���·��
%   EMGposition����ȡ����ͨ����csv�ļ��е�λ��
%   saveDataPath����ȡcsv�ļ������ݵı���λ��
%   saveDataName����ȡcsv�ļ������ݵı����ļ���
%   returnData: ���ض�ȡ�������ݣ���Ԫ����ʽ�洢����һ��Ϊ�ļ������ڶ���Ϊ�ļ�����Ӧ������
%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%   Date : 2019.02.17
function returnData = Delsys_csvread(csvPath,saveDataPath,saveDataName)
    if (nargin == 2)                        
        saveDataName = 'readDelsysdata.mat';
    end
    str=[csvPath,'\*.csv'];
    struct1=dir(str);
    lenStruct=length(struct1);
    for i=1:lenStruct
        filename=[csvPath,'\',struct1(i,1).name];
        readDelsysdata{1,i} = struct1(i,1).name;
        %%  ������������޸ģ�
        readDelsysdata{2,i} = csvread(filename,1,0);   
    end
    save([saveDataPath,'\',saveDataName],'readDelsysdata');
    returnData = readDelsysdata;
end