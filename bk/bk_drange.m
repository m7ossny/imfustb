function [b_map, d_map]=bk_drange(a, w)

ws=ut_itknl(size(w));

[wm, wn, wd]=size(ws);
[am, an, ad]=size(a);


a_sampling_maps=ut_cnvit(a, ws);
a_sampling_maps=reshape(a_sampling_maps, [prod(size(a_sampling_maps))/wd, wd])';

step=15000;
es=repmat(0, size(a_sampling_maps, 2), 1);
e=zeros(256);
%hprg=waitbar(0, 'calculating dynamic range map...');
for i=1:step:size(a_sampling_maps, 2)
    if i+step>size(a_sampling_maps, 2)
        step=size(a_sampling_maps, 2)-i;
    end
    h=a_sampling_maps(:, i:i+step);
    %e=diag(-h'*log2(h));
    e=max(h, [], 1)-min(h, [], 1);%sum(-h.*log2(h), 1);
    es(i:i+step)=e;
%    waitbar(i/size(a_sampling_maps, 2), hprg);
end
%close(hprg);

b_map=reshape(es, [am, an]);
[b_map, d_map]=ut_prpmp(b_map, jet(256), size(a));
% a_sampling_maps1=a_sampling_maps(:, 1:size(a_sampling_maps, 2)/4);
% a_sampling_maps1=-a_sampling_maps1'*log2(a_sampling_maps1);
% 
% a_sampling_maps2=a_sampling_maps(:, size(a_sampling_maps, 2)/2+1:end);
% a_sampling_maps2=-a_sampling_maps2'*log2(a_sampling_maps2);
% 
% a_sampling_maps=[a_sampling_maps1, a_sampling_maps2];
% 
%a_sampling_maps1=-a_sampling_maps(:, 1:25000)'*log2(a_sampling_maps(:, 1:25000));

% a_sampling_maps=conv_iterator(a, ws);
% a_sampling_vectors=reshape(a_sampling_maps, [prod(size(a_sampling_maps))/wd, wd])';
% a_histograms=hist(a_sampling_vectors, 0:255)/wd;
% a_histograms=a_histograms+.000000001;%(find(a_histograms>0));
% a_entropy_map=-a_histograms*log2(a_histograms');