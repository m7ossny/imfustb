function [b_map, d_map]=bk0_drange(a, w)

a=double(a);
fun=inline('repmat(max(x(:))-min(x(:)), size(x))');


drg_a=blkproc(a, size(w), fun);
b_map=double(drg_a);
%d_map=b_map;
[b_map, d_map]=ut_prpmp(b_map, jet(256), size(a));