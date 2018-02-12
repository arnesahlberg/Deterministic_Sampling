

function [q,w] = ShuffleEns(ens, weights)

q = ens;
w = weights;
nump = columns(q);
%shuffle rows
N = rows(q);
for i=1:N
  r1 = randi(N);
  r2 = randi(N);
  while r1 == r2
    r2 = randi(N);
  end
   q([r1,r2],:) = q([r2,r1],:);
   w([r1,r2],:) = w([r2,r1],:);
end
%shuffle columns
for i=1:nump
  r1 = randi(nump);
  r2 = randi(nump);
  while r1 == r2
    r2 = randi(nump);
  end
   q(:,[r1,r2]) = q(:,[r2,r1]);
end


