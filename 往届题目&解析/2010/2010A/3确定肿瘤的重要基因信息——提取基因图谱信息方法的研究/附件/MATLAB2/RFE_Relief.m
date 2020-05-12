function  [h_min,err_min]=RFE_Relief(M,h)
%找到决定分类的最小数量的基因组
%  Author : LIU Chao  
%  e-mail : liuchao-will@163.com
%  School of Computer Science and Technology,Southeast
%  University,China,Sept.2010  
% err=svm_process(M);
h_gab={};
err_gab=[];
i=1;
while ~isempty(h)
%     err_gab(i)=err;
    [M,h]=relief_new(M,h);
    err_gab(i)=svm_process(M);
    h_gab(i)=h(length(h));
    [r,c]=size(M);
%     if c==5
%         M5=M;
%         save M05 M5;
%         h5=h;
%         save h05 h5;
%     end
    
    M(:,c)=[];
    h(length(h))=[];
%     err=svm_process(M);
    i=i+1;
end
% 这时M是空矩阵 62 by 1
err_gab
err_min=min(err_gab);
h_min_t=h_gab(max(find(err_gab==min(err_gab))):length(h_gab));
h_min=h_min_t;
for j=1:1:length(h_min_t)
    h_min(j)=h_min_t(length(h_min_t)+1-j);
end 



% A=M;
% geneW=[];   
% i=1;
% while ~isempty(A)
%     [W_new,index]=relief(A);
%     [r,c]=size(A);
%     if index(length(index))==1
%          A=A(:,2:c);
%     elseif index(length(index))==c
%          A=A(:,1:c-1);
%     else
%         A=A(:,1:index(length(index))-1,index(length(index))+1:c);%去掉权值最小的一列
%     end
%     
%     if isempty(geneW)
%         geneW(i)=index(length(index));
%     else
%         if index(length(index))<min(geneW(1:i-1))
%             geneW(i)=index(length(index));
%         else
%             
%             
%         
%     i=i+1;
%     
%     
%     
%     
% end