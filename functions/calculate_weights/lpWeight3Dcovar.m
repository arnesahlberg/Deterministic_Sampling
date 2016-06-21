




function out = lpWeight3Dcovar(qvals, themoments, covarmatr)

covar = covarmatr;
qmean = themoments(1,:);
moms =  numel(themoments(:,1));
N = numel(qvals)/3;

A = zeros(3*moms+1,N);


A(1,:) = 1;


j = 2;
i = 1;
while j<3*moms+1
  A(j,:) = (qvals(:,1) - qmean(1)).^(i);
  j = j+1;
  A(j,:) = (qvals(:,2) - qmean(2)).^(i);
  j = j+1;
  A(j,:) = (qvals(:,3) - qmean(3)).^(i);
  j = j+1;
  i = i+1;
end


B = zeros(3*moms+1,1);
B(1) = 1;
j = 2;
i = 1;
themoments(1,:) = 0;
while j<3*moms+1
  B(j) = themoments(i,1);
  j = j+1;
  B(j) =themoments(i,2);
  j = j+1;
  B(j) =themoments(i,3);
  j = j+1;
  i = i+1;
end
themoments(1,:) = qmean;



%covariance
Amix = zeros(3,N);
Amix(1,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,2) - qmean(2));
Amix(2,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,3) - qmean(3));
Amix(3,:) = (qvals(:,2) - qmean(2)) .* (qvals(:,3) - qmean(3));
Bmix = zeros(3,1);
Bmix(1) = covar(1,2) ; %set covariance from input
Bmix(2) = covar(1,3) ; 
Bmix(3) = covar(2,3); 




%include this in A and B
A = [A ; Amix];
B = [B ; Bmix];


%solve by linlear programming
f = ones(N,1)';
Aeq = A;
beq = B;
lb = zeros(N,1); ub = ones(N,1); x0 = [];

W = glpk(f, Aeq, beq, lb, ub);

%matlab version of same code
%options = optimoptions('linprog','Algorithm','simplex'); A = [] ; b = []; W = linprog(f, A, b, Aeq, beq, lb, ub,x0,  options);



out = W;

end