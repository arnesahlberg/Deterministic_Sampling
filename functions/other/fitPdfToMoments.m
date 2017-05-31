% [f,x] = fitPdfToMoments(m,xlims)
% Input:
%    m - moments of distribution, mean, var, mom3, mom4 ...
%    xlimx - [x0, x1]
% Outputs:
%    f - distribution vector
%    x - x values vector
function [f,x] = fitPdfToMoments(m,xlims, minpoints=50)


nums = minpoints:1:minpoints*10;

for i=1:numel(nums)
  q = linspace(xlims(1),xlims(end),nums(i))';
  w = lpWeight1Dspread(q,m) ;
  w = w / trapz(q, w);
  W = fft(w);
  N = numel(W);
  WA = abs(W);
  if (mean(WA(ceil(N/3):floor(2*N/3))) < 0.2)
    f = w;
    x = q;
    break;
  end
end

if (mean(WA(ceil(N/3):floor(2*N/3))) > 0.2)
  error('Could not find good fit')  
end



end