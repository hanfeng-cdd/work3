function  [Purity,Gini_Index]=Purity_Gini(ture_label,y_label)
ture_label_num=size(unique(ture_label),1);
y_label_num=size(unique(y_label),1);
confusion_matrix=zeros(ture_label_num,y_label_num);
data_num=max(size(y_label,1));
ture_class=unique(ture_label);
y_class=unique(y_label);
for i=1:data_num
   confusion_matrix(ture_class==ture_label(i),y_class==y_label(i))= confusion_matrix(ture_class==ture_label(i),y_class==y_label(i))+1;
end
%计算纯度
P=max(confusion_matrix);%计算每一列最大的数
Purity=sum(P)/data_num;
%计算平均基尼指数，按列计算
M=sum(confusion_matrix,1);
G=ones(1,y_label_num)-sum((confusion_matrix./repmat(M,ture_label_num,1)).^2);
Gini_Index=M*G'/data_num;


