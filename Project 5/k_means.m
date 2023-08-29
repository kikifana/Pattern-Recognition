clc;
clear;
close all;
%2.A
load seeds_dataset.txt
X = seeds_dataset(:,1:7);
true_labels = seeds_dataset(:,8);
label1 = seeds_dataset(1:70,8);
label2 = seeds_dataset(71:140,8);
label3 = seeds_dataset(141:210,8);

%first iter for random initialized centroids
rng(1); % For reproducibility

[idx1,C] = kmeans(X,3,'Distance','cosine');
display(C);
display(idx1);
ri1 = rand_index(true_labels,idx1);
sorted_idx1 = sort(idx1);
label1_idx1 = sorted_idx1(1:79,1);
label2_idx1 = sorted_idx1(80:146,1);
label3_idx1 = sorted_idx1(147:210,1);

%second iter for random initialized centroids
rng(10); % For reproducibility

[idx2,C] = kmeans(X,3,'Distance','cosine');
display(C);
display(idx2);
ri2 = rand_index(true_labels,idx2);
sorted_idx2 = sort(idx2);
label1_idx2 = sorted_idx2(1:64,1);
label2_idx2 = sorted_idx2(65:146,1);
label3_idx2 = sorted_idx2(147:210,1);
%third iter for random initialized centroids
rng(50); % For reproducibility

[idx3,C] = kmeans(X,3,'Distance','cosine');
display(C);
display(idx3);
ri3 = rand_index(true_labels,idx3);
sorted_idx3 = sort(idx3);
label1_idx3 = sorted_idx3(1:81,1);
label2_idx3 = sorted_idx3(82:145,1);
label3_idx3 = sorted_idx3(146:210,1);
%forth iter for random initialized centroids
rng(100); % For reproducibility

[idx4,C] = kmeans(X,3,'Distance','cosine');
display(C);
display(idx4);
ri4 = rand_index(true_labels,idx4);
sorted_idx4 = sort(idx4);
label1_idx4 = sorted_idx4(1:82,1);
label2_idx4 = sorted_idx4(83:154,1);
label3_idx4 = sorted_idx4(155:210,1);
%fifth iter for random initialized centroids
rng(500); % For reproducibility

[idx5,C] = kmeans(X,3,'Distance','cosine');
display(C);
display(idx5);
ri5 = rand_index(true_labels,idx5);
sorted_idx5 = sort(idx5);
label1_idx5 = sorted_idx5(1:34,1);
label2_idx5 = sorted_idx5(35:48,1);
label3_idx5 = sorted_idx5(149:210,1);
ri_all = [ri1; ri2; ri3; ri4; ri5];
display(ri_all);

mean_ari = mean(ri_all);
display("the mean of the rand index using cosine metric for 5 random initialized centroids is:")
display(mean_ari)
std_ari = std(ri_all);
display("the std of the rand index using cosine metric for 5 random initialized centroids is:")
display(std_ari)

%LIA1= ismember(label1_idx1,label1)
