%Example 5

% Example of 21 Gaussian parameters, 3 of which have covariance described by matrix
C = [1    0.5   -0.2
     0.5   1     0.3
    -0.2  0.3     1  ] ;

% Ensemble for the 18 independent parameters. Let's pick the simple moments
m1 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
      1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
      3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3];

[q1, w1] = BlockDiagonalGaussian(m1);

% Ensemble for the 3 covariant parameters
m2 = [0,0,0
      1,1,1
      0,0,0
      3,3,3];
% Use the Corner method to get a covariant ensemble for the covariant parameters.
[q2,w2] = CornersEnsemble(m2,C);

%Combine them
[q,w] = combineEnsembles(q1,w1,q2,w2);

%Reduce ensemble to smaller size must enforce the total covariance. That's why a large covariance matrix is created and the lower right corner becomes the one for the three dependent parameters
Ctot = diag(ones(1,21));
Ctot(19:21, 19:21) = C;

%and total moments variable
mtot = [m1, m2];

% now reduce and get final ensemble, which will have 34 sigma-points.
[q,w] = reduceEnsembleCovar(q, mtot, Ctot)



