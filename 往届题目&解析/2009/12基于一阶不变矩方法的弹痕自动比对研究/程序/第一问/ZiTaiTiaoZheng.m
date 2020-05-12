clear,clc
close all
% c1.dat 为擦痕数据文件名
[x,y,z] = readdat('c1.dat');
data = [x,y,z];
% 绕Z轴旋转的起始角度
CitaZLimL = -0.2;
% 绕Z轴旋转的终止角度
CitaZLimR = 0.2;
% 以上角度区间的离散点数
Num1 = 15;
% 绕X轴旋转的起始角度
CitaXLimL = -0.2;
% 绕X轴旋转的终止角度
CitaXLimR = 0.2;
% 以上角度区间的离散点数
Num2 = 15;
ANS1 = [1e8,0,0];

toller = 1e-5; % 精度设置
while(1)


    [data_result,ANS,DeltaCitaZ,DeltaCitaX,W] = SelfCalibrat1_1(...
                                data, CitaZLimL, CitaZLimR, Num1,...
                                CitaXLimL, CitaXLimR, Num2);
                            
    if abs(ANS(1) - ANS1(1)) < toller
        break;
    else
        % 设置2倍于上一步离散长度
        CitaZLimL = ANS(2)-2*DeltaCitaZ;
        CitaZLimR = ANS(2)+2*DeltaCitaZ;
        % 新范围的采样点数
        Num1 = 15;
        
        % 设置2倍于上一步离散长度
        CitaXLimL = ANS(3)-2*DeltaCitaX;
        CitaXLimR = ANS(3)+2*DeltaCitaX;
        % 新范围的采样点数
        Num2 =15;
        ANS1 = ANS;       
    end   
end
TiaoZhengByZ = ANS(:,2) %绕Z轴的调整角度
TiaoZhengByX = ANS(:,3) %绕X轴的调整角度
%% 数据保存，在调整位置误差时会用到该数据文件
save result.mat   ANS data_result data

