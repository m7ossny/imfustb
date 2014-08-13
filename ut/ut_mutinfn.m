function e=ut_mutinfn(a, b)

ea=ut_entropy(a, a);
eb=ut_entropy(b, b);

e=ut_mutinf(a, b);

e=2*e/(ea+eb);
