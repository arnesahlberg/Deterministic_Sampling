%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Generates an ensemble for the Weibull distribution
% input:
%   scale - the scale parameter of the weibull distribution
%   shape - the schape parameter of the weibull distribution
%   nummoments - the number of moments to fulfill
%
% [q, W, outputmoments, themoments] = generateWeibullEnsemble1D(scale, shape, nummoments)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% May have problems for really small values of "scale", but remember, all 
% moments scale in proportion to this parameter, hence one can calculate 
% for "scale = 1" and multiply resulting ensemble by the desired scale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [q, W, outputmoments, themoments] = generateWeibullEnsemble1D(scale, shape, nummoments)

%get the moments of weibull
themoments = wblmoments(scale,shape, nummoments);


W = NA;

df = @(x) wblcdf(x, scale, shape);
numpointsguessed = 200;

maxtries = 100;
tries = 0;

err = 1e6; ertol = themoments(2) / 1e6; besterr = 1e6;

while (tries < maxtries && err > ertol)
  q = wblrnd(scale, shape, [numpointsguessed,1]);
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
