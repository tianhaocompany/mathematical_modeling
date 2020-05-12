clc;
clear all;


% P是样本数据, T是表示样本类别的下表矩阵
fid1=fopen('pre_pro.txt','r');
data1=fscanf(fid1,'%g',[62,1909]);
data=data1';
%%%%%%%%%%%%%%%%%%%%%%%小波去躁后的数据
for i=1:1909
xd1(1:62,i)=wden(data1(1:62,i),'heursure','s','one',3,'db3');
xd2(1:62,i)=wden(data1(1:62,i),'minimaxi','s','one',3,'db5');
xd3(1:62,i)=wden(data1(1:62,i),'minimaxi','s','one',3,'sym8');
xd4(1:62,i)=wden(data1(1:62,i),'minimaxi','s','one',3,'haar');
end
xd2_1=xd1';

%biaohao=[1312 1810 1404 892 1108];%sym8去躁后
%biaohao=[1331 348 690 893 1782];%db5去躁后
biaohao=[830 1789 365 622];%db3去躁后
%biaohao=[235 1605 891 648 955 1782];%haar去躁后

L=length(biaohao);
for i=1:(2^L-1)
    for j=1:L
        two_bit(i,L+1-j)=bitget(i,j);
    end
end

for kk=1:2^L-1
    biaohao_hou=[];
    for j=1:L
        if two_bit(kk,j)==1
            biaohao_hou=[biaohao_hou biaohao(j)];
        
        end
    end
            
            
        
    
for i=1:length(biaohao_hou)
    for j=1:1909
        if (j==biaohao(i))  
            P1=xd2_1(j,1:14);
            P2=xd2_1(j,23:48);
            P(i,1:40)=[P1 P2];
            break;
        end
    end
end


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
for i=1:length(biaohao_hou)
    for j=1:1909
        if (j==biaohao(i))  
            P3=xd2_1(j,15:22);
            P4=xd2_1(j,49:62);
            PP(i,1:22)=[P3 P4];
            break;
        end
    end
end

 Y=sim(net,PP);
 Y1=vec2ind(Y);
 correct(kk)=0;
 for i=1:22
     if (Y1(i)==1)&(i<=8)
         correct(kk)=correct(kk)+1;
     elseif (Y1(i)==2)&(i>8)
         correct(kk)=correct(kk)+1;
     end
 end
end
correct=correct';
correct_ratio=correct/22;
fprintf('正确个数：%g\n\n',correct);
fprintf('正确率： %g\n\n',correct_ratio);
         
