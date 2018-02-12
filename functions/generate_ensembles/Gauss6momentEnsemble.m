% Generate 6 moment gaussian ensemble
%
% [q,w] = Gauss6momentEnsemble(m)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [q,w] = Gauss6momentEnsemble(m, shuffle=true)

nump = columns(m);

if nump == 1
    [q,w] = HeavyMiddleEnsemble6momGauss(m);
    return;
end

part1 = ceil(nump/2);
part2 = floor(nump/2);

C1 = BinaryEnsMatrix(part1);
C2 = BinaryEnsMatrix(part2);
%if (rows(C2) < rows(C1))
%  C2 = [C2 ; C2];
%end


pad1c = nump - part1;
pad2c = nump - part2;
pad1r = rows(C1);
pad2r = rows(C2);

f2 = 3;
f1 = sqrt(2);
w2 = 1/126;
w1 = 3/14;
w0 = 2/9;

q = [
zeros(pad1r, pad1c), f2 * C1 ;
zeros(pad1r, pad1c), f1 * C1 ;
f2 * C2 , zeros(pad2r, pad2c);
f1 * C2 , zeros(pad2r, pad2c);
zeros(1,nump)
];


M = kron( m(1,:) , ones(rows(q),1) );
S = diag(sqrt(m(2,:)));

q = q * S + M;
w = zeros(rows(q), 1);
k = 1;
for i=1:(pad1r)
    w(k) = w2 / pad1r * 2;
    k = k+1;
end
for i=1:(pad1r)
    w(k) = w1 / pad1r * 2;
    k = k+1;
end
for i=1:(pad2r)
    w(k) = w2 / pad2r * 2 ;
    k = k+1;
end
for i=1:(pad2r)
    w(k) = w1 / pad2r * 2 ;
    k = k+1;
end
w(end) = w0 / 2;



if (shuffle && nump > 3)
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
end

end