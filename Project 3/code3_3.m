clear;
clc;
close all; 
format long

% find the A 

syms theta

p_th_d = @(th) sin(pi*th);
int_p_th = integral(p_th_d,0,1);
a = round(1/int_p_th,5)
disp("A is found to be:");
disp(a);
u=0:0.01:1;

p_d_1= u*(pi/2).*sin(pi*u) / double(int(theta*(pi/2)*sin(pi*theta),theta,0,1));
p_d_5= (u.^3).*((1-u).^2).*(pi/2).*sin(pi*u) / double(int(theta^3*(1-theta)^2*(pi/2)*sin(pi*theta),theta,0,1));
p_d_10= (u.^7).*((1-u).^3).*(pi/2).*sin(pi*u) / double(int(theta^7*(1-theta)^3*(pi/2)*sin(pi*theta),theta,0,1));
hold on; 
axis([0 1 0 3]);
plot(u,p_d_1,'k'),xlabel('\Theta'), ylabel('p(\Theta|D^n)');
plot(u,p_d_5,'c'); 
plot(u,p_d_10,'m'); 
grid on
h = legend('p(Theta|D^1)','p(Theta|D^5)','p(Theta|D^10)','Location','NorthWest');
set(h,'Interpreter','none')
hold off
[q,w]=max(double(p_d_10));
disp(['The max value for p_d_10 is=' num2str(q)])
disp(['for x=' num2str((w-1)/100)])
