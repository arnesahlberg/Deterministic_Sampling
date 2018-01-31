
function [q,w] = Gauss6momentSimple(m)
n = numel(m(1,:));
[q0,w0] = Gauss6momentEnsemble([0;1]);
qpm = q0(1:4) ; wpm = w0(1:4);

N = n * rows(qpm) + 1;

q = zeros(N,n); w = zeros(N,1);

for i=1:n
  i0 = (i-1)*4 + 1;
  i1 = (i-1)*4 + 4;
  q(i0:i1, i) = qpm;
  w(i0:i1,1) = wpm;
 end
 
w(end) = 1 - sum(w);

% scale and translate to the moments 
Sig = sqrt(diag(m(2,:)));
M = kron(ones(rows(q), 1) , m(1,:));

q = q * Sig + M;
