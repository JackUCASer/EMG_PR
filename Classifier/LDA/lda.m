%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LDA	Perform a linear discriminant analysis
%
%	Inputs: TrainData,TestData          - Train,test data arranged in columns
%			TrainClass,TestClass 		- vectors of class membership
%	Outputs:PeTrain,PeTest 				- probability of error
%			TrainPredict,TestPredict 	- predicted values
%			Wg,Cg 						- LDA weights
% (c) Kevin Englehart,1997
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [PeTrain,PeTest,TrainPredict,TestPredict,Wg,Cg] = lda(TrainData,TestData,TrainClass,TestClass)
N = size(TrainData,1);  % nfeat*nchan
Ptrain = size(TrainData,2); % nWin*nClass
Ptest = size(TestData,2);

sc = std(TrainData(:));
TrainData = TrainData;% + sc./1000.*randn(size(TrainData)); %add random noise into TrainData File (GLI)

K = max(TrainClass);

%%-- Compute the means and the pooled covariance matrix --%%
C = zeros(N,N);
for l = 1:K;
	idx = find(TrainClass==l);				% Find each of classes-->l=1,2,3,......(GLI)
	Mi(:,l) = mean(TrainData(:,idx)')';     % Get the mean of each class. (GLI)   N*1,N*2,......N*nClass
	C = C + cov((TrainData(:,idx)-Mi(:,l)*ones(1,length(idx)))');	% Get the covariance of all data (GLI)      N*N
end

C = C./K;
Pphi = 1/K; % Estimate of the prior probability of class k. All are same=1/K (GLI)
Cinv = inv(C);	% Inverse matrix of "pooled" covariance matrix

%%-- Compute the LDA weights --%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% (RIC/GLI, 07/05/2006)
%%%%% Linear Discriminant Function: 
%%%%%   Delta(k)=X'*inv(COV)*Mean(k)-Mean(k)'*inv(COV)*Mean(k)/2+log(pi(k))
%%%%%           =X'*Wg+Cg
%%%%%   Where Wg=inc(COV)*Mean(k);
%%%%%         Cg=-(1/2)*Mean(k)'*inv(COV)*Mean(k)+log(pi(k)).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:K
	Wg(:,i) = Cinv*Mi(:,i);  % N*1,N*2,......N*nClass
	Cg(:,i) = -1/2*Mi(:,i)'*Cinv*Mi(:,i) + log(Pphi)';  % 1,1*2,.....1*nClass
end


%%-- Compute the decision functions --%%
Atr = TrainData'*Wg + ones(Ptrain,1)*Cg;
Ate = TestData'*Wg + ones(Ptest,1)*Cg;

errtr = 0;
AAtr = compet(Atr');    % compet--Competitive Transfer Function (GLI)
errtr = errtr + sum(sum(abs(AAtr-ind2vec(TrainClass))))/2; %Total Classified Error of Training Set.
netr = errtr/Ptrain;
PeTrain = 1-netr;

TrainPredict = vec2ind(AAtr);

errte = 0;
AAte = compet(Ate');
errte = errte + sum(sum(abs(AAte-ind2vec(TestClass))))/2; %Total Classified Error of Test Set.
nete = errte/Ptest;
PeTest = 1-nete;

TestPredict = vec2ind(AAte);

return;
