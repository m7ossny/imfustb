function [qm, qn, b, d]=ut_qtd2(a, thre, fignumber)

%a=imread(ifn); a=imresize(a, [256, 256]); argb=a;
[mm, nn, d]=size(a);
if d>1
    a=rgb2gray(a);
end

%figure; imshow(a);

if mod(log2(mm), 2)~=0 || mod(log2(nn), 2)~=0
    mxdm=max(round([log2(mm), log2(nn)]))+1;
    mxdm=2^mxdm
    
    a=imresize(a, [mxdm, mxdm]);
end

b=a;

[m, n]=size(a);
%b=uint8(zeros(size(a)));
%b=uint8(repmat(0, mm, nn));
d=b;


%thre=histogramepselonadvisor(a);
%q=qtdecomp(a, thre);
%q=qtdecomp(a, thre, [4, 32]);
%q=qtdecomp(a, thre, [8, 8]);
%q=qtdecomp(a, @entropy, thre, [2, size(a, 1)/4]);
q=qtdecomp(a, @ut_qtsigma, thre, [4, size(a, 1)/4]);
qm=round(mm/m*q);
qn=round(nn/n*q);
%hprg=waitbar(0, 'drawing blocks');
numblks=length(find(q));
dims=[512, 256, 128, 64, 32, 16, 8, 4, 2, 1];
numdims=length(dims);
blkid=1;
vrtid=2;
dd=512;
counter=0;
for dim=dims
    clear blks;
    %[mblks, rm, cn]=qtgetblk(a, qm, dim);
    %[nblks, rm, cn]=qtgetblk(a, qn, dim);
    
    



    
    numsubblks=size(blks, 3);
    k=0;
    dim=dim-k;
    ds=blks;
    ds(:)=dim;
    
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
 %   end
    
end

%close(hprg);

b(m, :)=0;
b(:, n)=0;

if fignumber
    figure(fignumber); 
    imshow(b);
end
