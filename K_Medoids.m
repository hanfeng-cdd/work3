%%  
%K-Medoids算法   自己的时间：410s(包括距离矩阵90s计算)
function label_x=K_Medoids(x,K,random_num)

[row_x,column_x]=size(x);
%r=floor(K*(row_x-K)/10);%每次随机尝试总共点对的10分之一
r=500;
lamda=0.1;%迭代终止条件：平均目标函数改善值小于lamda
%random_num=10;%因为算法是局部最优值，所以要多次随机
Dist=pdist2(x,x,'cityblock');     %把Dist矩阵先算出来，预先存好,time= 95.4811
label_x=zeros(row_x,1);
S=zeros(random_num,K);
f=zeros(random_num,1);
%tic;
%time=0;
for k=1:random_num 
    sprintf(['the','   ',num2str(k),'  ','intenation'])
%第一步初始化k个中心点
    S(k,:)=randperm(row_x,K);%  1到x_row里面随机选K个,不重复
    R=1:row_x;
    R(S(k,:))=[];
  
    %第二步，计算目标函数
    while 1
        dist=Dist(S(k,:),R);  %    dist=pdist2(x(S,:),x(R,:),'cityblock');
        f(k)=sum(min(dist));
%第三步，更新代表点
        rand_R_index=randi(length(R),1,r);
        rand_S_index=randi(K,1,r);
        g=zeros(r,1);
        for i=1:r
%完成交换,确保每一次都是只换一组
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
%以S为中心，把R中的点进行聚类
  S=S(find(f==min(f)),:);
  S=S(1,:);                 %当有多个最小时，取其中一个就行
  R=1:row_x;
  R(S)=[];
  dist=Dist(S,R);   %dist=pdist2(x(S,:),x(R,:),'cityblock');
 [~,index]=min(dist); 
 label_x(S)=1:K;        %从小到大，依次为1到K类
 for i=1:K
    label_x(R(index==i))=i;
 end
 %disp('the totle time is:   ');
% totle_time=toc
end






