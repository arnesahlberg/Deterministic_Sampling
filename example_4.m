%EXAMPLE 4

% 4 Gaussian parameters with covariance
C = [  1    0.3  0.2   0.1 
      0.3    2   0.25  0.4
      0.2  0.23   1    0.15
      0.1  0.4   0.15    0.2    ];
      
%the moments 
moments = [0,0,0,0       % mean values
           1,2,1,0.2     % variances
           0,0,0,0       % mom 3 = 0
           3,12,3,0.12]; % mom 4 = 3*variance^2

           
%Create the base ensemble - 
[q,w] = CornersEnsemble(moments, C)


%Now have final ensemble. 
% check the moments
final_moments = weightedMoments(q,w,4)
% also check covariance
final_covariance = weightedCovariance(q,w)