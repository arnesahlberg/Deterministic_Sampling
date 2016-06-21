%Reduce ensembles without covariance involved%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [q,w] = reduceEnsembleCovar(q,m,C)

w = lpWeightCovar(q,m,C);
if (~isna(w))
  nz = find(w > 1e-14);
  w = w(nz);
  q = q(nz,:);
else
  error('No working weights found');
end

end
