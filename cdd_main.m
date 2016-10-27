clear;
clc;
%%
%对german数据
load german.txt;
x_german=german(:,1:end-1);
K_german=2;
k_german=[3,6,9];
rand_num_german=20;

y_german_K_Mediods=K_Medoids(x_german,K_german,rand_num_german); 
[german_K_Mediods_Purity,german_K_Mediods_Gini_Index]=Purity_Gini(german(:,end),y_german_K_Mediods);
german_Spectra_Purity=zeros(length(k_german),1);
german_Spectra_Gini_Index=zeros(length(k_german),1);
for i=1:length(k_german)
y_german_Spectra=spectral_clustering(x_german,K_german,k_german(i),rand_num_german);
[german_Spectra_Purity(i),german_Spectra_Gini_Index(i)]=Purity_Gini(german(:,end),y_german_Spectra);
end

%%
%对mnist数据
load mnist.txt;
x_mnist=mnist(:,1:end-1);
K_mnist=10;
k_mnist=[3 6 9];
rand_num_mnist=1;

y_mnist_K_Mediods=K_Medoids(x_mnist,K_mnist,rand_num_mnist); 
[mnist_K_Mediods_Purity,mnist_K_Mediods_Gini_Index]=Purity_Gini(mnist(:,end),y_mnist_K_Mediods);
mnist_Spectra_Purity=zeros(length(k_mnist),1);
mnist_Spectra_Gini_Index=zeros(length(k_mnist),1);
for i=1:length(k_mnist)
y_mnist_Spectra=spectral_clustering(x_mnist,K_mnist,k_mnist(i),rand_num_mnist);
[mnist_Spectra_Purity(i),mnist_Spectra_Gini_Index(i)]=Purity_Gini(mnist(:,end),y_mnist_Spectra);
end


