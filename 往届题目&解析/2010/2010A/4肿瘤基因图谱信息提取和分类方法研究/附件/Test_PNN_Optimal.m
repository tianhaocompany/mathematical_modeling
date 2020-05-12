clc;
clear all;


% P是样本数据, T是表示样本类别的下表矩阵
fid1=fopen('pre_pro.txt','r');
data1=fscanf(fid1,'%g',[62,1909]);
data=data1';

biaohao=[1696 643 1560 457 1855 1094 1798 67 691];%冗余+主成分0.5最优组合



for i=1:length(biaohao)
    for j=1:1909
        if (j==biaohao(i))  
            P1=data(j,1:14);
            P2=data(j,23:48);
            P(i,1:40)=[P1 P2];
            break;
        end
    end
end

 %T1=[1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2];
 T1=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 ];
% 将下标矩阵变为单值矢量组作为网络的目标输出
T=ind2vec(T1);


%  设计概率神经网络
sp=0.1; %扩展常数 
net=newpnn(P,T,sp);

%  对网络进行仿真，并绘出分类结果
Y=sim(net,P);
Y1=vec2ind(Y);
%[net,tr] = train(net,P,T);
%  对一组新的数据进行分类
for i=1:length(biaohao)
    for j=1:1909
        if (j==biaohao(i))  
            P3=data(j,15:22);
            P4=data(j,49:62);
            PP(i,1:22)=[P3 P4];
            break;
        end
    end
end

 Y=sim(net,PP);
 Y1=vec2ind(Y);
 correct=0;
 for i=1:22
     if (Y1(i)==1)&(i<=8)
         correct=correct+1;
     elseif (Y1(i)==2)&(i>8)
         correct=correct+1;
     end
 end
 correct_ratio=correct/22;
fprintf('正确个数：%g\n\n',correct);
fprintf('正确率： %g\n\n',correct_ratio);
