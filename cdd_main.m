clear;
clc;
%%
%采用谱聚类算法
load german.txt;
x_german=german(:,1:end-1);
K_german=2;
k_german=3;
rand_num_german=10;
y_german=spectral_clustering(x_german,K_german,k_german,rand_num_german);

load mnist.txt;
x_mnist=mnist(:,1:end-1);
K_mnist=10;
k_mnist=3;
rand_num_mnist=1;
y_mnist=spectral_clustering(x_mnist,K_mnist,k_mnist,rand_num_mnist);




%%
%采用K-Medoids算法
load german.txt;
x_german=german(:,1:end-1);
K_german=2;
rand_num_german=10;
y_german=K_Medoids(x_german,K_german,rand_num_german);

load mnist.txt;
x_mnist=mnist(:,1:end-1);
K_mnist=10;
rand_num_mnist=10;
y_mnist=K_Medoids(x_mnist,K_mnist,rand_num_mnist);


%%
%计算纯度和基尼指数
[german_Purity,german_Gini_Index]=Purity_Gini(german(:,end),y_german);

[mnist_Purity,mnist_Gini_Index]=Purity_Gini(mnist(:,end),y_mnist);


