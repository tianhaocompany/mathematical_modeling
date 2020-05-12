clear all;
clc;
fid1=fopen('pre_pro.txt','r');
data1=fscanf(fid1,'%g',[62,1909]);
data=data1';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 计算正常与癌变的均值与标准差
for i=1:1909
    normal_ave(i)=sum(data(i,1:12))/12;
    for j=1:12
        normal_biaozhuncha(i)=sqrt(sum(data(i,j)-normal_ave(i))^2/(12-1));
    end
end
for i=1:1909
    cancer_ave(i)=sum(data(i,13:62))/40;
    for j=13:62
        cancer_biaozhuncha(i)=sqrt(sum(data(i,j)-cancer_ave(i))^2/(40-1));
    end
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 方法一：d为基因信噪比
% for i=1:1909
%     d(i)=abs((normal_ave(i)-cancer_ave(i))/(normal_biaozhuncha(i)+cancer_biaozhuncha(i)));
% end
% dd=d';
% 
% [A,ind]=sort(d,'descend');
% d_juli=zeros(1909,2);
% 
% for i=1:1909
%     d_juli(i,1)=ind(i);
%     d_juli(i,2)=A(i);
% end
% BB_juli=d_juli(:,2)/d_juli(1,1);

% for i=1:300
%         choose_300(i,1)=d_juli(i,1);
%         choose_300(i,2)=d_juli(i,2);
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 方法二：b为Bhattacharyya距离
for i=1:1909
    b(i)=1/4*(normal_ave(i)-cancer_ave(i))^2/(normal_biaozhuncha(i)^2+cancer_biaozhuncha(i)^2)...
        +1/2*log((normal_biaozhuncha(i)^2+cancer_biaozhuncha(i)^2)/(2*normal_biaozhuncha(i)*cancer_biaozhuncha(i)));
end
bb=b';

[B,ind2]=sort(b,'descend');
b_juli=zeros(1909,2);

for i=1:1909
    b_juli(i,1)=ind2(i);
    b_juli(i,2)=B(i);
end
BB_juli=b_juli(:,2)/b_juli(1,1)/0.06;
figure(1);
hist(BB_juli,25);
