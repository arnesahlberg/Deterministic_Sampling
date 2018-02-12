% Skew ensembel to encode covariance. 
% Will mess up higher moments than second.
% [qs,w] = skewEnsemble(q,w,C)
%%%%%%%%%%%%%%%%%%%%

function [qs,w] = skewEnsemble(q,w,C)

[U , D] = eig(C);
Dsqrt = sqrt(D);
B = U * Dsqrt * U'; %new base

for i=1:rows(B)
	B(i,:) = B(i,:) / norm(B(i,:));
end

mn = weightedMean(q,w);
N = rows(q);
qs = kron(mn, ones(N,1)) + ( q - kron(mn, ones(N,1)) ) * B;



end