%
%m = gaussMoments(sigma, nummoments)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function m = gaussMoments(sigma, nummoments)

m = zeros(nummoments, 1);


for i=1:nummoments
  m(i) =  gaussMoment(i, sigma);
end

end