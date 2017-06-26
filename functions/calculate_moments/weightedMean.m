
function out = weightedMean(samples, weights)

weights = weights / sum(weights);

out = (samples' * weights)';

end
