clc;
clear all;
fid1=fopen('pre_pro.txt','r');
data1=fscanf(fid1,'%g',[62,1909]);
data111=data1';
disp('%%%%%%%%%%%%');

 biaohao=[1696 643 1560 457 27 1855 1094 1798 67 691 18 608 1108 1858 976];

for i=1:1909
xd1(1:62,i)=wden(data1(1:62,i),'heursure','s','one',3,'db3');
xd2(1:62,i)=wden(data1(1:62,i),'minimaxi','s','one',3,'db5');
xd3(1:62,i)=wden(data1(1:62,i),'minimaxi','s','one',3,'sym8');
xd4(1:62,i)=wden(data1(1:62,i),'minimaxi','s','one',3,'haar');
end






figure(1);
% for i=1:5
% subplot(3,2,i);
plot(data1(1:62,biaohao(3)));
xlabel('样本序列');
ylabel('幅度A');
title(' 参考信号');
%end
% figure(2);
% plot(s);
% xlabel('样本序列');
% ylabel('幅度A');
% title('含噪音信号');
figure(2);
% for i=1:5
% subplot(3,2,i);
plot(xd1(1:62,3));
xlabel('样本序列');
ylabel('幅度A');
title(' DB3消除噪音信号');
% end
figure(3);
% for i=1:5
% subplot(3,2,i);
plot(xd2(1:62,3));

xlabel('样本序列');
ylabel('幅度A');
title(' DB5消除噪音信号');
% end
figure(4);
% for i=1:5
% subplot(3,2,i);
plot(xd3(1:62,3));

xlabel('样本序列');
ylabel('幅度A');
title(' SYM8消除噪音信号');
% end
figure(5);
% for i=1:5
% subplot(3,2,i);
plot(xd4(1:62,3));

xlabel('样本序列');
ylabel('幅度A');
title('HAAR消除噪音信号');
% end
