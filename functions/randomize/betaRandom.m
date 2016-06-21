


function out = betaRandom(p, q, A1, A2, size)

if nargin < 5
  size = 1;
end

out = A1 + (A2-A1)*betarnd(p,q,size);



end