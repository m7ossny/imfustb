function [dosplit, archtests]=ut_qtarch(blks, thre, dims)

blks=double(blks);
[m, n, wd]=size(blks);

%reshapedblks=reshape(blks, [numel(blks(:, :, 1)), wd]);

r=reshape(blks, [wd, m*n]);
rm=r-repmat(mean(r, 2), [1, m*n]);
rmi=reshape(rm, m, n, wd);

for i=1:wd
    v=blks(:, :, 1);
    s=regstats(v(:), 1:numel(v), 'Linear', {'yhat', 'r', 'beta'});
    archtests(i)=archtest(s.r);
end

dosplit=archtests;%;>thre;
if nargin==3
    dosplit = (dosplit & (size(blks,1) > dims(1))) | (size(blks,2) > dims(2));
end




