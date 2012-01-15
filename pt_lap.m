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

w=[1 4 6 4 1]/16

[wm, wn]=size(w);
extend=floor(length(w)/2);
extendm=ceil(wm/2);
extendn=ceil(wn/2);

pyramid={};
tmpa=double(a);
oldtmpa=tmpa;
lp=tmpa;
%out=zeros(m, n*(2-2*(.5)^(nlevels+1)));

%out(1:m, 1:n)=a;
out=[];

eps = 1e-6;
i=1;
for i=1:nlevels
	lp=conv2(ut_es2(tmpa, extend), w, 'valid');
	lp=conv2(lp, w', 'valid');
	
	tmplp=lp(1:2:end, 1:2:end);
	newlp=zeros(size(lp));
	newlp(1:2:end, 1:2:end)=tmplp;
	%figure; imshow(uint8(newlp)); pause;
	newlp=filter2(2*w, newlp);
	%figure; imshow(uint8(newlp)); pause;
	newlp=filter2(2*w', newlp);	
	%figure; imshow(uint8(newlp)); pause;
	hp=(tmpa-newlp);
	%figure; imshow(uint8(hp)); pause;

    oldtmpa=tmpa;
	tmpa=lp(1:2:end, 1:2:end);
	%figure; imshow(uint8(tmpa)); pause;
	
	
	pyramid{i}=hp;
end

pyramid{i}=oldtmpa;


