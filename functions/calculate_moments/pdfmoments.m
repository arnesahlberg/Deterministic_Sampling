% calculate moments from PDF
% function themoments = pdfmoments(f, xmin, xmax,nummoments)

function themoments = pdfmoments(f, xmin, xmax,nummoments)

if(nargin < 3)
  nummoments = 4;
end

themoments = zeros(nummoments,1);


meanval = quad(@(x) x.*f(x), xmin, xmax);
themoments(1) = meanval;
for i=2:nummoments
  themoments(i) = quad(@(x) (x - meanval).^i .* f(x), xmin, xmax);
end

