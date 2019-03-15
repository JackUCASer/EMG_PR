%% Description
%   csvPath: ��ȡcsv�ļ���·��
%   csvRowStart: csv�ļ�����ʼ�㣬
%   csvColStart: csv�ļ�����ʼ��
%   saveDataPath����ȡcsv�ļ������ݵı���λ��
%   saveDataName����ȡcsv�ļ������ݵı����ļ���
%   returnData: ���ض�ȡ�������ݣ���Ԫ����ʽ�洢����һ��Ϊ�ļ������ڶ���Ϊ�ļ�����Ӧ������
%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%   Date : 2019.02.17
function returnData = TMSi_csvread(csvPath,saveDataPath,saveDataName,csvRowStart,csvColStart)
    if (nargin == 2)
        csvRowStart = 1;        % Ĭ�����п�ʼ����
        csvColStart = 2;
        saveDataName = 'readTMSidata.mat';
    end
    str=[csvPath,'\*.csv'];
    struct1=dir(str);
    lenStruct=length(struct1);
    for i=1:lenStruct
        filename=[csvPath,'\',struct1(i,1).name];
        readTMSidata{1,i} = struct1(i,1).name;
        %%  ������������޸ģ�
        readTMSidata{2,i} = csvread(filename,csvRowStart,csvColStart);   
    end
    save([saveDataPath,'\',saveDataName],'readTMSidata');
    returnData = readTMSidata;
end