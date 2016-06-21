% Returns the 'num' first moments of the ensemble
% q and w
% weightedMoments(q, w, num)

function moms = weightedMoments(q, w, num)

moms(1,:) = weightedMean(q,w);

for i=2:num
  moms(i,:) = weightedMoment(q,w,i);
end


end

