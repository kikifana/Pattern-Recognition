% 1.A

clc;
clear;
close all;
l = 2; %dimension
randn('seed',0);
m1 = [2 2]';
S1 = [2 -.5; -.5 1];
N = 150;
X1 = mvnrnd(m1,S1,round(N));
y1=ones(length(X1),1).*(-1);
randn('seed',100);
m2= [-8 2]';
S2 = [1 .5; .5 1];
X2 = mvnrnd(m2,S2,round(N));
y2=ones(length(X1),1).*1;

x_f = [X1; X2];
x_f_f = transpose(x_f);
newRow = ones(1,size(x_f_f,2));  

newData = [x_f_f(1:2, :); newRow; x_f_f(3:end, :)];

y_f =[ y1; y2]';
figure(1), plot(newData(1,y_f==1),newData(2,y_f==1),'bo',...
    newData(1,y_f==-1),newData(2,y_f==-1),'r.')
figure(1), axis equal
title('Display of the 2 classes')
hold on; axis(axis);


% 1.B,C

w_ini=[6 8 -0.5]';
rho=0.1;
[w,iter,mis_class,wrong_class]=perce_with_plot(newData,y_f,w_ini,rho);
% define parameters of the decision boundary y = ax+b 
a = -(w(1)/w(2));
b =- w(3)/w(2);
%plot the decision boundary
fplot(@(x) a*x +b,'LineWidth',2)
grid on;
hold off ;
%plot misclassifications
figure('Name','Perceptron misclassifications');
plot([1:iter],wrong_class);
xlabel('Iterations');
ylabel('Misclassifications');
disp("Weights when error reaches 0");
disp(w);
disp("Number of iterations for the batch perceptron");
disp(iter);
disp("Misclassified elements ");
disp(mis_class);


