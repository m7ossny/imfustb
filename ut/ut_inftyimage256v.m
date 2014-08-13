function infty=inftyimage256v


infty=mod(0:256*256, 256);
infty=infty(1:256*256);
infty=sort(infty, 2);
infty=reshape(infty(1:256*256), 256, 256);
infty=uint8(infty);
