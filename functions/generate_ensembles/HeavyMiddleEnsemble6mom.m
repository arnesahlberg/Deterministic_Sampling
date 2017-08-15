% Generates an approximated ensemble with moments 'm'
% Note: the matrix 'm' defines the number of parameters
% Note: all parameters must have the same distribution
%
% [q,w] = HeavyMiddleEnsemble6mom(m)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [q,w] = HeavyMiddleEnsemble6mom(m)


n = columns(m);

f2 = 3;
f1 =  sqrt(2);
w2 = 1.0/126;
w1 = 3.0/14;
w0 = 10.0/18;

Bn = BinaryEnsMatrix(n) ;

q = [f2 * Bn ; f1 * Bn ; zeros(1,n)];

omega = diag(sqrt(m(2,:))); 

q = q * omega + kron(ones(rows(q),1), m(1,:));

w = [ones(rows(Bn),1) * 2*w2/rows(Bn) ; 
     ones(rows(Bn),1) * 2*w1/rows(Bn) ;  
     w0];

end