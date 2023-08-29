%                             ||  FANARIDOU KYRIAKOULA , 57830  ||
%% ASKISI 2, erwtima a
%estw N=10 tuxaio
N = 10;
x2 = ceil(6*rand(1,N));

%% ASKISI 2, erwtima b
%pdf for N = 20 rolls
N1 = 20;
x1= ceil(6*rand(1,N1));
bins = 1:6;
histogram(x1,bins, 'Normalization','pdf');
title('PDF for N=20 rolls');
xlabel('1 2 3 4 5 6');
ylabel('probability');
%%
%%ASKISI 2, erwtima b
%pdf for N = 200 rolls
N2 = 200;
x2 = ceil(6*rand(1,N2));
bins = 0.5:1:6.5;
histogram(x2,bins,'Normalization','probability');
title('PDF for N=200 rolls');
xlabel('1 2 3 4 5 6');
ylabel('probability');


%%
%ASKISI 2, erwtima b
%pdf for N = 1500 rolls
N3 = 1500;
x3 =ceil(6*(rand(1,1500)));
bins = 0.5:1:6.5;
histogram(x3,bins,'Normalization', 'pdf');
title('PDF for N=1500 rolls');
xlabel('1 2 3 4 5 6');
ylabel('probability');



%%
%ASKISI 2, erwtima c
% below mean, var,skewness and kurtosis are calculated for n number of rolls
n1 = 10; 
mean_1 = mean(ceil(6*rand(1,n1)));

var_1 = var(ceil(6 *rand(1,n1)));

skew_1 = skewness(ceil(6*rand(1,n1)));

kurt_1 = kurtosis(ceil(6*rand(1,n1)));

x1 = [mean_1 var_1 skew_1 kurt_1]

n2 = 10; 
mean_2 = mean(ceil(6*rand(1,n2)));

var_2 = var(ceil(6 *rand(1,n2)));

skew_2 = skewness(ceil(6*rand(1,n2)));

kurt_2 = kurtosis(ceil(6*rand(1,n2)));

x2 = [mean_2 var_2 skew_2 kurt_2]

n3 = 50; 
mean_3 = mean(ceil(6*rand(1,n3)));

var_3 = var(ceil(6 *rand(1,n3)));

skew_3 = skewness(ceil(6*rand(1,n3)));

kurt_3 = kurtosis(ceil(6*rand(1,n3)));

x3 = [mean_3 var_3 skew_3 kurt_3]

n4 = 100; 
mean_4 = mean(ceil(6*rand(1,n4)));

var_4 = var(ceil(6 *rand(1,n4)));

skew_4 = skewness(ceil(6*rand(1,n4)));

kurt_4 = kurtosis(ceil(6*rand(1,n4)));

x4 = [mean_4 var_4 skew_4 kurt_4]

n5 = 200; 
mean_5 = mean(ceil(6*rand(1,n5)));

var_5 = var(ceil(6*rand(1,n5)));

skew_5 = skewness(ceil(6*rand(1,n5)));

kurt_5 = kurtosis(ceil(6*rand(1,n5)));
x5 = [mean_5 var_5 skew_5 kurt_5]

n6 = 500; 
x = randi([1,6],1,200);
mean_6 = mean(x);

var_6 = var(x);

skew_6 = skewness(x);

kurt_6 = kurtosis(x);

x6 = [mean_6 var_6 skew_6 kurt_6]

n7 = 1000; 
mean_7 = mean(ceil(6*rand(1,n7)));

var_7 = var(ceil(6 *rand(1,n7)));

skew_7 = skewness(ceil(6*rand(1,n7)));

kurt_7 = kurtosis(ceil(6*rand(1,n7)));

x7 = [mean_7 var_7 skew_7 kurt_7]

%%
%ASKISI 3 
N = 1000;
z1 = ceil(6*(rand(1,N)));
z2 = ceil(6*(rand(1,N)));
y = z1.*z2;
bins = 1:1:36;
histogram(y,bins,'Normalization', 'pdf')
title('PDF for joint probability of 2 dice for 1000 rolls');
xlabel('1-36');
ylabel('probability');

%%
%%ASKISI 3 z1+z2

N = 1000;
z1 = ceil(6*(rand(1,N)));
z2 = ceil(6*(rand(1,N)));
y = z1+z2;
bins = 0.5:1:12.5;
histogram(y,bins,'Normalization', 'pdf')
title('PDF for sum of 2 dice with 1000 rolls each');
xlabel('1-12');
ylabel('probability');


%%
% ASKISI 4,erwtima b 

%    ||  GRADIENT DESCENT METHOD ||
f = @(x) (x-5).^4+3*x;
pnt_x = 2; %random starting point
lr = .01; %learning rate 
error = 1e-6; % error tolerance
previous_dist = 1;

iters = 1; 
df = @(x) 4*(x-5).^3+3; %derivative of f

while previous_dist > error 
    prev_x = pnt_x;
    pnt_x = pnt_x - lr*df(prev_x); %gradient descent
    previous_dist = abs(pnt_x-prev_x); 
    iters = iters +1;
    
    if iters>10000
        fprintf("Exceeded the maximum iterations try another random learning rate\n")
        break
    end
    fprintf('Iteration:%d x= %.20f\n',iters,pnt_x)
end
fprintf("the minimum is %f",pnt_x)


 %%   
%%ASKISI 4, erwtima c
%            || NEWTON METHOD ||
f = @(x) (x-5).^4+3*x;
df = @(x) 4*(x-5).^3+3;
ddf = @(x) 12*(x-5).^2;

iters = 1; 
x_in = 2;
error = 1e-6; %error tolerance

while iters<1000
    x_next = x_in - (df(x_in)/ddf(x_in));
    fprintf('Iteration:%d x= %.20f\n',iters,x_next) %newton method 
    
    if (abs(x_next - x_in))<error %if xnew-x_in < error tolerance minimum is found
        break
    end
    iters = iters+1;
    x_in=x_next;
     
end
if  iters == 1000
        fprintf('The Newton method has failed to converge for %3.0f iterations',iters);
end

fprintf("The minimum is %f",x_next)