

function out = weightedMoment(samples, weights, momentNum)

meanval = weightedMean(samples, weights);
N = rows(samples);

out = ( (samples' -  kron(ones(1,N),meanval')).^momentNum  * weights ) ;

end
