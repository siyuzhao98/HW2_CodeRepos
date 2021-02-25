n = 100; % The dimension of our grid.
dim = 1;
a = 2;
shape = power(n, dim);
[A, b] = DiffusionBVPalpha(n, dim, a);
resT = Ludecomp(A, b, shape, 0.001);
T = zeros(n);
if dim == 1
    for i = 1:n
        idx = i;
        T(i) = resT(idx);
    end
    plot(T);
    xlabel('grid size n') 
    ylabel('T value') 
    str = sprintf('%d Grids', n);
    title({[str, ' (', num2str(n), ' nodes in 1D line)']});
end 
if dim == 2
   for row = 1:n
        for col = 1:n
            idx = (row - 1) * n + col;
            T(row, col) = resT(idx);
        end
   end
    h = figure();
    contourf(T)
    colorbar
    str = sprintf('%d by %d Grid', n, n);
    title({[str, ' (', num2str(n), ' nodes in each dimension)']})
end 
if dim == 2
    str1 = sprintf("Q3Results/%dD_%dby%dGrid.jpg", dim, n, n);
    saveas(h,str1)
else
    str2 = sprintf("Q3Results/%dD_%dGrid.jpg", dim, n);
    saveas(gcf,str2)
end


