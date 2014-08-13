function [b_map, d_map]=bk_var(a, w)

%check_kernel_for_averaging(w);    
a_double=double(a);

mu_a=imfilter(a_double, w, 'replicate');

sigma_ab=imfilter((a_double-mu_a).*(a_double-mu_a), w, 'replicate');
b_map=sigma_ab;
d_map=b_map;

% a_sq=a_double.*a_double;
% mu_a=filter2(w, a_double, 'valid');
% mu_a_sq=mu_a.*mu_a;
% sigma_a=filter2(w, a_sq, 'valid');
% sigma_a=sigma_a - mu_a_sq;
% b_map=sigma_a;

% [b_map, d_map]=ut_prpmp(b_map, jet(256), size(a));
