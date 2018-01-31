

function out = weightedStd(samples, weights)

out = sqrt(weightedMoment(samples, weights, 2));

end