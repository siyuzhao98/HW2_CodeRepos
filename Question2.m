n = 100:40:700;
disp(length(n))

for i = 1:length(n)
% init A and b
    A = rand(n(i), n(i));
    b = rand(n(i), 1);
% intrinsic method
    tSum = 0;
    for j = 1:10 % 10 times
        tic
        x1 = A\b;
        tSum = tSum + toc;  
    end
    tIntrinsicAVG(i) = tSum / 10; % AVG time for each data i
% my method
    tSum = 0;
    for j = 1:10
        tic
        x2 = Ludecomp(A, b, n(i), 0.001);
        tSum = tSum + toc;  
    end
    tMyAVG(i) = tSum / 10;
end

% Discussed with classmates: 
% the logarithmic coordinate representation is clearer 
% otherwise the coefficient will be 10^-3
n = log10(n);
tIntrinsicAVG = log10(tIntrinsicAVG);
tMyAVG = log10(tMyAVG);
sampleNum = length(n);
centerPos = floor(sampleNum / 2);

h(1) = figure('Name', 'intrinsic Method');
p1 = polyfit(n, tIntrinsicAVG, 1);
f1 = polyval(p1, n);
intrEquation = ['y = (' num2str(p1(1)) ')x+ (' num2str(p1(2)) ')'];
plot(n, tIntrinsicAVG, '-o', n, f1, '-');
xlabel('Matrix Size n')
ylabel('Time in second')
title('intrinsic method（log10 coordinates）')
legend('data','linear fit')
text(n( centerPos ), f1( centerPos ) - 0.08, intrEquation);

h(2) = figure('Name', 'my Method');
p2 = polyfit(n, tMyAVG, 1);
f2 = polyval(p2, n);
myEquation = ['y = (' num2str(p2(1)) ')x+ (' num2str(p2(2)) ')'];
plot(n, tMyAVG, '-o', n, f2, '-');
xlabel('Matrix Size n')
ylabel('Time in second')
title('my method（log10 coordinates）')
legend('data','linear fit')
text(n( centerPos ), f2( centerPos ) - 0.08, myEquation);

saveas(h(1),'Q2Results/intrinsicMethod.jpg')
saveas(h(2),'Q2Results/myMethod.jpg')
savefig(h,'Q2Results/Q2TwoMethodsPlot.fig')