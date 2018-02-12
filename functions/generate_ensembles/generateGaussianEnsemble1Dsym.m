%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Generates an ensemble for the Normal distribution with mean value at zero
% input:
%   sigma - the standard deviation of the normal distribution
%   nummoments - the number of moments to fulfill
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [q, W, outputmoments, themoments] = generateGaussianEnsemble1D(sigma,  nummoments)

%get the moments of gaussian distribution
themoments = gaussMoments(sigma,nummoments);

if (nummoments == 2)
  q = [-1,1]' ; 
  W = [0.5, 0.5]' ;
  q = q*sigma;
elseif( nummoments == 4)
   q = sqrt(3) * [-1, 0, 1]' ;
   W = [1/6, 2/3, 1/6]';
   q = q*sigma;
else %or generate one 
  W = NA;
  
  numpointsguessed = 50;
  
  maxtries = 200;
  tries = 0;
  err = 1e6; ertol = themoments(2) / 1e6; besterr = 1e6;
  while (tries < maxtries && err > ertol)
    q = sigma * abs(randn(numpointsguessed,1));
    q(1) = 0; % set mean first
    W = lpWeight1Dsym(q, themoments);  
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
  
  q = bestq;
  w = bestw;

  q = [-flipud(q(2:end)) ; q]; %fix mirroring
  w = [flipud(w(2:end)) ; w];
  nonzerind = find(w > 1e-10);
  q = q(nonzerind);
  W = w(nonzerind);
end

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
