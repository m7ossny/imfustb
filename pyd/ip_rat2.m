function Y=ipdt_lap2(E)%, zl, sl)

zt=length(E);
M1=E{zt};
zt=zt-1;

% check inputs 
[z1 s1] = size(M1);

% define filter 
w  = [1 4 6 4 1] / 16;

% loop over decomposition depth -> synthesis
for i1 = zt:-1:1
  % undecimate and interpolate 
  M1T = conv2(conv2(ut_es2(ut_undec2(M1), 2), 2*w, 'valid'), 2*w', 'valid');
  % add coefficients
  M1  = (M1T+eps) .* E{i1};

  % select valid image region 
%  M1 	= M1(1:zl(i1),1:sl(i1));
end;

% copy image
Y = M1;
