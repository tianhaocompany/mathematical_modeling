%   把原始数据处理成一个矩阵存放。
%   每一个500*2000块存放一个子弹的转换坐标后的数据
%   从上到下依次为子弹1-22 ct1-22.mat中存放的是转换坐标后1-22颗子弹转换坐标后的数据

load ct1.mat %依次载入数据
load ct2.mat 
load ct3.mat
load ct4.mat
load ct5.mat
load ct6.mat
load ct7.mat
load ct8.mat
load ct9.mat
load ct10.mat
load ct11.mat
load ct12.mat
load ct13.mat
load ct14.mat
load ct15.mat
load ct16.mat
load ct17.mat
load ct18.mat
load ct19.mat
load ct20.mat
load ct21.mat
load ct22.mat
%%      数据汇总成一个矩阵
all_data=[ct1_c1(201:600,1:500) ct1_c2(201:600,1:500) ct1_c3(201:600,1:500) ct1_c4(201:600,1:500);
    ct2_c1(201:600,1:500) ct2_c2(201:600,1:500) ct2_c3(201:600,1:500) ct2_c4(201:600,1:500);
    ct3_c1(201:600,1:500) ct3_c2(201:600,1:500) ct3_c3(201:600,1:500) ct3_c4(201:600,1:500);
    ct4_c1(201:600,1:500) ct4_c2(201:600,1:500) ct4_c3(201:600,1:500) ct4_c4(201:600,1:500);
    ct5_c1(201:600,1:500) ct5_c2(201:600,1:500) ct5_c3(201:600,1:500) ct5_c4(201:600,1:500);
    ct6_c1(201:600,1:500) ct6_c2(201:600,1:500) ct6_c3(201:600,1:500) ct6_c4(201:600,1:500);
    ct7_c1(201:600,1:500) ct7_c2(201:600,1:500) ct7_c3(201:600,1:500) ct7_c4(201:600,1:500);
    ct8_c1(201:600,1:500) ct8_c2(201:600,1:500) ct8_c3(201:600,1:500) ct8_c4(201:600,1:500);
    ct9_c1(201:600,1:500) ct9_c2(201:600,1:500) ct9_c3(201:600,1:500) ct9_c4(201:600,1:500);
    ct10_c1(201:600,1:500) ct10_c2(201:600,1:500) ct10_c3(201:600,1:500) ct10_c4(201:600,1:500);
    ct11_c1(201:600,1:500) ct11_c2(201:600,1:500) ct11_c3(201:600,1:500) ct11_c4(201:600,1:500);
    ct12_c1(201:600,1:500) ct12_c2(201:600,1:500) ct12_c3(201:600,1:500) ct12_c4(201:600,1:500);
    ct13_c1(201:600,1:500) ct13_c2(201:600,1:500) ct13_c3(201:600,1:500) ct13_c4(201:600,1:500);
    ct14_c1(201:600,1:500) ct14_c2(201:600,1:500) ct14_c3(201:600,1:500) ct14_c4(201:600,1:500);
    ct15_c1(201:600,1:500) ct15_c2(201:600,1:500) ct15_c3(201:600,1:500) ct15_c4(201:600,1:500);
    ct16_c1(201:600,1:500) ct16_c2(201:600,1:500) ct16_c3(201:600,1:500) ct16_c4(201:600,1:500);
    ct17_c1(201:600,1:500) ct17_c2(201:600,1:500) ct17_c3(201:600,1:500) ct17_c4(201:600,1:500);
    ct18_c1(201:600,1:500) ct18_c2(201:600,1:500) ct18_c3(201:600,1:500) ct18_c4(201:600,1:500);
    ct19_c1(201:600,1:500) ct19_c2(201:600,1:500) ct19_c3(201:600,1:500) ct19_c4(201:600,1:500);
    ct20_c1(201:600,1:500) ct20_c2(201:600,1:500) ct20_c3(201:600,1:500) ct20_c4(201:600,1:500);
    ct21_c1(201:600,1:500) ct21_c2(201:600,1:500) ct21_c3(201:600,1:500) ct21_c4(201:600,1:500);
    ct22_c1(201:600,1:500) ct22_c2(201:600,1:500) ct22_c3(201:600,1:500) ct22_c4(201:600,1:500);];
%%      保存矩阵
save all_data.mat all_data