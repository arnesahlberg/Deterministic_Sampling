

function out = weightedCovariance(samples, weights)

numparameters = numel(samples(1,:));
n = numel(samples(:,1));
normweights = weights / sum(weights);


meanval = weightedMean(samples, weights);

out = zeros(numparameters, numparameters);



for i=1:numparameters
    for j=1:numparameters
        out(i,j) = 0;
        for k = 1:n
            out(i,j) = out(i,j) + normweights(k) .* ...
                (samples(k,i) - meanval(i)) .* (samples(k,j) - meanval(j)) ;
        end
    end
end






end