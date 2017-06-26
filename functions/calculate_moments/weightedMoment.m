

function out = weightedMoment(samples, weights, momentNum)

meanval = weightedMean(samples, weights);
N = rows(samples);

weights = weights / sum(weights);

out =  (samples' -  kron(ones(1,N),meanval') ).^momentNum  * weights  ;

end
