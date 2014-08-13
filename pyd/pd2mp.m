function out=pd2im(pyramid)
% TODO: needs documentation!!

[m,n]=size(pyramid{1});

out=[];

for i=1:length(pyramid)
	hp=imresize(pyramid{i}, [m, n]);%, 'nearest');
	[mm, nn]=size(hp);
	if i==1
		hplp=[hp];
	else
		hplp=[hp;zeros(m-mm, nn)];
	end
	
	out=[out, hplp];
	

% 	figure(20); imshow(uint8(out));
% 	pause;
end