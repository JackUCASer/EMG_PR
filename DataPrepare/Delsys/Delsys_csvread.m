%% Description
%   csvPath: 读取csv文件的路径
%   EMGposition：读取肌电通道在csv文件中的位置
%   saveDataPath：读取csv文件后，数据的保存位置
%   saveDataName：读取csv文件后，数据的保存文件名
%   returnData: 返回读取到的数据，以元胞格式存储，第一行为文件名，第二行为文件名对应的数据
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
        %%  这里需视情况修改，
        readDelsysdata{2,i} = csvread(filename,1,0);   
    end
    save([saveDataPath,'\',saveDataName],'readDelsysdata');
    returnData = readDelsysdata;
end