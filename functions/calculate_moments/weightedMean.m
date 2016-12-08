
function out = weightedMean(samples, weights)

numparameters = numel(samples(1,:));
theSum = zeros(1,numparameters);

%normalize weights
nweights = weights / sum(weights);

out = (samples' * weights)'

end
