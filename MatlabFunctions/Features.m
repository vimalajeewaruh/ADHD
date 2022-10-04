%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Construct features defined in the Engineering method 
% (Read A robust Machine learning based framework for the automated detection
% of ADHD using pupillometric Biomarker and time series analysis, William Das and Shubh Khanna, 2021 
% for more details about the feaures)

% Inputs
%   group  - cases(medication on and off and controls) --> on-ADHD and
%   off-ADHD
%   data   - raw pupil diameter data

% Outputs
%   F - featrue matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function F = Features(group, data)
l = length(group);
Z = zeros(l, 160, 8000);
for j = 1: l
    k = group(j);
    TaskEpoch =  data(k).Task_epocs;
        pupil = TaskEpoch.Pupil;
        
    for i  = 1: 160
        pupil{i,1}(find(isnan(pupil{i,1}))) = 0;
        pupil{i,2}(find(isnan(pupil{i,2}))) = 0;
        Z(j,i,:) = pupil{i,1};
    end
end 

v = @(p,t) [p/t, p/t^2]; 
V = zeros( l, 160, 8000); Ac = zeros( l, 160, 8000);
for i = 1:l
    for j = 1: 160
        a = diff(Z(i,j,:));
        t = diff(1: 8000);
        for k = 1: length(t)
           A =  v(a(i), t(i));
           V(i,j,k+1) = A(1); Ac(i,j,k+1) = A(2);
        end 
    end 
end

F = zeros(l, 22, 160);
for i  =1: l
    for j = 1: 160
        F(i,1,j) = max(Z(i, j, 5000:7000));
        F(i,2,j) = max(Z(i, j, 1:5000));
        F(i,3,j) = min(Z(i, j, 6500:8000));
        F(i,4,j) = mean(Z(i, j, 5500:7000));
        F(i,5,j) = std(Z(i, j, :));
        F(i,6,j) = kurtosis(Z(i,j,:));
        F(i,7,j) = skewness(Z(i,j,:));
        F(i,8,j) = median(Z(i,j,:));
        F(i,9,j) = mean(Z(i,j,:));
        F(i,10,j) = mean(V(i,j,1:4999));
        F(i,11,j) = mean(V(i,j,5000:8000));
        F(i,12,j) = max(V(i,j,1:4999));
        F(i,13,j) = max(V(i,j,5000:8000));
               a1 = cumsum(V(i,j,1:4999));
        F(i,14,j) = a1(end);
               a2 = cumsum(V(i,j,5000:8000));
        F(i,15,j) = a2(end);
        F(i,16,j) = a2(end) - a1(end);
        F(i,17,j) = max(V(i,j,5000:8000)) - max(V(i,j,1:4999));
        F(i,18,j) = mean(Z(i, j, 1:5000)) - a1(end);
        F(i,19,j) = max(V(i,j,5000:8000)) - a1(end);
        F(i,20,j) = max(Ac(i,j,5000:7000));
        F(i,21,j) = min(Ac(i,j,5000:7000));
        F(i,22,j) = mean(Ac(i,j,5000:7000));        
    end 
end 

