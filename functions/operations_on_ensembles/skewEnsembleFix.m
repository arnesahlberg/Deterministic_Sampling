% Skew ensembel to encode covariance. 
% Will mess up higher moments than second.
% q = skewEnsembleFix(q0,w,m,C)
% This one will enfore the same mean value though.
%%%%%%%%%%%%%%%%%%%%

function [q] = skewEnsembleFix(q0,w,m,C)

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

%fix mean value
means = weightedMean(q,w);
for i=1:n
  meandiff = m(1,i) - means(i) ;
  q(:,i) = q(:,i) + meandiff;
end


end