%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.21

%%  Description:
%   function: Delsys����Ԥ����
%   data: �����������
%   ChsChoice����Ҫ�����ͨ��
%   fs: ԭʼ���ݲ�����
%   downFs: ��������
%   numAction: ����������Ҫ˵������ʵ�ʲ���ʱ��Ϣ���ȶ�������1����������ȡ��Ϣ����ڶ�����
%   returnData: ����Ԥ���������ݣ�
%               Ԫ��(cell)��ʽ����һ��Ϊ���������ƣ��ڶ���ΪnumAction���������ݣ�������ΪnumAction����Ϣ����
function returnData = Delsysdata_preprocess(data,ChsChoice,fs,downFs,numAction)
    %% ����Ԥ�������²���-> ȥ���㣨ƽ���� -> ��ʱ��Ͷ����²���
    [m n] = size(data);     % ��ȡ���ݽṹ��������豸����һ��Ϊ�����ߣ��ڶ���Ϊ�����ߵļ��鶯��
    for cnt1 = 1:n          % �б���
        [m2 n2] = size(data{2,cnt1});                           % ��ȡ�����߶�������n2
        Pre_Data{1,cnt1} = data{1,cnt1};                        % �����߲���
        for cnt2 = 1:n2
           Pre_Data{2,cnt1}{1,cnt2} = TMSiData_Pre_Proc(data{2,cnt1}{1,cnt2},fs,ChsChoice,downFs);      
        end   
    end
    %% ���ݷֶΣ���ÿ��ÿ�������ָ����
    [m n] = size(Pre_Data);     % ��ȡ���ݽṹ��������豸����һ��Ϊ�����ߣ��ڶ���Ϊ�����ߵļ��鶯��
    dataSeg = cell(3,n);
    for cnt1 = 1:n          % �б���
        dataSeg{1,cnt1} = Pre_Data{1,cnt1};
        [dataSeg{2,cnt1},dataSeg{3,cnt1}] = TMSiData_Segmentation(Pre_Data{2,cnt1},downFs,numAction);
    end
    returnData = dataSeg;
end