

function out = weightedCovariance(samples, weights)

q = samples
w = weights


out = (q' - q'*w) * ( (q' - q'*w)' .* kron(w, ones(1,columns(q)) ) )




end