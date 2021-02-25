function[x] = Ludecomp(a, b, n, tol, x, er)
    o = 1:n;
    s = 1:n;
    x = 1:n;
    er = 0;
    
    [a, er, o] = Decompose(a, n, tol, o, s, er);
    if er ~= -1
        x = Substitute(a, o, n, b, x);
    end
end