function e=dm_centropy(a, b)

a=double(a);
b=double(b);

G=256;
wd=numel(a);

ha=hist(double(a(:)), 0:G-1)'/wd;
ha=ha;%(find(a_histograms>0));
hb=hist(double(b(:)), 0:G-1)'/wd;
hb=hb;%(find(a_histograms>0));


e=sum(log2(ha.^ha./(hb.^ha)), 1);
% e=-sum(log2(hb.^ha), 1);
