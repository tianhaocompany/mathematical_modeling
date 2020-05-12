function  fangzheng()%第三问的仿真，主要考虑经济危机带来的突变。本文在本问考虑  投资、进出口额 的变化。
%%%%%%%%%%%%%%%%%%%%%%%%%%%对于仿真没有考虑因素，通过实际的历史数据，仿真过程中通过预测取得
%%%%%%其中不变因素有1、GDP总额 2、教育经费 3、市场化程度 4、人口总量 5、利率 6、城镇人口比例
%%时间预测2009年以上1-6的变量系数的取值区间
clc;clear;
A=load('D:\ti3.1.txt');
[m,n]=size(A);
touzie=[20000 20000]; %2008，2009额外的投资总额
xiaofeie=[0 0];  %2008,2009年居民消费提高值
chukoue=[1000 4500];%2008,2009年居民消费提高值
lilv=0.27;
GDP=[141552.4093    256675.0462;
    126957.9853    266050.14];
edu=[1696.3482      2771.5719;
    1563.1351      2869.3918;];
renkou=[129814.0       134299.9;
        128826.2       135144.7;];
shichang=[5798.1496+xiaofeie(1)  7661.7572+xiaofeie(1);
         5381.8078+xiaofeie(2)  8000.9788+xiaofeie(2);];
chengzhen=[30.6572        35.7360;
         30.0324        36.2105;];
%%%%%%变化大的变量
%%%%%%%考虑到系数是负的，增加起到相反作用
touzi=[103133.7790-touzie(1)  167106.1437-touzie(1) ;
       95175.2584-touzie(2)   172912.7455-touzie(2) ;];
chukou=[14291.7+chukoue(1),14291.7+chukoue(1);
        11785.8+chukoue(2),11148+chukoue(2)];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
die=1000;
for i=1:die %迭代随机求的2009、2010年后就业总人数
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
     jiuye(1,i)=0.7594718027*y+0.0013596889*x1-0.0317091422*x2+0.3754777057*x3+0.1255889064*x4+0.6632706628*x5+0.0357341352*x6-65.495330046*x7-0.0001081396639*x8;
     yy=jiuye(1,i);
     jiuye(2,i)=0.7594718027*yy+0.0013596889*xx1-0.0317091422*xx2+0.3754777057*xx3+0.1255889064*xx4+0.6632706628*xx5+0.0357341352*xx6-65.495330046*xx7-0.0001081396639*xx8;
end
format short; 
T=[mean(jiuye'),std(jiuye')]

quekou=[31343-T(1),32423-T(2)]

% [R1,R2]=hist(jiuye) ;
% figure(1);
% hist(jiuye(1,:));
% xlabel('就业总数/万人');ylabel('统计次数');
% title('2009年就业人口数直方图');
% figure(2);
% hist(jiuye(2,:));
% xlabel('就业总数/万人');ylabel('统计次数');
% title('2010年就业人口数直方图');
% jianyan=[skewness(jiuye(1,:)),kurtosis(jiuye(1,:));
% skewness(jiuye(2,:)),kurtosis(jiuye(2,:));]
% 31343
% 32423

