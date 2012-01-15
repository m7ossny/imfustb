function image_maps=conv_iterator(a, ws)

if nargin<2
    ws=ut_itknl(8);
end
[am, an, ad]=size(a);
[wm, wn, nn]=size(ws);

%image_maps=repmat(0, [am-wm+1, an-wn+1, nn]);
image_maps=repmat(uint8(0), [am, an, nn]);

for i=1:nn
    image_maps(:, :, i)=uint8(imfilter(a, ws(:, :, i), 'replicate'));
end