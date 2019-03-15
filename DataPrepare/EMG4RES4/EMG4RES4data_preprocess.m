%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.19

%%  Description:
%   function: EMG4RES4����Ԥ����
%   data: �����������
%   ChsChoice����Ҫ�����ͨ��
%   fs: ԭʼ���ݲ�����
%   downFs: ��������
%   numAction: ����������Ҫ˵������ʵ�ʲ���ʱ��Ϣ���ȶ�������1����������ȡ��Ϣ����ڶ�����
%   returnData: ����Ԥ���������ݣ�
%               Ԫ��(cell)��ʽ����һ��Ϊ���������ƣ��ڶ���Ϊ ����*numAction ���������ݣ�������Ϊ ����*numAction�� ��Ϣ����
%                 sub_x
%              ����*numAction  ����
%              ����*numAction  ��Ϣ
function returnData = EMG4RES4data_preprocess(data,ChsChoice,fs,downFs,numAction)
    %% ����Ԥ�������²���-> ȥ���㣨ƽ���� -> ��ʱ��Ͷ����²���
    [m n] = size(data);     % ��ȡ���ݽṹ��������豸����һ��Ϊ�����ߣ��ڶ���Ϊ�����ߵļ��鶯��
    for cnt1 = 1:n          % �б���
        [m2 n2] = size(data{2,cnt1});                           % ��ȡ�����߶�������n2
        Pre_Data{1,cnt1} = data{1,cnt1};                        % �����߲���
        for cnt2 = 1:n2
           if isempty(data{2,cnt1}{1,cnt2}) ~=1
                Pre_Data{2,cnt1}{1,cnt2} = EMG4RES4Data_Pre_Proc(data{2,cnt1}{1,cnt2},fs,downFs);  
           end
        end   
    end
    %% ���ݷֶΣ���ÿ��ÿ�������ָ����
    [m n] = size(Pre_Data);     % ��ȡ���ݽṹ��������豸����һ��Ϊ�����ߣ��ڶ���Ϊ�����ߵļ��鶯��
    dataSeg = cell(3,n);
    for cnt1 = 1:n          % �б���
        dataSeg{1,cnt1} = Pre_Data{1,cnt1};
        [dataSeg{2,cnt1},dataSeg{3,cnt1}] = EMG4RES4Data_Segmentation(Pre_Data{2,cnt1},downFs,numAction,ChsChoice);  % һ�����ͽ�ȥ�ü���
    end
    returnData = dataSeg;
end