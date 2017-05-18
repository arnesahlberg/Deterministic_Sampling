%

function out = uniformRandomInInterval(interval, n)

if (nargin > 1)
  out = zeros(n,1);
  for i=1:n
    out(i) = uniformRandomInInterval(interval);
  end
  return;
end

a = interval(1);
b = interval(end);

out = a + rand .* (b-a);

end
