%Reduce ensembles without covariance involved%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [q,w] = reduceEnsembleMix(q,m)

%MM4 = weightedMixedMoment4(q,w);

w = lpWeightIndepMix(q,m);
if (~isna(w))
  nz = find(w > 1e-14);
  w = w(nz);
  q = q(nz,:);
else
  error('No working weights found');
end

end
