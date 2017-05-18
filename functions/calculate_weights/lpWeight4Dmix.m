


function out = lpWeight4Dmix(qvals, themoments)


qmean = themoments(1,:);  
moms =  numel(themoments(:,1)); %number of moments
N = numel(qvals)/4;       %number of samples

numeqs = 4*moms+1;

A = zeros(numeqs,N); 


A(1,:) = 1;
A(2,:) = qvals(:,1);
A(3,:) = qvals(:,2); 
A(4,:) = qvals(:,3);
A(5,:) = qvals(:,4);

j = 6;
i = 2;
while j < numeqs
  A(j,:) = (qvals(:,1) - qmean(1)).^(i);
  j = j+1;
  A(j,:) = (qvals(:,2) - qmean(2)).^(i);
  j = j+1;
  A(j,:) = (qvals(:,3) - qmean(3)).^(i);
  j = j+1;
  A(j,:) = (qvals(:,4) - qmean(4)).^(i);
  j = j+1;
  i = i+1;
end


B = zeros(numeqs,1);
B(1) = 1;
j = 2;
i = 1;
while j<numeqs
  B(j) = themoments(i,1);
  j = j+1;
  B(j) =themoments(i,2);
  j = j+1;
  B(j) =themoments(i,3);
  j = j+1;
  B(j) =themoments(i,4);
  j = j+1;
  i = i+1;
end


%mixed moments

nmix = 6+7+16;
Amix = zeros(nmix, N);

j = 1;
%covariances
Amix(j,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,2) - qmean(2)); j = j+1;
Amix(j,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,3) - qmean(3)); j = j+1;
Amix(j,:) = (qvals(:,2) - qmean(2)) .* (qvals(:,3) - qmean(3)); j = j+1;
Amix(j,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,4) - qmean(4)); j = j+1;
Amix(j,:) = (qvals(:,2) - qmean(2)) .* (qvals(:,4) - qmean(4)); j = j+1;
Amix(j,:) = (qvals(:,3) - qmean(3)) .* (qvals(:,4) - qmean(4)); j = j+1;

% 6

%mom3
Amix(j,:) = (qvals(:,1) - qmean(1)).^2 .* (qvals(:,2) - qmean(2)); j = j+1;
Amix(j,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,2) - qmean(2)).^2; j = j+1;
Amix(j,:) = (qvals(:,1) - qmean(1)).^2 .* (qvals(:,3) - qmean(3)); j = j+1;
Amix(j,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,3) - qmean(3)).^2; j = j+1;
Amix(j,:) = (qvals(:,2) - qmean(2)).^2 .* (qvals(:,2) - qmean(2)); j = j+1;
Amix(j,:) = (qvals(:,2) - qmean(2)) .* (qvals(:,3) - qmean(3)).^2; j = j+1;

Amix(j,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,2) - qmean(2)) .* (qvals(:,3) - qmean(3)); j = j+1;

% 7

%mom4
Amix(j,:) = (qvals(:,1) - qmean(1)).^3 .* (qvals(:,2) - qmean(2)); j = j+1;
Amix(j,:) = (qvals(:,1) - qmean(1)).^2 .* (qvals(:,2) - qmean(2)).^2; j = j+1;
Amix(j,:) = (qvals(:,1) - qmean(1))    .* (qvals(:,2) - qmean(2)).^3; j = j+1;

Amix(j,:) = (qvals(:,1) - qmean(1)).^3 .* (qvals(:,3) - qmean(3)); j = j+1;
Amix(j,:) = (qvals(:,1) - qmean(1)).^2 .* (qvals(:,3) - qmean(3)).^2; j = j+1;
Amix(j,:) = (qvals(:,1) - qmean(1))    .* (qvals(:,3) - qmean(3)).^3; j = j+1;

Amix(j,:) = (qvals(:,1) - qmean(1)).^3 .* (qvals(:,4) - qmean(4)); j = j+1;
Amix(j,:) = (qvals(:,1) - qmean(1)).^2 .* (qvals(:,4) - qmean(4)).^2; j = j+1;
Amix(j,:) = (qvals(:,1) - qmean(1))    .* (qvals(:,4) - qmean(4)).^3; j = j+1;

Amix(j,:) = (qvals(:,2) - qmean(2)).^3 .* (qvals(:,3) - qmean(3)); j = j+1;
Amix(j,:) = (qvals(:,2) - qmean(2)).^2 .* (qvals(:,3) - qmean(3)).^2; j = j+1;
Amix(j,:) = (qvals(:,2) - qmean(2))    .* (qvals(:,3) - qmean(3)).^3; j = j+1;

Amix(j,:) = (qvals(:,2) - qmean(2)).^3 .* (qvals(:,4) - qmean(4)); j = j+1;
Amix(j,:) = (qvals(:,2) - qmean(2)).^2 .* (qvals(:,4) - qmean(4)).^2; j = j+1;
Amix(j,:) = (qvals(:,2) - qmean(2))    .* (qvals(:,4) - qmean(4)).^3; j = j+1;


Amix(j,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,2) - qmean(2)) .* (qvals(:,3) - qmean(3)) .* (qvals(:,4) - qmean(4)); j = j+1;
% 16

Bmix = zeros(nmix, 1); %all mixed moment zero


%include them in A and B
A = [A ; Amix];
B = [B ; Bmix];

%solve by linlear programming instead
f = ones(N,1)';
Aeq = A;
beq = B;
lb = zeros(N,1); ub = ones(N,1);

W = glpk(f, Aeq, beq, lb, ub);



out = W;

end