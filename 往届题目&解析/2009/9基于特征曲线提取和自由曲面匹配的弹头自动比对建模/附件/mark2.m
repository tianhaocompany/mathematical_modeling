function out =mark2( fileT1 , fileT2 )
% 要先将当前目录切换到数据文件夹         
% fileT1,fileT2 为要比较的两个 .dat 文件的相对目录
    
    %载入Dat文件中的数据
cc1=load( fileT1 );
cc2=load( fileT2 );
%将数据点分配到三维矩阵中 
threeD1=zeros(564,756,3);
threeD2=zeros(564,756,3);
for i=1:756*564,
    if rem(i,564)==0 ,
       threeD1(564,i/564,1)=cc1(i,1);
       threeD1(564,i/564,2)=cc1(i,2);
       threeD1(564,i/564,3)=cc1(i,3);
       threeD2(564,i/564,1)=cc2(i,1);
       threeD2(564,i/564,2)=cc2(i,2);
       threeD2(564,i/564,3)=cc2(i,3);
    elseif rem(i,564)~=0 
           threeD1(rem(i,564),fix(i/564)+1,1)=cc1(i,1);
           threeD1(rem(i,564),fix(i/564)+1,2)=cc1(i,2);
           threeD1(rem(i,564),fix(i/564)+1,3)=cc1(i,3);
           threeD2(rem(i,564),fix(i/564)+1,1)=cc2(i,1);
           threeD2(rem(i,564),fix(i/564)+1,2)=cc2(i,2);
           threeD2(rem(i,564),fix(i/564)+1,3)=cc2(i,3);
    end
end

%矩阵截取有效部分
for i=10:300
    for j=50:700
        threD1(i-9,j-49,1)=threeD1(i,j,1);
        threD1(i-9,j-49,2)=threeD1(i,j,2);
        threD1(i-9,j-49,3)=threeD1(i,j,3);
        threD2(i-9,j-49,1)=threeD2(i,j,1);
        threD2(i-9,j-49,2)=threeD2(i,j,2);
        threD2(i-9,j-49,3)=threeD2(i,j,3);
    end
end
%截取后矩阵的行数
[m n o]=size(threD1);
p=1;
c00=zeros(m*n,4);
for i=1:n,
    for j=1:m,
        c00(p,1)=threD2(j,i,1);
        c00(p,2)=threD2(j,i,2);
        c00(p,3)=threD2(j,i,3);
        c00(p,4)=1;
        p=p+1;
    end
end
        
%求两曲面重心坐标
c1x=0;c1y=0;c1z=0;
c2x=0;c2y=0;c2z=0;
for i=1:m,  %756为划痕面上点行数 564为列数
    for j=1:n
        c1x=c1x+threD1(i,j,1);
        c1y=c1y+threD1(i,j,2);
        c1z=c1z+threD1(i,j,3);
        
        c2x=c2x+threD2(i,j,1);
        c2y=c2y+threD2(i,j,2);
        c2z=c2z+threD2(i,j,3);
    end
 end
c1x=c1x/m/n;
c1y=c1y/m/n;
c1z=c1z/m/n;
c2x=c2x/m/n;
c2y=c2y/m/n;
c2z=c2z/m/n;   
%中心坐标的偏移
Tx=c2x-c1x;
Ty=c2y-c1y;
Tz=c2z-c1z;
dc=0;%与Z轴夹角的旋转量
zb1=1000;
zb2=1000;
zb3=0;
for dty=-0.03:0.06/10:0.03,
for da=-0.2/180*pi:0.4/10/180*pi:0.2/180*pi,      %与X轴夹角的旋转量
    db=da;    
    TT=[cos(db)           sin(da)*sin(db)-cos(da)                   cos(da)*sin(db)                           Tx
       0                  cos(da)*cos(db)                           sin(da)                                   Ty+dty
        -1*sin(db)        sin(da)*cos(db)                           cos(da)*cos(db)                           Tz
        0                  0                                        0                                         1];%将c2向c1变动的坐标转换矩阵
     c21=(TT*(c00)')';%将c2向c1变动，变动完成后，与原来c2对应的新的曲面坐标矩阵，其第四列全为1
         
     %把c21转成对应的三维矩阵
     threD21=zeros(m,n,3);
     for i=1:m*n,
         if rem(i,m)==0 ,
            threD21(m,i/m,1)=c21(i,1);
            threD21(m,i/m,2)=c21(i,2);
            threD21(m,i/m,3)=c21(i,3);
         elseif rem(i,m)~=0 
            threD21(rem(i,m),fix(i/m)+1,1)=c21(i,1);
            threD21(rem(i,m),fix(i/m)+1,2)=c21(i,2);
            threD21(rem(i,m),fix(i/m)+1,3)=c21(i,3);
         end
     end
                     
%         m=min(m1,m2);
 zhibiao1=0;zhibiao2=0; zhibiao3=0;       
%只对比两矩阵中间部分设定两边去掉的行和列kx,ky
      kx=100 ; ky=200;
      %算样本曲面的平均高度
      stand=3.95;j1=1;j2=1;
      for i=1+kx:23:m-kx
          for j=1+ky:23:n-ky
              j2=j2+1;
          end
          j1=j1+1;
      end
     
      for i=1+kx:23:m-kx,
         for j=1+ky:23:n-ky
             zhibiao1=zhibiao1+((threD1(i,j,1)-threD21(i,j,1))^2+(threD1(i,j,2)-threD21(i,j,2))^2+(threD1(i,j,3)-threD21(i,j,3))^2);%对应点距离平方和，近似认为是比对曲面所有点到样本曲面最短距离的平方和
             zhibiao2=zhibiao2+abs(threD1(i,j,3)-threD21(i,j,3));
             %zhibiao3=abs(threD1(i,j,3)-threD21(i,j,3));
             %if zhibiao3>zb3
               % zb3=zhibiao3;
             %end    
          %zb3=zhibiao3;
          %err=[zb1,zb2,zb3];
         end
      end
             %if zhibiao3>zb3
              %  zb3=zhibiao3;
             %end    
       if zhibiao1<zb1,
          zb1=zhibiao1; 
          zb2=zhibiao2;
          %zb3=zhibiao3;
          %err=[zb1,zb2,zb3];
          match=1-zb2/stand;
       end
    end
end

out=match%输出两个弹痕的吻合度           
                      