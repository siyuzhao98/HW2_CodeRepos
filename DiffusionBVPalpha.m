function[A, b] = DiffusionBVPalpha(n, dim, a)
    % n is the number of an axis.
    % dim is 1D or 2D.
    % a is alpha.
    %% init vector b:
    % if without alpha:
    if nargin < 3 || isempty(a)
        a = 2;
    end
    A = eye(n * n);
    h = 1 / (n - 1);
    h2 = h * h;
    h2Inv = 1 / h2;
    %1D
    if dim == 1
        b = a * zeros(1, n);
        for i = 1:n
            idx = i;
            if i == 1 || i == n
                b(idx) = 0;
            else
                b(idx) = -a;
                A(idx,idx) = -2 * h2Inv;
                A(idx,idx - 1) = 1 * h2Inv;
                A(idx,idx + 1) = 1 * h2Inv;
            end
        end
    end
    %2D
    if dim == 2 
        b = a * zeros(n * n, 1);
        for row = 1:n
            for col = 1:n
                idx = (row - 1) * n + col;
                if row == 1 || row == n || col == 1 || col == n
                    b(idx) = 0;
                else
                    b(idx) = -a;
                    A(idx, idx) = -4 * h2Inv;
                    A(idx, idx - 1) = 1 * h2Inv;
                    A(idx, idx + 1) = 1 * h2Inv;
                    A(idx, idx - n) = 1 * h2Inv;
                    A(idx, idx + n) = 1 * h2Inv;
                end
            end
        end
    end
end