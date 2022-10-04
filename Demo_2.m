close all
clear all force
clc
addpath('MatlabFunctions')
load FeatureData1.mat;load Slope1.mat;

p      =  3;   % number of predictors 
k      = 20;   % number of nearest neightbors for KNN
tr_per = 0.80; % training samples %
n      = 1000; % number of training iterations 

As     = zeros(3, 8); Bs = zeros(3,8); Cs = zeros(3,8);D=zeros(3,p);

%% feature Engineering
isdata = 1;    % use only feature engineering data for the classification

% select most significant features
[X_caseP, X_controlP]= ClassiFeatures(FeatureData1, Slope1, isdata, p);

th = .5556; % Threshold for the logistic regression from Test9a

 Ac_l = zeros(n,3); Ac_svm = zeros(n,3);Ac_knn = zeros(n,3);
 
 for i = 1: n

    % select training and testing samples
    [X_tr, Y_tr, X_ts, Y_ts] = TrainTestSample(X_controlP, X_caseP, tr_per);

    Data.X_tr = X_tr; Data.Y_tr= Y_tr; Data.X_ts = X_ts; Data.Y_ts = Y_ts;

    %% Logistic
    [acc_ts, sensi, speci] = LogisticModel(Data, th) ;
    Ac_l(i,:) = [acc_ts, sensi, speci];
    
    %% SVM
    [acc_ts, sensi, speci] = SVMMOdel(Data) ;
    Ac_svm(i,:) = [acc_ts, sensi, speci];
    
    %% KNN   
    [acc_ts, sensi, speci] = KNNModel(Data, k) ;
    Ac_knn(i,:) = [acc_ts, sensi, speci];
 end 

ACC1(:, :) = [ mean(Ac_l,1); mean(Ac_svm,1); mean(Ac_knn,1)]

%% Slope data

isdata = 2;  % use only the slope data for the classification
th = .4444;  % Threshold for the logistic regression from Test9a

[X_caseP, X_controlP]= ClassiFeatures(FeatureData1, Slope1, isdata, p);

 Ac_l = zeros(n,3); Ac_svm = zeros(n,3);Ac_knn = zeros(n,3);
 for i = 1: n
    [X_tr, Y_tr, X_ts, Y_ts] = TrainTestSample(X_controlP, X_caseP, tr_per);

    Data.X_tr = X_tr; Data.Y_tr= Y_tr; Data.X_ts = X_ts; Data.Y_ts = Y_ts;

    %% Logistic
    [acc_ts, sensi, speci] = LogisticModel(Data, th) ;
    Ac_l(i,:) = [acc_ts, sensi, speci];
    
    %% SVM
    [acc_ts, sensi, speci] = SVMMOdel(Data) ;
    Ac_svm(i,:) = [acc_ts, sensi, speci];
    
    %% KNN   
    [acc_ts, sensi, speci] = KNNModel(Data, k) ;
    Ac_knn(i,:) = [acc_ts, sensi, speci];
end 



ACC2(:, :) = [ mean(Ac_l,1); mean(Ac_svm,1); mean(Ac_knn,1)]







    
