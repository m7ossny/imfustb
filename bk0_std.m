function [b_map, d_map]=bk0_std(a, w)

b_map=ones(size(a));
%d_map=b_map;
[b_map, d_map]=ut_prpmp(b_map, jet(256), size(a));