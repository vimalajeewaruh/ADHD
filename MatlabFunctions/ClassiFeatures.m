%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Create feature matrics using features computed in engineering and sel-similarity approaches 

%%%%% Inputs 
% data     - case and control spectra
% slope    - case and control slope matrix from  of data
% hfilt    - wavelet filter
% L        - wavelet decomposition level
% tr_per   - percentage of data samples for training classification model
% p        -   number of perdictors from slope metrics
% isdata   - data used for the classification 1 - On, 2 -off, 3 - on+off
% ismethod - fisher, slope, and both

%%%%% Output
% Ac       - percentage of correct classification 
% Pef      - Sensitivity and specifivity

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [X_caseP, X_controlP]= ClassiFeatures(FeatureData, Slope, isdata, p)

%% Features Engineering
Control = FeatureData.FControl;
CaseOn  = FeatureData.FCaseOn;
CaseOff = FeatureData.FCaseOff;

% Control
X_n1 = mean(Control(:,:,1:159),3);
X_n1(find(isnan(X_n1))) = 0 ;
X_n1 = RemoveEmpty(X_n1, 0.8);
X_n1 = DataMissing(X_n1);

% CaseOn
% X_c11 = mean(CaseOn(:,:,1:159),3);
% X_c11(find(isnan(X_c11))) = 0 ;
% X_c11 = RemoveEmpty(X_c11, 0.8);
% X_c11 = DataMissing(X_c11);

% CaseOff
X_c12 = mean(CaseOff(:,:,1:159),3);
X_c12(find(isnan(X_c12))) = 0 ;
X_c12 = RemoveEmpty(X_c12, 0.8);
X_c12 = DataMissing(X_c12);

%% Slope
Slop_Control = RemoveEmpty(Slope.Slop_Control, 0.8);
Slop_CaseOn  = RemoveEmpty(Slope.Slop_CaseOn, 0.8);
Slop_CaseOff = RemoveEmpty(Slope.Slop_CaseOff, 0.8);

Slop_Control = DataMissing(Slop_Control);
Slop_CaseOn  = DataMissing(Slop_CaseOn);
Slop_CaseOff = DataMissing(Slop_CaseOff);

k = min(size(Slop_Control,2), min(size(Slop_CaseOn,2), size(Slop_CaseOff,2))); 
X_n2 = Slop_Control(:,1:k); 

if isdata == 1 % Feature Engineering Approach
    X_case    = X_c12;
    X_control = X_n1;
elseif isdata == 2 % Self-similarity Approach
    X_control = X_n2;
    X_case    = Slop_CaseOff(:,1:k);

end 

% Control and case data windows that show a significant difference w.r.t. slope
d = (mean(X_control,1) - mean(X_case,1)).^2./ (var(X_control,1) + var(X_case,1));
d(find(isnan(d))) = 0;

% find column indexes at which mean slope is greater that 50th quantile  
[r, k] = maxk(d, p); % max p entries of d

% predictor maxtrixes for case and control with only k indexes
X_caseP = X_case(:,k); X_controlP = X_control(:,k);

end