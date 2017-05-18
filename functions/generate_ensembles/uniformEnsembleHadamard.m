

function [q,w] = uniformEnsembleHadamard(n)

%pick moments
m0 = uniformMoments(-1,1,4);
m = [];
for i=1:n
  m = [m,m0];
end

q = sqrt(3/5) * [BinaryEnsMatrix(n) ; zeros(1,n)];

w = lpWeightIndep(q,m);

nz = find(w > 1e-14);
w = w(nz);
q = q(nz,:);


end