function qdiff=pm_msuqi(x, y, w, sigma, nlevels)

if size(x, 3)>1 x=rgb2gray(x); end
if size(y, 3)>1 y=rgb2gray(y); end

K=[0.01 0.03];

p_x=pt_lap2(x, nlevels);%, w, sigma);
p_y=pt_lap2(y, nlevels);%, w, sigma);

ww=w;
% ww=2;
qdiff=ones(size(x));
jj=0;

for i=1:length(p_x)
%     j=i;
    j=nlevels-i+1;
    c_xy{i}=c(p_x{i}, p_y{i}, w, sigma); c_xy{i}=imresize(c_xy{i}, size(p_x{i})); c_xy{i}=max(0, c_xy{i});
    s_xy{i}=s(p_x{i}, p_y{i}, w, sigma); s_xy{i}=imresize(s_xy{i}, size(p_x{i})); s_xy{i}=max(0, c_xy{i});
    p_qdiff{i}=c_xy{i}.*s_xy{i};
    p_qdiff{i}=p_qdiff{i}.^j;
    
%     max(c_xy{i}(:))
%     max(s_xy{i}(:))
    
%     figure(40);
%  	subplot(1, 3, 1); imshow(uint8(p_x{i}));
%  	subplot(1, 3, 2); imshow(uint8(p_y{i}));
%  	subplot(1, 3, 3); imshow(uint8(255*p_qdiff{i}));
%     pause;

%    figure(71); imagesc(hough(p_x{i})); colormap(hot);
%    figure(72); imagesc(hough(p_y{i})); colormap(hot);
%    figure(73); imagesc(hough(p_qdiff{i})); colormap(hot);
%    pause;

%	ww=floor(max(ww/2, 2));	
%  	ww=ceil(min(ww*2, min(w, size(p_x{i}, 1)/2)));
%	ww=w;
	
	jj=jj+j;
end

l_xy=l(p_x{i}, p_y{i}, w, sigma); l_xy=imresize(l_xy, size(p_x{i})); l_xy=max(0, l_xy);
p_qdiff{i}=p_qdiff{i}.*l_xy;


snlevels=nlevels*(1+nlevels)/2;
% jj

qdiff=ip_rat2(p_qdiff); qdiff=qdiff.^(1/jj);
% qdiff=ipdt_lap2(p_qdiff); qdiff=qdiff/jj;


qdiff=1-qdiff;

% figure(41); 
% subplot(1, 3, 1); imshow(uint8(x));
% subplot(1, 3, 2); imshow(uint8(y));
% subplot(1, 3, 3); imshow(uint8(255*qdiff));




function l_xy=l(x, y, w, sigma)

C1=(.01*255)^2;
C2=(.02*255)^2;
% C3=C2/2;

x=double(x);
y=double(y);

% alpha=1;
% beta=1;
% gamma=1;
sigma=1.5*w/8;

delta=zeros(w, w);
delta(floor(w^2/2))=1;

w=fspecial('gaussian', [w, w], sigma);

xx=imfilter(x, delta, 'replicate');
yy=imfilter(y, delta, 'replicate');

mu_x=imfilter(x, w, 'replicate');
mu_y=imfilter(y, w, 'replicate');

mu_x_2=mu_x.^2;
mu_y_2=mu_y.^2;
mu_xy=mu_x.*mu_y;

sigma_x_2=imfilter((xx-mu_x).*(xx-mu_x), w, 'replicate');
sigma_y_2=imfilter((yy-mu_y).*(yy-mu_y), w, 'replicate');
sigma_xy=imfilter((xx-mu_x).*(yy-mu_y), w, 'replicate');

sigma_x=sqrt(sigma_x_2);
sigma_y=sqrt(sigma_y_2);

l_xy=(2*mu_x.*mu_y+C1)./(mu_x_2+mu_y_2+C1);


function c_xy=c(x, y, w, sigma)

% C1=(.01*255)^2;
C2=(.02*255)^2;
% C3=C2/2;

x=double(x);
y=double(y);

% alpha=1;
% beta=1;
% gamma=1;
sigma=1.5*w/8;

delta=zeros(w, w);
delta(floor(w^2/2))=1;

w=fspecial('gaussian', [w, w], sigma);

xx=imfilter(x, delta, 'replicate');
yy=imfilter(y, delta, 'replicate');

mu_x=imfilter(x, w, 'replicate');
mu_y=imfilter(y, w, 'replicate');

mu_x_2=mu_x.^2;
mu_y_2=mu_y.^2;
mu_xy=mu_x.*mu_y;

sigma_x_2=imfilter((xx-mu_x).*(xx-mu_x), w, 'replicate');
sigma_y_2=imfilter((yy-mu_y).*(yy-mu_y), w, 'replicate');
sigma_xy=imfilter((xx-mu_x).*(yy-mu_y), w, 'replicate');

sigma_x=sqrt(sigma_x_2);
sigma_y=sqrt(sigma_y_2);

c_xy=(2*sigma_x.*sigma_y+C2)./(sigma_x_2+sigma_y_2+C2);


function s_xy=s(x, y, w, sigma)

%C1=(.01*255)^2;
C2=(.02*255)^2;
C3=C2/2;

x=double(x);
y=double(y);

% alpha=1;
% beta=1;
% gamma=1;
sigma=1.5*w/8;

delta=zeros(w, w);
delta(floor(w^2/2))=1;

w=fspecial('gaussian', [w, w], sigma);

xx=imfilter(x, delta, 'replicate');
yy=imfilter(y, delta, 'replicate');

mu_x=imfilter(x, w, 'replicate');
mu_y=imfilter(y, w, 'replicate');

mu_x_2=mu_x.^2;
mu_y_2=mu_y.^2;
mu_xy=mu_x.*mu_y;

sigma_x_2=imfilter((xx-mu_x).*(xx-mu_x), w, 'replicate');
sigma_y_2=imfilter((yy-mu_y).*(yy-mu_y), w, 'replicate');
sigma_xy=imfilter((xx-mu_x).*(yy-mu_y), w, 'replicate');

sigma_x=sqrt(sigma_x_2);
sigma_y=sqrt(sigma_y_2);

s_xy=(sigma_xy+C3)./(sigma_x.*sigma_y+C3);














