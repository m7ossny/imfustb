function Y = ut_selb(M1, M2, mpsalfun)
%Y = selb(M1, M2, mp) coefficient selection for base image
%
%    M1  - coefficients A
%    M2  - coefficients B
%    mp  - switch for selection type
%          mp == 1: select A
%          mp == 2: select B
%          mp == 3: average A and B
% 
%    Y   - combined coefficients

%    (Oliver Rockinger 16.08.99)

% e1=ut_entropy(M1);
% e2=ut_entropy(M2);

mp=mpsalfun{1};
if mp==4
    salfun=mpsalfun{2};
    e1=feval(salfun, M1);
    e2=feval(salfun, M2);
    etotal=e1+e2;

    if(etotal~=0)
        e1=e1/etotal;
        e2=e2/etotal;
    else
        warning('zero total saliency!!!');
        mp=3;
    end
end


switch (mp)
  case 1, Y = M1;
  case 2, Y = M2;
  case 3, Y = (M1 + M2) / 2;
  case 4, Y = e1*M1+e2*M2;
  case 5, Y = max(M1, M2);
  case 6, Y = min(M1, M2);
  otherwise, error('unknown option');
end;
