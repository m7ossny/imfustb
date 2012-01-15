function result=check_kernel_for_averaging(w)

sum_w=sum(sum(w));
result=(sum_w==1);
if ~result
    error('the kernel sums up to %d. It should equal to 1', sum_w)
end

