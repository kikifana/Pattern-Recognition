clc;
clear;


m =[0 0 0; 1 2 2; 3 3 4]';

S(:,:,1)=[0.8 0.2 0.1; 0.2 0.8 0.2; 0.1 0.2 0.8] ;
S(:,:,2)=[0.6 0.2 0.01; 0.2 0.8 0.01; 0.01 0.01 0.6];
S(:,:,3)=[0.6 0.1 0.1; 0.1 0.6 0.1; 0.1 0.1 0.6];

S1=S(:,:,1);
S2=S(:,:,2);
S3=S(:,:,3);

P=[1/6 1/6 2/3]';

N=1000;

% create random data testing
randn('seed',100);
[X1,y1] = gauss_class(m,S,P,N);


%here we compute the classifiers using the estimation 
%for testing data 

class_euclidean = euclidean_classifier(m,X1);

class_mahalanobis = mahalanobis_classifier(m,S,X1);

class_bayes = bayes_classifier(m,S,P,X1);

%compute the errors for each classifier

err_euclidean = (1-length(find(y1 ==class_euclidean))/length(y1));

err_mahalanobis = (1-length(find(y1 ==class_mahalanobis))/length(y1))

err_bayes = (1-length(find(y1 ==class_bayes))/length(y1))

errors = [round(err_euclidean,5); round(err_mahalanobis,5); round(err_bayes,5)];
disp("The probability errors for specific mean and covariance is displayed:");
disp(errors)

% function to find the estimators for mean and covariance 
% using gaussian distirbution

function [m_est,S_est] = estimators(X)

% dimensions of X 3 x 1000
[l,N] = size(X);

% mean estimator equals
% to the arithmetic mean of learning data
m_est = (1/N)*sum(X')'; 

% initialize covariance estimator to zero 
S_est = zeros(l);

for k=1:N
    
    S_est = S_est + (X(:,k) -m_est)*(X(:,k)-m_est)';
    
end
% we suppose biased ML estimator 
S_est = (1/N)*S_est;
end
% function to find the gauss classes for random vectors
function [X,y] = gauss_class(m,S,P,N)

X = [];
y = [];
% we create a random vector for 1000
for j=1:3 % 3 because of mean vector 
    
    vector = mvnrnd(m(:,j),S(:,:,j),fix(P(j)*N))';
    X = [X vector];
    y = [y ones(1,fix(P(j)*N))*j];
end
end
% function for euclidean classifier 
%euclidean distances is only used for 
%diagonal covariance matrixes 
% || WE DO NOT HAVE THIS KIND OF COV MATRIX ||

function [euc_class] = euclidean_classifier(m,X)
[l,c]=size(m);
[l,N]=size(X);
for i = 1:N
    for j=1:c
        euc_distance(j) = sqrt((X(:,i)-m(:,j))'*(X(:,i)-m(:,j)));
    end
    [~,euc_class(i)] = min(euc_distance);
end

end
%function for mahalanobis classifier
function [z]=mahalanobis_classifier(m,S,X)

[l,c]=size(m);
[l,N]=size(X);

for i=1:N
    for j=1:c
        dm(j)=sqrt((X(:,i)-m(:,j))'*inv(S(:,:,j))*(X(:,i)-m(:,j)));
    end
    [num,z(i)]=min(dm);
end
end
% first we compute with a function the pdf
% for gaussian distirbution

function [pdf]=gauss_pdf(m,S,X)

l=3;
pdf=(1/( (2*pi)^(l/2)*det(S)^0.5) )*exp(-0.5*(X-m)'*inv(S)*(X-m));

end

%function for bayes classifier
function [z] = bayes_classifier(m,S,P,X)

[l,c]=size(m);
[l,N]=size(X);

for i=1:N
    for j=1:c
        t(j)=P(j)*gauss_pdf(m(:,j),S(:,:,j),X(:,i));
    end
    [num,z(i)]=max(t);
end
end