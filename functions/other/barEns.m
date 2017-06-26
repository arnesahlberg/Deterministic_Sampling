

function barEns(q,w,col='r', width=0.2, 
	xlab='', ylab='', titl='',  fontsize=15)

[s,i] = sort(q);
q = s;
w = w(i);


bar(q,w,width,col)
hx = xlabel(xlab);
hy = ylabel(ylab);
title(titl)
set (hx, 'fontsize', fontsize) ;
set (hy, 'fontsize', fontsize) ;
h = get(gcf, 'currentaxes');
set(h, 'fontsize', fontsize);


end

