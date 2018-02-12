


function out = getWeights(qvals, themoments, C)


qmean = themoments(1,:);  

moms =  rows(themoments); %number of moments
N = rows(qvals);                %number of samples
numparameters = columns(qvals); %numer of parameters


numeqs = numparameters*moms+1; %number of equations not counting mixed moments

A = zeros(numeqs,N); 

B = zeros(numeqs,1);

if (nargin < 3)
  C = diag(themoments(2,:));
end


j=1;
A(j,:) = 1; 
B(j) = 1; %sum of weights always 1
j = j+1;

for i=1:numparameters %mean value
  A(j,:) = qvals(:,i);
  B(j) = themoments(1,i); 
  j = j+1;
end



i = 2;
while j < numeqs %higher moments
  for k = 1:numparameters
    A(j,:) = (qvals(:,k) - qmean(k)).^(i);
    B(j) = themoments(i,k); j = j+1;
  end
  i = i+1;
end


if (numparameters > 1)
  %extra equations for dependence
  m = sum(1:(numparameters-1));
  Amix = zeros(m, N);
  Bmix = zeros(m,1);
  
  j = 1;
  for i = 1:(numparameters-1)
    for k = (i+1):numparameters
      Amix(j,:) = (qvals(:,i) - qmean(i)) .* (qvals(:,k) - qmean(k)) ;
      Bmix(j) = C(i,k);
      j = j+1;
    end
  end
  
  %include them in A and B
  A = [A ; Amix];
  B = [B ; Bmix];

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
param.msglev = 0;
param.dual = 3; %another simplex method to use...

[W, fmin, status, extra] = glpk(f, Aeq, beq, lb, ub, ctype, vartype, s, param);


out = W;

end