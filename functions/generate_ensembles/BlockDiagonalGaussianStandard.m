% Generate an ensemble fulfilling the first four moments
% for 'numparameters' parameters with the standard gaussian
% distribution. The parameters are independent.
%
% [q,w] = BlockDiagonalGaussian(numparameters)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [q,w] = BlockDiagonalGaussianStandard(numparameters)

n = numparameters;

if (n == 1)
  q = [1 ; -1 ; 0] * sqrt(3);
  w = [1/6, 1/6, 2/3]';
elseif (n == 2)
  q = [
  0 1;
  0 -1;
  1 0;
  -1 0;
  0 0] * sqrt(3);
  w = [1/6, 1/6, 1/6, 1/6, 1/3]';
else
  
  
  d = floor(n/3);
  r = rem(n,3);
  
  a = d;
  b = d;
  c = d;
  if r>0
    a = a+1;
    r = r-1;
  end
  if r>0
    b = b+1;
  end
  
  %New smarter method giving a smaller size of the ensemble
  Ca = BinaryEnsMatrix(a); % can be made much smaller by using this instead
  Cb = BinaryEnsMatrix(b); % but weights need to be recalculated
  Cc = BinaryEnsMatrix(c);
  
  q = [zeros(rows(Ca), n - columns(Ca)), Ca ;
  zeros(rows(Cb),n - columns(Ca) - columns(Cb)), Cb, zeros(rows(Cb),columns(Ca) ) ;
  Cc, zeros(rows(Cc), n - columns(Cc))] * sqrt(3);
  
  % and calculate the weights
  w = zeros(rows(q), 1);
  k = 1;
  n1 = rows(Ca);
  for i = 1:n1
    w(k) = 1 / (3 * n1);
    k = k+1;
  end
  n2 = rows(Cb);
  for i = 1:n2
    w(k) = 1 / (3 * n2);
    k = k+1;
  end
  n3 = rows(Cc);
  for i = 1:n3
    w(k) = 1 / (3 * n3);
    k = k+1;
  end
  
  
end


end