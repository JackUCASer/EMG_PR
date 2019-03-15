%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.02.19

%%  Description:
%   function: ������ȡ����
%   TrainData: ��������ȡ�Ķ�������Ϣ��������
%   win�� ����Ĵ���
%   win_inc�� ��������
%   nclass:  ������
%   Feat_Kind��ѡ���������ȡ����
%   Remove_Mean��ȥֱ������
%   returnData: ����Ԥ���������ݣ� Ԫ��(cell)��ʽ
%                                       sub_x
%                                  Train_Act_Feat,
%                                  Train_Act_Label,
%                                  Train_Rest_Feat,
%                                  Train_Rest_Label
function returnData = data_feature(TrainData,win,win_inc,nclass,Feat_Kind,Remove_Mean)
    [m n] = size(TrainData);        % ��ȡ���ݽṹ��n�ж��ٸ������ߣ�
    returnData = cell(5,n);
    for cnt1 = 1:n                              % ��������������    
        returnData{1,cnt1} = TrainData{1,cnt1}; % ����������
        [m2 n2] = size(TrainData{2,cnt1});      % m2 ��ʾһ������������m2���ʵ��
        for cnt2 = 1:m2                         % ������������������������
            [returnData{2,cnt1}{cnt2},returnData{3,cnt1}{cnt2},returnData{4,cnt1}{cnt2},returnData{5,cnt1}{cnt2}]...
            =Extract_Features2(TrainData{2,cnt1}(cnt2,:),TrainData{3,cnt1}(cnt2,:),win,win_inc,nclass,Feat_Kind,Remove_Mean);
        end 
        data = returnData(2:5,cnt1);        % 4���ǹ̶���
        [m3 n3] = size(data{1,1});          % ��ȡ����
        [m4 n4] = size(data{1,1}{1,1});     % ��ȡÿ�������
        a =cell(1,n4);b =cell(1,n4);c =cell(1,n4);d =cell(1,n4);
        for cnt4 = 1:n4
            for cnt3 = 1:n3
                a{cnt4} = [a{cnt4},data{1,1}{1,cnt3}{1,cnt4}];
                b{cnt4} = [b{cnt4},data{2,1}{1,cnt3}{1,cnt4}];
                c{cnt4} = [c{cnt4},data{3,1}{1,cnt3}{1,cnt4}];
                d{cnt4} = [d{cnt4},data{4,1}{1,cnt3}{1,cnt4}];
            end
        end
        returnData{2,cnt1} = a;
        returnData{3,cnt1} = b;
        returnData{4,cnt1} = c;
        returnData{5,cnt1} = d;
    end
    disp('---------- ����������ȡ��� --------');
end