function  fangzheng_2()%第三问的仿真模型的改进
%主要考虑经济危机带来的突变。本文在本问考虑  投资、进出口额 的变化。
%%%%%%%%%%%%%%%%%%%%%%%%%%%对于仿真没有考虑因素，通过实际的历史数据，仿真过程中通过预测取得
%%%%%%其中不变因素有1、GDP总额 2、教育经费 3、市场化程度 4、人口总量 5、利率 6、城镇人口比例
%%时间预测2009年以上1-6的变量系数的取值区间
clc;clear;
A=load('D:\ti3.1.txt');
[m,n]=size(A);
% figure(1);
% plot([1990:2006],A(:,3));
% % hold on;
% figure(2);
% plot([1990:2006],A(:,5));
lilv=0.27;
GDP=[141552.4093    256675.0462;
    126957.9853    266050.14];
edu=[1696.3482      2771.5719;1563.1351      2869.3918;];
renkou=[129814.0       134299.9;128826.2       135144.7;];
shichang=[5798.1496      7661.7572;5381.8078      8000.9788;];
chengzhen=[30.6572        35.7360;30.0324        36.2105;];
%%%%%%%%%%%%%5两个特殊的指标
touzi=[26003.3099     35757.0204;
    23810.3053+40000*0.154   37501.5280+40000*0.154];%有效投资额
chukou=[14291.7,14291.7;
    11785.8,11148];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
die=1000;
for i=1:die %迭代随机求的2009年后就业总人数
    y=30000;
    x1=GDP(1,1)+rand*(GDP(1,2)-GDP(1,1));%GDP 
     xx1=GDP(2,1)+rand*(GDP(2,2)-GDP(2,1));%GDP
    x2=touzi(1,1)+rand*(touzi(1,2)-touzi(1,1));%总投资额
    xx2=touzi(2,1)+rand*(touzi(2,2)-touzi(2,1));%总投资额
    x3=edu(1,1)+rand*(edu(1,2)-edu(1,1));;%教育经费
    xx3=edu(2,1)+rand*(edu(2,2)-edu(2,1));;%教育经费
    x4=chukou(1,1)+rand*(chukou(1,2)-chukou(1,1));;%出口贸易额
    xx4=chukou(2,1)+rand*(chukou(2,2)-chukou(2,1));;%出口贸易额
    x5=shichang(1,1)+rand*(shichang(1,2)-shichang(1,1));;%市场程度
    xx5=shichang(2,1)+rand*(shichang(2,2)-shichang(2,1));;%市场程度
    x6=renkou(1,1)+rand*(renkou(1,2)-renkou(1,1));%人口总量
     xx6=renkou(2,1)+rand*(renkou(2,2)-renkou(2,1));%人口总量
    x7=lilv;xx7=lilv;%利率
    x8=chengzhen(1,1)+rand*(chengzhen(1,2)-chengzhen(1,1));;%城镇化水平
    xx8=chengzhen(2,1)+rand*(chengzhen(2,2)-chengzhen(2,1));;%城镇化水平

     jiuye(1,i)=0.85502*y+0.0028768*x1+0.085243*x2-0.45296*x3+0.065377*x4+0.10753*x5+0.046523*x6-106.97*x7-114.29*x8;
     yy=jiuye(1,i);
     jiuye(2,i)=0.85502*yy+0.0028768*xx1+0.085243*xx2-0.45296*xx3+0.065377*xx4+0.10753*xx5+0.046523*xx6-106.97*xx7-114.29*xx8;
end
[mean(jiuye'),std(jiuye')]
[R1,R2]=hist(jiuye) ;
 figure(1);
hist(jiuye(1,:));
xlabel('就业总数');ylabel('统计次数');
figure(2);
hist(jiuye(2,:));
xlabel('就业总数');ylabel('统计次数');
jianyan=[skewness(jiuye(1,:)),kurtosis(jiuye(1,:));
skewness(jiuye(2,:)),kurtosis(jiuye(2,:));]
%  w=[2.93:0.025:3.175];
% R1,w
%  hold on;
% plot(w,R1) ,
 %fplot('1/(sqrt())*exp()^2');
%  hold on
%  fplot();




