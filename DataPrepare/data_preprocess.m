%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.19

%%  Description:
%   function: 数据预处理
%   numAction: 动作数，需要说明的是实际测量时休息数比动作数多1，但是我们取休息书等于动作数
%   ChsChoice：通道选择(向量格式)，为空时，选择所有通道；
%   ActChoice：动作选择，空集选择所有动作；向量或者标量
%   returnData: 返回预处理后的数据； 
%               元胞(cell)形式，第一行为受试者名称，第二行为numAction个动作数据，第三行为numAction个休息数据
%                  sub_x
%               action data
%                rest data
function returnData = data_preprocess(data,deviceName,ChsChoice,ActChoice,fs,numAction)
    switch deviceName
        case 'EMG4RES4'
            downFs = fs;
            returnData = EMG4RES4data_preprocess(data,ChsChoice,fs,downFs,numAction);
            disp('-------- EMG4RES4 数据预处理完成--------');
        case 'EMG4'
            downFs = fs;
            returnData = EMG4data_preprocess(data,ChsChoice,fs,downFs,numAction);
            disp('-------- EMG4 数据预处理完成--------');
        case 'RES4'
            downFs = fs;
            returnData = RES4data_preprocess(data,ChsChoice,fs,downFs,numAction);
            disp('-------- RES4 数据预处理完成--------');
        case 'TMSi'
            downFs = fs;
            returnData = TMSidata_preprocess(data,ChsChoice,fs,downFs,numAction);
            disp('-------- TMSi 数据预处理完成--------');
        case 'Delsys'
            downFs = fs;
            returnData = Delsysdata_preprocess(data,ChsChoice,fs,downFs,numAction);
            disp('-------- Delsys 数据预处理完成--------');
    end
    if isempty(ActChoice)~= 1           % 如果ActChoice不为空
        [m n] = size(returnData);       % 读取returnData格式
        for cnt = 1:n                   % 遍历每个受试者
            data{1,cnt} = returnData{1,cnt};
            data{2,cnt} = returnData{2,cnt}(:,ActChoice);   % 读取选定的动作
            data{3,cnt} = returnData{3,cnt}(:,ActChoice);   % 读取选定的动作
        end
        returnData = data;
    end
end