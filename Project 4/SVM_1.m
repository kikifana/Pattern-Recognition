clc;
clear;
close all;

l = 2; %dimension


randn('seed',0);
m1 = [2 2]';
S1 = [2 -.5; -.5 1];
N = 150;
X1 = mvnrnd(m1,S1,N)';

y1=ones(length(X1),1).*(-1);

randn('seed',10);
m2= [-8 2]';
S2 = [1 .5; .5 1];
X2 = mvnrnd(m2,S2,N)';

y2=ones(length(X1),1).*(-1);

x_f = [X1 X2];
X = transpose(x_f);
y =[ones(1,N) -ones(1,N)];
Y = transpose(y);
% Plot the training set X1
figure(1), plot(x_f(1,y==1),x_f(2,y==1),'bo',...
    x_f(1,y==-1),x_f(2,y==-1),'r.')
hold on;
 
kernel = 'linear';
SVMModel =  fitcsvm(X,Y,'Standardize',false,'KernelFunction',kernel);
% gia svm2


classOrder = SVMModel.ClassNames;
sv = SVMModel.SupportVectors;
figure(1), plot(x_f(1,y==1),x_f(2,y==1),'bo',...
    x_f(1,y==-1),x_f(2,y==-1),'r.')
hold on;
plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)
legend('Support Vectors')
hold off;
rng('default'); 
[SVMModel,ScoreParameters] = fitPosterior(SVMModel); 
xMax = max(X);
xMin = min(X);
d = 0.01;
[x1Grid,x2Grid] = meshgrid(xMin(1):d:xMax(1),xMin(2):d:xMax(2));

[~,PosteriorRegion] = predict(SVMModel,[x1Grid(:),x2Grid(:)]);

figure;
contourf(x1Grid,x2Grid,reshape(PosteriorRegion(:,2),size(x1Grid,1),size(x1Grid,2)));
    
h = colorbar;

h.YLabel.FontSize = 5;
caxis([0 1]);
colormap jet;

hold on
gscatter(X(:,1),X(:,2),y,'mc','.x',[15,10]);
sv = X(SVMModel.IsSupportVector,:);
plot(sv(:,1),sv(:,2),'yo','MarkerSize',10,'LineWidth',4);
axis tight
hold off