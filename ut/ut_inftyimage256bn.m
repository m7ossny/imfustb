function infty=inftyimage256bn


inftyvct=uint8(0:255);
inftyvct=inftyvct(randperm(numel(inftyvct)));
inftyblk=reshape(inftyvct, 16, 16)'; entropy(inftyblk)
infty=repmat(inftyblk, 16, 16);

infty=uint8(infty);
