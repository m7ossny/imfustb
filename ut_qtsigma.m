function dosplit=ut_qtsigma(blks, thre, dims)

blks=double(blks);
[m, n, l]=size(blks);

means=mean(mean(blks, 1), 2);
variances=(blks-repmat(means, m, n));
variances=variances.*variances;
sigmas=squeeze(sqrt(mean(mean(variances, 1), 2)));
dosplit=sigmas>thre;
dosplit = (dosplit & (size(blks,1) > dims(1))) | (size(blks,2) > dims(2));



