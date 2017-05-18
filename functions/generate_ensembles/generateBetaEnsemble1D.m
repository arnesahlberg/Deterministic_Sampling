%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Generates an ensemble for the Beta distribution
% input:
%   alpha, beta - the alpha-beta parameters of the distribution
%   A1, A2 - the interval over which the distribution takes place
%   nummoments - the number of moments to fulfill
%
%  [q, W, outputmoments, themoments] = generateBetaEnsemble1D(alpha, beta, A1, A2,  nummoments)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [q, W, outputmoments, themoments] = generateBetaEnsemble1D(alpha, beta, A1, A2,  nummoments)

%get the moments of gaussian distribution
themoments = zeros(nummoments,1);

denom = quad(@(x) (x-A1).^(alpha-1) .* (A2-x).^(beta-1), A1, A2);
f = @(x) ( (x-A1).^(alpha-1) .* (A2-x).^(beta-1) ) ./ denom  ;

meanval = quad(@(x) x.*f(x), A1, A2);
themoments(1) = meanval;
for i=2:nummoments
  themoments(i) = quad(@(x) (x - meanval).^i .* f(x), A1, A2);
end

W = NA;

df = @(x) wblcdf(x, scale, shape);
numpointsguessed = 100;

maxtries = 100;
tries = 0;
while (isna(W) && tries < maxtries)
  q = A1 + (A2-A1)*betarnd(alpha,beta,[numpointsguessed,1]);
  W = lpWeight1D(q, themoments);  
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



end
