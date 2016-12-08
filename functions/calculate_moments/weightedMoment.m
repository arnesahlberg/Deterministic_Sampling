

function out = weightedMoment(samples, weights, momentNum)

numparameters = numel(samples(1,:));
n = numel(samples(:,1));
normweights = weights / sum(weights);
m = momentNum;
meanval = weightedMean(samples, weights);


out = ( (samples' - kron(ones(1,n), meanval')).^momentNum  * weights ) ;

end
