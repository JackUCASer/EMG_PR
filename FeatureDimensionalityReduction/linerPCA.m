%%   Design by Wang Yuan,Center for Neural Engineering,Institute of Biomedical and Health Engineering,SIAT,CAS
%     Date : 2019.03.13

%%  Description:
%   function: ���ݽ�ά
%   data: ��ѵ�����������ݣ�������Ϣ�Ͷ�����Ԫ����ʽ
%                                       sub_x
%                                  Train_Act_Feat,
%                                  Train_Act_Label,
%                                  Train_Rest_Feat,
%                                  Train_Rest_Label

%   returnData: ����Ԥ���������ݣ� Ԫ��(cell)��ʽ
%                                       sub_x
%                                  Train_Act_Feat,
%                                  Train_Act_Label,
%                                  Train_Rest_Feat,
%                                  Train_Rest_Label
%%
function returnData = linerPCA(data)    
    %----���ɷַ���������ֵ�Ŀռ�ֲ�---------------------------
    % 1����COEFF �����ɷַ�����������Э����������������(������ֵ�Ӵ�С��Ӧ��������������)��
    % 2����SCORE���ɷ֣�������X�ڵ�ά�ռ�ı�ʾ��ʽ��������Xȥ��ֵ�������ɷݷ���COEFF�ϵ�ͶӰ��
    %                                               ����Ҫ��kά����ֻ��Ҫȡǰk�����ɷַ�������
    % 3����latent������Э������������ֵ(�Ӵ�С����)��
    % score�ļ��㷽�����£�
    % data2 = bsxfun(@minus,data,mean(data,1));                 % ȥ��������ֵ
    % �ȼ�������������䣺
    % data2 = data -  repmat(mean(data,1),size(data,1),1);      % ȥ��������ֵ
    % score = data2 * coeff;                                    % ͶӰ
    %%
    [coeff,score,latent]= pca(data,'Centered',false);
    theta = 1-0.001;                % ���ɷ���ȡ����
    sumLatent = sum(latent);        % �ܳɷ�
    nEigenvalue = size(latent);     % ����ֵ����
    comSumLatent = 0;
    for i = 1:nEigenvalue
        comSumLatent = comSumLatent + latent(i);
        if comSumLatent/sumLatent > theta
            break;
        end
    end
    returnData = score(:,1:i);
%     %% ��ͼ�鿴ǰ�������ɷ�
%     figure;
%     biplot(coeff(:,1:2),'scores',score(:,1:2)});    
end

