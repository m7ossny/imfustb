function e=ut_entropyTE(a, alpha)

[am, an, ad]=size(a);

G=256;
%ha=imhist(uint8(a))/numel(a);
ha=hist(a(:), 0:G-1)/numel(a);

%e=sum(-log2(ha.^ha));
e=(sum(ha.^alpha)-1)/(1-alpha);

%G=256;
%Ga=1:G;

%Ga=Ga(ha>0);%.0001);
%e=0;
%for x=Ga
%	e=e+-log2(ha(x)^ha(x));
%end

