function pyramid=pdt(a, nlevels, w, sigma)

if size(a, 3)>1 a=rgb2gray(a); end;
[m, n]=size(a);

if nargin<3
	sigma=.5;
	w=fspecial('gaussian', [1, 5], sigma);
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

for i=1:nlevels
	lp=filter2(w, tmpa);
	lp=filter2(w', lp);
	hp=(tmpa-lp);
	tmpa=lp(1:2:end, 1:2:end);
	
	pyramid{i}=hp;
end

pyramid{i}=lp;


