function [b_map, d_map]=bk_avg(a, w)

%check_kernel_for_averaging(w);    
a_double=double(a);

b_map=filter2(w, a_double, 'valid');
[b_map, d_map]=ut_prpmp(b_map, jet(256), size(a));