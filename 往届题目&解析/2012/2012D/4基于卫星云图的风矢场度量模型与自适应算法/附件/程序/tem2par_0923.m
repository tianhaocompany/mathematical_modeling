% 温度到压强
% 计算 9点所有点的压强

function par=tem2par(BB)
global K_temp% 压强
P_36=[0.1, 0.2,  0.5,  1,  1.5,  2,  3,   4,  5,   7, 10,  20, 30,  50,  70,...
    100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700, 750, ...
    800, 850, 900, 925, 950, 975, 1000]; % 

for i=1:18
temp(i)=P_36(37-i);
temp(37-i)=P_36(i);
end
P_36=temp;
P_36=P_36';

temp=load('temp3.mat');
%BB=loab('BB.mat');
Temp3=temp.t;
[x1 y1]=jingwei2xy(46,40);% 计算范围确定
[x2 y2]=jingwei2xy(126,-40);
x1=floor(x1);
y1=floor(y1);
x2=floor(x2);
y2=floor(y2);
% temp3文件起始点的经纬度
x0=0; y0=86.5; %% 确认！！！
X_weidu=[x0:-0.28125:-90 90:-0.28125:x0+0.28125];%
Y_jindu=[y0:-0.28125:0 0-0.28125:-0.28125:-180 180-0.28125:-0.28125:y0];
for i=x1:x2
    for j=y1:y2
        [j1,w1]=xy2jingwei(i,j);% 先由 BB 坐标导成 经纬度
        num=BB(i,j);
        if num~=-1
            K=K_temp(num);% 由BB 数组中的灰度值导成温度
            [v s]=min(abs(X_weidu-w1));
            xx=s;
            [v s]=min(abs(Y_jindu-j1));
            yy=s;
            % 由温度求出所在层
            
            all_tem=Temp3(xx,yy,:);
            % 由所在层导出压强
            [v K_c1]=min(abs(all_tem-K));
            if  Temp3(xx,yy,K_c1)>K
                K_c2=K_c1+1;
                if K_c2>=1 & K_c2<=36
                    k1=Temp3(xx,yy,K_c1);
                    k2=Temp3(xx,yy,K_c2); % k1>k2
                    par(i,j)=P_36(K_c1)*((K-k2)/(k1-k2))+P_36(K_c2)*((k1-K)/(k1-k2)); % 插值
                else
                    par(i,j)=P_36(K_c1);
                end
            else
                K_c2=K_c1-1;
                if K_c2>=1 & K_c2<=36
                    k1=Temp3(xx,yy,K_c1);
                    k2=Temp3(xx,yy,K_c2); % k2>k1
                    par(i,j)=P_36(K_c1)*((K-k2)/(k1-k2))+P_36(K_c2)*((k1-K)/(k1-k2)); % 插值
                else
                    par(i,j)=P_36(K_c1);
                end
                
            end
        else
            par(i,j)=-1;
        end
    end
end

