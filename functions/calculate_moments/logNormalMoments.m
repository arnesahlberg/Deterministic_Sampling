
%out = logNormalMoments(mu,sigma,n)

function out = logNormalMoments(mu,sigma,n)



out = zeros(n,1);
for i=1:n
  out(i) = logNormalMoment(mu,sigma,i);
end


end