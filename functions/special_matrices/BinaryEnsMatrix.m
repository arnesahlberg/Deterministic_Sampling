% Constructs a Binary Ensemble Matrix of size 'n'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function A = BinaryEnsMatrix(n, shuffle=true)

%increase n by one since first row should be ignored
n = n+1;

m = n;

while (~okNumber(m))
   m = m+1;
end

h = hadamard(m);


A = h(:,2:n);

% do some shuffling to make less weird upwards. Probably not needed, but maybe is
if (shuffle)
  for i=1:columns(A)
    if (rand() < 0.5)
      A(:,i) = -A(:,i);
    end 
  end
end

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
