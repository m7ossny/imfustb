function [b_map, d_map]=bk_std(a, w)

sigma_a=bk_var(a, w);
std_a=sqrt(sigma_a);
b_map=std_a;
d_map=b_map;
[b_map, d_map]=ut_prpmp(b_map, jet(256), size(a));