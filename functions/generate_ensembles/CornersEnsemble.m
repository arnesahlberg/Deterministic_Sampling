% The Corners-ensemble to
% encode covariance for
% Gaussian parameters
% [q,w] = CornersEnsemble(m, C)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [q,w] = CornersEnsemble(m, C)

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

[q,w] = reduceEnsembleCovar (q,m,C);