%数据重构
% E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77T1-1203959
% E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77T2-1203959
clc
clear
load  'E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77t2-1812492\c1.dat' ;
load  'E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77t2-1812492\c2.dat' ;
load  'E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77t2-1812492\c3.dat' ;
load  'E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77t2-1812492\c4.dat' ;

c1=reshape(c1(:,3),564,756);
c2=reshape(c2(:,3),564,756);
c3=reshape(c3(:,3),564,756);
c4=reshape(c4(:,3),564,756);

% save  'E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77t2-1812492\c1.mat' c1;
% save  'E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77t2-1812492\c2.mat' c2;
% save  'E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77t2-1812492\c3.mat' c3;
% save  'E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77t2-1812492\c4.mat' c4;

cc1=c1;
cc2=c2;
cc3=c3;
cc4=c4;

load  'E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77t1-1812492\c1.dat' ;
load  'E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77t1-1812492\c2.dat' ;
load  'E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77t1-1812492\c3.dat' ;
load  'E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77t1-1812492\c4.dat' ;

c1=reshape(c1(:,3),564,756);
c2=reshape(c2(:,3),564,756);
c3=reshape(c3(:,3),564,756);
c4=reshape(c4(:,3),564,756);

[pc1] = pol_fit(c1(:,150:600));
[pc2] = pol_fit(c2(:,150:600));
[pc3] = pol_fit(c3(:,150:600));
[pc4] = pol_fit(c4(:,150:600));

[pcc1] = pol_fit(cc1(:,150:600));
[pcc2] = pol_fit(cc2(:,150:600));
[pcc3] = pol_fit(cc3(:,150:600));
[pcc4] = pol_fit(cc4(:,150:600));

% pose = waveltmethod(pc1)
% pose = waveltmethod(pc2)
% pose = waveltmethod(pc3)
% pose = waveltmethod(pc4)
% pose = waveltmethod(pcc1)
% pose = waveltmethod(pcc2)
% pose = waveltmethod(pcc3)
% pose = waveltmethod(pcc4)
% 
% 
% plot(c1(:,100))
% hold on
% plot(del(:,100),'LineWidth',2,'Color','red')
% h = legend('原始弹痕数据截面','拟合圆柱面截面',2);
% set(h)


