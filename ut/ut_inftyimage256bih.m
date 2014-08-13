function infty=inftyimage256bih

inftyblk=reshape(0:255, 16, 16);
infty=[];
c=0;
for i=1:16
    inftyrow=[];
    for j=1:16
        inftyblk=c*ones(16, 16); c=c+1;
        inftyrow=[inftyrow, inftyblk];
    end
    infty=[infty;inftyrow];
end

infty=uint8(infty);