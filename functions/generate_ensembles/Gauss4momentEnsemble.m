function [q,w] = Gauss4momentEnsemble(m, shuffle=true)

[q,w] = BlockDiagonalGaussian(m, shuffle=shuffle);

end