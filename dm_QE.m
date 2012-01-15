function [b_map, d_map]=dm_QE(A, B, siz)

A=double(A);
B=double(B);

hH=fspecial('sobel')%, siz);
% vH=[-1 -2 -3 -2 -1
%     00 00 00 00 00
%     00 00 00 00 00
%     00 00 00 00 00
%     +1 +2 +3 +2 +1]


vH=hH'

veA=imfilter(A, vH, 'same');
heA=imfilter(A, hH, 'same');

veB=imfilter(B, vH, 'same');
heB=imfilter(B, hH, 'same');

gA=sqrt(veA.^2+heA.^2);
tanA=veA./heA;
alphaA=atan(tanA);
alphaA(~heA)=pi/2;
alphaA(~gA)=0;

gB=sqrt(veB.^2+heB.^2);
tanB=veB./heB;
alphaB=atan(tanB);
alphaB(~heB)=pi/2;
alphaB(~gB)=0;

%GAB=255*ones(size(A));
gA_lt_gB=find(gA<gB & gA);
GAB(gA_lt_gB)=gA(gA_lt_gB)./gB(gA_lt_gB);

gA_gte_gB=find(gA>=gB & gB);
GAB(gA_gte_gB)=gB(gA_gte_gB)./gA(gA_gte_gB);

GAB=reshape(GAB, size(A));

AAB=1-2*abs(alphaA-alphaB)/pi;

% parameters
gaussian=fspecial('gaussian', [3, 3], 1)
Lambda_g=0.9994;
Kappa_g=-15;
sigma_g=.5;
% sigma_g=bk_std(GAB, gaussian);

Lambda_a=0.9879;
Kappa_a=-22;
sigma_a=.8;
% sigma_a=bk_std(AAB, gaussian);

QAB_g=Lambda_g./(1+exp(Kappa_g*(GAB-sigma_g)));
QAB_a=Lambda_a./(1+exp(Kappa_a*(AAB-sigma_a)));

figure; imagesc(QAB_g); colormap hot;
figure; imagesc(QAB_a); colormap hot;

b_map=1-QAB_g.*QAB_a;



