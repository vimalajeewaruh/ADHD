function [acc_ts, sensi, speci] = LogisticModel(Data, p)   
X_tr = Data.X_tr; Y_tr = Data.Y_tr; 
X_ts = Data.X_ts; Y_ts = Data.Y_ts;

    ytrain = Y_tr; % Target variable
    xtrain = zscore(X_tr);% Normalized Predictors

    xtrain =[ones(size(xtrain,1),1) xtrain]; % one is added for calculation of biases. 

    %compute cost and gradient
    iter=1000; % No. of iterations for weight updation

    theta=zeros(size(xtrain,2),1); % Initial weights

    alpha=0.1; % Learning parameter

    [J, grad, h, th]=cost(theta,xtrain,ytrain,alpha,iter); % Cost funtion
    
   
    ypred_tr = xtrain*th; 
    
    % probability calculation
    [hp]=sigmoid(ypred_tr); % Hypothesis Function
    ypred_tr(hp >= p) = 1;
    ypred_tr(hp < p) = 0;
    
    acc_train = (1 - sum(abs(ypred_tr - Y_tr))/length(Y_tr))*100;% correct classification percentage
    
    xtest = zscore(X_ts);% Normalized Predictors
    xtest = [ones(size(xtest,1),1) xtest]; % test data 
    ypred_ts = xtest*th; 

    % probability calculation
    [hp]=sigmoid(ypred_ts); % Hypothesis Function
    ypred_ts(hp >= p)=1;
    ypred_ts(hp < p)=0;
    
    acc_ts = (1 - sum(abs(ypred_ts - Y_ts))/length(Y_ts))*100;% correct classification percentage
    
    % sensitivity and specificivity 
    E_l = TestOutcome(Y_ts, ypred_ts);
    %[se_l,sp_l] = sesp(E_l(1),E_l(2), E_l(3), E_l(4));
    [sensi, speci, pre_l, ppv_l, npv_l, ac_l] = sesp(E_l(1),E_l(2), E_l(3), E_l(4));
    end