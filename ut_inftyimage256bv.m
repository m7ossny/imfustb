function infty=inftyimage256bv


inftyblk=reshape(uint8(0:255), 16, 16); entropy(inftyblk)
infty=repmat(inftyblk, 16, 16);

infty=uint8(infty);
