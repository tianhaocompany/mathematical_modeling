
% dt=1;
% x = -0:dt:180;
% figure;
% % hist(aa,x);
% aa=a;
% n=hist(aa,x);
% nn=sum(n,2);
% a=numel(aa);
% a=a*dt;%重要式子，从统计直方图到概率密度转化因子
% bar(x,nn/a)
% hold on
% x=0:1:180;
% thegma=std(aa);
% u=mean(aa);
% pdf=(1.0/(sqrt(2*pi)*thegma))*exp(-(x-u).^2/float(2*thegma^2));
% plot(x,pdf,'r','LineWidth',2);
% legend('数据分布直方图','估计得到的高斯分布');
% text_name=['步长 = ' num2str(dt)];
% text(2,1.45,text_name)
% 
% dt=5;
% x=0:dt:180;
% figure;
% % hist(aa,x);
% n=hist(aa,x);
% nn=sum(n,2);
% a=numel(aa);
% a=a*dt;%重要式子，从统计直方图到概率密度转化因子
% bar(x,nn/a)
 x=0:0.02:1;
 n=hist(aa,x);
 bar(x,n/231/0.02)

%  hist(aa,40)
% x=0:5:180;
% n=hist(aa,x);
% plot(n/231)
hold on
% x=0:5:180;
thegma=std(aa);
u=mean(aa);
pdf=(1/(sqrt(2*pi)*thegma))*exp(-(x-u).^2/(2*thegma^2));
plot(x,pdf,'r','LineWidth',2);
legend('匹配测度值特征数据分布直方图','估计得到的高斯分布');
% set(gca,'Xtick',(1:1:9),'Xticklabel',{'0','20','40','60','80','100','120','140','160'},...
%     'Color','white','FontWeight',' bold ')