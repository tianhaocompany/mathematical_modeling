clc;
clear all;


% P是样本数据, T是表示样本类别的下表矩阵
fid1=fopen('pre_pro.txt','r');
data1=fscanf(fid1,'%g',[62,1909]);
data=data1';

biaohao=[1696 643 1560 457 1855 1094 1798 67 691];%冗余+主成分0.5最优组合


%biaohao=[540];%加权APC
%biaohao=[114 259 533 635 859 994 1354 1360 1700 1896];%加权RAS


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
 %%%%%%%%%%%%%%%%%%%%%%
%  a1=0.35565;
%  a2=0.414226;
%  a3=0.230126;
 for i=1:22
     if (Y1(i)==1)
         X1(i)=0;
     elseif (Y1(i)==2)
         X1(i)=1;
     end
 end
 
biaohao=[540];%加权APC
%biaohao=[114 259 533 635 859 994 1354 1360 1700 1896];%加权RAS


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
 Y2=vec2ind(Y);
  correct=0;
 for i=1:22
     if (Y2(i)==1)&(i<=8)
         correct=correct+1;
     elseif (Y2(i)==2)&(i>8)
         correct=correct+1;
     end
 end
 %%%%%%%%%%%%%%%%%%%%%%
%  a1=0.35565;
%  a2=0.414226;
%  a3=0.230126;
 for i=1:22
     if (Y2(i)==1)
         X2(i)=0;
     elseif (Y2(i)==2)
         X2(i)=1;
     end
 end
 
 %biaohao=[540];%加权APC
%biaohao=[114 259 533 635 859 994 1354 1360 1700 1896];%加权RAS
biaohao=[114 259 533 635 859 994 1354 1896];%加权RAS较优，正确19个

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
 Y3=vec2ind(Y);
  correct=0;
 for i=1:22
     if (Y3(i)==1)&(i<=8)
         correct=correct+1;
     elseif (Y3(i)==2)&(i>8)
         correct=correct+1;
     end
 end
 %%%%%%%%%%%%%%%%%%%%%%
 a1=0.35565;
 a2=0.414226;
 a3=0.230126;
%  a1=0.4843;
%  a2=0.35897;
%  a3=0.15673;

 for i=1:22
     if (Y3(i)==1)
         X3(i)=0;
     elseif (Y3(i)==2)
         X3(i)=1;
     end
 end
%  X2=[0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ];
%  X3=[0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ];
 Score=a1*X1+a2*X2+a3*X3;
 for i=1:22
     if (Score(i)<=a1)
         Result(i)=0;
     elseif (Score(i)>=(a2+a3))
         Result(i)=1;
     end
 end
 
 correct=0;
 for i=1:22
     if (Result(i)==0)&(i<=8)
         correct=correct+1;
     elseif (Result(i)==1)&(i>8)
         correct=correct+1;
     end
 end
correct_ratio=correct/22;
fprintf('正确个数：%g\n\n',correct);
fprintf('正确率： %g\n\n',correct_ratio);
