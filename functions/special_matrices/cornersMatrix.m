% Generate a matrix where every row indicating the 
% a corner in the nD room [-1, 1]^n
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function A = cornersMatrix(n)


if (n == 1)
  A = [1;-1];
else
  Am = cornersMatrix(n-1); %temporary
  r = rows(Am);
  A = [ones(r,1) , Am ;
       -ones(r,1) , Am ];
end


end
