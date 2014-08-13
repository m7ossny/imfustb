function [b_map, d_map]=bk0_cov(a, b, w)

fun=inline('repmat(mean2(x), size(x))');
%fun=inline('mean2((x-mean2(x)).*(y-mean2(y)))');

double_a=double(a);
double_b=double(b);

mean_a=blkproc(double_a, size(w), fun);
mean_b=blkproc(double_b, size(w), fun);

cov_ab=blkproc((double_a-mean_a).*(double_b-mean_b), size(w), fun);

b_map=cov_ab;
%d_map=b_map;
[b_map, d_map]=ut_prpmp(b_map, jet(256), size(a));


% [b_map, d_map]=ut_prpmp(b_map, jet(256), size(a));