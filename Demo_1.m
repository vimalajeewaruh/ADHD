close all
clear all force
clc

addpath('MatlabFunctions')

load FeatureData1.mat;load Slope1.mat;


p      =  8;  % number of predictors 
k      = 20; % number of nearest neightbors for KNN
tr_per = .80; % training samples %
As = zeros(3, 8); Bs = zeros(3,8); Cs = zeros(3,8);D=zeros(3,p);
n = 1000;
%% feature Engineering
isdata = 1;    
[X_caseP, X_controlP]= ClassiFeatures(FeatureData1, Slope1, isdata, p);

th = linspace(0,1,10); ACC1 = zeros(length(th),3);

for j = 1 : length(th)
    Ac = zeros(n,3);
   
    for i = 1: n
        [X_tr, Y_tr, X_ts, Y_ts] = TrainTestSample(X_controlP, X_caseP, tr_per);

        Data.X_tr = X_tr; Data.Y_tr= Y_tr; Data.X_ts = X_ts; Data.Y_ts = Y_ts;

        [acc_ts, sensi, speci] = LogisticModel(Data, th(j)) ;
        
        Ac(i,:) = [acc_ts, sensi, speci];
    end 

    ACC1(j, :) = mean(Ac,1);
end 

%% Self-similarity
isdata = 2; 

ACC2 = zeros(length(th),3);
for j = 1 : length(th)
    Ac = zeros(n,3);
    for i = 1: n
    [X_caseP, X_controlP]= ClassiFeatures(FeatureData1, Slope1, isdata, p);

    [X_tr, Y_tr, X_ts, Y_ts] = TrainTestSample(X_controlP, X_caseP, tr_per);

    Data.X_tr = X_tr; Data.Y_tr= Y_tr; Data.X_ts = X_ts; Data.Y_ts = Y_ts;

    [acc_ts, sensi, speci] = LogisticModel(Data, th(j)) ;
    Ac(i,:) = [acc_ts, sensi, speci];
    end 

    ACC2(j, :) = mean(Ac,1);
end 


x = linspace(0,12);
y = linspace(0,12);

t = tiledlayout('flow');
lw = 1.0;  set(0, 'DefaultAxesFontSize', 16);
fs = 15;  msize = 15;

%% ROC Curves 
figure(1)
subplot(111)
    plot(1-ACC1(:,3), ACC1(:,2), '-xk', 'LineWidth', 2); hold on
    plot(1-ACC2(:,3), ACC2(:,2), '-*r', 'LineWidth', 2);
    xlabel('1-Specificity', 'FontSize', 20);ylabel('Sensitivity', 'FontSize', 20)
    ylim([0 1])
    plot(x,y, '--g', 'LineWidth', 2);
    legend('Feature Engineering', 'Self-Similarity')
    hold off
    grid on

z1 = (ACC1(:,2)+ACC1(:,3) -1)/ sqrt(2);[t,c] = max(z1); th(c)
z2 = (ACC2(:,2)+ACC2(:,3) -1)/ sqrt(2);[t,c] = max(z2); th(c)

%% Distribution of Hurst exponent of cases and controls

figure(2)

[f,xi] = ksdensity(-(mean(X_caseP,2)+1)/2); 
plot(xi,f, 'r-','linewidth', 2);

hold on
[f,xi] = ksdensity(-(mean(X_controlP,2)+1)/2); 
plot(xi,f,'b--','linewidth', 2);

legend(["Cases", " Controls"])
%title("Positive correlation",'fontweight','bold','fontsize',fs )
ylabel("Probability",'fontsize',fs )
xlabel("Hurst Exponent (H)",'fontsize',fs )
grid on
hold off



