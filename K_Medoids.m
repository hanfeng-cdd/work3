%%
%K-Medoids�㷨
function label_x=K_Medoids(x,K)

r=10;%ÿ���������10����

[row_x,column_x]=size(x);
label_x=zeros(row_x,1);
%��һ����ʼ��k�����ĵ�
D=1:row_x;
R=D;
S=randperm(row_x,K);%  1��x_row�������ѡK��
R(S)=[];
%�ڶ���������Ŀ�꺯��
dist=pdist2(x(S,:),x(R,:),'cityblock');
f=sum(min(dist));
%�����������´����
rand_R=R(randi(length(R),1,r));
rand_S=S(randi(K,1,r));
f_Swap=zeros(r,1);
S_Swap=S;
R_Swap=R;
for i=1:r
    




end
%�ڶ�����ֱ�Ӽ���Ŀ�꺯��





