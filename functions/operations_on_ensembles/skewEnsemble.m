% Skew ensembel to encode covariance. 
% Will mess up higher moments than second.
% skewEnsemble(q0,C)
%%%%%%%%%%%%%%%%%%%%

function [q] = skewEnsemble(q0,C)

[U , D] = eig(C);
Dsqrt = sqrt(D);
b = U * Dsqrt * U'; %new base

r = rows(q0);
n = columns(q0);

q = 0*q0;

for i=1:r
  for j=1:n
    q(i,:) = q(i,:) + q0(i,j) * b(j,:) / norm(b(j,:));
  end
end


end