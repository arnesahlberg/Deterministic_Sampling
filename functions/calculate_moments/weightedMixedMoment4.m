






function out = weightedMixedMoment4(samples, weights)

numparameters = numel(samples(1,:));
n = numel(samples(:,1));
normweights = weights / sum(weights);


meanval = weightedMean(samples, weights);

out = zeros(numparameters, numparameters, numparameters, numparameters);


q = samples;
w = weights;
for i=1:numparameters
    for j=1:numparameters
      for k=1:numparameters
        for l=1:numparameters
          out(i,j,k,l) = 0;
          for s=1:n
            out(i,j,k,l) = out(i,j,k,l) + ...
            (q(s,i) - meanval(i)) .* (q(s,j) - meanval(j)) .* ...
            (q(s,k) - meanval(k)) .* (q(s,l) - meanval(l)) .* w(s);
          end
        end
      end
    end
end




end