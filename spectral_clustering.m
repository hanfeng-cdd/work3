function label_x=spectral_clustering(x,K,k,rand_num_K_Medoids)
%自己的时间总共：400s

%%生成k近邻的图,加上权重，用的欧式距离
dist=pdist2(x,x, 'euclidean');
[row_x,column_x]=size(x);
[~,index]=sort(dist,1);   %对每一列从小到大排序
clear dist;             %清除内存
W=zeros(row_x);
for j=1:row_x
    W(index(2:k+1,j),j)=1;
end
W=max(W,W');      %保证对称
clear index;
%对于k构成的子图是否连通的处理
Dist=graphallshortestpaths(sparse(W));
%W=sparse(W);     %稀疏存储节省空间
 connected_subgraph={};
connected_subgraph_num=1;
connected_subgraph{1}=find(Dist(1,:)<inf);
totle_num=1:row_x;
b=find(Dist(1,:)==inf);
while size(b)~=[0,0]
        totle_num=setdiff(totle_num,connected_subgraph{connected_subgraph_num});
        connected_subgraph_num=connected_subgraph_num+1;
        connected_subgraph{connected_subgraph_num}=find(Dist(b(1),:)<inf);
        b=totle_num(find(Dist(b(1),totle_num)==inf));
end
clear Dist;      %清除内存
dimension_reduction_x=[];    %降维后的数据
for j=1:connected_subgraph_num        %对每个连通子图进行广义特征值分解
    D=sum(W(connected_subgraph{j},connected_subgraph{j}));
    D=diag(D);
    L=D-W(connected_subgraph{j},connected_subgraph{j});
    [V,~]=eig(L,D);     % 已经按照从小到大,时间128s
    dimension_reduction_x=[dimension_reduction_x;V(:,2:K+1)];%因为第一列没有用
end
%开始调用K-Medoids
clear D;
clear L;        
clear W;         %清除内存
clear V;
label_x=K_Medoids(dimension_reduction_x,K,rand_num_K_Medoids);
end




