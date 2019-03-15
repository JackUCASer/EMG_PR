%% Description
%   csvPath: 读取csv文件的路径
%   csvRowStart: csv文件行起始点，
%   csvColStart: csv文件列起始点
%   saveDataPath：读取csv文件后，数据的保存位置
%   saveDataName：读取csv文件后，数据的保存文件名
%   returnData: 返回读取到的数据，以元胞格式存储，第一行为文件名，第二行为文件名对应的数据
%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%   Date : 2019.02.17
function returnData = TMSi_csvread(csvPath,saveDataPath,saveDataName,csvRowStart,csvColStart)
    if (nargin == 2)
        csvRowStart = 1;        % 默认行列开始参数
        csvColStart = 2;
        saveDataName = 'readTMSidata.mat';
    end
    str=[csvPath,'\*.csv'];
    struct1=dir(str);
    lenStruct=length(struct1);
    for i=1:lenStruct
        filename=[csvPath,'\',struct1(i,1).name];
        readTMSidata{1,i} = struct1(i,1).name;
        %%  这里需视情况修改，
        readTMSidata{2,i} = csvread(filename,csvRowStart,csvColStart);   
    end
    save([saveDataPath,'\',saveDataName],'readTMSidata');
    returnData = readTMSidata;
end