%%%%%%%%%%
%prints active plot
%%%%%%%
function stdprint(name)

if(nargin == 0)
  name = 'stdfigure';
end

print(name, '-dpng');
%print(name, '-dtikz');

end


