function out=pd2im(pyramid)
% stitches pyramid structure in a spanned image

[m,n]=size(pyramid{1});

out=[];

for i=1:length(pyramid)
	hp=pyramid{i};
	[mm, nn]=size(hp);
	if i==1
		hplp=[hp];
	else
		hplp=[hp;255*ones(m-mm, nn)];
	end
	
	out=[out, hplp];
	

% 	figure(20); imshow(uint8(out));
% 	pause;
end