function dosplit=ut_qtentropyTE(blks, thre, dims)

blks=double(blks);
[m, n, wd]=size(blks);

%blks=reshape(blks, [prod(size(blks))/wd, wd])';
reshapedblks=reshape(blks, [numel(blks(:, :, 1)), wd]);

G=256;
%entropies=repmat(0, size(blks, 2), 1);

h=hist(double(reshapedblks), 0:G-1)/(m*n);
if wd==1, h=h'; end;
entropies=sum(-log2(h.^h), 1);

dosplit=entropies>thre;
dosplit = (dosplit & (size(blks,1) > dims(1))) | (size(blks,2) > dims(2));



