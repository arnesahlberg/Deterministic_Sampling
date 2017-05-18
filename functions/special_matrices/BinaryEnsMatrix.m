%
% Constructs a Binary Ensemble Matrix of size 'n'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function A = BinaryEnsMatrix(n)

%increase n by one since first row should be ignored
n = n+1;

m = n;

while (~okNumber(m))
   m = m+1;
end

h = hadamard(m);


A = h(:,2:n);

function out = okNumber(n)
  out = false;
  for p=[1, 12, 20, 28]
    x = log2(n/p);
    if ceil(x) == x && x >= 0
      out = true;
    end
  end
end



end
