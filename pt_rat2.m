function [E, zl, sl]=pdt_lap2(x, n)

zt=n;
M1=double(x);

% check inputs 
[z1 s1] = size(M1);

% define filter 
w  = [1 4 6 4 1] / 16;

% cells for selected images
E = cell(1,zt);
%oldM1T=M1;

% define eps
eps = 1e-6;

% loop over decomposition depth -> analysis
for i1 = 1:zt 
  % calculate and store actual image size 
  [z s]  = size(M1); 
  zl(i1) = z; sl(i1)  = s;
  
  % check if image expansion necessary 
  if (floor(z/2) ~= z/2), ew(1) = 1; else, ew(1) = 0; end;
  if (floor(s/2) ~= s/2), ew(2) = 1; else, ew(2) = 0; end;

  % perform expansion if necessary
  if (any(ew))
  	M1 = adb(M1,ew);
  end;	
  
  % perform filtering 
  G1 = conv2(conv2(es2(M1,2), w, 'valid'),w', 'valid');
 
  % decimate, undecimate and interpolate 
  M1T = conv2(conv2(es2(undec2(dec2(G1)), 2), 2*w, 'valid'),2*w', 'valid');
 
  % select coefficients and store them
  E(i1) = {M1./(M1T+eps)};
  
  % decimate 
  M1 = dec2(G1);
end;

E{i1+1}=M1;

