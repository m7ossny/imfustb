function [q, b, d, d2]=ut_qtd_h(a, thre, fignumber)

%a=imread(ifn); a=imresize(a, [256, 256]); argb=a;
[mm, nn, d]=size(a);
if d>1
    a=rgb2gray(a);
end

%figure; imshow(a);

if mod(log2(mm), 2)~=0 || mod(log2(nn), 2)~=0
    mxdm=max(round([log2(mm), log2(nn)]))+0;
    mxdm=2^mxdm
    
    a=imresize(a, [mxdm, mxdm]);
end

[m, n]=size(a);
b=uint8(zeros(size(a)));
d=b;

mindim=8;

%thre=histogramepselonadvisor(a);
%q=qtdecomp(a, thre);
%q=qtdecomp(a, thre, [4, 32]);
%q=qtdecomp(a, thre, [8, 8]);
%q=qtdecomp(a, @entropy, thre, [2, size(a, 1)/4]);
%q=qtdecomp(a, @ut_qtsigma, thre, [4, size(a, 1)/4]);
q=qtdecomp(a, @ut_qtarch, thre, [mindim, size(a, 1)/2]);
%hprg=waitbar(0, 'drawing blocks');
numblks=length(find(q));

%dims=[512, 256, 128, 64, 32, 16, 8, 4, 2, 1];

dims=2.^(log2(m)-1:-1:1);

numdims=length(dims);
blkid=1;
vrtid=2;
dd=512;
counter=0;
for dim=dims
    clear blks;
    [blks, r, c]=qtgetblk(a, q, dim);
    numsubblks=size(blks, 3);
    if ~numsubblks continue; end;
    k=0;
    dim=dim-k;
    ds=blks;
    ds(:)=dim;
    
    [dum, ents]=ut_qtentropy(blks, thre, [1, 2]);
    ds=ents/dim/dim;
    blks(1:dim, 1, :)=0;
    blks(1, 1:dim, :)=0;
    
%     for i=1:numsubblks
%         blks(1:dim+k, 1, i)=0;
%         blks(1, 1:dim+k, i)=0;
%         %blks(1:dim+k, dim+k, i)=0;
%         %blks(dim+k, 1:dim+k, i)=0;
%         
%         counter=counter+1;
%         
%         hprg=waitbar(counter/numblks);
%     end


%    if size(blks, 3)
        b=qtsetblk(b, q, dim+k, blks);
        d=double(qtsetblk(d, q, dim+k, ds));
        %d2=double(qtsetblk(d, q, dim+k, ds));
 %   end
    
end

%close(hprg);

b(m, :)=0;
b(:, n)=0;

if fignumber
    figure(fignumber); 
    imshow(b);
    figure(fignumber+1); 
    imagesc(d); colormap hot; colorbar;
end
