function [b_map, d_map]=bk1_entropy(a, w)

a=double(a);
fun=inline('repmat(-sum(log2((imhist(uint8(x))/length(x(:))).^(imhist(uint8(x))/length(x(:))))), size(x))');


ent_a=blkproc(a, size(w), floor(size(w)/2), fun);
b_map=double(ent_a);
%d_map=b_map;
[b_map, d_map]=ut_prpmp(b_map, jet(256), size(a));