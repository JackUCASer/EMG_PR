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

function [TestPredict] = TestLDA(TestData,Wg,Cg)

Ptest = size(TestData,2);  % nWin*nClass
%%-- Compute the decision functions --%%
Ate = TestData'*Wg + ones(Ptest,1)*Cg;
AAte = compet(Ate');
TestPredict = vec2ind(AAte);

return;
