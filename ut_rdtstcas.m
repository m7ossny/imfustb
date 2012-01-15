function [a, b, f]=ut_rdtstcas(filename)

im=imread(filename);
a=im(:, :, 1);
b=im(:, :, 2);
f=im(:, :, 3);

