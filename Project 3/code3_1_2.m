%                 || FANARIDOU KYRIAKOULA, 57830 ||
clear;
clc;
close all
%  ASKISI 3.2.1
%           -------w1-------  -------w2-------  -------w3-------
%            x1    x2    x3    x1    x2    x3    x1    x2    x3
data =[-5.01 -8.12 -3.68 -0.91 -0.18 -0.05  5.35  2.26  8.13;
       -5.43 -3.48 -3.54  1.3  -2.06 -3.53  5.12  3.22 -2.66;
        1.08 -5.52  1.66 -7.75 -4.54 -0.95 -1.34 -5.31 -9.87;
        0.86 -3.78 -4.11 -5.47  0.5   3.92  4.48  3.42  5.19;
       -2.67  0.63  7.39  6.14  5.72 -4.85  7.11  2.39  9.21;
        4.94  3.29  2.08  3.6   1.26  4.36  7.17  4.33 -0.98;
       -2.51  2.09 -2.59  5.37 -4.63 -3.65  5.75  3.97  6.65;
       -2.25 -2.13 -6.94  7.18  1.46 -6.66  0.77  0.27  2.41;
        5.56  2.86 -2.26 -7.39  1.17  6.3   0.9  -0.43 -8.71;
        1.03 -3.33  4.33 -7.5  -6.32 -0.31  3.52 -0.36  6.43];
         
pw1 = 1/2;
pw2 = 1/2;

syms g1(x1);
g1(x1) = g(data(:,1), pw1);

syms g2(x1);
g2(x1) = g(data(:,4), pw2);

g1_2 = g1- g2;
sol_1 = double(solve(g1_2==0));


disp("The solution is  = ");
disp(sol_1);


% ASKISI 3.2.2
sort1 = 0;
sort2 = 0;
for i=1:10
    
    if g1_2(data(i,1))>0
        sort1 = sort1 + 1;
    end
    
     if g1_2(data(i,4))<0
        sort2 = sort2 + 1;
    end
end

error1 = (10 - sort1)/10;
error2 = (10 - sort2)/10;
disp("Classification using x1:");
disp(["Error w1: " + num2str(error1)]);
disp(["Error w2: " + num2str(error2)]);


hold on;
plot(data(:,1),zeros(1,10),'*');
plot(data(:,4),zeros(1,10) ,'o');
plot([sol_1(1) sol_1(1)], ylim);
plot([sol_1(2) sol_1(2)], ylim);
title("classification using x1");


% ASKISI 3.2.3

syms g1(x1,x2);
g1(x1,x2) = g(data(:,1:2), pw1);
syms g2(x1,x2);
g2(x1,x2) = g(data(:,4:5), pw2);
d2 = g1 - g2;
syms W0_2(x1);
W0_2(x1) = (solve(d2==0,x2));

figure;
hold on;
plot(data(:,1),data(:,2),'*');
plot(data(:,4),data(:,5),'o');
fplot(W0_2);
xlim([-10 10]);
ylim([-10 10]);
title("Classification using x1 and x2");

error3 = 0;
error4 = 0;
for i=1:10
    if d2(data(i,1),data(i,2))>0
        error3 = error3 + 1;
    end
     if d2(data(i,4),data(i,5))<0
        error4 = error4 + 1;
    end
end

error1 = (10 - error3)/10;
error2 = (10 - error4)/10;
disp("Classification using x1 and x2:");
disp(["Error w1: " + num2str(error1)]);
disp(["Error w2: " + num2str(error2)]);


% ASKISI 3.2.4


syms g5(x1,x2,x3);
g5(x1,x2,x3) = g(data(:,1:3),pw1);
syms g6(x1,x2,x3);
g6(x1,x2,x3) = g(data(:,4:6),pw2);
g1_2_3 = g5 - g6;
syms sol_3(x1,x2);
sol_3(x1,x2) = solve(g1_2_3 ==0,x3);

sort_5 = 0;
sort_6 = 0;
for i=1:10
    if g1_2_3(data(i,1),data(i,2),data(i,3)) > 0
        sort_5 = sort_5 + 1;
    end
    if g1_2_3(data(i,4),data(i,5),data(i,6)) < 0
        sort_6 = sort_6 +1;
    end
end

error5 = (10-sort_5)/10;
error6 = (10-sort_6)/10;

disp("Classification using x1,x2 and x3 is :");
disp(["Error w1: " + num2str(error5)]);
disp(["Error w2: " + num2str(error6)]);

% ASKISI 3.2.6

pw1 = 0.8;
pw2 = 0.1;
pw3 = 0.1;
syms g1(x1,x2,x3);
g1(x1,x2,x3) = g(data(:,1:3),pw1);
syms g2(x1,x2,x3);
g2(x1,x2,x3) = g(data(:,4:6),pw2);
syms g3(x1,x2,x3);
g1(x1,x2,x3) = g(data(:,7:9),pw3);
d1_2 = (g1 - g2);
d2_3 = g2 - g3;
d1_3 = g1 - g3;
disp(simplify(d1_2,'steps',500))
disp(simplify(d2_3,'steps',500))
disp(simplify(d1_3,'steps',500))




%         ||      FUNCTIONS GIA ASKISI 3.1       ||
% ------------------------------------------------------------
%                 ||      ASKISI 3.1.1     ||

function [dis_func] = g(data,pw)
m = mean(data)';
S = cov(data);
d = length(S);
x = sym('x',[d 1],'real');
dis_func = (-1/2)*(x-m)'*inv(S)*(x-m)-d*log(2*pi)/2-1/2*log(det(S))+log(pw);
end


%     ||      ASKISI 3.1.2    ||
function [dis_eucl] = euclid(x1,x2)
    s = 0;
    d = length(vec1);

    for i=1:d
        s = s + (x2(i)-x1(i))^2;
    end
    dis_eucl = sqrt(s);
end
%               ||      ASKISI 3.1.3     ||

function [dis_maha] = mahalanobis(x,m,S)
    dist = length(x);
    for i = 1:d
    dis_maha = sqrt((x(1,:)-m)'*inv(S)*(x(1,:)-m));
    end 
end



