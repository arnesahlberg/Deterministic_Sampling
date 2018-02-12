
function themoments = wblmoments(scale, shape,nummoments)

if(nargin < 3)
  nummoments = 4;
end

themoments = zeros(nummoments,1);

f = @(x) wblpdf(x, scale, shape);
meanval = quad(@(x) x.*f(x), 0, 30*scale);
themoments(1) = meanval;
for i=2:nummoments
  themoments(i) = quad(@(x) (x - meanval).^i .* f(x), 0, 30*scale);
end

