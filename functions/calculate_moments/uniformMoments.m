

function m = uniformMoments(a, b, nummoments)

m = zeros(nummoments, 1);

for i=1:nummoments
	m(i) = uniformMoment(a,b,i);
end

end

