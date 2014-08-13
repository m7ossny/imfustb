function [colomns]=ut_prepblks4bulkproc(blks)

blks=double(blks);
[m, n, wd]=size(blks);

colomns=reshape(blks, [numel(blks(:, :, 1)), wd]);

