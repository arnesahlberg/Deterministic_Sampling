% Example 3

% Five independent parameters as follows

% 3 gaussian with
mu1 = 1; sig1 = 1.67e-2;
mu2 =  0.41; sig2 = 4.89e-3;
mu3 = 5.2; sig3 = 0.1;

% one weibull-distributed with
scl = 8.77e-2; shp = 45.54;

% one beta-distibuted with
A1 = 1.8; A2 = 2.2; p = 1.2; q = 2;

% Want to encode four moments
numberOfMoments = 4;

%Create ensemble

%The gaussian parameters:
% Can get their moments like this
mn1 = gaussMoments(sig1, numberOfMoments); mn1(1) = mu1;
mn2 = gaussMoments(sig2, numberOfMoments); mn2(1) = mu2;
mn3 = gaussMoments(sig3, numberOfMoments); mn3(1) = mu3;

mn = [mn1, mn2, mn3]; % The gaussian parameters moments

% Ensemble for the gaussian becomes
[qn,wn] = BlockDiagonalGaussian(mn);


%Weibull ensemble
[qw, ww, mw] =  generateWeibullEnsemble1D(scl,shp,numberOfMoments);
% the variable mw is the moments of the output ensemble

%Beta ensemble
[qb, wb, mb] = generateBetaEnsemble1D(p,q,A1,A2,numberOfMoments);
% the variable mb is the moments of the output ensemble


%Combine the unsymmetric ensembles
[qwb, wwb] = combineEnsembles(qw, ww, qb, wb);

% Reduce their size. 
[qwb, wwb] = reduceEnsemble(qwb, [mw, mb]);


[q, w] = combineEnsembles(qn, wn, qwb, wwb);


%moments for all distributions becomes
m = [mn1, mn2, mn3, mw, mb];

% Reduce final ensemble
[q , w] = reduceEnsemble(q,m)


