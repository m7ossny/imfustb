function [b_map, d_map]=bk_qtd(a, ws)

[wm, wn, wd]=size(ws);
[am, an, ad]=size(a);


a_sampling_maps=ut_cnvit(a, ws);
a_sampling_maps=reshape(a_sampling_maps, [prod(size(a_sampling_maps))/wd, wd])';

step=0;
es=repmat(0, size(a_sampling_maps, 2), 1);
e=zeros(256);
hprg=waitbar(0, 'calculating qtd range map...');
for i=1:size(a_sampling_maps, 2)
%    tic;
    if i+step>size(a_sampling_maps, 2)
        step=size(a_sampling_maps, 2)-i;
    end
    h=a_sampling_maps(:, i);
    tmpimage=reshape(h, [wm, wn]);
    d=qtd(tmpimage, 10, 0);
    e=std2(d);
    %e=diag(-h'*log2(h));
    %e=max(h, [], 1)-min(h, [], 1);%sum(-h.*log2(h), 1);
    es(i:i+step)=e;
    waitbar(i/size(a_sampling_maps, 2), hprg);
%    toc
end
close(hprg);

b_map=reshape(es, [am-wm+1, an-wn+1]);
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
