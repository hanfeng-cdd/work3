clear;
clc;
%%
%对german数据
tic
load german.txt;           %加载原数据
% 参数设置
K_german=2;                 %聚类类别数
k_german=[3,6,9];             %谱聚类中建立近邻图的参数k
rand_num_german=20;           %K-Mediods算法要随机运行的次数
%运行K-Mediods算法并计算结果
y_german_K_Mediods=K_Medoids(german(:,1:end-1),K_german,rand_num_german);    
[german_K_Mediods_Purity,german_K_Mediods_Gini_Index]=Purity_Gini(german(:,end),y_german_K_Mediods);
 %运行不同参数的谱聚类算法并计算结果
german_Spectra_Purity=zeros(length(k_german),1);
german_Spectra_Gini_Index=zeros(length(k_german),1);
for i=1:length(k_german)                               
y_german_Spectra=spectral_clustering(german(:,1:end-1),K_german,k_german(i),rand_num_german);
[german_Spectra_Purity(i),german_Spectra_Gini_Index(i)]=Purity_Gini(german(:,end),y_german_Spectra);
end


%%
%对mnist数据
load mnist.txt;
%参数设置
K_mnist=10;
k_mnist=[3 6 9];
rand_num_mnist=10;
%Dist=pdist2(mnist(:,1:end-1),mnist(:,1:end-1),'cityblock');
%运行K-Mediods算法并计算结果
y_mnist_K_Mediods=K_Medoids(mnist(:,1:end-1),K_mnist,rand_num_mnist);  
[mnist_K_Mediods_Purity,mnist_K_Mediods_Gini_Index]=Purity_Gini(mnist(:,end),y_mnist_K_Mediods);
%运行不同参数的谱聚类算法并计算结果
mnist_Spectra_Purity=zeros(length(k_mnist),1);
mnist_Spectra_Gini_Index=zeros(length(k_mnist),1);
for i=1:length(k_mnist)
y_mnist_Spectra=spectral_clustering(mnist(:,1:end-1),K_mnist,k_mnist(i),rand_num_mnist);
[mnist_Spectra_Purity(i),mnist_Spectra_Gini_Index(i)]=Purity_Gini(mnist(:,end),y_mnist_Spectra);
end
time=toc;
sprintf(['the totle time is: ',num2str(time)])

