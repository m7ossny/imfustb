function [b_map, d_map]=dm_mutinfb_classic(a, b, w)

ws=ut_itknl(w);

[wm, wn, wd]=size(ws);
[am, an, ad]=size(a);
[bm, bn, bd]=size(b);


a_sampling_maps=(ut_cnvit(a, ws));
a_sampling_maps=reshape(a_sampling_maps, [prod(size(a_sampling_maps))/wd, wd])';
b_sampling_maps=(ut_cnvit(b, ws));
b_sampling_maps=reshape(b_sampling_maps, [prod(size(b_sampling_maps))/wd, wd])';
%a_sampling_maps=hist(a_sampling_maps, 255)/wd;
%a_sampling_maps=a_sampling_maps+.000000001;%(find(a_histograms>0));

G=256;

step=3000;
es=repmat(0, size(a_sampling_maps, 2), 1);

% jh=repmat(0, G*G, step);
% ph=repmat(0, G*G, step);

hprg=waitbar(0, 'calculating entropy map...');
for i=1:step:size(a_sampling_maps, 2)
    if i+step>size(a_sampling_maps, 2)
        step=size(a_sampling_maps, 2)-i;
    end
	ha=hist(double(a_sampling_maps(:, i:i+step)), 0:G-1)/wd;
	ha=ha;%(find(a_histograms>0));
	hb=hist(double(b_sampling_maps(:, i:i+step)), 0:G-1)/wd;
	hb=hb;%(find(a_histograms>0));
	%hab=hist(double([a_sampling_maps(:, i:i+step);b_sampling_maps(:, i:i+step)]), 256)/(2*wd);
	[hab, hahb]=ut_jhist(a_sampling_maps(:, i:i+step), b_sampling_maps(:, i:i+step));
    hab=hab/(1*wd);
    hahb=hahb/wd/wd;
%     hab=reshape(hab, [G, G]);
%     hab=hab;%(find(a_histograms>0));
    %h=a_sampling_maps(:, i:i+step);
    %e=diag(-h'*log2(h));

%     hahb=reshape(ha*hb', G*G, 1);
    
% 	ent_a=-sum(log2(ha.^ha), 1);
% 	ent_b=-sum(log2(hb.^hb), 1);
%	e=sum(log2(hab.^hab)-log2(ha.^hab)-log2(hb.^hab), 1);
%	e=sum(log2(hab.^hab./((ha.^hab).*(hb.^hab))), 1);

    hahb(hahb==0)=.000000000001;

	e=sum(log2(hab.^hab./((hahb.^hab))), 1);

	
% 	la=log2(ha);
% 	la(find(la==-Inf))=0;
% 	
% 	lb=log2(hb);
% 	lb(find(lb==-Inf))=0;
% 
% 	lab=log2(hab);
% 	lab(find(lab==-Inf))=0;
% 
% 	e=sum(abs(hab.*(lab-.5*(la+lb))), 1);
    es(i:i+step)=e;
    waitbar(i/size(a_sampling_maps, 2), hprg);
%	clear h;
end
close(hprg);

b_map=reshape(es, [am, an]);
[b_map, d_map]=ut_prpmp(b_map, hot(256), size(a));
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
