% 将经纬度转换为球坐标
% 2012-9-22

function [i,j]=jingwei2xyz(jingdu,weidu)

for tt=1:max(size(jingdu))
    a=6378136.5; % 地球长半轴
    b=6356751.8; % 地球短半轴
    i0=1145; % 星下标在S-VISSR帧平面上的行数
    j0=1145; % 星下标在S-VISSR帧平面上的列数
    Rse=42164000; % 卫星到地心的距离
    P=140*10^(-6);% 步进角，微弧
    Q=140*10^(-6);% 采样角，微弧
    h=Rse;
    lo=86.5;
    
    y(tt)=sqrt(1/((1+(tan((jingdu(tt)-lo)*pi/180))^2)/a^2+(1+(tan((jingdu(tt)-lo)*pi/180))^2)*((tan(weidu(tt)*pi/180)))^2/b^2));
    
    
    x(tt)=y(tt)*tan((jingdu(tt)-lo)*pi/180);
    
    
    z(tt)=y(tt)*sqrt(1+(tan((jingdu(tt)-lo)*pi/180))^2)*tan((weidu(tt))*pi/180);
    
    alfa=atan(z(tt)/(y(tt)-h));
    beita=-atan(x(tt)/(y(tt)-h));
    
    i(tt)=i0+alfa/P;
    j(tt)=j0+beita/Q;
    
end




