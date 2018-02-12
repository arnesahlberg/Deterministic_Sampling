

function [q,w] = Gauss8momentEnsemble(m, shuffle=true)

n = columns(m);

if (n==1)
  [q,w] = HeavyMiddleEnsemble8momGauss(m);
  return;
end


f3 = 3;
f2 = 2;
f1 = sqrt(3/2);
w3 = 1./150;
w2 = 3./100;
w1 = 16./75;
w0 = 1./2;

n1 = ceil(n/2);
n2 = floor(n/2);

part1 = BinaryEnsMatrix(n1);
part2 = BinaryEnsMatrix(n2);

q = zeros(3*rows(part1) + 3 * rows(part2), n);
w = zeros(3*rows(part1) + 3*rows(part2),1);

p1 = rows(part1); p2 = rows(part2);
q(1:p1,1:n1) = part1 * f3;
sof = p1;
q(sof+1:sof+p1 , 1:n1) = part1 * f2;
sof = sof+p1;
q(sof+1:sof+p1, 1:n1) = part1 * f1;
sof = sof + p1;
q(sof+1:sof+p2, n1+1:n1+n2) = part2 * f3;
sof = sof + p2;
q(sof+1:sof+p2, n1+1:n1+n2) = part2 * f2;
sof = sof + p2;
q(sof+1:sof+p2, n1+1:n1+n2) = part2 * f1;

j = 1;
for i=1:rows(part1)
  w(j) = 1/150 / rows(part1) * 2;
  j = j+1;
end
for i=1:rows(part1)
  w(j) = 3/100 / rows(part1) * 2;
  j = j+1;
end
for i=1:rows(part1)
  w(j) = 16/75 / rows(part1) * 2;
  j = j+1;
end
for i=1:rows(part2)
  w(j) = 1/150 / rows(part1) * 2;
  j = j+1;
end
for i=1:rows(part2)
  w(j) = 3/100 / rows(part1) * 2;
  j = j+1;
end
for i=1:rows(part2)
  w(j) = 16/75 / rows(part1) * 2;
  j = j+1;
end

if (shuffle)
  [q,w] = ShuffleEns(q,w)
end




end

