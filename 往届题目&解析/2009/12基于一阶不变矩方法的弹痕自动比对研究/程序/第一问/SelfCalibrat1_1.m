function [data_result,ANS,DeltaCitaZ,DeltaCitaX,Wieght] = SelfCalibrat1_1(...
                            data, CitaZLimL, CitaZLimR, Num1,...
                            CitaXLimL, CitaXLimR, Num2)
%  在给定的沿x轴、z轴旋转角度范围内，搜索最佳姿态调整角度。
%  输入：
%  data 包含三列数据 x坐标，y坐标，z坐标，单位mm
%  CitaZLimL 绕Z轴旋转的起始搜索角度  单位 °
%  CitaZLimR 绕Z轴旋转的终止搜索角度  单位 °
%  Num1 离散点数
%  CitaXLimL 绕X轴旋转的起始搜索角度  单位 °
%  CitaXLimL 绕X轴旋转的终止搜索角度  单位 °
%  Num2 离散点数
%  输出：
%  data_result：修正后的[x,y,z]
%  ANS:  1×3，
%        ANS(1)：最小面积
%        ANS(2)：绕Z轴旋转的角度  
%        ANS(3)：绕X轴旋转的角度


x = data(:,1);
y = data(:,2);
z = data(:,3);

% 与y轴的夹角（绕Z轴）
dcitaZ =linspace(CitaZLimL * pi/180,CitaZLimR * pi/180,Num1);
DeltaCitaZ = ( dcitaZ(2) - dcitaZ(1) ) * 180 / pi;
% 与XOY平面的夹角（绕X轴）
dcitaX =linspace(CitaXLimL * pi/180,CitaXLimR * pi/180,Num2);
DeltaCitaX = ( dcitaX(2) - dcitaX(1) ) * 180 / pi;

totle = zeros(length(dcitaX));
ANS = [1e16,0,0];  % 结果初值，第一个点保存投影面积，
%                   第二个点表示沿Z轴旋转的角度，
%                   第三个点表示沿X轴旋转的角度
for II = 1:length(dcitaZ)
    DcitaZ = dcitaZ(II);
    % 先在x0y平面转动，即调整擦痕走向与y轴的夹角
    [x1,y1] = routeByZ(x,y,DcitaZ); 
    for III = 1:length(dcitaX)
        %数据旋转    
        DcitaX = dcitaX(III);
        % 调整母线与x0y平面的夹角，即沿X轴转动
        [y1,z1] = routeByX(y1,z,DcitaX);
        %% 提取数据
        Ystart =1; % 从第1 个样本开始
        step = 1;
        Yend = 756;  % 到第18个样本结束
        tt = Ystart:step:Yend;
        Z1 = Inf.*zeros(length(tt),564);

        t = 1;
        for I = Ystart:step:Yend
            Z1(t,:) = z1((I-1)*564+1:I*564)';
            t=t+1;
        end
        
        Zmax_ByY = max(Z1,[],2);
        Zmin_ByY = min(Z1,[],2);

        totle(II,III) = abs(sum(Zmax_ByY-Zmin_ByY))+abs(sum(y(2:end)-y1(2:end)));
        % totle 每一行代表的是：对于在XOY平面转动一个角度，
        %       对应的母线沿X轴转动的所有情形
        if  totle(II,III) < ANS(1)
            ANS(1) = totle(II,III);
            ANS(2) = DcitaZ*180/pi;
            ANS(3) = DcitaX*180/pi;
            Wieght = [abs(sum(Zmax_ByY-Zmin_ByY)), abs(sum(y(2:end)-y1(2:end)))]; % Detect
            data_result = [x1,y1,z1];
            
        end
    end
end

