% 3.4.2
%initial values without estimation
clc;
clear;


m =[0 0 0; 1 2 2; 3 3 4]';

S1=[ 0.8 0.2 0.1; 0.2 0.8 0.2; 0.1 0.2 0.8];
S(:,:,1)=S1;
S(:,:,2)=S1;
S(:,:,3)=S1;
S2 = S(:,:,2);
S3 = S(:,:,3);
P=[1/3 1/3 1/3]';

N=1000;

% create random data testing
randn('seed',100);
[X1,y1] = gauss_class(m,S,P,N);

% errors with specific S and m without estimation

S11 = (1/3)*(S1+S2+S3);


class_euclidean = euclidean_classifier(m,X1);

class_mahalanobis = mahalanobis_classifier(m,S11,X1);

class_bayes = bayes_classifier(m,S,P,X1);

%compute the errors for each classifier

err_euclidean = (1-length(find(y1 ==class_euclidean))/length(y1));

err_mahalanobis = (1-length(find(y1 ==class_mahalanobis))/length(y1));

err_bayes = (1-length(find(y1 ==class_bayes))/length(y1));



errors = [round(err_euclidean,5); round(err_mahalanobis,5); round(err_bayes,5)];
disp("The initial errors for specific mean and covariance is displayed:");
disp(errors)

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

function [euc_class] = euclidean_classifier(m,X)

for i = 1:999
    for j=1:3
        euc_distance(j) = sqrt((X(:,i)-m(:,j))'*(X(:,i)-m(:,j)));
    end
    [~,euc_class(i) ] = min(euc_distance);
end

end
%function for mahalanobis classifier
function [maha_dist]=mahalanobis_classifier(m,S,X)


for i=1:999
    for j=1:3
        distance(j)=sqrt((X(:,i)-m(:,j))'*inv(S)*(X(:,i)-m(:,j)));
    end
    [~,maha_dist(i)]=min(distance);
end
end

% for gaussian distirbution

function [pdf]=gauss_pdf(m,S,X1)

l=3;
pdf=(1/( (2*pi)^(l/2)*det(S)^0.5) )*exp(-0.5*(X1-m)'*inv(S)*(X1-m));

end

%function for bayes classifier
function [bayes_class] = bayes_classifier(m,S,P,X1)

for i=1:999
    for j=1:3
       bayes(j)=P(j)*gauss_pdf(m(:,j),S(:,:,j),X1(:,i));
    end
    [~,bayes_class(i)] = max(bayes);
end
end