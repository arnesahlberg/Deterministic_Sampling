

function out = lpWeight2Dmix(qvals, themoments)


qmean = themoments(1,:);
moms =  numel(themoments(:,1));
N = numel(qvals)/2;

A = zeros(2*moms+1,N);


A(1,:) = 1;


j = 2;
i = 1;
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
themoments(1,:) = 0;
while j<2*moms+1
  B(j) = themoments(i,1);
  j = j+1;
  B(j) =themoments(i,2);
  j = j+1;
  i = i+1;
end
themoments(1,:) = qmean;
%mixed moments

m = 5;

Amix = zeros(m, N); 

%covariance
Amix(1,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,2) - qmean(2));

%mom3
Amix(2,:) = (qvals(:,1) - qmean(1)).^2 .* (qvals(:,2) - qmean(2));
Amix(3,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,2) - qmean(2)).^2;

%mom4
Amix(4,:) = (qvals(:,1) - qmean(1)).^3 .* (qvals(:,2) - qmean(2));
Amix(5,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,2) - qmean(2)).^3;



Bmix = zeros(rows(Amix), 1); %all mixed moment zero

%include them in A and B
A = [A ; Amix];
B = [B ; Bmix];


%solve by linlear programming instead
f = ones(N,1)';
Aeq = A;
beq = B;
lb = zeros(N,1); ub = ones(N,1); x0 = [];

W = glpk(f, Aeq, beq, lb, ub);

%matlab version of same code
%options = optimoptions('linprog','Algorithm','simplex'); A = [] ; b = []; W = linprog(f, A, b, Aeq, beq, lb, ub,x0,  options);



out = W;

end