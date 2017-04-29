%merge two points in an ensemble and return new ensemble 
function [q2,w2] = mergePoints(q,w,i1,i2)

qt = [q(i1,:) ; q(i2,:)] ;
wt = [w(i1) ; w(i2)] ;

q2 = q ;
w2 = w ;

q2(i2,:) = [];
w2(i2,:) = [];
q2(i1,:) = weightedMean(qt,wt);
w2(i1) = sum(wt);

end


