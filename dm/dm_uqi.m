function qdiff=dm_uqi(x, y, w, sigma)

if size(x, 3)>1 x=rgb2gray(x); end
if size(y, 3)>1 y=rgb2gray(y); end

K=[0.01 0.03];

ssim_map_af=ut_ssim(x, y, K, fspecial('gaussian', w, sigma));
qdiff=imresize(ssim_map_af, size(x));

qdiff=min(1, qdiff);
qdiff=max(0, qdiff);
qdiff=1-qdiff;

