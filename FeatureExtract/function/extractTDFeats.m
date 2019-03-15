
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% extractTDFeats	Compute all time domain features
%       			and the mean features [Hudgins 1991]
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function feats = extractTDFeats(DataSet,frameLen,nfeats)

%DEADZONE = 3;
DEADZONE = 10;

Ntotal = size(DataSet,1);  % winSize==frameLen
Nsig = size(DataSet,2);  % nWin
% ruler = 1/frameLen;		% inc=256; ruler=1/256=0.039
% rulersq = ruler^2;	% rulersq=ruler^2=0.0039^2=0.00001521. (GLI)
% DataSet = DataSet - ones(Ntotal,1)*mean(DataSet);
DataSet = DataSet - ones(Ntotal,Nsig)*mean(mean(DataSet));

feats = zeros(nfeats,Nsig);  % feats_number * nWin

for SigNum = 1:Nsig
    clear mav turns zero_count len;
    zero_count = 0;
    len = 0;
    %mav = 0;
    turns = 0;

%     index = 1;
%     range = index:index+frameLen-1;
    range = 1:frameLen;
    
    %%%%% Feature-1: Mean Absolute Value: mav (GLI)
    mav = mean(abs(DataSet(range,SigNum)));
    
    %%%%% Feature-2: Compute Zero Crossings
    %flag1 = 1;
    flag2 = 1;
    for i = 1:frameLen-2
        %idx = index + i;
        idx = 1 + i;
        fst = DataSet(idx-1,SigNum);
        mid = DataSet(idx,SigNum);
        lst = DataSet(idx+1,SigNum);

        % Compute Zero Crossings
        if ((mid>=0 & fst>=0) | (mid<=0 & fst<=0))
            flag1 = flag2;
        elseif ((mid<DEADZONE) & (mid>-DEADZONE) & (fst<DEADZONE) & (fst>-DEADZONE))
            flag1 = flag2;
        else
            flag1 = (-1)*flag2;
        end
        if (flag1~=flag2);
            zero_count = zero_count + 1;
            %flag1 = flag2;
        end
        
        % Compute Turns (Slope Changes£©
        if((mid>fst & mid>lst) | (mid<fst & mid<lst))
            % turns threshold of 15mV (i.e. 3uV noise)
            if (abs(mid-fst)>10) | (abs(mid-lst)>10)
                turns=turns+1;
            end
        end
        % Compute Waveform Length
        len = len + abs(fst-mid);
        %len = len + sqrt(((fst-mid)/20.0)^2 + rulersq); %Note: the difference from the fomula in the reference. 
    end
        % Scale the feats to normalize for the neural network
    len = len/frameLen;
    turns = turns/frameLen;
    zero_count = zero_count/frameLen;
    if nfeats ==4
        feats(:,SigNum) = [mav len zero_count turns]';  % feats_num * nWin
    elseif nfeats ==2
        feats(:,SigNum) = [mav len]';  % feats_num * nWin
    end
end

