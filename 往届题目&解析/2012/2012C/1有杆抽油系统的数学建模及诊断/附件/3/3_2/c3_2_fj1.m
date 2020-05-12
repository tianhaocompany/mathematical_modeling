clc
clear

%输入参数
Line=13;   %网格化的行数
Cross=Line*2;  %网格化的列数（由于长是宽的两倍，因此列数为行数的2倍）
dis=1/Line;  %单个网格的长宽
m=zeros(Line,Cross);  %对每个网格单元的灰度进行初始化

%读入示功数据，数据必须从上冲程开始，按工作顺序排列
[s,f]=textread('result1.txt','%f %f');

%确定数据的个数
[r,c]=size(s);
NUM=r*c;

%用五点平均法求每一点的坐标平均值
for i=3:(NUM-2)
    sp(i)=(s(i-2)+s(i-1)+s(i)+s(i+1)+s(i+2))/5;
    fp(i)=(f(i-2)+f(i-1)+f(i)+f(i+1)+f(i+2))/5;
end
sp(1)=(s(NUM-1)+s(NUM)+s(1)+s(2)+s(3))/5;
sp(2)=(s(NUM)+s(1)+s(2)+s(3)+s(4))/5;
sp(NUM-1)=(s(NUM-3)+s(NUM-2)+s(NUM-1)+s(NUM)+s(1))/5;
sp(NUM)=(s(NUM-2)+s(NUM-1)+s(NUM)+s(1)+s(2))/5;
fp(1)=(f(NUM-1)+f(NUM)+f(1)+f(2)+f(3))/5;
fp(2)=(f(NUM)+f(1)+f(2)+f(3)+f(4))/5;
fp(NUM-1)=(f(NUM-3)+f(NUM-2)+f(NUM-1)+f(NUM)+f(1))/5;
fp(NUM)=(f(NUM-2)+f(NUM-1)+f(NUM)+f(1)+f(2))/5;

%求坐标的最大与最小值
sp_max=max(sp);
sp_min=min(sp);
fp_max=max(fp);
fp_min=min(fp);

%离散点归一化
for i=1:NUM
    spg(i)=(sp(i)-sp_min)/(sp_max-sp_min)*2;    %s从0到2
    fpg(i)=(fp(i)-fp_min)/(fp_max-fp_min);      %f从0到1
end

%将上下冲程分开
for i=2:NUM
    if (spg(i)-spg(i-1))<0
        j=i;
        break;
    end
end
n_s=j-1;        %上冲程的数据个数
n_x=NUM-j+1;    %下冲程的数据个数

%上冲程数据   （s由0到2）
for i=1:j-1;
    s_s(i)=spg(i);
    f_s(i)=fpg(i);
end

%下冲程数据 （s由2到0）
for i=j:NUM;
    s_x(i-j+2)=spg(i);
    f_x(i-j+2)=fpg(i);
end
s_x(1)=s_s(n_s);  %为了保证下边界是由2到0
f_x(1)=f_s(n_s);
s_x(n_x+2)=s_s(1);
f_x(n_x+2)=f_s(1);
n_x=n_x+2;


%确定边界所在的单元    （以列来寻找）
bo_1=zeros(1,Cross);   %用于记录上冲程对应的每列的最大网格单元序号
bo_2=zeros(1,Cross);   %用于记录上冲程对应的每列的最小网格单元序号
bo_3=zeros(1,Cross);   %用于记录下冲程对应的每列的最大网格单元序号
bo_4=zeros(1,Cross);   %用于记录下冲程对应的每列的最小网格单元序号


%上冲程边界
for i=1:Cross
    aa1=(i-1)*dis;
    aa2=i*dis;
    
    for j=2:n_s
        if aa1<=s_s(j)
            k=j;
            break;
        end
    end
    bb1=(aa1-s_s(k-1))/(s_s(k)-s_s(k-1))*(f_s(k)-f_s(k-1))+f_s(k-1);
    bb1=fix(bb1/dis)+1;
    
        for j=2:n_s
        if aa2<=s_s(j)
            k=j;
            break;
        end
    end
    bb2=(aa2-s_s(k-1))/(s_s(k)-s_s(k-1))*(f_s(k)-f_s(k-1))+f_s(k-1);
    bb2=fix(bb2/dis)+1;
    
    bb_max=max(bb1,bb2);
    bb_min=min(bb1,bb2);
    
    for v=bb_min:bb_max
        m(v,i)=1;
    end
    
    bo_1(i)=bb_max;
    bo_2(i)=bb_min;
end

%下冲程边界
for i=1:Cross
    aa1=(i-1)*dis;
    aa2=i*dis;
    
    for j=2:n_x
        if aa1>=s_x(j)
            k=j;
            break;
        end
    end
    bb1=(aa1-s_x(k-1))/(s_x(k)-s_x(k-1))*(f_x(k)-f_x(k-1))+f_x(k-1);
    bb1=fix(bb1/dis)+1;
    
        for j=2:n_x
        if aa2>=s_x(j)
            k=j;
            break;
        end
    end
    bb2=(aa2-s_x(k-1))/(s_x(k)-s_x(k-1))*(f_x(k)-f_x(k-1))+f_x(k-1);
    bb2=fix(bb2/dis)+1;
    
    bb_max=max(bb1,bb2);
    bb_min=min(bb1,bb2);
    
    for v=bb_min:bb_max
        m(v,i)=1;
    end
    
    bo_3(i)=bb_max;
    bo_4(i)=bb_min;
