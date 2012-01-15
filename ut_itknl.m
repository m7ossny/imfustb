function kernels=ut_itknl(siz)

m=siz(1);
n=siz(2);

kernels=zeros(m, n, m*n);

for i=1:m*n
    k=kernels(:, :, i);
    k(i)=1;
    kernels(:, :, i)=k;
end
