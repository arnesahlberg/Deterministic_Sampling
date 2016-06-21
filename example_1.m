%EXAMPLE 1

%Five Gaussian parameters without covariance
%and encode four moments

%define moments
moments = [0,2,6,3,2       % mean values
           1,2,1,0.2,0.3   % variances
           0,0,0,0,0       % mom 3 = 0
           3,12,3,0.12,0.27]; % mom 4 = 3*variance^2
           
% create heavy middle ensemble
[q,w] = HeavyMiddleEnsemble(moments)
%could also have used, which only works for Gaussian parameters:
%[q,w] = BlockDiagonalGaussian(moments)


% check the moments
final_moments = weightedMoments(q,w,4)
%also check covariance
final_covariance = weightedCovariance(q,w)

