function ssim_map=ssim(x, y, w, sigma, alpha, beta, gamma)

if size(x, 3)>1 x=rgb2gray(x); end
if size(y, 3)>1 y=rgb2gray(y); end

if size(x)~=size(y)
    error('image sizes do not match!!!');
end

double_x=double(x);
double_y=double(y);

eps=.0001;


kernel=fspecial('gaussian', [w, w], sigma);

mu_x=filter2(kernel, x, 'valid'); mu_x=imresize(mu_x, size(x));
mu_y=filter2(kernel, y, 'valid'); mu_y=imresize(mu_y, size(y));
mu_x_squared=mu_x.^2;
mu_y_squared=mu_y.^2;
l=(2*mu_x.*mu_y+eps)./(mu_x_squared+mu_y_squared+eps);

var_x=filter2(kernel, (x-mu_x).^2, 'valid'); var_x=imresize(var_x, size(x));
var_y=filter2(kernel, (y-mu_y).^2, 'valid'); var_y=imresize(var_y, size(y));
sigma_x=sqrt(var_x);
sigma_y=sqrt(var_y);
c=(2*sigma_x.*sigma_y+eps)./(var_x+var_y+eps);

sigma_xy=filter2(kernel, (x-mu_x).*(y-mu_y), 'valid'); sigma_xy=imresize(sigma_xy, size(x));
sigma_xy=max(0, sigma_xy);
%sigma_xy=sqrt(sigma_xy);
s=(2*sigma_xy+eps)./(sigma_x.*sigma_y+eps);

n=alpha+beta+gamma;

ssim_map=(l.^alpha).*(c.^beta).*(s.^gamma);
ssim_map=(ssim_map).^(1/n);





