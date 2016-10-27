clear;%清除内存
%对mnist数据
load mnist.txt;
%参数设置
K_mnist=10;
k_mnist=3;
rand_num_mnist=1;
tic;
y_mnist_Spectra=spectral_clustering(mnist(:,1:end-1),K_mnist,k_mnist,rand_num_mnist);
time=toc