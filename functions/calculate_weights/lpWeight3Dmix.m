


function out = lpWeight3Dmix(qvals, themoments)


qmean = themoments(1,:);  
moms =  numel(themoments(:,1)); %number of moments
N = numel(qvals)/3;       %number of samples

numeqs = 3*moms+1;

A = zeros(numeqs,N); 


A(1,:) = 1;


j = 2;
i = 1;
while j < numeqs
  A(j,:) = (qvals(:,1) - qmean(1)).^(i);
  j = j+1;
  A(j,:) = (qvals(:,2) - qmean(2)).^(i);
  j = j+1;
  A(j,:) = (qvals(:,3) - qmean(3)).^(i);
  j = j+1;
  i = i+1;
end

themoments(1,:) = 0; % first central moment is zero
B = zeros(3*moms+1,1);
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
  i = i+1;
end
themoments(1,:) = qmean; %back to mean as first moment

%mixed moments
m = 11;
Amix = zeros(m, N);

%covariances
Amix(1,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,2) - qmean(2));
Amix(2,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,3) - qmean(3));
Amix(3,:) = (qvals(:,2) - qmean(2)) .* (qvals(:,3) - qmean(3));

%%mom3
Amix(4,:) = (qvals(:,1) - qmean(1)).^2 .* (qvals(:,2) - qmean(2));
Amix(5,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,2) - qmean(2)).^2;
Amix(4,:) = (qvals(:,1) - qmean(1)).^2 .* (qvals(:,3) - qmean(3));
Amix(5,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,3) - qmean(3)).^2;
Amix(6,:) = (qvals(:,2) - qmean(2)).^2 .* (qvals(:,3) - qmean(3));
Amix(7,:) = (qvals(:,2) - qmean(2)) .* (qvals(:,3) - qmean(3)).^2;
Amix(8,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,2) - qmean(2)) .* (qvals(:,3) - qmean(3));


%%mom4

Amix(9,:) = (qvals(:,1) - qmean(1)).^2 .* (qvals(:,2) - qmean(2)) .* (qvals(:,3) - qmean(3));
Amix(10,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,2) - qmean(2)).^2 .* (qvals(:,3) - qmean(3));
Amix(11,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,2) - qmean(2)) .* (qvals(:,3) - qmean(3)).^2;
%
%
%Amix(12,:) = (qvals(:,1) - qmean(1)).^3 .* (qvals(:,2) - qmean(2));
%Amix(13,:) = (qvals(:,1) - qmean(1)).^2 .* (qvals(:,2) - qmean(2)).^2;
%Amix(14,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,2) - qmean(2)).^3;
%
%Amix(12,:) = (qvals(:,1) - qmean(1)).^3 .* (qvals(:,3) - qmean(3));
%Amix(13,:) = (qvals(:,1) - qmean(1)).^2 .* (qvals(:,3) - qmean(3)).^2;
%Amix(14,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,3) - qmean(3)).^3;
%
%Amix(15,:) = (qvals(:,2) - qmean(2)).^3 .* (qvals(:,3) - qmean(3));
%Amix(16,:) = (qvals(:,2) - qmean(2)).^2 .* (qvals(:,3) - qmean(3)).^2;
%Amix(17,:) = (qvals(:,2) - qmean(2)) .* (qvals(:,3) - qmean(3)).^3;
%
%Amix(19,:) = (qvals(:,1) - qmean(1)).^2 .* (qvals(:,2) - qmean(2)) .* (qvals(:,3) - qmean(3));
%Amix(20,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,2) - qmean(2)).^2 .* (qvals(:,3) - qmean(3));
%Amix(21,:) = (qvals(:,1) - qmean(1)) .* (qvals(:,2) - qmean(2)) .* (qvals(:,3) - qmean(3)).^2;

Bmix = zeros(rows(Amix), 1); %all mixed moment zero

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