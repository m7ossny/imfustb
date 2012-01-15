function h=ut_imjhist(a, b)

G=256;
h=zeros(G, G);

ha=imhist(a);
hb=imhist(b);

Ga=1:G;
Gb=1:G;

Ga=Ga(ha>0);
Gb=Gb(hb>0);
for x=Ga
	for y=Gb
		c=((a(:)==x)&(b(:)==y));
		h(x, y)=ones(size(c))'*c;
	end
end



% 		for i=1:m
% 			for j=1:n
% 				c=c+(a(i,j)==x & b(i,j)==y);
% 			end
% 		end
		
