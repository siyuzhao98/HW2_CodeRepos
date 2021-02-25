%change the grid sizes n
%let a equal to a fixed value
n = 3:10; % test value range 3:20 
a = 2;
error = zeros(length(n), 1);
h = zeros(length(n), 1);
for i = 1:length(n)
    error(i) = L2ErrorNorm(n(i), a);
    h(i) = 1 / n(i);
end

sampleNum = length(h);
figure(5)
p2 = polyfit(h, error, 2);
f2 = polyval(p2, h);
myEquation = ['y = (' num2str(p2(1)) ')x^2+ (' num2str(p2(2)) ')x+ (' num2str(p2(3)) ')'];
plot(h, error, '-o', h, f2, '-');
text((h(sampleNum) + h(1)) / 4, (f2(sampleNum) + f2(1)) / 2,myEquation);
legend('data','2nd degree fit')
title({['Error Evluation alpha = ', num2str(a)]})
xlabel('h value (transformd from n)')
ylabel('average error in norms')
str1 = sprintf("Q5_diff_nResults/2D_Grid3to10_Alpha%d.jpg", a);
saveas(gcf,str1)