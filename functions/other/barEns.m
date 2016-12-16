

function barEns(q,w,col)

[s,i] = sort(q);
q = s;
w = w(i);

if (nargin < 3)
  bar(q, w, 0.1)
else
  bar(q,w,0.1,col)
end

end

