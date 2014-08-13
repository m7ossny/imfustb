function [b_map, d_map]=bk0_avg(a, w)

%check_kernel_for_averaging(w);    
a_double=double(a);
fun=inline('mean2(x)');

b_map=blkproc(a, size(w), fun);
[b_map, d_map]=ut_prpmp(b_map, jet(256), size(a));