%EXAMPLE 2

% Two covariant parameters, not gaussian

% Make ensemble for first parameter
%First parameter's moments
m1 = [0.88
      0.21
      0.06
      0.15];


interval = [0,3]; % Specify interval to let sigma-points fall in
[q1, w1] = generateEnsemble1D(m1, interval);

% The secind parameter
% Second parameter's moments
m2 = [0
      1
      0
      4];
[q2, w2] = generateEnsemble1D(m2); 


% Combine them
[q,w] = combineEnsembles(q1,w1,q2,w2);

% Covariance matrix
C = [0.21, 0.1;
     0.1,   1];

% Skew according to covariance matrix
qs = skewEnsemble(q,C);


%moments for both
m = [m1,m2];
%reduce with covariance
[qr,wr] = reduceEnsembleCovar(qs, m,C)

%check final ensembles moments
final_moments = weightedMoments(qr,wr,4)

%check covariance
final_cov = weightedCovariance(qr,wr)



