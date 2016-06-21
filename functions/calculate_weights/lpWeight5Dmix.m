


function out = lpWeight5Dmix(qvals, themoments)


qmean = themoments(1,:);  
moms =  numel(themoments(:,1)); %number of moments
N = rows(qvals);       %number of samples

numeqs = 5*moms+1;

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
  A(j,:) = (qvals(:,4) - qmean(4)).^(i);
  j = j+1;
  A(j,:) = (qvals(:,5) - qmean(5)).^(i);
  j = j+1;
  i = i+1;
end

themoments(1,:) = 0;
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
  B(j) =themoments(i,5);
  j = j+1;  
  i = i+1;
end
themoments(1,:) = qmean;

%mixed moments
m = 40;
Amix = zeros(m, N);

%covariances
k = 1;
for i=1:4
  for j=(i+1):5
    Amix(k,:) = (qvals(:,i) - qmean(i)) .* (qvals(:,j) - qmean(j));  
    k = k+1;
  end
end %10


%%mom3
%
for i=1:4
  for j=(i+1):5
    Amix(k,:) = (qvals(:,i) - qmean(i)).^2 .* (qvals(:,j) - qmean(j));  
    k = k+1;
    Amix(k,:) = (qvals(:,i) - qmean(i)) .* (qvals(:,j) - qmean(j)).^2;  
    k = k+1;
  end
end %20

for i=1:3
  for j=(i+1):4
    for l=(j+1):5
      Amix(k,:) = (qvals(:,i) - qmean(i)) .* (qvals(:,j) - qmean(j)) .* (qvals(:,l) - qmean(l))  ;
      k = k+1;
    end
  end
end %10


%%mom4
%Amix(k,:) = (qvals(:,1) - qmean(1)).^3 .* (qvals(:,2) - qmean(2));  k = k+1;
%Amix(k,:) = (qvals(:,1) - qmean(1)).^2 .* (qvals(:,2) - qmean(2)).^2; k = k+1;
%Amix(k,:) = (qvals(:,1) - qmean(1)).^1 .* (qvals(:,2) - qmean(2)).^3; k = k+1;





Bmix = zeros(m, 1); %all mixed moment zero

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