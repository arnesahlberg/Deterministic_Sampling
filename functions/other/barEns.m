

function barEns(q,w,col, width)

[s,i] = sort(q);
q = s;
w = w(i);

if (nargin < 3)
  bar(q, w, 0.2)
else if (nargin < 4)
  bar(q,w,0.2,col)
else
  bar(q,w,width,col)
end

end

