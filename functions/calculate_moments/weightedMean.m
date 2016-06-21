
function out = weightedMean(samples, weights)

numparameters = numel(samples(1,:));
theSum = zeros(1,numparameters);

%normalize weights
nweights = weights / sum(weights);

for i=1:numel(samples(:,1))
    theSum = theSum + samples(i,:) * nweights(i);
end

out = theSum;

end