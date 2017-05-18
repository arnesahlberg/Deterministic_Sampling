% Generates a symmetric ensemble with moments 'm'
% Note: the matrix 'm' defines the number of parameters
% Note: all parameters must have the same distribution
%
% [q,w] = HeavyMiddleEnsemble(m)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [q,w] = HeavyMiddleEnsemble(m)


n = columns(m);

rat = sqrt( m(4,:) ./ m(2,:) ) ; %ratio
omega = diag(rat); 


q = [BinaryEnsMatrix(n) ; zeros(1,n)];

q = q * omega + m(1,:);

Wd = m(2).^2 ./ m(4);
W = ones(rows(q)-1,1)*Wd/(rows(q)-1);
w = [W ; 1-sum(W)];

end
