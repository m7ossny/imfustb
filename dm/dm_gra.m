function qdiff=dm_entropy(x, y, w, sigma)

if size(x, 3)>1 x=rgb2gray(x); end
if size(y, 3)>1 y=rgb2gray(y); end

double_x=double(x);
double_y=double(y);


%w=5;
%sigma=2;

kernel=ut_itknl(w);

x_entropy=bk_entropy(double_x, kernel);
y_entropy=bk_entropy(double_y, kernel);

%diff_xy=double_x-double_y;
%diff_xy_squared=diff_xy.^2;

diff_xy_entropy=x_entropy-y_entropy;
diff_xy_entropy_squared=diff_xy_entropy.^2;

qdiff=sqrt(diff_xy_entropy_squared)/8;
%qdiff=sqrt(imblkentropy(diff_xy_squared, kernel))/8;


