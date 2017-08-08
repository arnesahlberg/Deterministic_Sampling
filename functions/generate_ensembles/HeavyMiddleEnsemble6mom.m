% Generates an approximated ensemble with moments 'm'
% Note: the matrix 'm' defines the number of parameters
% Note: all parameters must have the same distribution
%
% [q,w] = HeavyMiddleEnsemble6mom(m)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [q,w] = HeavyMiddleEnsemble6mom(m)


n = columns(m);

f2 = 3.063382622701169;
f1 =  1.435371283863669;
w2 = 0.006833071171212186;
w1 = 0.2114780909225839;
w0 = 0.5633776758124079;

Bn = BinaryEnsMatrix(n) ;

q = [f2 * Bn ; f1 * Bn ; zeros(1,n)];

omega = diag(sqrt(m(2,:))); 

q = q * omega + kron(ones(rows(q),1), m(1,:));

w = [ones(rows(Bn),1) * 2*w2/rows(Bn) ; 
     ones(rows(Bn),1) * 2*w1/rows(Bn) ;  
     w0];

end