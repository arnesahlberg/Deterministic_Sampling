%
% Constructs a extended hadamard matrix of size 'n'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function A = extendedHadamardMatrix(n)

m = n;

while (~okNumber(m))
   m = m+1;
end

h = hadamard(m);

h = [h; -h];

A = h(:,1:n);

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
