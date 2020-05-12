%danTouCor
% 求解第4个问题的第2小问，并保存在变量ans4_2中和存在ans4_2.mat里
% 求解时需要用到第4个问题第1小问的结果——eigenVal.mat（两个弹头两两擦痕的相似度）
%
clc
clear all
%th = (0.001733041616609 + 6.250128440027647e-004) / 2; %10
th = 0.0009; %12
%th = 0.0007; %11
load eigenVal.mat
data4_2 = ones(22,22) * realmax; % 一共有22个弹头

%% 计算任意2个弹头之间的相似度
for gunNumi = 1:21
    for gunNumj = gunNumi+1:22
        indexi = [1:4] + (gunNumi-1)*4;
        indexj = [1:4] + (gunNumj-1)*4;
        p = 10000;
        for ii=1:4 % 每两个弹头的擦痕有4种匹配方式
            corArr = zeros(4,1);
            indexjRot = circshift(indexj,ii-1);
            for aa=1:4  %对于每种匹配，遍历4组擦痕
              eigenId = map2pos(indexi(aa),indexj(aa),88);
              corArr(aa) = abs(eigenVal(eigenId,7));
            end
            corArr = sort(corArr);
            
            pTemp = mean(corArr(find(corArr<th)));
            %pTemp = sum(corArr(1:3));  % 选取两个子弹最相似的两组擦痕来计算子弹的相似性
            if pTemp < p
                p = pTemp;
            end
        end
        data4_2(gunNumi,gunNumj) = p;    
    end
end
save data4_2.mat data4_2

%% 找出与i个弹头最相似的前n个弹头
n = 5;
[row col] = size(data4_2);
for ii=2:row
    for jj=1:ii-1
        data4_2(ii,jj) = data4_2(jj,ii);
    end
end
ans4_2 = zeros(row,n);
for ii=1:row
    [Y I] = sort(data4_2(ii,:));
    ans4_2(ii,:) = I(1:n);
end

%save ans4_2.mat ans4_2