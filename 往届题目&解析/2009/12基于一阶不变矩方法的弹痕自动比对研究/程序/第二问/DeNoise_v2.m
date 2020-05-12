function y = DeNoise_v2(data)
% 输入：二维矩阵：有3列，分别表示x，y，z轴；行数不限
% 输出：二维矩阵，维数和大小同输入一样。
% 功能：对输入的元素先后进行数据误差去除和噪声去除处理，并给出4幅图像：
%      原始数据的图像、去除数据误差后的数据图像、去除数据误差和噪声后
%      的数据图像、去除的数据误差和噪声之和的图像

%% 图像坐标系
x = 1:564;
y = 1:756;
[xx,yy] = meshgrid(x,y);


%%
dataDeNoise = data;
%% 去除由油迹等造成的误差
for gunNum = 1%1:6
    for zdSeq = 1 %1:2
        for lineSeq = 1 %1:4
            data1 = squeeze(data(gunNum,zdSeq,lineSeq,:,:));
            z = CorrectZround(data1(:,3));         
           %% 得到Z的平面矩阵
            zz = zeros(756,564);
%             for I = 1:756
%                 zz(I,:) = z((I-1)*564+1:I*564);
%             end      
            zz = reshape(z,756,564);
            
            
            %%
            ori = zz;
            figure % 原始图像
            mesh(xx,yy,zz)
            xlabel('X')
            ylabel('Y');
            zlabel('Z');
            title('原始图像')
            
            %%
            zz_deNoise = zz;
            %% 空间域进行平均
            %T  =  mean(zz)/10; % 阈值
            [row col] = size(zz);
            T = (max(max(zz))-min(min(zz)))/(row*col);
            for K = 2:563
                for I = 2:755
                    G = 1/8 * (zz(I-1,K-1)+zz(I-1,K)+zz(I-1,K+1)+zz(I,K-1)+zz(I,K+1)+zz(I+1,K-1)+zz(I+1,K)+zz(I+1,K+1));
                    % 判断点是否为奇异点
                    if abs( zz(I,K)-G ) > T % 是奇异点
                        zz_deNoise(I,K) = G ;
                    end
                end
            end

            dataDeNoise(gunNum,zdSeq,lineSeq,:,3) = reshape(zz_deNoise,[],1);
        end   % lineSeq = 1:4
    end    % zdSeq = 1:2
end    % gunNum = 1:6


%%
figure % 去除数据误差后的图像
mesh(xx,yy,zz_deNoise)
xlabel('X')
ylabel('Y');
zlabel('Z');
title('去除误差后的图像')


%% 去除随机噪声
dataTemp = dataDeNoise;
for gunNum = 1:6
    for zdSeq = 1:2
        for lineSeq = 1:4
            data1 = squeeze(dataDeNoise(gunNum,zdSeq,lineSeq,:,:));
            z = CorrectZround(data1(:,3));         
           %% 得到Z的平面矩阵
            zz = zeros(756,564);     
            zz = reshape(z,756,564);
            zz_deNoise = zz;
           
            for K = 2:563
                for I = 2:755
                    G = 1/8 * (zz(I-1,K-1)+zz(I-1,K)+zz(I-1,K+1)+zz(I,K-1)+zz(I,K+1)+zz(I+1,K-1)+zz(I+1,K)+zz(I+1,K+1));
                    zz_deNoise(I,K) = G ;
                end
            end
            dataTemp(gunNum,zdSeq,lineSeq,:,3) = reshape(zz_deNoise,[],1);
        end   % lineSeq = 1:4
    end    % zdSeq = 1:2
end    % gunNum = 1:6

y = dataTemp;

% save dataDeNoise.mat dataDeNoise


%%
figure % 去除随机噪声后的图像
mesh(xx,yy,zz_deNoise)
xlabel('X')
ylabel('Y');
zlabel('Z');
title('去除随机噪声后的图像')

%% 画图显示

figure % 去除掉的噪声图像
mesh(xx,yy,zz_deNoise - ori)
xlabel('X')
ylabel('Y');
zlabel('Z');
title('去除掉的误差+噪声图像')

