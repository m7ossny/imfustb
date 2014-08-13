function [jh, ph]=ut_jhist(a, b)

[ma, na]=size(a);
[mb, nb]=size(b);

if(ma~=mb)
    error('two images are not of the same size!!');
end

if(na~=nb)
    error('number of sub-images to be test are not the same!!');
end



G=256;
%h=zeros(G, G, na);

jh=(repmat(0, G*G, na));
% ph=(repmat(0, G*G, na));
tmph=zeros(G, G);

ha=hist(a, 0:G-1); if(na<2) ha=ha'; end;
hb=hist(b, 0:G-1); if(na<2) hb=hb'; end;

for i=1:na

    Ga=0:G-1;
    Gb=0:G-1;

%     Ga=Ga(ha>0);
%     Gb=Gb(hb>0);

    tmph=tmph*0;
    
    for j=1:ma
        tmph(uint8(a(j, i))+1, uint8(b(j, i))+1)=...
            tmph(uint8(a(j, i))+1, uint8(b(j, i))+1)+1;    
%     for x=Ga
%         for y=Gb
%             c=sum((a(:, i)==x)&(b(:, i)==y));
%             tmph(x+1, y+1)=c;
%         end
%     end
    end
    jh(:, i)=reshape(tmph, G*G, 1);
%    ph(:, i)=reshape(((ha(:, i)*hb(:, i)')), G*G, 1);
%      ph(:, i)=reshape(diag(diag(ha(:, i)*hb(:, i)')), G*G, 1);
end


% 		for i=1:m
% 			for j=1:n
% 				c=c+(a(i,j)==x & b(i,j)==y);
% 			end
% 		end
		
