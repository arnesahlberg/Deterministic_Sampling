

function F = faceAndCornersMatrix(n)

if (n == 1)

F = [1;0;-1];

else

  Fm = faceAndCornersMatrix(n-1);
  r = rows(Fm);
  F = [
  ones(r,1) , Fm ;
  zeros(r,1), Fm ;
  -ones(r,1) , Fm ];

end


end