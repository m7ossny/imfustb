function e=ut_mutinf(a, b)

[am, an, ad]=size(a);
[bm, bn, bd]=size(b);

ha=imhist(a)/numel(a);
hb=imhist(b)/numel(b);
ab=[a,b];
hab=ut_imjhist(a, b)/(numel(a));

disp 'joint hist calculated'

G=256;
Ga=1:G;
Gb=1:G;

Ga=Ga(ha>0);
Gb=Gb(hb>0);
e=0;
for x=Ga
	for y=Gb
		e=e+log2(hab(x,y)^hab(x,y))-log2(ha(x)^hab(x,y))-log2(hb(y)^hab(x,y));
% 		e=e+hab(x,y)*log2(hab(x,y)/(ha(x)*hb(y)));
	end
end

% lab=log2(hab(:).^hab(:));
% la=log2(ha.^hab(1:G, :)); la((ha==0))=0;
% lb=log2(hb.^hab); lb((hb==0))=0;
% 
% e=sum(lab)-sum(la)-sum(lb);
% 
