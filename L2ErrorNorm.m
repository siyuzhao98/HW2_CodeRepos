% n: grid points number for an axis.
% This means h = 1/n;
% Theoretically, error should scalar with h.
% Reference should have n + n - 1 grid points along each axis.
function[errorNorm] = L2ErrorNorm(n, a)
    if nargin < 2 || isempty(a)
        a = 2;
    end
    dim = 2;
    %original case
    n_normal = n;
    h_normal = 1 / (n - 1);
    [A_normal, b_normal] = DiffusionBVPalpha(n_normal, dim, a);
    resT_normal = Ludecomp(A_normal, b_normal, n_normal * n_normal, 0.001);
    T_normal = zeros(n);
    for row = 1:n_normal
        for col = 1:n_normal
           idx = (row - 1) * n_normal + col;
           T_normal(row, col) = resT_normal(idx);
         end
    end
    
    %L2 norms case
    n_incre = 2 * n - 1;
    h_incre = 1 / (2 * n - 2);
    [A_incre, b_incre] = DiffusionBVPalpha(n_incre, dim, a);    
    resT_incre = Ludecomp(A_incre, b_incre, n_incre * n_incre, 0.001); 
    T_incre = zeros(n_incre);
    for row = 1:n_incre
        for col = 1:n_incre
           idx = (row - 1) * n_incre + col;
           T_incre(row, col) = resT_incre(idx);
         end
    end
    
    errorNorm = 0;
    for col = 1:n
        for row = 1:n
            % Get space coordinate of (row, col) point for original grid.
            coordX = (col - 1) * h_normal;
            coordY = (row - 1) * h_normal;
            Col_incre = round((coordX / h_incre) + 1);
            Row_incre = round((coordY / h_incre) + 1);
            error = (T_normal(row, col) - T_incre(Row_incre, Col_incre)) * (T_normal(row, col) - T_incre(Row_incre, Col_incre));
            errorNorm = errorNorm + error;
        end
    end
    errorNorm = sqrt(errorNorm) / power(n, 2);    
end