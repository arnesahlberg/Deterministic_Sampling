
function [qs,ws] = SortEns(q,w)

[qs,i] = sort(q);
ws = w(i);

end
