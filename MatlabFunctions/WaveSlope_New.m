%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the spectral slope by using fast distance covariance method
% Input
%   data - pupil diameter data signals
%   windowSize - data window size used to compute slope 
%   hfilt - wavelet filter 
%   L - wavelet decomposition level
%   k1, k2 - dydic range used to evaluate slope 

% Output
%   SlopeMat - Slope matrix 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function SlopeMat = WaveSlope_New(data, windowSize, hfilt,L, k1, k2) 
n = 2^windowSize;
d_window = 1: n : size(data,3);length(d_window)
SlopeMat = zeros( size(data,1),length(d_window));%standard
for i = 1:size(data,1)
    A = zeros(size(data,2),length(d_window));
    for p = 1:size(data,2)
        Slop = [];
        for j = 1: length(d_window)
            start =  d_window(j); 
            range = start:start+(n-1);
           [slope, levels, log2spec ] = waveletspectraFDC(data(i,p,range), L, hfilt, k1, k2, 1,0);
           Slop = [Slop, slope];
        end
        Slop( find(isnan(Slop)) ) = 0;
        A(p,:) = Slop;
    end
    SlopeMat(i, :) = mean(A,1);
end 