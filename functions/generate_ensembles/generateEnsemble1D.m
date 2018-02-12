%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Generates an ensemble for the generic
% input:
%
% function [q, W, outputmoments, themoments] = generateEnsemble1D(moments, interval)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [q, W, outputmoments, themoments] = generateEnsemble1D(moments, interval)

themoments = moments;
nummoments = numel(moments);

W = NA;

numpointsguessed = 200;

maxtries = 100;
tries = 0;

err = 1e6; ertol = themoments(2) / 1e6; besterr = 1e6;

if (nargin < 2)
  reach = 3;
  interval = [themoments(1) - reach * themoments(2), themoments(2) + reach * themoments(2)];
end

while (tries < maxtries && err > ertol)
  q = uniformRandomInInterval(interval, numpointsguessed);
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

[q,W] = SortEns(q,W);


function er = getError
  er = 0;
  for i = 2:2:nummoments
    er = er +  abs(themoments(i) - weightedMoment(q,W,i)) / themoments(i);
  end
end


end
