function infty=inftyimage256biv

inftyblk=reshape(0:255, 16, 16);
infty=[];
c=0;
for i=1:16
    inftycol=[];
    for j=1:16
        inftyblk=c*ones(16, 16); c=c+1;
        inftycol=[inftycol; inftyblk];
    end
    infty=[infty,inftycol];
end

infty=uint8(infty);