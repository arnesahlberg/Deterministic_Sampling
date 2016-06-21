


function out = lpWeight(qvals, themoments)


qmean = themoments(1,:);  

moms =  rows(themoments); %number of moments
N = rows(qvals);                %number of samples
numparameters = columns(qvals);



numeqs = numparameters*moms+1;

A = zeros(numeqs,N); 

B = zeros(numeqs,1);


j=1;
A(j,:) = 1; 
B(j) = 1; %sum of weights always 1

j = j+1;

for i=1:numparameters
  A(j,:) = qvals(:,i);
  B(j) = themoments(1,i); 
  j = j+1;
end




i = 2;
while j < numeqs
  for k = 1:numparameters
    A(j,:) = (qvals(:,k) - qmean(k)).^(i);
    B(j) = themoments(i,1); j = j+1;
  end
  i = i+1;
end



%solve by linlear programming instead
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