%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.18

%%  Description:
%   function: 导入数据
%   path: 导入数据路径  savePath = 'E:\5_Team\6_My_project\programming\pattern recongnition\Data\loaddedData';
%   deviceName: 数据采集设备；
%   'TMSi'，'Delsys'，['EMG4RES4'，'EMG4','RES4']这三个都是自研设备EMG4RES4，只是用处不同：EMG4RES4肌电&阻抗；EMG4肌电；RES4阻抗；
%   EMGpos: Delsys 肌电通道所在位置信息
%   returnData: 返回读取到的数据；采取元胞(cell)格式：第一行为动作序号（字符串名称）；第二行为 第一行中每列名称对应的动作数据 
function returnData = loadData(path,deviceName,savePath,EMGpos)
    switch deviceName
        case 'EMG4RES4'
            returnData = EMG4RES4_matread(path,savePath);
            disp('-------- EMG4RES4 数据读取完成--------');
        case 'EMG4'
            returnData = EMG4_matread(path,savePath);
            disp('-------- EMG4 数据读取完成--------');
        case 'RES4'
            returnData = RES4_matread(path,savePath);
            disp('-------- RES4 数据读取完成--------');
        case 'TMSi'
            data = TMSi_csvread(path,savePath);
            [m n] = size(data); % 第一行为动作名称，第二行为各个名称对应的数据
            getLetterNum = 3;  % 取前3个字母作为受试者名称
            returnData{1,1} = data{1,1}(1:getLetterNum);
            for cnt1 = 1:n
                returnData{2,1}{1,cnt1} = data{2,cnt1}(100:end,:)';  %每通道前100个数据都不要，原因：采集系统还未稳定
            end
            disp('-------- TMSi 数据读取完成--------');
        case 'Delsys'
            returnData1 = Delsys_csvread(path,savePath); 
            if (nargin == 3)
                disp('--------由于未提供肌电位置信息，读取的 Delsys 数据包含时间和加速度信息-------'); 
                returnData2 = returnData1;
            else
                numChs = length(EMGpos);        %  通道数目
                [m n] = size(returnData1);      %  读取的 Delsys 数据数据结构 m--row, n--column
                for cnt1 = 1:n
                    returnData2{1,cnt1} =  returnData1{1,cnt1};
                    returnData2{2,cnt1} =  returnData1{2,cnt1}(:,EMGpos);
                end
                disp('-------- Delsys 数据读取完成--------');
            end
            [m n] = size(returnData2); % 第一行为动作名称，第二行为各个名称对应的数据
            getLetterNum = 3;  % 取前3个字母作为受试者名称
            returnData{1,1} = returnData2{1,1}(1:getLetterNum);
            for cnt1 = 1:n
                returnData{2,1}{1,cnt1} = returnData2{2,cnt1}(100:end,:)';  %每通道前100个数据都不要，原因：采集系统还未稳定
            end
    end
end



