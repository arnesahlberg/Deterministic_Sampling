%Reduce ensembles without covariance involved%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [q,w] = reduceEnsemble(q,m)

nummoments = rows(m);

w = lpWeightIndep(q,m);
if (~isna(w))
  nz = find(w > 1e-14);
  w = w(nz);
  q = q(nz,:);
else
  error('No working weights found');
end




end
