function plotEns(q,w,col='r', widthfunc=@(q,w,i) sqrt(w(i))*rows(q)*15 , 
	xlab='', ylab='', titl='',  fontsize=15)

if(columns(q) == 3)
	for i=1:rows(1)
		scatter3(q(i,1), q(i,2), q(i,3),  widthfunc(q,w,i), col,  'filled')
	end
elseif (columns(q) == 2)
	for i=1:rows(q)
		scatter(q(i,1), q(i,2), widthfunc(q,w,i),  col ,  'filled')
	end
elseif (columns(q) == 1)
	barEns(q,w,col='r', width, 	xlab, ylab, titl)
end

hx = xlabel(xlab);
hy = ylabel(ylab);
title(titl)
set (hx, 'fontsize', fontsize) ;
set (hy, 'fontsize', fontsize) ;
h = get(gcf, 'currentaxes');
set(h, 'fontsize', fontsize);

end