end

%填充非边界区域
for i=1:Cross
    for j=1:Line
        %判断点在内部还是外部
        if(j>bo_3(i) && j<bo_2(i))%内部
            ad_left=10000;
            ad_right=10000;
            ad_up=10000;
            ad_down=10000;
            %left
            if(i>1)
                for k=(i-1):-1:1
                    if(m(j,k)==1)
                        ad_left=abs(k-i);
                        break;
                    end
                end
            end
            %right
            if(i<Cross)
                for k=(i+1):Cross
                    if(m(j,k)==1)
                        ad_right=abs(k-i);
                        break;
                    end
                end
            end
            %up
            if(j<Line)
                for k=(j+1):Line
                    if(m(k,i)==1)
                        ad_up=abs(k-j);
                        break;
                    end
                end
            end
            %down
            if(j>1)
                for k=(j-1):-1:1
                    if(m(k,i)==1)
                        ad_down=abs(k-j);
                        break;
                    end
                end
            end
            ad_final=min(ad_left,ad_right);
            ad_final=min(ad_final,ad_up);
            ad_final=min(ad_final,ad_down);
            m(j,i)=1+ad_final;
        else if(j>bo_1(i) || j<bo_4(i))%外部
            ad_left=10000;
            ad_right=10000;
            ad_up=10000;
            ad_down=10000;
            %left
            if(i>1)
                for k=(i-1):-1:1
                    if(m(j,k)==1)
                        ad_left=abs(k-i);
                        break;
                    end
                end
            end
            %right
            if(i<Cross)
                for k=(i+1):Cross
                    if(m(j,k)==1)
                        ad_right=abs(k-i);
                        break;
                    end
                end
            end
            %up
            if(j<Line)
                for k=(j+1):Line
                    if(m(k,i)==1)
                        ad_up=abs(k-j);
                        break;
                    end
                end
            end
            %down
            if(j>1)
                for k=(j-1):-1:1
                    if(m(k,i)==1)
                        ad_down=abs(k-j);
                        break;
                    end
                end
            end
            ad_final=min(ad_left,ad_right);
            ad_final=min(ad_final,ad_up);
            ad_final=min(ad_final,ad_down);
            m(j,i)=1-ad_final;
            end
        end
    end   
end

mm_max=max(max(m));
mm_min=min(min(m));

R=zeros(1,(mm_max-mm_min+1));
p=zeros(1,(mm_max-mm_min+1));
for k=mm_min:mm_max
    for i=1:Line
        for j=1:Cross
            if(m(i,j)==k)
                R(k-mm_min+1)=R(k-mm_min+1)+1;
            end
        end
    end
end

for k=mm_min:mm_max
    p(k-mm_min+1)=R(k-mm_min+1)/(Line*Cross);
end

f=zeros(1,6);
%求灰度均值
for k=mm_min:mm_max
    f(1)=f(1)+k*p(k-mm_min+1);
end

%求灰度方差
for k=mm_min:mm_max
    f(2)=f(2)+(k-f(1))^2*p(k-mm_min+1);
end

%求灰度偏度
for k=mm_min:mm_max
    f(3)=f(3)+(k-f(1))^3*p(k-mm_min+1);
end
f(3)=f(3)/(f(2)^(3/2));

%求灰度峰度
for k=mm_min:mm_max
    f(4)=f(4)+(k-f(1))^4*p(k-mm_min+1);
end
f(4)=f(4)/(f(2)^2);

%求灰度能量
for k=mm_min:mm_max
    f(5)=f(5)+(p(k-mm_min+1))^2;
end

%求灰度熵
for k=mm_min:mm_max
    f(6)=f(6)+(1-p(k-mm_min+1))*log10(1-p(k-mm_min+1));
end
f(6)=-f(6);

%参考故障类别灰度统计特征向量的值
fc=zeros(2,6); %故障类别*特征值
fc=[3.230769231,3.230769231,0.398332458,2.051704706,0.164665103,0.396198536;
    1.437869822,7.743181261,-0.680559339,3.349141388,0.129389727,0.404353482;
   ];

%求关联系数
dlt=zeros(2,6);
for i=1:2
    for k=1:6
        dlt(i,k)=abs(f(k)-fc(i,k));
    end
end

ff_min=min(min(dlt));
ff_max=max(max(dlt));
rou=0.5;   %分辨系数

cgm=zeros(2,6);
for i=1:2
    for k=1:6
        cgm(i,k)=(ff_min+rou*ff_max)/(dlt(i,k)+rou*ff_max);
    end
end

yita=zeros(1,2);
for i=1:2
    for k=1:6
        yita(i)=yita(i)+cgm(i,k);
    end
    yita(i)=yita(i)/6;
end
