%‘∆µº∑ÁÕºªÊ÷∆
%ª≠µÿ«Ú
diqiu=zeros(2288,2288);
diqiu=bb;
for i=1:2288
    for j=1:2288
        if diqiu(i,j)==-1
            diqiu(i,j)=983;
        end
    end
end
diqiu=diqiu/983;
imshow(diqiu);
hold on
%ª≠∑Á ∏±Íº«
a=6378136.5;
c=6356751.8;
H=42164000;
a0=0.5*pi;
a1=0.5*pi;
for ii=1:81
    for jj=1:81
        if V(ii,jj)~=0
            weidu=41-ii;
            jingdu=45+jj;
            p=(90-weidu)*pi/180;
            q=(jingdu+3.5)*pi/180;
            if p<=a0&&q<=a1  %±±∞Î«Ú£¨◊Û±ﬂ
            z=sqrt(1/(1/c^2+tan(p)^2/a^2));
            m=z*tan(p);
            x=m*cos(q);
            y=m*cos(a0-q);
            n=z/x;
            mm=(y-H)/x;
            sitai=atan(n/(sqrt(1+mm^2)));
            sitaj=atan(1/(sqrt(mm^2+n^2)));
            i=1145-sitai/0.00014;
            j=1145-sitaj/0.00014;
            elseif p>a0&&q<=a1  %ƒœ∞Î«Ú◊Û±ﬂ
            z=sqrt(1/(1/c^2+tan(pi-p)^2/a^2));  
            m=z*tan(pi-p);
            x=m*cos(q);
            y=m*cos(a0-q);
            n=z/x;
            mm=(y-H)/x;
            sitai=atan(n/(sqrt(1+mm^2)));
            sitaj=atan(1/(sqrt(mm^2+n^2)));
            i=1145+sitai/0.00014;
            j=1145-sitaj/0.00014;
            elseif p<=a0&&q>a1  %±±∞Î«Ú£¨”“±ﬂ
            z=sqrt(1/(1/c^2+tan(p)^2/a^2));
            m=z*tan(p);
            x=m*cos(pi-q);
            y=m*sin(pi-q);
            n=z/x;
            mm=(y-H)/x;
            sitai=atan(n/(sqrt(1+mm^2)));
            sitaj=atan(1/(sqrt(mm^2+n^2)));
            i=1145-sitai/0.00014;
            j=1145+sitaj/0.00014; 
            elseif p>a0&&q>a1  %ƒœ∞Î«Ú£¨”“±ﬂ
            z=sqrt(1/(1/c^2+tan(pi-p)^2/a^2));
            m=z*tan(pi-p);
            x=m*cos(pi-q);
            y=m*sin(pi-q);
            n=z/x;
            mm=(y-H)/x;
            sitai=atan(n/(sqrt(1+mm^2)));
            sitaj=atan(1/(sqrt(mm^2+n^2)));
            i=1145+sitai/0.00014;
            j=1145+sitaj/0.00014; 
            end
            draw_f(j,2288-i,V(ii,jj),J(ii,jj),yq(ii,jj));%∑Á ∏±Íº«ªÊ÷∆∫Ø ˝
        end
    end
end

%ª≠∫£∞∂œﬂ
coastline=importdata('coastline0.txt');
m=size(coastline.data,1);
zuobiao=zeros(m,2);
k=0;
for n=1:m
    if coastline.data(n,1)<99999   
        k=k+1;
        p=(90-coastline.data(n,2))*pi/180;
        q=(coastline.data(n,1)+3.5)*pi/180;
        if p<=a0&&q<=a1  %±±∞Î«Ú£¨◊Û±ﬂ
            z=sqrt(1/(1/c^2+tan(p)^2/a^2));
            m=z*tan(p);
            x=m*cos(q);
            y=m*cos(a0-q);
            n=z/x;
            mm=(y-H)/x;
            sitai=atan(n/(sqrt(1+mm^2)));
            sitaj=atan(1/(sqrt(mm^2+n^2)));
            i=1145-sitai/0.00014;
            j=1145-sitaj/0.00014;
        elseif p>a0&&q<=a1  %ƒœ∞Î«Ú◊Û±ﬂ
            z=sqrt(1/(1/c^2+tan(pi-p)^2/a^2));  
            m=z*tan(pi-p);
            x=m*cos(q);
            y=m*cos(a0-q);
            n=z/x;
            mm=(y-H)/x;
            sitai=atan(n/(sqrt(1+mm^2)));
            sitaj=atan(1/(sqrt(mm^2+n^2)));
            i=1145+sitai/0.00014;
            j=1145-sitaj/0.00014;
        elseif p<=a0&&q>a1  %±±∞Î«Ú£¨”“±ﬂ
            z=sqrt(1/(1/c^2+tan(p)^2/a^2));
            m=z*tan(p);
            x=m*cos(pi-q);
            y=m*sin(pi-q);
            n=z/x;
            mm=(y-H)/x;
            sitai=atan(n/(sqrt(1+mm^2)));
            sitaj=atan(1/(sqrt(mm^2+n^2)));
            i=1145-sitai/0.00014;
            j=1145+sitaj/0.00014; 
        elseif p>a0&&q>a1  %ƒœ∞Î«Ú£¨”“±ﬂ
            z=sqrt(1/(1/c^2+tan(pi-p)^2/a^2));
            m=z*tan(pi-p);
            x=m*cos(pi-q);
            y=m*sin(pi-q);
            n=z/x;
            mm=(y-H)/x;
            sitai=atan(n/(sqrt(1+mm^2)));
            sitaj=atan(1/(sqrt(mm^2+n^2)));
            i=1145+sitai/0.00014;
            j=1145+sitaj/0.00014; 
        end
        zuobiao(k,1)=i;
        zuobiao(k,2)=j;
    end
end
plot(zuobiao(1:k,2),zuobiao(1:k,1),'b.')  
hold off
        
        
        
        
        
        
        
        
        
        
        
        
        