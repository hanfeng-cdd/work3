%%  
%K-Medoids算法
function label_x=K_Medoids(x,K)

r=10;%每次随机尝试10对点
lamda=0.1;%迭代终止条件：平均目标函数改善值小于lamda

[row_x,column_x]=size(x);
label_x=zeros(row_x,1);
%第一步初始化k个中心点
D=1:row_x;
R=D;
S=randperm(row_x,K);%  1到x_row里面随机选K个
R(S)=[];
j=1;
%第二步，计算目标函数
while 1
    sprintf(['the','   ',num2str(j),'  ','intenation'])
    dist=pdist2(x(S,:),x(R,:),'cityblock');
    f=sum(min(dist));
%第三步，更新代表点
    rand_R_index=randi(length(R),1,r);
    rand_S_index=randi(K,1,r);
    g=zeros(r,1);
    for i=1:r
%完成交换,确保每一次都是只换一组
        S_Swap=S;
        R_Swap=R;          
        t=R_Swap(rand_R_index(i));
        R_Swap(rand_R_index(i))=S_Swap(rand_S_index(i));
        S_Swap(rand_S_index(i))=t;
        dist=pdist2(x(S_Swap,:),x(R_Swap,:),'cityblock');
        g(i)=sum(min(dist));   
    end
    if (f<=min(g))|| (sum(f-g(g<f))/sum(g<f))<lamda
        break;
    else
        flag=find(g==min(g));
        t=R(rand_R_index(flag));
        R(rand_R_index(flag))=S(rand_S_index(flag));
        S(rand_S_index(flag))=t;
    end
    sprintf(['f=',num2str(f)])
end
%%
%以S为中心，把R中的点进行聚类
 dist=pdist2(x(S,:),x(R,:),'cityblock');
 [~,index]=min(dist); 
 label_x(S)=1:K;        %从小到大，依次为1到K类
 for i=1:K
    label_x(R(index==i))=i;
 end
end






