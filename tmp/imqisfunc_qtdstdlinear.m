function [lambda, lambdaoriginal]=imqisfunc_qtdstdlinear(a, b, f, da, db, df, m, n, d)


dration_fa=da./df;
dration_fb=db./df;

lambda=zeros(m, n);

%lambda=dration_fa./(dration_fa+dration_fb);
%lambda=1-lambda;
%lambda=lambda/sum(sum(lambda));

% incase qa and qb have corresponding
% blocks of the same size.
ixs=find(da==db);
lambda(ixs)=0.5;

% incase qa and qb have corresponding
% blocks of the different sizes.
ixs=find(da~=db);
lambda(ixs)=(df(ixs)-da(ixs))./(db(ixs)-da(ixs));
lambda(ixs)=1-lambda(ixs);

lambda(lambda<0)=0.5;%1-lambda(lambda<0);

%if min(min(lambda))<0
%    ; % breakpoint here
%end

% incase qa and qb have corresponding
% blocks of the different sizes and qf has a corresponding
% block with size less than min(qa, qb) or greater than max(qa, qb).
% ixs=find(da~=db & df>max(db);
% lambda(ixs)=(df(ixs)-da(ixs))./(db(ixs)-da(ixs));
% lambda(ixs)=1-lambda(ixs);


lambdaoriginal=lambda;

%fun=inline('mean2(x)');
%lambda=blkproc(lambda, [d, d], fun);

q=qtdecomp(lambda, 0, [d, d]);
aa=qtgetblk(lambda, q, d);

aa=double(aa);

% compute mean
lambda=mean(mean(aa, 1), 2);
lambda=reshape(lambda, size(da)/d);



stdlambda=zeros(m, n);

c=0.01;

a=double(a);
b=double(b);
f=double(f);

std_a=imblkstd(a, d);
std_b=imblkstd(b, d);
std_f=imblkstd(f, d);

std_af=std_a./(std_f+c^2);
std_bf=std_b./(std_f+c^2);


stdlambda=(std_a)./(std_a+std_b+c^2);


%lambda=lambda/sum(sum(lambda));

stdlambdaoriginal=imresize(lambda, [m, n]);


lambda=lambda.*stdlambda;
lambdaoriginal=lambdaoriginal.*stdlambdaoriginal;

