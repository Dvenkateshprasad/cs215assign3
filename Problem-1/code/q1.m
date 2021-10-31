rng(1);
N = [5,10,20,40,60,80,100,500,10^3,10^4];
sitrue = 4;
muprior=10.5;
sigprior = 1;
mutrue = 10;
B = zeros(100,length(N),3);
for i = 1:length(N)
    n = N(i);
    for k = 1:100
        A = 4*randn(n,1)+10;
        muml = sum(A(:,:))/n;
        muap1 = (muml*(sigprior^2)+muprior*(sitrue^2)/n) / (sigprior^2+(sitrue^2)/n);
        muap2 = muml;
        err1 = abs(muml-mutrue)/mutrue;
        err2 = abs(muap1-mutrue)/mutrue;
        if(muap2<9.5)
            mumap2=9.5;
        elseif(muap2>11.5)
            muap2=11.5;
        end
        err3 = abs(muap2-mutrue)/mutrue;
        B(k,i,1) = err1;
        B(k,i,2) = err2;
        B(k,i,3) = err3;
    end
end
fig = figure;
C = reshape(B(:,:,1),100,length(N));
D = reshape(B(:,:,2),100,length(N));
E = reshape(B(:,:,3),100,length(N));
boxplot(C,'Labels',N);
xlabel('Values of N');
ylabel('Error using $$\hat{\mu}^{ML}$$','Interpreter','Latex')
hold on;
saveas(fig,'../results/MLEstimateerror.png');
fig1 = figure;
boxplot(D,'Labels',N);
xlabel('Values of N');
ylabel('Error using $$\hat{\mu}^{PAM1}$$','Interpreter','Latex')
hold on;
saveas(fig1,'../results/MAP1.png');
fig2 = figure;
boxplot(E,'Labels',N);
xlabel('Values of N');
ylabel('Error using $$\hat{\mu}^{PAM2}$$','Interpreter','Latex')
hold on;
saveas(fig2,'../results/MAP2.png');
