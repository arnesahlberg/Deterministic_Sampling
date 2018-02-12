
function out = lpWeightIndep(qvals, themoments)


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

i = 1;


themoments(1,:) = 0;
while j <= numeqs
  for k = 1:numparameters
    A(j,:) = (qvals(:,k) - qmean(k)).^(i);
    B(j) = themoments(i,k); j = j+1;
  end
  i = i+1;
end
themoments(1,:) = qmean;


%extra equations for setting covariance to zero
m = 200; %guess this
Amix = zeros(m, N);
Bmix = zeros(m,1);

j = 1;
for i = 1:(numparameters-1)
  for k = (i+1):numparameters
    Amix(j,:) = (qvals(:,i) - qmean(i)) .* (qvals(:,k) - qmean(k)) ;
    Bmix(j) = 0;
    j = j+1;
  end
end

%%mixed moment 3
%
%if(moms > 2)
%  for i = 1:numparameters
%    for k = 1:numparameters
%      for l = 1:numparameters
%        if ~(i==k && i==l)
%          Amix(j,:) = (qvals(:,i) - qmean(i)) .* (qvals(:,k) - qmean(k)) .* (qvals(:,l) - qmean(l)) ;
%          Bmix(j) = 0;
%          j = j+1;
%        end
%      end
%    end
%  end
%end
%
%%mixed moment 4
%if(moms > 2)
%  for a = 1:numparameters
%    for b = 1:numparameters
%      for c = 1:numparameters
%        for d = 1:numparameters
%          if ~(a==b && c==d || a == c && b == d || a == d && b == c)
%            Amix(j,:) = ...
%           (qvals(:,a) - qmean(a)) .* (qvals(:,b) - qmean(b)) .* ...
%           (qvals(:,c) - qmean(c)) .* (qvals(:,d) - qmean(d)) ;
%            Bmix(j) = 0;
%            j = j+1;
%          end
%        end
%      end
%    end
%  end
%end


j = j-1;
Amix = Amix(1:j,:);
Bmix = Bmix(1:j);

%include them in A and B
A = [A ; Amix];
B = [B ; Bmix];

%solve by linlear programming instead
f = ones(N,1)';
Aeq = A;
beq = B;
lb = zeros(N,1);
ub = [];
ctype = [];
vartype = [];
s = [];
param.dual = 1; %another simplex method to use...

W = glpk(f, Aeq, beq, lb, ub, ctype, vartype, s, param);


out = W;

end