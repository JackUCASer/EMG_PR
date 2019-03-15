%% Description
%   csvPath: 读取mat文件的路径
%   EMGposition：读取肌电通道在mat文件中的位置
%   saveDataPath：读取mat文件后，数据的保存位置
%   saveDataName：读取mat文件后，数据的保存文件名
%   returnData: 返回读取到的数据，以元胞格式存储，第一行为文件名，第二行为文件名对应的数据
%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%   Date : 2019.02.17
function returnData = EMG4RES4_matread(matPath,saveDataPath,saveDataName)
    if (nargin == 2)
        saveDataName = 'readEMG4RES4data.mat';
    end 
    str=[matPath,'\*.mat'];
    struct1=dir(str);
    lenStruct=length(struct1);
    for i=1:lenStruct
        filename=[matPath,'\',struct1(i,1).name];
        readEMG4RES4data{1,i} = struct1(i,1).name;
        %%  这里需视情况修改，
        data_buff = load(filename);
        readEMG4RES4data{2,i} = data_buff.save_data_buff;   
    end
    save([saveDataPath,'\',saveDataName],'readEMG4RES4data');
    returnData = readEMG4RES4data;   
end