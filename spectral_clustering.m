function label_x=spectral_clustering(x,K,k,rand_num_K_Medoids)
%%����k���ڵ�ͼ,����Ȩ�أ��õ�ŷʽ����
dist=pdist2(x,x, 'euclidean');
[row_x,column_x]=size(x);
[~,index]=sort(dist,1);   %��ÿһ�д�С��������
W=zeros(row_x);
for j=1:row_x
    W(index(2:k+1,j),j)=1;
end
W=max(W,W');      %��֤�Գ�
%clear dist;             %����ڴ�
%����k���ɵ���ͼ�Ƿ���ͨ�Ĵ���
Dist=graphallshortestpaths(sparse(W));
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
dimension_reduction_x=[];    %��ά�������
for j=1:connected_subgraph_num        %��ÿ����ͨ��ͼ���й�������ֵ�ֽ�
    D=sum(W(connected_subgraph{j},connected_subgraph{j}));
    D=diag(D);
    L=D-W(connected_subgraph{j},connected_subgraph{j});
    [V,lamda]=eig(L,D);     % �Ѿ����մ�С����
    dimension_reduction_x=[dimension_reduction_x;V(:,2:K+1)];%��Ϊ��һ��û����
end
%��ʼ����K-Medoids
label_x=K_Medoids(dimension_reduction_x,K,rand_num_K_Medoids);
end



