

function out = Heaviside(x)

%%handle multiple inputs
if (numel(x) > 1)
  out = x * 0;
  for i=1:numel(x)
    out(i) = Heaviside(x(i));
  end
  return;
end

%standard case
out = x >= 0;

% x = 0 case ignore

end