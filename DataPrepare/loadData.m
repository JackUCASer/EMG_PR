%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.18

%%  Description:
%   function: ��������
%   path: ��������·��  savePath = 'E:\5_Team\6_My_project\programming\pattern recongnition\Data\loaddedData';
%   deviceName: ���ݲɼ��豸��
%   'TMSi'��'Delsys'��['EMG4RES4'��'EMG4','RES4']���������������豸EMG4RES4��ֻ���ô���ͬ��EMG4RES4����&�迹��EMG4���磻RES4�迹��
%   EMGpos: Delsys ����ͨ������λ����Ϣ
%   returnData: ���ض�ȡ�������ݣ���ȡԪ��(cell)��ʽ����һ��Ϊ������ţ��ַ������ƣ����ڶ���Ϊ ��һ����ÿ�����ƶ�Ӧ�Ķ������� 
function returnData = loadData(path,deviceName,savePath,EMGpos)
    switch deviceName
        case 'EMG4RES4'
            returnData = EMG4RES4_matread(path,savePath);
            disp('-------- EMG4RES4 ���ݶ�ȡ���--------');
        case 'EMG4'
            returnData = EMG4_matread(path,savePath);
            disp('-------- EMG4 ���ݶ�ȡ���--------');
        case 'RES4'
            returnData = RES4_matread(path,savePath);
            disp('-------- RES4 ���ݶ�ȡ���--------');
        case 'TMSi'
            data = TMSi_csvread(path,savePath);
            [m n] = size(data); % ��һ��Ϊ�������ƣ��ڶ���Ϊ�������ƶ�Ӧ������
            getLetterNum = 3;  % ȡǰ3����ĸ��Ϊ����������
            returnData{1,1} = data{1,1}(1:getLetterNum);
            for cnt1 = 1:n
                returnData{2,1}{1,cnt1} = data{2,cnt1}(100:end,:)';  %ÿͨ��ǰ100�����ݶ���Ҫ��ԭ�򣺲ɼ�ϵͳ��δ�ȶ�
            end
            disp('-------- TMSi ���ݶ�ȡ���--------');
        case 'Delsys'
            returnData1 = Delsys_csvread(path,savePath); 
            if (nargin == 3)
                disp('--------����δ�ṩ����λ����Ϣ����ȡ�� Delsys ���ݰ���ʱ��ͼ��ٶ���Ϣ-------'); 
                returnData2 = returnData1;
            else
                numChs = length(EMGpos);        %  ͨ����Ŀ
                [m n] = size(returnData1);      %  ��ȡ�� Delsys �������ݽṹ m--row, n--column
                for cnt1 = 1:n
                    returnData2{1,cnt1} =  returnData1{1,cnt1};
                    returnData2{2,cnt1} =  returnData1{2,cnt1}(:,EMGpos);
                end
                disp('-------- Delsys ���ݶ�ȡ���--------');
            end
            [m n] = size(returnData2); % ��һ��Ϊ�������ƣ��ڶ���Ϊ�������ƶ�Ӧ������
            getLetterNum = 3;  % ȡǰ3����ĸ��Ϊ����������
            returnData{1,1} = returnData2{1,1}(1:getLetterNum);
            for cnt1 = 1:n
                returnData{2,1}{1,cnt1} = returnData2{2,cnt1}(100:end,:)';  %ÿͨ��ǰ100�����ݶ���Ҫ��ԭ�򣺲ɼ�ϵͳ��δ�ȶ�
            end
    end
end



