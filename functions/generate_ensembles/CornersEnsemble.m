% The Corners-ensemble to
% encode covariance for
% Gaussian parameters
% [q,w] = CornersEnsemble(m, C)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [q,w] = CornersEnsemble(m, C=0, reduce=true)

n = columns(m);

q = sqrt(3) * [cornersMatrix(n)
                  zeros(1,n)       ];
                  
Sig = sqrt(diag(m(2,:)));
M = ones(rows(q),1) .* m(1,:);
q = q * Sig + M;

m(3,:) = 0;
for i=1:n
   m(4,i) = gaussMoment(4,sqrt(m(2,i)));
end

if reduce
  [q,w] = reduceEnsembleCovar (q,m,C);
else
  N = rows(q)
  w = zeros(N,1)
  w(1:N - 1) = 1./6 / (N-1) * 2
  w(end) = 2.0/3
end

end
