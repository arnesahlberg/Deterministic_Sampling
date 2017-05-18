

function out = uniformMoment(a,b,n)

if (n == 1)
  out = (b+a)/2;
else
  namn =  (b-a) * (n+1)  ;
  talj = ( (b-a)/2 )^(n+1) - ( (a-b)/2 )^(n+1);
  out = talj/namn;
end




end

