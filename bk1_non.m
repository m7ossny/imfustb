function [b_map, d_map]=bk1_non(a, w)

b_map=128*ones(size(a));
[b_map, d_map]=ut_prpmp(b_map, jet(256), size(a));