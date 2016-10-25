%%
%K-Medoids算法
function label_x=K_Medoids(x,K)

r=10;%每次随机尝试10个点

[row_x,column_x]=size(x);
label_x=zeros(row_x,1);
%第一步初始化k个中心点
D=1:row_x;
R=D;
S=randperm(row_x,K);%  1到x_row里面随机选K个
R(S)=[];
%第二步，计算目标函数
dist=pdist2(x(S,:),x(R,:),'cityblock');
f=sum(min(dist));
%第三步，更新代表点
rand_R=R(randi(length(R),1,r));
rand_S=S(randi(K,1,r));
f_Swap=zeros(r,1);
S_Swap=S;
R_Swap=R;
for i=1:r
    




end
%第二步：直接计算目标函数





