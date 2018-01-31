
function out = weightedMean(samples, weights)

weights = weights / sum(weights);

out = weights' * samples;

end
