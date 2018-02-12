%calculates weights, but does not strive to set many of them to zero
function out  = lpWeight1Dspread(qvals, themoments)


qmean = themoments(1);
moms =  numel(themoments);
N = numel(qvals);

A = zeros(moms+1,N);

A(1,:) = 1;
for i=2:(moms+1)
  A(i,:) = (qvals - qmean).^(i-1);
end


B = zeros(moms+1,1);
B(1) = 1;
themoments(1) = 0;
for i=1:moms
  B(i+1) = themoments(i);  
end
themoments(1) = qmean;


%solve by linlear programming instead
f = ones(N,1)';
Aeq = A;
beq = B;
lb = zeros(N,1);
ub = [];
ctype = [];
vartype = [];
s = [];
param.lpsolver = 2; %interior point method...

W = glpk(f, Aeq, beq, lb, ub, ctype, vartype, s, param);



out = W;



end