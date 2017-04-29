%  lpWeight1Dsym(qp, themoments)
%  assume qp vals are in format
% [mu, q1, q2, q3, q4 ...] where mu is mean
% outputs values for positive sigma points
% Need to mirror afterwards as w = [flipud(W(2:end)) ; W] to
% match q = [-flipud(qp:2:end) ; qp]
% Assume mean value is zero as well!
function out  = lpWeight1Dsym(qp, themoments)

qvals = qp;
qmean = qp(1);

moms =  numel(themoments);
N = numel(qvals);

A = zeros(moms+1,N);


A(1,:) = 2;
A(1,1) = 1;
for i=2:(moms+1)
  mom = i-1;
  if (ceil(mom/2) == mom/2) %even moments calculated like this
      A(i,:) = 2*(qvals - qmean).^(i-1);
      A(i,1) = A(i,1)/2;
  end % odd moments just zero
end

B = zeros(moms+1,1);
B(1) = 1;
themoments(1) = 0;
for i=1:moms
  B(i+1) = themoments(i);  
end
themoments(1) = qmean;


%solve by linlear programming
f = ones(N,1)';
Aeq = A;
beq = B;
lb = zeros(N,1);
ub = [];
ctype = [];
vartype = [];
s = [];
param.dual = 3; %another simplex method to use...

W = glpk(f, Aeq, beq, lb, ub, ctype, vartype, s, param);

out = W;
end