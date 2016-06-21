%EXAMPLE 0

% 3 parameters, 2 moments, some covariance

%cov matrix
C = [   1    0.4  -0.7 
       0.4    1    0.2
      -0.7   0.2    1   ];
 
 %moments
m = [0 , 2, -1    %mean values
     1 , 1   1];  %variances
    
%Binary ensemble for 2 moments
[q,w] = BinaryEns(m, C)


% check the moments
final_moments = weightedMoments(q,w,2)
%also check covariance
final_covariance = weightedCovariance(q,w) 


