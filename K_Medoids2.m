%%  
%K-Medoids�㷨
function label_x=K_Medoids(x,K)

r=10;%ÿ���������10�Ե�
lamda=0.1;%������ֹ������ƽ��Ŀ�꺯������ֵС��lamda

[row_x,column_x]=size(x);
label_x=zeros(row_x,1);
%��һ����ʼ��k�����ĵ�
D=1:row_x;
R=D;
S=randperm(row_x,K);%  1��x_row�������ѡK��
R(S)=[];
j=1;
%�ڶ���������Ŀ�꺯��
while 1
    sprintf(['the','   ',num2str(j),'  ','intenation'])
    dist=pdist2(x(S,:),x(R,:),'cityblock');
    f=sum(min(dist));
%�����������´�����
    rand_R_index=randi(length(R),1,r);
    rand_S_index=randi(K,1,r);
    g=zeros(r,1);
    for i=1:r
%��ɽ���,ȷ��ÿһ�ζ���ֻ��һ��
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
%��SΪ���ģ���R�еĵ���о���
 dist=pdist2(x(S,:),x(R,:),'cityblock');
 [~,index]=min(dist); 
 label_x(S)=1:K;        %��С��������Ϊ1��K��
 for i=1:K
    label_x(R(index==i))=i;
 end
end





