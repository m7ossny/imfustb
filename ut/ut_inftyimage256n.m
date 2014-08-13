function infty=inftyimage256n


infty=mod(0:256*256, 256);
infty=infty(1:256*256);
infty=infty(randperm(numel(infty)));
infty=reshape(infty(1:256*256), 256, 256);
infty=uint8(infty);
