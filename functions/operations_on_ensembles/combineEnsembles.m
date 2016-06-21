

function [q,w] = combineEnsembles(q1,w1,q2,w2)


q = zeros(rows(q1) * rows(q2), columns(q1) + columns(q2));
w = zeros(rows(q), 1);

k = 1;
for i=1:rows(q1)
  for j=1:rows(q2)
    q(k,:) = [q1(i,:) , q2(j,:)];
    w(k) = w1(i) * w2(j);
    k = k+1;
  end
end



end