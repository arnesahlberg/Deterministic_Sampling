%
%Produces a binary ensemble for DS
% input:
%   m = moments (first two), also defines number of parameters
%   C = Covariance matrix
%%%%%%%%%%%%%%%%%%%%%%%
function [q,w] = BinaryEns(m, C)

if (nargin < 2)
  C = diag(m(2,:));
end


n = numel(m(1,:));

q = BinaryEnsMatrix(n);

M = kron(ones(rows(q), 1) , m(1,:));

Sig = sqrt(diag(m(2,:)));


q = q*Sig + M;

w = ones(rows(q),1)/rows(q);

q = skewEnsembleFix(q,w,m, C);
