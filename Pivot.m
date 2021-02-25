function[o] = Pivot(a, o, s, n, k)
    p = k;
    big = abs(a(o(k),k)/s(o(k)));
    for ii = k+1:n
        dummy = abs(a(o(ii),k)/s(o(ii)));
        if dummy > big
            big = dummy;
            p = ii;
        end
    end
    dummy = o(p);
    o(p) = o(k);
    o(k) = dummy;
end