%change the alpha
%let n equal to a fixed value
n = 15;
a = 2:10; % test value range 2:20 
error = zeros(length(a), 1);
for i = 1:length(a)
    error(i) = L2ErrorNorm(n, a(i));
end

sampleNum = length(a);
figure(6)
p2 = polyfit(a, error, 2);
f2 = polyval(p2, a);
myEquation = ['y = (' num2str(p2(1)) ')x^2+ (' num2str(p2(2)) ')x+ (' num2str(p2(3)) ')'];
plot(a, error, '-o', a, f2, '-');
text((a(sampleNum) + a(1)) / 4, (f2(sampleNum) + f2(1)) / 2,myEquation);
legend('data','2nd degree fit')
title({['Error Evluation grid(n) = ', num2str(n)]})
xlabel('Alpha value') 
ylabel('average error in norm2') 
str1 = sprintf("Q5_diff_alphaResults/2D_Alpha2to10_Grid%d.jpg", n);
saveas(gcf,str1)

