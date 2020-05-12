%云迹风求解
%以touyingaa、touyingbb、touyingcc为输入，建立风矢场度量模型，利用相关系数法求解
%增加的处理环节：云块识别，相关系数阈值检验，匹配面质量检测,连续性检测
f=zeros(1801,1801);
g=zeros(1801,1801);
h=zeros(1801,1801);

f=touyingbb;
g=touyingcc;
h=touyingaa;

ff=0;%2030该窗口内采样点的灰度平均值
wyi=zeros(109,109);%各窗口相关系数最大值对应行位移量
wyj=zeros(109,109);%各窗口相关系数最大值对应列位移量
wyi1=zeros(109,109);%各窗口相关系数 次最大值对应行位移量
wyj1=zeros(109,109);%各窗口相关系数 次最大值对应列位移量
weiyii=zeros(1801,1801);%各像素相关系数最大值对应列位移量
weiyij=zeros(1801,1801);%各像素相关系数最大值对应列列移量
xishumax=zeros(109,109);%相关系数最大值
xishumax1=zeros(109,109);%相关系数次最大值
for i=1:109 %共需计算110个窗口（示踪云）
    for j=1:109 %共需计算110个窗口（示踪云）
        m=25+16*(i-1);%各窗口起始行号
        n=25+16*(j-1);%各窗口起始列号   
        %云块识别
        temp1=0;
        for ii=m:(m+15)
            for jj=n:(n+15)
                if f(ii,jj)>512
                    temp1=temp1+1;
                end
            end
        end
        if temp1<64
            for ii=m:(m+15)
                for jj=n:(n+15)
                    weiyii(ii,jj)=0;
                    weiyij(ii,jj)=0;
                end
            end
        else
            for ii=m:(m+15)
                for jj=n:(n+15)
                    ff=ff+f(ii,jj);
                end
            end
            ff=ff/(16*16);
            fenmu1=0;
            for ii=m:(m+15)
                for jj=n:(n+15)
                    fenmu1=fenmu1+(f(ii,jj)-ff)^2;
                end
            end   
            xishu=zeros(25,25);
            p=zeros(25,25);
            q=zeros(25,25);
            for ii=1:25
                for jj=1:25
                    p(ii,jj)=26-2*ii;%位移改变量（行）
                    q(ii,jj)=2*jj-26;%位移改变量（列）
                    gg=0;%2100该窗口周围各目标窗口内采样点的灰度平均值
                    for iii=(m+p(ii,jj)):(m+p(ii,jj)+15)
                        for jjj=(n+q(ii,jj)):(n+q(ii,jj)+15)
                            gg=gg+g(iii,jjj);
                        end
                    end
                    gg=gg/(16*16);
                    fenzi=0;
                    for iii=m:(m+15)
                        for jjj=n:(n+15)
                            fenzi=fenzi+(f(iii,jjj)-ff)*(g(iii+p(ii,jj),jjj+q(ii,jj))-gg);
                        end
                    end
                    fenmu2=0;
                    for  iii=m:(m+15)
                        for jjj=n:(n+15)
                            fenmu2=fenmu2+(g(iii+p(ii,jj),jjj+q(ii,jj))-gg)^2;
                        end
                    end
                    xishu(ii,jj)=fenzi/sqrt(fenmu1*fenmu2);
                    if xishu(ii,jj)>xishumax(i,j)
                        xishumax(i,j)=xishu(ii,jj);
                        wyi(i,j)=p(ii,jj);
                        wyj(i,j)=q(ii,jj);
                    end
                end
            end
            for ii=1:25
                for jj=1:25
                    if (xishu(ii,jj)>xishumax1(i,j))&&(xishu(ii,jj)~=xishumax(i,j))
                        xishumax1(i,j)=xishu(ii,jj);
                        wyi1(i,j)=p(ii,jj);
                        wyj1(i,j)=q(ii,jj);
                    end
                end
            end
            
            
            if (abs(wyi(i,j)-wyi1(i,j))<3)&&(abs(wyj(i,j)-wyj1(i,j))<3)%匹配面质量检测
                if (xishumax(i,j)-xishumax1(i,j))<0.01
                    wyi(i,j)=0;
                    wyj(i,j)=0;
                end
            else%通过匹配面质量检测,进行连续性检测
                for ii=(m-wyi(i,j)):(m-wyi(i,j)+15)
                    for jj=(n-wyj(i,j)):(n-wyj(i,j)+15)
                        hh=0;
                        for iii=(m-wyi(i,j)):(m-wyi(i,j)+15)
                        	for jjj=(n-wyj(i,j)):(n-wyj(i,j)+15)
                                hh=hh+h(iii,jjj);
                            end
                        end
                        hh=hh/(16*16);
                        fenzi=0;
                        for iii=m:(m+15)
                            for jjj=n:(n+15)
                                fenzi=fenzi+(f(iii,jjj)-ff)*(h(iii-wyi(i,j),jjj-wyj(i,j))-hh);
                            end
                        end
                        fenmu2=0;
                        for  iii=m:(m+15)
                            for jjj=n:(n+15)
                                fenmu2=fenmu2+(h(iii-wyi(i,j),jjj-wyj(i,j))-hh)^2;
                            end
                        end
                        xishu1=fenzi/sqrt(fenmu1*fenmu2);
                    end
                end
                
                for ii=(m-wyi1(i,j)):(m-wyi1(i,j)+15)
                    for jj=(n-wyj1(i,j)):(n-wyj1(i,j)+15)
                        hh1=0;
                        for iii=(m-wyi1(i,j)):(m-wyi1(i,j)+15)
                        	for jjj=(n-wyj1(i,j)):(n-wyj1(i,j)+15)
                                hh1=hh1+h(iii,jjj);
                            end
                        end
                        hh1=hh1/(16*16);
                        fenzi1=0;
                        for iii=m:(m+15)
                            for jjj=n:(n+15)
                                fenzi1=fenzi1+(f(iii,jjj)-ff)*(h(iii-wyi1(i,j),jjj-wyj1(i,j))-hh1);
                            end
                        end
                        fenmu21=0;
                        for  iii=m:(m+15)
                            for jjj=n:(n+15)
                                fenmu21=fenmu21+(h(iii-wyi1(i,j),jjj-wyj1(i,j))-hh1)^2;
                            end
                        end
                        xishu2=fenzi1/sqrt(fenmu1*fenmu21);
                    end
                end
                
                if abs(xishu1-xishu2)<0.01
                    wyi(i,j)=0;
                    wyj(i,j)=0;
                else
                    if abs(xishu1-xishumax(i,j))>0.2
                        wyi(i,j)=0;
                        wyj(i,j)=0;
                    end
                end
            end
            if xishumax(i,j)>0.5%阈值检验
                for ii=m:(m+15)
                    for jj=n:(n+15)
                        weiyii(ii,jj)=wyi(i,j);
                        weiyij(ii,jj)=wyj(i,j);
                    end
                end
            end
        end
    end
end

%求非零风矢个数
geshu=0;
for i=1:109
    for j=1:109
        if xishumax(i,j)>0
            geshu=geshu+1;
        end
    end
end
%通过像素点位移改变量求风矢的速度和角度
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


        
        









        
        