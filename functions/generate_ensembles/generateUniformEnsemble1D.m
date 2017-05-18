%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Generates an ensemble for the Uniform distribution with mean value at zero
% input:
%    a - first boundary
%    b - end boundary
%    nummoments - number of moments to be encoded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [q, W, outputmoments, themoments] = generateGaussianEnsemble1D(a,b,  nummoments)
%get the moments 
themoments = uniformMoments(a,b, nummoments);


W = NA;
if (nummoments == 2)
  q = [-1/sqrt(3), 1/sqrt(3)]';
  W = [0.5, 0.5]';
  q = q * (b-a)/2;
  q = q + (b+a)/2;
elseif (nummoments == 4)
  q = [0, sqrt(3/5), -sqrt(3/5)]' ; 
  W = [4/9 , 5/18, 5/18]';
  q = q * (b-a)/2;
  q = q + (b+a)/2;
else

  numpointsguessed = 200;

  maxtries = 100;
  tries = 0;

  err = 1e6; ertol = themoments(2) / 1e6; besterr = 1e6;

  while (tries < maxtries && err > ertol)
    q = rand(numpointsguessed, 1)*(b-a) + a;
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

end

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
