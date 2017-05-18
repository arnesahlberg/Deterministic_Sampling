%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Generates an ensemble for the LogNormal distribution
% input:
%   mu - the mu parameter of the lognormal distribution
%   sigma - the sigma parameter of the lognormal distribution
%   nummoments - the number of moments to fulfill
%
% [q, W, outputmoments, themoments] = generateLogNormalEnsemble1D(mu, sigma, nummoments)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [q, W, outputmoments, themoments] = generateLogNormalEnsemble1D(mu, sigma, nummoments)

themoments = logNormalMoments(mu,sigma,nummoments);

W = NA;

numpointsguessed = 200;

maxtries = 100;
tries = 0;

err = 1e6; ertol = themoments(2) / 1e6; besterr = 1e6;

while (tries < maxtries && err > ertol)
  q = lognrnd(mu, sigma, [numpointsguessed,1]);
  W = lpWeight1D(q, themoments);  
  
  if (~isna(W))
    err = getError;
    if (err < besterr)
      besterr = err;
      bestq = q;
      bestw = W;
    end
  end
  tries = tries + 1;
end



nonzerind = find(W > 1e-10);
q = q(nonzerind);
W = W(nonzerind);

outputmoments = zeros(numel(themoments),1);
outputmoments(1) = weightedMean(q, W);
for i=2:numel(themoments)
  outputmoments(i) = weightedMoment(q, W, i);
end


function er = getError
  er = 0;
  for i = 2:2:nummoments
    er = er +  abs(themoments(i) - weightedMoment(q,W,i)) / themoments(i);
  end
end


end
