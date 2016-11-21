function plotEns(q)

if(columns(q) == 3)
  plot3(q(:,1), q(:,2), q(:,3), '*', 'linewidth', 10)
elseif (columns(q) == 2)
  plot(q(:,1), q(:,2), '*', 'linewidth', 10)
elseif (columns(q) == 1)
  plot(q, 0*q, '*', 'linewidth', 10)
end

end
