
%[m, v] = gaussTerms(sigma, n)

function [m, v] = gaussTerms(sigma, n)

m0 = 1;
m1 = 0;

m = zeros(n+1,1);
m(1) = m0; m(2) = m1;

for i = 2:n
    m(i+1) = 1 / sqrt(2*pi) * gamma(i/2+1/2) * 2^(i/2-1/2) * sigma^(i) * (1+(-1)^i) / factorial(i) ;
end

m;


%version 1
%v = zeros(n,1);
%k = 1;
%for i=1:n
%  for j=1:i
%    f1 = 1 / (factorial(i-j) * factorial(j)) ;
%    f2 = gaussMoment(i,sigma) - gaussMoment(i-j, sigma) * gaussMoment(j, sigma) ;
%    v(k) = f1 * f2;
%    k = k+1;
%  end
%end

%version 2
v = zeros(n, n);
for i=1:n
  for j=1:n
    v(i,j) = 1 / (factorial(i) * factorial(j)) * (gaussMoment(i+j,sigma) - gaussMoment(i,sigma) * gaussMoment(j,sigma));
  end
end


end