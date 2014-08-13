function pyramid=pdt(a, nlevels, w, sigma)

if size(a, 3)>1 a=rgb2gray(a); end;
[m, n]=size(a);

if nargin<3
	sigma=2.5;
	w=fspecial('gaussian', [1, 15], sigma);
elseif nargin<4
	if max(size(w))>1
		;
	else
		sigma=.5;
		w=fspecial('gaussian', [1, w], sigma);		
	end
elseif nargin<5
	if max(size(w))>1
	else
		w=fspecial('gaussian', [1 w], sigma);		
	end
elseif nargin<6
	w=fspecial('gaussian', size(w), sigma);
end

pyramid={};
tmpa=double(a);
%out=zeros(m, n*(2-2*(.5)^(nlevels+1)));

%out(1:m, 1:n)=a;
out=[];

%w=[1 4 6 4 1]/16
eps = 1e-6;

for i=1:nlevels
	lp=filter2(w, tmpa);
	lp=filter2(w', lp);
	
	tmplp=lp(1:2:end, 1:2:end);
	newlp=zeros(size(lp));
	newlp(1:2:end, 1:2:end)=tmplp;
%	figure; imshow(uint8(newlp)); pause;
	newlp=filter2(2*w, newlp);
%	figure; imshow(uint8(newlp)); pause;
	newlp=filter2(2*w', newlp);	
%	figure; imshow(uint8(newlp)); pause;
	hp=(tmpa./(newlp+eps)-1);
%	figure; imshow(uint8(hp)); pause;

	tmpa=lp(1:2:end, 1:2:end);
%	figure; imshow(uint8(tmpa)); pause;
	
	
	pyramid{i}=hp;
end

pyramid{i}=lp;


