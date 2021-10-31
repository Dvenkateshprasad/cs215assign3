rng(0)
N = [5,10,20,40,60,80,100,500,10^3,10^4];
lamtrue = 5;
B = zeros(100,length(N),2);
for i=1:length(N)
    n = N(i);
    for m = 1:100
        x = rand(n,1);
        y = (-1/5).*(log(x));
        lamml = n/sum(y(:));
        lampam = (n+5.5)/(sum(y(:))+1);
        err1 = abs(lamml-lamtrue)/lamtrue;
        err2 = abs(lampam-lamtrue)/lamtrue;
        B(m,i,1) = err1;
        B(m,i,2) = err2;
    end
end
C = reshape(B(:,:,1),100,length(N));
D = reshape(B(:,:,2),100,length(N));
fig = figure;
boxplot(C,'Labels',N);
xlabel('Values of N');
ylabel('Error using $$\hat{\lambda}^{ML}$$','Interpreter','Latex')
hold on;
saveas(fig,'../results/ErrorusingMLE.png');
fig1 = figure;
boxplot(D,'Labels',N);
xlabel('Values of N');
ylabel('Error using $$\hat{\lambda}^{Posteriormean}$$','Interpreter','Latex')
hold on;
saveas(fig1,'../results/ErrorUsingPosteriorMean.png');
