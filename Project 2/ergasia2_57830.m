%           ||      FANARIDOU KYRIAKOULA , 57830   ||

clc;
clear;


p_w1 = 1/3;
p_w2 = 2/3;

N = 1000;

%conjuction probabilities

px_w1 = 2 + 0.7071.*randn(round(N*p_w1),1); 
px_w2 = 1.5 + 0.4472.*randn(round(N*p_w2),1);

cost = 0;

for i=1:length(px_w1)
    if (px_w1(i) < 0.0126 && px_w1(i)>2.32)
        %if it was wrongly in px_w2 the penalty is l21 =3
        cost = cost + 3;
    else
        %l11 = 1
        cost = cost +1;
    end
end

for i=1:length(px_w2)
    if (px_w2(i) > 0.0126 && px_w2(i)<2.32)
       %l22 it's correct
        cost = cost + 1;
    else
        %l12 = 2
        cost = cost +2;
    end
end

disp("The total cost with bayes classification theorem is:");
disp(cost);
disp("Mean cost:");
mean_cost = cost/N;
disp(mean_cost);

histogram(px_w1);

figure
histogram(px_w2);