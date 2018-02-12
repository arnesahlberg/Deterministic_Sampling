


function out = logNormalMoment(mu,sigma,n)

f = @(x) lognpdf(x,mu,sigma);

meanval = e.^( (sigma.^2+2*mu)/2);

if (n == 1)
  out = meanval;
elseif (n == 2)
  out = (e.^(sigma.^2) - 1) .* e.^(2*mu + sigma.^2) ;
elseif (n == 3)
  out = (sqrt(2) .* sqrt(pi) .* sigma .* e.^((9 .* sigma.^2) ./ 2+3 .* mu)-3 .* sqrt(2) .* sqrt(pi) .* sigma .* e.^((5 .* sigma.^2) ./ 2+3 .* mu)+2.^(3 ./ 2) .* sqrt(pi) .* sigma .* e.^((3 .* sigma.^2) ./ 2+3 .* mu)) ./ (sqrt(2) .* sqrt(pi) .* sigma);
elseif (n == 4)
  out = (sqrt(2) .* sqrt(pi) .* sigma .* e .^ (8 .* sigma .^ 2+4 .* mu)-2 .^ (5 ./ 2) .* sqrt(pi) .* sigma .* e .^ (5 .* sigma .^ 2+4 .* mu)+3 .* 2 .^ (3 ./ 2) .* sqrt(pi) .* sigma .* e .^ (3 .* sigma .^ 2+4 .* mu)-2 .^ (5 ./ 2) .* sqrt(pi) .* sigma .* e .^ (2 .* sigma .^ 2+4 .* mu)+sqrt(2) .* sqrt(pi) .* sigma .* e .^ (2 .* sigma .^ 2+4 .* mu)) ./ (sqrt(2) .* sqrt(pi) .* sigma) ;
elseif (n == 5)
  out = (sqrt(2).*sqrt(pi).*sigma.*e.^((25.*sigma.^2)./2+5.*mu)-5.*sqrt(2).*sqrt(pi).*sigma.*e.^((17.*sigma.^2)./2+5.*mu)+5.*2.^(3./2).*sqrt(pi).*sigma.*e.^((11.*sigma.^2)./2+5.*mu)-5.*2.^(3./2).*sqrt(pi).*sigma.*e.^((7.*sigma.^2)./2+5.*mu)+2.^(5./2).*sqrt(pi).*sigma.*e.^((5.*sigma.^2)./2+5.*mu))./(sqrt(2).*sqrt(pi).*sigma);
elseif (n == 6)
  out = (sqrt(2).*sqrt(pi).*sigma.*e.^(18.*sigma.^2+6.*mu)-3.*2.^(3./2).*sqrt(pi).*sigma.*e.^(13.*sigma.^2+6.*mu)+15.*sqrt(2).*sqrt(pi).*sigma.*e.^(9.*sigma.^2+6.*mu)-5.*2.^(5./2).*sqrt(pi).*sigma.*e.^(6.*sigma.^2+6.*mu)+15.*sqrt(2).*sqrt(pi).*sigma.*e.^(4.*sigma.^2+6.*mu)-3.*2.^(3./2).*sqrt(pi).*sigma.*e.^(3.*sigma.^2+6.*mu)+sqrt(2).*sqrt(pi).*sigma.*e.^(3.*sigma.^2+6.*mu))./(sqrt(2).*sqrt(pi).*sigma);
elseif (n == 7)
  out = (sqrt(2).*sqrt(pi).*sigma.*e.^((49.*sigma.^2)./2+7.*mu)-7.*sqrt(2).*sqrt(pi).*sigma.*e.^((37.*sigma.^2)./2+7.*mu)+21.*sqrt(2).*sqrt(pi).*sigma.*e.^((27.*sigma.^2)./2+7.*mu)-35.*sqrt(2).*sqrt(pi).*sigma.*e.^((19.*sigma.^2)./2+7.*mu)+35.*sqrt(2).*sqrt(pi).*sigma.*e.^((13.*sigma.^2)./2+7.*mu)-21.*sqrt(2).*sqrt(pi).*sigma.*e.^((9.*sigma.^2)./2+7.*mu)+3.*2.^(3./2).*sqrt(pi).*sigma.*e.^((7.*sigma.^2)./2+7.*mu))./(sqrt(2).*sqrt(pi).*sigma);
elseif (n == 8)
  out = (sqrt(2).*sqrt(pi).*sigma.*e.^(32.*sigma.^2+8.*mu)-2.^(7./2).*sqrt(pi).*sigma.*e.^(25.*sigma.^2+8.*mu)+7.*2.^(5./2).*sqrt(pi).*sigma.*e.^(19.*sigma.^2+8.*mu)-7.*2.^(7./2).*sqrt(pi).*sigma.*e.^(14.*sigma.^2+8.*mu)+35.*2.^(3./2).*sqrt(pi).*sigma.*e.^(10.*sigma.^2+8.*mu)-7.*2.^(7./2).*sqrt(pi).*sigma.*e.^(7.*sigma.^2+8.*mu)+7.*2.^(5./2).*sqrt(pi).*sigma.*e.^(5.*sigma.^2+8.*mu)-2.^(7./2).*sqrt(pi).*sigma.*e.^(4.*sigma.^2+8.*mu)+sqrt(2).*sqrt(pi).*sigma.*e.^(4.*sigma.^2+8.*mu))./(sqrt(2).*sqrt(pi).*sigma);
else
  error('Only moments 1-8 not avalible');
end


end