function [b_map, d_map]=bk_cov(a, b, w)

%check_kernel_for_averaging(w);    
a_double=double(a);
b_double=double(b);


mu_a=imresize(imfilter(a_double, w, 'replicate'), size(a));
mu_b=imresize(imfilter(b_double, w, 'replicate'), size(b));

sigma_ab=imfilter((a_double-mu_a).*(b_double-mu_b), w, 'replicate');
b_map=sigma_ab;

[b_map, d_map]=ut_prpmp(b_map, jet(256), size(a));