clc;
clear all;


% P是样本数据, T是表示样本类别的下表矩阵
fid1=fopen('pre_pro.txt','r');
data1=fscanf(fid1,'%g',[62,1909]);
data=data1';

for i=1:1909
xd1(1:62,i)=wden(data1(1:62,i),'heursure','s','one',3,'db3');
xd2(1:62,i)=wden(data1(1:62,i),'minimaxi','s','one',3,'db5');
xd3(1:62,i)=wden(data1(1:62,i),'minimaxi','s','one',3,'sym8');
xd4(1:62,i)=wden(data1(1:62,i),'minimaxi','s','one',3,'haar');
end
xd2_1=xd4';
biaohao=[235 1605 891 648 955 1782];%haar去躁后
%biaohao=[830 1789 365 622];%db3去躁后
%biaohao=[1331 348 690 893 1782];%db5去躁后
%biaohao=[1312 1810 1404 892 1108];%sym8去躁后
for i=1:40
    k(i)=i
end
for m=1:40
    if k(m)==1
        for i=1:length(biaohao)
            for j=1:1909
               if (j==biaohao(i))  
                  P1=data(j,2:14);
                  P2=data(j,23:48);
            
                  P(i,1:39)=[P1 P2];
                  
                break;
               end
            end
        end
    elseif (k(m)>1)&(k(m)<14)
for i=1:length(biaohao)
    for j=1:1909
        if (j==biaohao(i))  
            P1=data(j,1:(k(m)-1));
            P2=data(j,(k(m)+1):14);
            P3=data(j,23:48);
            P(i,1:39)=[P1 P2 P3];
            break;
        end
    end
end
    elseif k(m)==14
        for i=1:length(biaohao)
            for j=1:1909
               if (j==biaohao(i))  
                  P2=data(j,1:13);
                  P3=data(j,23:48);
            
                  P(i,1:39)=[P2 P3];
                break;
               end
            end
        end
    elseif k(m)==15
        for i=1:length(biaohao)
            for j=1:1909
               if (j==biaohao(i)) 
                  P1=data(j,1:14);
                  P2=data(j,24:48);
                 % P2=data(j,(k(m)+1):14);
            
                  P(i,1:39)=[P1 P2];
                break;
               end
            end
        end
    elseif (k(m)>15)&(k(m)<40)
        for i=1:length(biaohao)
            for j=1:1909
               if (j==biaohao(i)) 
                  P1=data(j,1:14);
                  P2=data(j,23:(k(m)+8-1));
                  P3=data(j,(k(m)+8+1):48);
            
                  P(i,1:39)=[P1 P2 P3];
                break;
               end
            end
        end
    elseif k(m)==40
        for i=1:length(biaohao)
            for j=1:1909
               if (j==biaohao(i)) 
                  P1=data(j,1:14);
                  P2=data(j,23:47);
                 
                  P(i,1:39)=[P1 P2];
                break;
               end
            end
        end
        

    end


 %T1=[1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2];
 if (k(m)>=1)&(k(m)<=14)
 T1=[ 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 ];
 end
 if (k(m)>=15)&(k(m)<=40)
 T1=[ 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 ];
 end
% 将下标矩阵变为单值矢量组作为网络的目标输出
T=ind2vec(T1);

%  设计概率神经网络
sp=0.1; %扩展常数 
net=newpnn(P,T,sp);

%  对网络进行仿真，并绘出分类结果
Y=sim(net,P);
Y1=vec2ind(Y);

%  对一组新的数据进行分类
if (k(m)>=1)&(k(m)<=14)
for i=1:length(biaohao)
    for j=1:1909
        if (j==biaohao(i))  
            P3=data(j,k(m));
            
            PP(i,1)=[P3];
            break;
        end
    end
end
elseif (k(m)>=15)&(k(m)<=40)
    for i=1:length(biaohao)
    for j=1:1909
        if (j==biaohao(i))  
            P3=data(j,k(m)+8);
            
            PP(i,1)=[P3];
            break;
        end
    end
    end
end
    

 Y=sim(net,PP);
 Y1(i)=vec2ind(Y);
end
correct=0;
for i=1:39
    if (i<=14)&(Y1(i)==1)
        correct=correct+1;
    elseif (i>=15)&(Y1(i)==2)
        correct=correct+1;
    end
end
correct_ratio=(correct+1)/40;
fprintf('正确个数：%g\n\n',correct+1);
fprintf('正确率： %g\n\n',correct_ratio);