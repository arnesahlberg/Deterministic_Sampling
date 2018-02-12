function [q,w] = Gauss8momentSimple(m)

n = numel(m(1,:));
q0 = [-3, -2, -sqrt(3/2), sqrt(3/2), 2, 3, 0]';
w0 = [1/150, 3/100, 16/75,  16/75, 3/100, 1/150, 1/2]';
qpm = q0(1:6) ; wpm = w0(1:6);

N = n * rows(qpm) + 1;

q = zeros(N,n); w = zeros(N,1);

for i=1:n
  i0 = (i-1)*6 + 1;
  i1 = (i-1)*6 + 6;
  q(i0:i1, i) = qpm;
  w(i0:i1,1) = wpm;
 end
 
w(end) = 1 - sum(w);

% scale and translate to the moments 
Sig = sqrt(diag(m(2,:)));
M = kron(ones(rows(q), 1) , m(1,:));

q = q * Sig + M;

end