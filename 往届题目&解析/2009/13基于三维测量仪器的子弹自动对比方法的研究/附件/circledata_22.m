%       进行坐标转换，将相对于观测仪器的坐标系转换为基于子弹表面的坐标，求得相应
%       新坐标系下的矩阵。为了对于后面数据的处理，并且减轻计算量，该段代码只计算了
%       原始矩阵中第201到第600共400行、纵坐标从第1到第500共500列的矩阵对应值。
%       其中原始矩阵中的行和列的选取可以根据情况修改。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       
%%%     c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c11c1c1c1c1c1c1c
%%%     c1c11c1c1c1c1c1c1c1c1c11c1c1c1c1c1c1c1c1c11c1c1c1c1c1c1c1c1c1
load t22.mat        %载入第22个子弹的数据 下面计算截取的第一个次棱的矩阵转换坐标后的矩阵
syms x z
x1=0;x2=0;z1=0;z2=0;
step=2;
dist=2;
begin=1;
ending=446;
col=dist/step+1;

for row=201:600         %   截取相应的行 对每一行进行坐标变换
    row
    for i=0:step:dist   %   求取个轴心点求取平均值
        x1=(begin+i)*2.75/1000.00;
        x2=(ending+i)*2.75/1000.00;
        z1=t22_c1(row,begin+i);
        z2=t22_c1(row,ending+i);
        eq1=(x-x1)^2+(z-z1)^2-3.9500^2; %   第一个点和被求椭圆轴心组成的方程
        eq2=(x-x2)^2+(z-z2)^2-3.9500^2; %   第二个点和被求椭圆轴心组成的方程
        R=solve(eq1,eq2,'x,z');         %   求解该方程组 求取该row行对应的两个轴心点
        if eval(R.z(1,1))>0             %   舍弃不符合的轴心点
            xdata(1,i/step+1)=eval(R.x(2,1));
            zdata(1,i/step+1)=eval(R.z(2,1));
        else
            xdata(1,i/step+1)=eval(R.x(1,1));   
            zdata(1,i/step+1)=eval(R.z(1,1));
        end
    end
    xm=mean(xdata); %   求多个轴心在x轴上的坐标轴的平均值
    zm=mean(zdata); %   求多个轴心在y轴上的坐标轴的平均值
    for i=1:500 %  截取相应列的数据，并且对该行的每一个列的点进行坐标转换。
        ct22_c1((row-200),i)=sqrt((xm-(i-1)*2.75/1000)^2+(t22_c1(row,i)-zm)^2)-3.95;
    end
end
save('ct22_c1.mat','ct22_c1');%     将该子弹第一个次棱转换后的矩阵进行保存
clear all                           


%%% c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c
%%% 2c2c2c2c2c2c2c2c2c2c2
load t22.mat     %载入第22个子弹的数据 下面计算截取的第一个次棱的矩阵转换坐标后的矩阵下面的代码同上省略。
syms x z
x1=0;x2=0;z1=0;z2=0;p=-pi:0.01:pi;
step=2;
dist=2;
begin=1;
ending=450;
col=dist/step+1;
for row=201:600
    row
    for i=0:step:dist
        x1=(begin+i)*2.75/1000.00;
        x2=(ending+i)*2.75/1000.00;
        z1=t22_c2(row,begin+i);%%%%%%%
        z2=t22_c2(row,ending+i);%%%%%%
        eq1=(x-x1)^2+(z-z1)^2-3.9500^2;
        eq2=(x-x2)^2+(z-z2)^2-3.9500^2;
        R=solve(eq1,eq2,'x,z');
        if eval(R.z(1,1))>0
            xdata(1,i/step+1)=eval(R.x(2,1));
            zdata(1,i/step+1)=eval(R.z(2,1));
        else
            xdata(1,i/step+1)=eval(R.x(1,1));   
            zdata(1,i/step+1)=eval(R.z(1,1));
        end
    end
    xm=mean(xdata);    
    zm=mean(zdata)
    for i=1:500
        ct22_c2(row-200,i)=sqrt((xm-(i-1)*2.75/1000)^2+(t22_c2(row,i)-zm)^2)-3.95;%%%%%%
    end
end
save('ct22_c2.mat','ct22_c2');%%%%%%%%%%%%%%%%%
clear all
%%%  c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3
%%%  c3
load t22.mat
syms x z
x1=0;x2=0;z1=0;z2=0;p=-pi:0.01:pi;
step=2;
dist=2;
begin=1;
ending=450;
col=dist/step+1;
for row=201:600
    row
    for i=0:step:dist
        x1=(begin+i)*2.75/1000.00;
        x2=(ending+i)*2.75/1000.00;
        z1=t22_c3(row,begin+i);%%%%%%%
        z2=t22_c3(row,ending+i);%%%%%%
        eq1=(x-x1)^2+(z-z1)^2-3.9500^2;
        eq2=(x-x2)^2+(z-z2)^2-3.9500^2;
        R=solve(eq1,eq2,'x,z');
        if eval(R.z(1,1))>0
            xdata(1,i/step+1)=eval(R.x(2,1));
            zdata(1,i/step+1)=eval(R.z(2,1));
        else
            xdata(1,i/step+1)=eval(R.x(1,1));   
            zdata(1,i/step+1)=eval(R.z(1,1));
        end
    end
    xm=mean(xdata);    

    zm=mean(zdata)
    for i=1:500
        ct22_c3(row-200,i)=sqrt((xm-(i-1)*2.75/1000)^2+(t22_c3(row,i)-zm)^2)-3.95;%%%%%%
    end
end

save('ct22_c3.mat','ct22_c3');%%%%%%%%%%%%%%%%%
clear all
load t22.mat
syms x z
x1=0;x2=0;z1=0;z2=0;p=-pi:0.01:pi;
step=2;
dist=2;
begin=1;
ending=450;
col=dist/step+1;
for row=201:600
    row
    for i=0:step:dist
        x1=(begin+i)*2.75/1000.00;
        x2=(ending+i)*2.75/1000.00;
        z1=t22_c4(row,begin+i);%%%%%%%
        z2=t22_c4(row,ending+i);%%%%%%
        eq1=(x-x1)^2+(z-z1)^2-3.9500^2;
        eq2=(x-x2)^2+(z-z2)^2-3.9500^2;
        R=solve(eq1,eq2,'x,z');
        if eval(R.z(1,1))>0
            xdata(1,i/step+1)=eval(R.x(2,1));
            zdata(1,i/step+1)=eval(R.z(2,1));
        else
            xdata(1,i/step+1)=eval(R.x(1,1));   
            zdata(1,i/step+1)=eval(R.z(1,1));
        end
    end
    xm=mean(xdata);    
    zm=mean(zdata)
    for i=1:500
        ct22_c4(row-200,i)=sqrt((xm-(i-1)*2.75/1000)^2+(t22_c4(row,i)-zm)^2)-3.95;%%%%%%
    end
end
save('ct22_c4.mat','ct22_c4');%%%%%%%%%%%%%%%%
clear all
