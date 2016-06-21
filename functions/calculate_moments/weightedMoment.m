

function out = weightedMoment(samples, weights, momentNum)

numparameters = numel(samples(1,:));
n = numel(samples(:,1));
normweights = weights / sum(weights);
m = momentNum;
meanval = weightedMean(samples, weights);


out = zeros(1,numparameters);
for i=1:n
    out = out + normweights(i).*(samples(i,:) - meanval).^momentNum;
end

end