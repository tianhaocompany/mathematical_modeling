function [M_sorted,h_sorted]=relief(M,h)
%计算矩阵M的特征计分准则FSC，包括FSC,RFSC,BFSC
%这里M的行代表样本，列代表基因
%  Author : LIU Chao
%  e-mail : liuchao-will@163.com
%  School of Computer Science and Technology,Southeast
%  University,China,Sept.2010
[r,c]=size(M);
FSC=[];
RFSC=[];
BFSC=[];
for j=1:1:c
    A=M(:,j);
%     A_plus=A(find(A>=0));
%     A_minus=A(find(A<0));   
    A_plus=A(1:22);%正常样本
    A_minus=A(23:62);%癌细胞样本
%      FSC(j)=abs(mean(A_plus)-mean(A_minus)) / (std(A_plus)+std(A_minus)) ;
%    RFSC(j)=0.5*abs((mean(A_plus)-mean(A_minus))/(std(A_plus)+std(A_minus)))+0.5*log10((std(A_plus)^2+std(A_minus)^2)/(2*std(A_plus)*std(A_minus)));
    BFSC(j)=0.25*( (mean(A_plus)-mean(A_minus))^2 / (std(A_plus)^2+std(A_minus)^2)) + 0.5*log10((std(A_plus)^2+std(A_minus)^2)/(2*std(A_plus)*std(A_minus)));
    %见论文：肿瘤信息基因启发式宽度优先搜索算法研究
end

% [FSC_des,FSC_index]=sort(FSC,'descend');%降序
% figure('name','FSC');
% x=0:0.001:max(FSC_des);
% hist(FSC_des,x);
% bar(FSC_des);

% [RFSC_des,RFSC_index]=sort(RFSC,'descend');%降序
% figure('name','RFSC');
% y=0:0.001:max(RFSC_des);
% hist(RFSC_des,y);
% bar(RFSC_des);

 [BFSC_des,BFSC_index]=sort(BFSC,'descend');%降序
% figure('name','BFSC');
% z=0:0.001:max(BFSC_des);
% hist(BFSC_des,z);
% bar(BFSC_des);
M_sorted=M(:,BFSC_index);
h_sorted=h(BFSC_index);
% W=zeros(1,c);
% for i=1:1:r
%     X=M(i,:);
%     MM=[];
%     NN=[];
%     if i>=1&&i<=22
%         for m=1:1:22;
%             if m==i
%                 continue;
%             end
%             MM(m)=dist(X,M(m,:)');
%         end
%         [V,I]=min(MM);
%         if I<i
%             In=M(I,:);
%         else
%             In=M(I+1,:);
%         end
% 
%         for n=23:1:62
%             NN(n-22)=dist(X,M(n,:)');
%         end
%         [VV,II]=min(NN);
%         Out=M(II+22,:);
%     else
%         for m=1:1:22;
%             MM(m)=dist(X,M(m,:)');
%         end
%         [V,I]=min(MM);
%         Out=M(I,:);
% 
%         for n=23:1:62
%             if n==i
%                 continue;
%             end
%             NN(n-22)=dist(X,M(n,:)');
%         end
%         [VV,II]=min(NN);
%         if II+22<i
%             In=M(II+22,:);
%         else
%             In=M(II+23,:);
%         end
%     end
%     for j=1:1:c
%         W(j)=W(j)-abs(X(j)-In(j))/r+abs(X(j)-Out(j))/r;
%     end
% end
% [W_des,index]=sort(W,'descend');
% for k=1:1:c
%     R(:,k)=M(:,index(k));
% end



    

    
    
    
