

function out = gaussMoment(n, sigma, mu)

if (nargin < 3)
  mu = 0;
end

if nargin < 2
  sigma = 1;
end

if (n == 1)
  out = mu;
  return;
end

out = 1/ sqrt(2*pi) * gamma((n+1)/2) .* 2.^((n-1)/2) .* sigma.^n .* (1 + (-1).^n) ;

end