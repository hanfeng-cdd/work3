clear;
clc;

% load german.txt;
% x=german(:,1:24);
% K=2;
% y=K_Medoids(x,K);

load mnist.txt;
x_mnist=mnist(:,1:784);
%Dist=pdist2(x_mnist,x_mnist,'cityblock'); 
%save Dist_mnist.txt Dist -ascii ;
K_mnist=10;
y_mnist=K_Medoids(x_mnist,K_mnist);