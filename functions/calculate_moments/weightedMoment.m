

function out = weightedMoment(samples, weights, momentNum)

meanval = weightedMean(samples, weights);


out = ( (samples' -  meanval').^momentNum  * weights ) ;

end
