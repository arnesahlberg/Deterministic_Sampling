


function out = gaussRandom(mu, sigma, size)

if nargin < 3
  size = 1;
end

out = mu + sigma .* stdnormal_rnd(size) ;



end