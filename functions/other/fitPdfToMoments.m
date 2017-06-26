% [f,x] = fitPdfToMoments(m,xlims, minpoints=50, smoothify=0)
% Input:
%    m - moments of distribution, mean, var, mom3, mom4 ...
%    xlimx - [x0, x1]
% Outputs:
%    f - distribution vector
%    x - x values vector
function [f,x] = fitPdfToMoments(m,xlims, minpoints=50, smoothify=0)


nums = minpoints:1:minpoints*10;

for i=1:numel(nums)
  q = linspace(xlims(1),xlims(end),nums(i))';
  w = lpWeight1Dspread(q,m) ;
  w = w / trapz(q, w);
  W = fft(w);
  N = numel(W);
  WA = abs(W);
  if (mean(WA(ceil(N/3):floor(2*N/3))) < 0.2)
    f = w;
    x = q;
    break;
  end
end

if (mean(WA(ceil(N/3):floor(2*N/3))) > 0.2)
  error('Could not find good fit')  
end

if (smoothify > 0)
  m = numel(x);
  h = x(2) - x(1);
  H=diag(ones(m,1),0);
  H(1:4,1:4)=diag([17/48 59/48 43/48 49/48]);
  H(m-3:m,m-3:m)=fliplr(flipud(diag([17/48 59/48 43/48 49/48])));
  H=H*h;
  HI=inv(H);

     
  Q=(-1/12*diag(ones(m-2,1),2)+8/12*diag(ones(m-1,1),1)-8/12*diag(ones(m-1,1),-1)+1/12*diag(ones(m-2,1),-2));
  Q_U = [0 0.59e2 / 0.96e2 -0.1e1 / 0.12e2 -0.1e1 / 0.32e2; -0.59e2 / 0.96e2 0 0.59e2 / 0.96e2 0; 0.1e1 / 0.12e2 -0.59e2 / 0.96e2 0 0.59e2 / 0.96e2; 0.1e1 / 0.32e2 0 -0.59e2 / 0.96e2 0;];
  Q(1:4,1:4)=Q_U;
  Q(m-3:m,m-3:m)=flipud( fliplr(-Q_U(1:4,1:4) ) );

  e_1=zeros(m,1);e_1(1)=1;
  e_m=zeros(m,1);e_m(m)=1;

  D1=HI*(Q-1/2*e_1*e_1'+1/2*e_m*e_m') ;

  M_U=[0.9e1 / 0.8e1 -0.59e2 / 0.48e2 0.1e1 / 0.12e2 0.1e1 / 0.48e2; -0.59e2 / 0.48e2 0.59e2 / 0.24e2 -0.59e2 / 0.48e2 0; 0.1e1 / 0.12e2 -0.59e2 / 0.48e2 0.55e2 / 0.24e2 -0.59e2 / 0.48e2; 0.1e1 / 0.48e2 0 -0.59e2 / 0.48e2 0.59e2 / 0.24e2;];
  M=-(-1/12*diag(ones(m-2,1),2)+16/12*diag(ones(m-1,1),1)+16/12*diag(ones(m-1,1),-1)-1/12*diag(ones(m-2,1),-2)-30/12*diag(ones(m,1),0));

  M(1:4,1:4)=M_U;

  M(m-3:m,m-3:m)=flipud( fliplr( M_U ) );
  M=M/h;

  S_U=[-0.11e2 / 0.6e1 3 -0.3e1 / 0.2e1 0.1e1 / 0.3e1;]/h;
  S_1=zeros(1,m);
  S_1(1:4)=S_U;
  S_m=zeros(1,m);
  S_m(m-3:m)=fliplr(-S_U);

  D2=HI*(-M-e_1*S_1+e_m*S_m);
  d = 0.1;
  A = d * D2;
  A(:,1) = 0;
  A(:,end) = 0;
 
  k = 0.01;
  ikAi = inv( eye(m) - k * A );

  for i=1:smoothify
    f = ikAi * f;
    k = diag(0.01 * sqrt(f / max(f)));
    ikAi = inv( eye(m) - k * A );
  end

  f = f / trapz(x,f);
end


end