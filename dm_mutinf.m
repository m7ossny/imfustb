function e=dm_mutinf(a, b)

a=double(a);
b=double(b);

% G=256;
wd=numel(a);

% ha=hist(double(a(:)), 0:G-1)'/wd;
% ha=ha;%(find(a_histograms>0));
% hb=hist(double(b(:)), 0:G-1)'/wd;
% hb=hb;%(find(a_histograms>0));
%hab=hist(double([a_sampling_maps(:, i:i+step);b_sampling_maps(:, i:i+step)]), 256)/(2*wd);
[hab]=ut_jhist(a(:), b(:));

%hab2=hist2(uint8(a), uint8(b), 0:255, 0:255); hab=hab2(:);


hab=hab/(1*wd);
% hahb=hahb/wd/wd;

% hahb(hahb==0)=0.000000000001;

ent_a=ut_entropy(a);%-sum(log2(ha.^ha), 1);
ent_b=ut_entropy(b);%-sum(log2(hb.^hb), 1);

% r=100000000;
% 
% hab=round(hab*r)/r;
% hahb=round(hahb*r)/r;

%valid=(hahb~=0 | hab==0);
%e=log2(hab(valid).^hab(valid)./((hahb(valid).^hab(valid))));

%hahb(~hahb)=.000000001;
%e=log2(hab.^hab./((hahb.^hab)));

%e=e(e~=Inf);
%e=e(e~=-Inf);
%e=e(e~=NaN);
%e=sum(e, 1);

ent_ab=-sum(log2(hab.^hab), 1);

e=ent_a+ent_b-ent_ab;


nume=2*e;
deno=ent_a+ent_b;

if nume~=deno
    e=nume/deno;
else
    e=1;
end

% e=round(e*100)/100;




% if deno
%     e=nume/deno;
% else
%     e=1;
% end

