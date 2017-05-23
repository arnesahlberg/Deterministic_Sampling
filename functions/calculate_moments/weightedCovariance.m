

function out = weightedCovariance(samples, weights)


q = samples;
w = weights;
N = rows(q);

out = (q' - kron(ones(1,N),q'*w)) * ( (q' - kron(ones(1,N),q'*w))' .* kron(w, ones(1,columns(q)) ) );




end