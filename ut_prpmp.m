function [new_b_map, new_d_map]=preparemap(a_map, mp, siz)

if nargin<2
    mp=jet(256);
    siz=size(a_map);
elseif nargin<3
    siz=size(a_map);
end

new_b_map=imresize(a_map, siz);
new_d_map=new_b_map;
[mm, nn]=size(a_map);
max_a=max(max(a_map));
a_map=uint8(a_map/max_a*255);
a_map=mp(a_map(:)+1, :)*255;
a_map=reshape(a_map, [mm, nn, 3]);
a_map=uint8(double(a_map));
% 
new_d_map=imresize(a_map, siz);

