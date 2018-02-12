%not general, but works only for 4 moments

function out = lpWeight2D(qvals, themoments)


qmean = themoments(1,:);
moms =  numel(themoments(:,1));
N = numel(qvals)/2;

A = zeros(2*moms+1,N);


A(1,:) = 1;
A(2,:) = qvals(:,1);
A(3,:) = qvals(:,2); 


j = 4;
i = 2;
while j<2*moms+1
  A(j,:) = (qvals(:,1) - qmean(1)).^(i);
  j = j+1;
  A(j,:) = (qvals(:,2) - qmean(2)).^(i);
  j = j+1;
  i = i+1;

end





B = zeros(2*moms+1,1);
B(1) = 1;
j = 2;
i = 1;
while j<2*moms+1
  B(j) = themoments(i,1);
  j = j+1;
  B(j) =themoments(i,2);
  j = j+1;
  i = i+1;
end



%solve by linlear programming instead
f = ones(N,1)';
Aeq = A;
beq = B;
lb = zeros(N,1); ub = ones(N,1);

W = glpk(f, Aeq, beq, lb, ub);
%Alp = []; b = []; W = linprog(f, Alp, b, Aeq, beq, lb, ub);


out = W;

end