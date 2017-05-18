
function csvEns(q,w, names)

if nargin == 3
	for i = 1:numel(names)
		printf( [names{i} , ' \t;\t'] ) ;
	end
	printf("weights ; \n");
end


NR = rows(q); NC = columns(q);
for i=1:NR
	for j = 1:NC
		printf( ['%2.8d', ' ;\t'], q(i,j) ) ;
	end
	printf(['%2.8d', '\t; \n'], w(i));
end
printf('\n')


end