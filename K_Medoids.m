%%  
%K-Medoids�㷨   �Լ���ʱ�䣺410s(�����������90s����)
function label_x=K_Medoids(x,K,random_num)

[row_x,column_x]=size(x);
%r=floor(K*(row_x-K)/10);%ÿ����������ܹ���Ե�10��֮һ
r=500;
lamda=0.1;%������ֹ������ƽ��Ŀ�꺯������ֵС��lamda
%random_num=10;%��Ϊ�㷨�Ǿֲ�����ֵ������Ҫ������
Dist=pdist2(x,x,'cityblock');     %��Dist�������������Ԥ�ȴ��,time= 95.4811
label_x=zeros(row_x,1);
S=zeros(random_num,K);
f=zeros(random_num,1);
%tic;
%time=0;
for k=1:random_num 
    sprintf(['the','   ',num2str(k),'  ','intenation'])
%��һ����ʼ��k�����ĵ�
    S(k,:)=randperm(row_x,K);%  1��x_row�������ѡK��,���ظ�
    R=1:row_x;
    R(S(k,:))=[];
  
    %�ڶ���������Ŀ�꺯��
    while 1
        dist=Dist(S(k,:),R);  %    dist=pdist2(x(S,:),x(R,:),'cityblock');
        f(k)=sum(min(dist));
%�����������´����
        rand_R_index=randi(length(R),1,r);
        rand_S_index=randi(K,1,r);
        g=zeros(r,1);
        for i=1:r
%��ɽ���,ȷ��ÿһ�ζ���ֻ��һ��
            S_Swap=S(k,:);
            R_Swap=R;          
            t=R_Swap(rand_R_index(i));
            R_Swap(rand_R_index(i))=S_Swap(rand_S_index(i));
            S_Swap(rand_S_index(i))=t;
            dist=Dist(S_Swap,R_Swap);   %  dist=pdist2(x(S_Swap,:),x(R_Swap,:),'cityblock');
            g(i)=sum(min(dist));   
        end
 %       sprintf(['sum(f-g(g<f))/sum(g<f)=',num2str( sum(f-g(g<f))/sum(g<f)),'\n'])
        if (f(k)<=min(g))|| (sum(f(k)-g(g<f(k)))/sum(g<f(k)))<lamda
            break;
        else
            flag=find(g==min(g));
            t=R(rand_R_index(flag));
            R(rand_R_index(flag))=S(k,rand_S_index(flag));
            S(k,rand_S_index(flag))=t;
        end
    end
     dist=Dist(S(k,:),R);  %    dist=pdist2(x(S,:),x(R,:),'cityblock');
     f(k)=sum(min(dist));
     sprintf(['f(k)=',num2str(f(k))])
 %    time1=time;
 %    time=toc;
  %   time_every=time-time1
end
%%
%��SΪ���ģ���R�еĵ���о���
  S=S(find(f==min(f)),:);
  S=S(1,:);                 %���ж����Сʱ��ȡ����һ������
  R=1:row_x;
  R(S)=[];
  dist=Dist(S,R);   %dist=pdist2(x(S,:),x(R,:),'cityblock');
 [~,index]=min(dist); 
 label_x(S)=1:K;        %��С��������Ϊ1��K��
 for i=1:K
    label_x(R(index==i))=i;
 end
 %disp('the totle time is:   ');
% totle_time=toc
end






