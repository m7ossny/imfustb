function infty=dm_qtdlocsatimg(a, md)

%ent_a=ut_entropy(a)

%md=2^(log2(md)+1)

ent_a=mean2(bk_entropy(a, zeros(md, md)))
ent_b=ent_a;

%[q_a, b_a, d_a]=ut_qtd(a, ent_a, 10);


entropythreshold=min(ent_a, ent_b);%*2/3;
entropythreshold=(ent_a+ ent_b)/2
entropythreshold=ent_a

%[q_a, b_a, d_a]=ut_qtd(a, entropythreshold, 30);

mindim=2;%2;
maxdim=16;%min(size(a, 1))/2;

im=a;

q=qtdecomp(im, @ut_qtentropy, entropythreshold, [mindim, maxdim]);

numblks=length(find(q));
dims=2.^[log2(maxdim):-1:log2(mindim)];
%dims=[512, 256, 128, 64, 32, 16, 8, 4, 2, 1];
numdims=length(dims);
blkid=1;
vrtid=2;
dd=512;
counter=0;

totalweight=0;
totalerr=0;

infty=uint8(zeros(size(a)));

for dim=dims
    clear blks;
    [ablks, r, c]=qtgetblk(a, q, dim);
    siz=size(ablks);
    numsubblks=size(ablks, 3);
    k=0;

    if ~numsubblks; continue; end;
    s=size(ablks, 1);
    step=1;
    eblks=[];
    for i=1:step:numsubblks
        tmpu=0:s*s-1;
        eblks(:, :, i)=reshape(tmpu(randperm(numel(tmpu))), [s,s]);
        eblks(:, :, i)=histeq(uint8(eblks(:, :, i)), 256);
    end
    
    eblks=reshape(eblks, siz);
    infty=uint8(qtsetblk(uint8(infty), q, dim+k, eblks));
end
