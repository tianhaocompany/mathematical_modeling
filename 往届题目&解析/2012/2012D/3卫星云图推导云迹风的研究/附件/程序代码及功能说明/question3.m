
%基于yunjifeng.m程序，以touying，touyingbb,touyingcc作为三个投影矩阵，通过对每个像素点计算梯度，将梯度进行分段确定自适应窗口大小
 %windowpix为正方形窗口的一条边包含对像素值
 weiyii=zeros(1018,1018);
 weiyij=zeros(1018,1018);
for i=32:1049
    for j=32:1049
       
 a=touying(i:i+2,j:j+2);
 dx= a(3,1)  + a(3,2) * 2 + a(3,3)+a(1,1)* (-1) + a(1,2) * (-2) + a(1,3) * (-1); 
 dy=a(1,3) + a(2,3) *2 + a(3,3) +a(1,1) * (-1) + a(2,1) * (-2) + a(3,1) * (-1); 
 tidu=sqrt(dx^2+dy^2);

if tidu<=100   %
  windowpix=32;
elseif tidu<=200&&tidu>100
  windowpix=16;   
else
  windowpix=8;
end
tiduwindow=zeros(windowpix,windowpix);
tiduwindow(1,1)=tidu;
%先确定该像素的窗口，计算窗口梯度
for ii=i-windowpix/2:i+windowpix/2-1
    for jj=j-windowpix/2:j+windowpix/2-1
                     a=touying(ii:ii+2,jj:jj+2);
                     dx= a(3,1) + a(3,2) * 2 + a(3,3)+a(1,1)* (-1) + a(1,2) * (-2) + a(1,3) * (-1); 
                     dy=a(1,3) + a(2,3) *2 + a(3,3) +a(1,1) * (-1) + a(2,1) * (-2) + a(3,1) * (-1); 
                     tiduwindow(ii-i+windowpix/2+1,jj-j+windowpix/2+1)=sqrt(dx^2+dy^2);
    end
end
tidumean=mean(mean(tiduwindow));
r=zeros(64-windowpix,64-windowpix);
 %确定搜索范围
 for m=i-31:i+windowpix %m窗口起始编号,每个像素平移窗口
       for n=j-31:j+windowpix% n窗口起始编号
            temp1=0;
           for ii=m:m+windowpix-1 %窗口内像素统计
           for jj=n:n+windowpix-1
               if touying(ii,jj)>512
               temp1=temp1+1;%是云
               end
           end
           end
           if temp1<0.25*windowpix*windowpix
                for ii=m:m+windowpix-1
                for jj=n:n+windowpix-1
                    weiyii(ii,jj)=0;
                    weiyij(ii,jj)=0;
                end
                end
           else %算每个像素的梯度和窗口的梯度均值
              fenzi=0;
              fenmu1=0;
              fenmu2=0;
              for ii=m:(m+windowpix-1)  %算
                for jj=n:(n+windowpix-1)
                    %每个窗口
                    %for kk=1:windowpix
                      a=touyingbb(ii:ii+2,jj:jj+2);
                      dx= a(3,1)  + a(3,2) * 2 + a(3,3)+a(1,1)* (-1) + a(1,2) * (-2) + a(1,3) * (-1); 
                      dy=a(1,3) + a(2,3) *2 + a(3,3) +a(1,1) * (-1) + a(2,1) * (-2) + a(3,1) * (-1); 
                      tiduwindowbb(ii-m+1,jj-n+1)=sqrt(dx^2+dy^2);
                end
              end
                
                tidumeanbb=mean(mean(tiduwindowbb));
                for iii=1:windowpix%i-windowpix/2:i+windowpix/2-1
                  for jjj=1:windowpix%j-windowpix/2:j+windowpix/2-1 %每个窗口计算相关系数
                    fenzi=fenzi+(tiduwindow(iii,jjj)- tidumean )*(tiduwindowbb(iii,jjj)- tidumeanbb);%???梯度
                    fenmu1= fenmu1+(tiduwindow(iii,jjj)- tidumean )^2;
                    fenmu2= fenmu2+(tiduwindowbb(iii,jjj)- tidumeanbb)^2;
                  end   
               end
              r(m-i+32,n-j+32)=fenzi/sqrt( fenmu1*fenmu2);
           end 
       end
   end
             [M,I]=max(r);
             [N,J]=max(M);
             maxi=I(J)+m;
             maxj=J+n; %最大值的行列号
  
         
 
   if max(max(r))<0.5
    weiyii(i,j)=0;
     weiyij(i,j)=0
    else   
   weiyii(i,j)= i-maxi;
   weiyij(i,j)=j-maxj;
    end
 end
end
a=6378136.5;
b=6356751.8;

V=zeros(81,81);%速度
J=zeros(81,81);%角度
for i=40:-1:-40%纬度
    for j=46:126%经度
        ih=i*pi/180;
        jh=j*pi/180;
        wi=20*(45+i)+1;%经纬度所在行号
        wj=20*(j-40)+1;%经纬度所在列号
        if (weiyii(wi,wj)~=0)||(weiyij(wi,wj)~=0)
            wi1=wi+weiyii(wi,wj);%位移后经纬度所在行号
            wj1=wj+weiyij(wi,wj);%位移后经纬度所在列号
            i1=((wi1-1)*0.05-45)*pi/180;%位移后纬度
            j1=(40+(wj1-1)*0.05)*pi/180;%位移后经度
            yuanxinjiao=acos(cos(pi/2-ih)*cos(pi/2-i1)+sin(pi/2-ih)*sin(pi/2-i1)*cos(abs(j1-jh)));%圆心角
            xx=sqrt(a^2*b^2/(b^2+a^2*tan(abs(ih))^2));
            r=xx/cos(abs(ih));%半径
            huchang=yuanxinjiao*r;%弧长
            v=huchang/1800;%速度，单位米/秒
            if j1<jh
                jiao=2*pi-acos((cos(pi/2-i1)-cos(yuanxinjiao)*cos(pi/2-ih))/sin(yuanxinjiao)*sin(pi/2-ih));
            else
                jiao=acos((cos(pi/2-i1)-cos(yuanxinjiao)*cos(pi/2-ih))/sin(yuanxinjiao)*sin(pi/2-ih));
            end
            V(41-i,j-45)=v;
            J(41-i,j-45)=jiao;
        else
            V(41-i,j-45)=0;
            J(41-i,j-45)=0;
        end
    end
end    
       
             
          
             
              
              
            
              
    
             
             
     
     
 
