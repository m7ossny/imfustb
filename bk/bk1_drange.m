function [b_map, d_map]=bk1_drange(a, w)

a=double(a);
fun=inline('repmat(max(x(:))-min(x(:)), size(x))');


drg_a=blkproc(a, size(w), floor(size(w)/2), fun);
b_map=double(drg_a);
%d_map=b_map;
[b_map, d_map]=ut_prpmp(b_map, jet(256), size(a));