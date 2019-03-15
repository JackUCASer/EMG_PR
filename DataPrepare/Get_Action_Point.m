%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   本函数根据计算机记录的动作时间用来求取真实的人体动作时间
%   Temp_Data结构：6 X N 矩阵，前4行为形变阻抗值，第五行为时间（S），第六行为动作序号
%   输出：奇数点为休息点，偶数点为动作起始点（第一点为休息点，第二点为动作起始点）
%   需要My_Diff 和 RemoveBadData 两个函数支持

function Act_Point=Get_Action_Point(Temp_Data,Sampling_Rate,numAction)
 %--求计算机的动作起始点，存放在Comp_Act_Point中-----
        n=length(Temp_Data);
        diff_Temp_Data(1:n)=0;
        diff_Temp_Data(2:n)=diff(Temp_Data(end,:));                           % 计算机的动作起始点
        j=1;
        Comp_Act_Point(1)=1;                                                % 第一点为休息起始点
        i=1;
        while(i<=n)
            if(abs(diff_Temp_Data(i))>0.05)
                j=j+1;
                Comp_Act_Point(j)=i;                                        % 对于i，偶数为计算机的动作起始点，奇数为结束点（或休息起始点）
                i=i+2;
            else
                i=i+1;
            end
        end
        j=j+1; 
        Comp_Act_Point(j)=n;                                                % 最后一个点位置存储在Comp_Act_Point
                                                                            % 动作数
    %% --求人动作的起始点和结束点------------                           
            %分j个点存储在Act_Point中
            diff_Temp_Data=[];                                              % 求差分的数据
            diff_Temp_Data(1:n)=0;
            %% 这里最好事先画图查看四个通道，选取最佳的数据通道
            m = size(Temp_Data,1);
            for i=1:m-2
                a=Temp_Data(i,:);
                a=smooth(a,25);
                a=My_Diff(a);
                a=smooth(a,25);
                diff_Temp_Data=diff_Temp_Data+abs(a');
            end
            diff_Temp_Data=smooth(diff_Temp_Data,25);                       % 通道微分后的数据，方便求取动作点
            temp=diff_Temp_Data;
            Act_Threshold=1.8*mean(temp);                                   % 动作阈值取1.8倍的均值，每个动作起始点应该在计算机动作起始点和结束点之间
                                                                            % 休息起始点是在动作结束点和下一个动作起始点之间
            diff_Temp_Data=diff_Temp_Data>Act_Threshold;                    % 二值化
            
            for i=1:numAction
                %-----动作起始点--------------------
                Temp_Act_Data=[];
                Temp_Act_Data=diff_Temp_Data(Comp_Act_Point(2*i):Comp_Act_Point(2*i+1));
                t=0;
                for ii=1:length(Temp_Act_Data)
                    if(Temp_Act_Data(ii)>0.5)
                        t=ii;
                        break;
                    end
                end
                if(t==0)
                    disp('************************************')
                    disp('错误！未找到真实动作起始点！')
                    disp('暂时采用经验值0.2秒代替！')
                    disp('可能需要重设阈值Act_Threshold')
                    t=floor(Sampling_Rate*0.35);
                    %return;                                                % 终止程序
                end
                Act_Point(i*2)=t+Comp_Act_Point(2*i)-1;
                
                %----休息起始点-----------------
                Temp_Act_Data=[];
                Temp_Act_Data=diff_Temp_Data(Comp_Act_Point(2*i+1):Comp_Act_Point(2*i+2));
                t=0;
                for ii=1:length(Temp_Act_Data)
                    if(Temp_Act_Data(ii)>0.5)
                        t=ii;
                        break;
                    end
                end
                if(t==0)
                    disp('************************************')
                    disp('错误！未找到真实休息起始点！')
                    disp('暂时采用经验值0.2秒代替！')
                    disp('可能需要重设阈值Act_Threshold')
                     %return;
                     t=floor(Sampling_Rate*0.2);
                end
                
                Act_Point(i*2+1)=t+Comp_Act_Point(2*i+1)-1;
            end
            Act_Point(1)=1;
            Act_Point(numAction*2+1)=Comp_Act_Point(numAction*2+1);
end