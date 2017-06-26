%
% Perform give the first terms of the Gram-Charlier expansion
% of a PDF, given four input moments
% usage: f = GramCharlierFitPDF(moments, xvals)
%%%%%%%%%%%%
function f = GramCharlierFitPDF(moments, xvals)
m = moments;
x = xvals;

k4 = m(4) - 3 * m(2)^2;
H3 = @(x) x.^3 - 3*x;
H4 = @(x) x.^4 - 6 * x.^2 + 3;
f =  1 / (sqrt(2*pi) * sqrt(m(2))) * exp(-(x - m(1)).^2 / (2*m(2))) .* ...
( 1 + m(3) / (6 * m(2)^(3/2)) * H3((x-m(1))/sqrt(m(2))) + ...
k4 /  (24 * m(2).^2) * H4((x-m(1))/sqrt(m(2))));

end