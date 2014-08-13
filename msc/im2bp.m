function out=im2bp(a, nlevels)

a=double(a);
[m, n]=size(a);

out={};
for i=1:nlevels
	mask=2^i*ones(m,n);
	tmp=bitand(a, mask);
	out{i}=tmp;
end
