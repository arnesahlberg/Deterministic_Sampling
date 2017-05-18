%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Generates an ensemble for the Normal distribution with mean value at zero
% input:
%   sigma - the standard deviation of the normal distribution
%   nummoments - the number of moments to fulfill
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [q, W, outputmoments, themoments] = generateGaussianEnsemble1D(sigma,  nummoments)

%get the moments of gaussian distribution
themoments = gaussMoments(sigma,nummoments);

if (nummoments == 2)
  q = [-1,1]' ; 
  W = [0.5, 0.5]' ;
  q = q*sigma;
elseif( nummoments == 4)
   q = sqrt(3) * [-1, 0, 1]' ;
   W = [1/6, 2/3, 1/6]';
   q = q*sigma;
%elseif (nummoments == 10 || nummoments == 8) % pre calculated ensembles
%  [q,W] = fetchEnsemble;
%  q = q*sigma;
else %or generate one
  
  
  W = NA;
  
  numpointsguessed = 100;
  
  maxtries = 200;
  tries = 0;
  err = 1e6; ertol = themoments(2) / 1e6; besterr = 1e6;
  while (tries < maxtries && err > ertol)
    q = sigma * randn(numpointsguessed,1);
    W = lpWeight1D(q, themoments);  
    if (nummoments == 4) %prevent from being to big
      nb = find(q <= 2*sigma);
      q = q(nb);
    end
    if (~isna(W))
      err = getError;
      if (err < besterr)
        besterr = err;
        bestq = q;
        bestw = W;
      end
    end
    tries = tries + 1;
  end
  
  q = bestq;
  w = bestw;
  
  nonzerind = find(W > 1e-10);
  q = q(nonzerind);
  W = W(nonzerind);

end

outputmoments = zeros(numel(themoments),1);
outputmoments(1) = weightedMean(q, W);
for i=2:numel(themoments)
  outputmoments(i) = weightedMoment(q, W, i);
end

function er = getError
  er = 0;
  for i = 2:2:nummoments
    er = er +  abs(themoments(i) - weightedMoment(q,W,i)) / themoments(i);
  end
end

function [qf,wf] = fetchEnsemble
  if (nummoments == 10)
    qf = [0.638927673745286;3.382300731279880;1.359603862932809;-0.479070760995290;-1.722488041456855;-2.424204231305383;0.706174168169192;1.971669488766421;-3.485691026547371;-1.538511458996972;-0.518182409790115];
    wf =[0.08311958779442430;0.00208405153709959;0.01117564197513755;0.36551508100454738;0.02975130143960183;0.01594095200184087;0.28921080371281027;0.07276256405478049;0.00131018637175557;0.08484516098779883;0.04428466913552410];
  elseif (nummoments == 8)
    qf = [-1.420178821191138;-1.620731713526681;-0.210470851154051;2.673597214914731;-3.332796918735916;1.011066412934956;1.177851635645379;  -1.948918707981806;  -0.274954294852521];
    wf =[0.07838702406053163;0.04740543293149579;0.38175749099612827; .01890003835983059;   0.00286908630566007;   0.06014885596889163;   0.23395565312641783;   0.03601880412510579;   0.14055761364439109];
  end
end

end
