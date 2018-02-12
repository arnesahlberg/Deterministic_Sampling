% Generates an approximated ensemble with moments 'm'
% Note: the matrix 'm' defines the number of parameters
% Note: all parameters must have the same distribution
%
% [q,w] = HeavyMiddleEnsemble6mom(m)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [q,w] = HeavyMiddleEnsemble8momGauss(m)


n = columns(m);

f3 = 3;
f2 = 2;
f1 = sqrt(3/2);
w3 = 1./150;
w2 = 3./100;
w1 = 16./75;
w0 = 1./2;

Bn = BinaryEnsMatrix(n) ;

q = [f3 * Bn ; f2 * Bn ; f1 * Bn ; zeros(1,n)];

omega = diag(sqrt(m(2,:))); 

q = q * omega + kron(ones(rows(q),1), m(1,:));

w = [ones(rows(Bn),1) * 2*w3/rows(Bn) ;
     ones(rows(Bn),1) * 2*w2/rows(Bn) ; 
     ones(rows(Bn),1) * 2*w1/rows(Bn) ;  
     w0];

end
