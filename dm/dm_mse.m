function qdiff=dm_mse(x, y, w, sigma)

if size(x, 3)>1 x=rgb2gray(x); end
if size(y, 3)>1 y=rgb2gray(y); end

%w=15;
%sigma=2;

kernel=fspecial('gaussian', [w, w], sigma);

double_x=double(x);
double_y=double(y);

diff_xy=double_x-double_y;
diff_xy_squared=diff_xy.^2;

qdiff=sqrt(filter2(kernel, diff_xy_squared, 'valid'))/255;
qdiff=imresize(qdiff, size(x));
