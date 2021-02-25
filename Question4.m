% Performance Test for Matrix Caluculation in Q3
% n is dimension of a grid for our problem
n = 10:5:50;
dim = 2;
a = 2;
tIntrinsicAVG = zeros(length(n), 1);
tMyAVG = zeros(length(n), 1);
for i = 1:length(n)
    [A, b] = DiffusionBVPalpha(n(i), dim, a);
    % intrinstic time:
    tSum = 0;
    for j = 1:5
        tic
        resT = A\b;
        tSum = tSum + toc;
    end
    tIntrinsicAVG(i) = tSum / 5;
    
    % my method's time:
    tSum = 0;
    for j = 1:5
        tic
        resT = Ludecomp(A, b, n(i) * n(i), 0.001);
        tSum = tSum + toc;
    end
    tMyAVG(i) = tSum / 5;
end

% Get our plot:
% Get the matrix demension.
for i = 1:length(n)
    n(i) = n(i) * n(i);
end

n = log10(n);
tIntrinsicAVG = transpose(log10(tIntrinsicAVG));
tMyAVG = transpose(log10(tMyAVG));
sampleNum = length(n);
centerPos = floor(sampleNum / 2);

h(1) = figure('Name', 'intrinsic Method 2D');
p1 = polyfit(n, tIntrinsicAVG, 1);
f1 = polyval(p1, n);
intrEquation = ['y = (' num2str(p1(1)) ')x+ (' num2str(p1(2)) ')'];
plot(n, tIntrinsicAVG, '-o', n, f1, '-');
xlabel('Matrix Size n')
ylabel('Time in second')
title('intrinsic method（log10 coordinates）')
legend('data','linear fit')
text(n( centerPos ), f1( centerPos ) - 0.08, intrEquation);

h(2) = figure('Name', 'my Method 2D');
p2 = polyfit(n, tMyAVG, 1);
f2 = polyval(p2, n);
myEquation = ['y = (' num2str(p2(1)) ')x+ (' num2str(p2(2)) ')'];
plot(n, tMyAVG, '-o', n, f2, '-');
xlabel('Matrix Size n')
ylabel('Time in second')
title('my method（log10 coordinates）')
legend('data','linear fit')
text(n( centerPos ), f2( centerPos ) - 0.08, myEquation);

saveas(h(1),'Q4Results/intrinsicMethod2D.jpg')
saveas(h(2),'Q4Results/myMethod2D.jpg')