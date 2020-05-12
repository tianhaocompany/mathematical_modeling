% 通过一阶不变矩来求出阈值Th，该阈值用于判断两个弹头是否来自于同一把枪
% 该阈值的取值范围是[th_min th_max]

clear all
clc

tic
index = 10000:20000;

% que4data.mat文件是通过运行getQue4data.m得到
load que4data.mat % data


%%
% 纠正数据中z的精度
for gunNum = 1:11
    for zdSeq = 1:2
        for line = 1:4
            data(gunNum,zdSeq,line,:,3) = CorrectZround(squeeze(data(gunNum,zdSeq,line,:,3)));
        end
    end
end

%%
% remove noise
data = DeNoise_v2(data);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gunNum = 11;
myEnd = 400000/min(index);
[d1 d2 d3 d4 d5] = size(data);
tableData = zeros(d1*d2*d3,d4,d5);
for gunNum = 1:11
    for zdSeq = 1:2
        for line = 1:4
            myIndex = (gunNum-1)*8 + (zdSeq-1)*4 + line;
            tableData(myIndex,:,:) = squeeze(data(gunNum,zdSeq,line,:,:));
        end
    end
end

ju = zeros(d1*d2*d3,myEnd+1);
for jj=1:d1*d2*d3
    for ii=0:myEnd
        myIndex = index + ii*min(index);
        x = squeeze(tableData(jj,myIndex,1));
        y = squeeze(tableData(jj,myIndex,2));
        z = squeeze(tableData(jj,myIndex,3));
        miu00 = m(0,0,x,y,z);
        j_mean = m(1,0,x,y,z) / miu00;
        k_mean = m(0,1,x,y,z) / miu00;
        miu02 = m(0,2,x,y,z) - k_mean * m(0,1,x,y,z);
        miu20 = m(2,0,x,y,z) - j_mean * m(1,0,x,y,z);
        y20 = miu20 / miu00;
        y02 = miu02 / miu00;
        I1_12 = y20 + y02;
        ju(jj,ii+1) = I1_12;
    end
end

n = d1*d2*d3;
eigenVal = zeros(n*(n-1)/2,7);
eigenId = 1;
for jj=1:d1*d2*d3-1
    for kk=jj+1:d1*d2*d3
        th = 10000000;
        for ju_i=0:myEnd
            for ju_j=0:myEnd
                if abs( ju(jj,ju_i+1) - ju(kk,ju_j+1) ) <= th
                    eigenVal(eigenId,1) = ju(jj,ju_i+1);
                    eigenVal(eigenId,2) = ju(kk,ju_j+1);
                    eigenVal(eigenId,3) = jj;
                    eigenVal(eigenId,4) = kk;
                    eigenVal(eigenId,5) = ju_i;
                    eigenVal(eigenId,6) = ju_j;              
                    th = abs( ju(jj,ju_i+1) - ju(kk,ju_j+1) );
                    eigenVal(eigenId,7) = th;
                end
            end
        end
        eigenId = eigenId + 1;
    end
end

% load eigenVal.mat
for jj=1:11   % 比较同一枪支的两个弹头
    zd1 = [1:4] + (jj-1)*8;
    zd2 = [zd1] + 4;
    th = -10000;
    for kk=1:4    
         zd2a = circshift(zd2,[0 kk-1]);
         total = 0;
         for aa = 1:4
            eigenId = map2pos(zd1(aa),zd2a(aa),88);
            total = total + eigenVal(eigenId,7);
         end
         if total > th
             th = total;
         end
    end
end
th_max = th


for jj=1:21   % 比较不同枪支的两个弹头
    for mm=jj+1:22
        zd1 = [1:4] + (jj-1)*4;
        zd2 = [1:4] + (mm-1)*4;
        if min(zd2)==max(zd1) && mod(max(zd2),8)==0
            continue;
        end
        th = 10000;
        for kk=1:4
            zd2a = circshift(zd2,[0 kk-1]);
            total = 0;
            for aa = 1:4
                eigenId = map2pos(zd1(aa),zd2a(aa),88);           
                total = total + eigenVal(eigenId,7);
            end
            if total < th
                th = total;
            end
        end
    end
end
th_min = th

toc
save eigenVal.mat eigenVal
% th_max = 0.001733041616609 (new)              %%%   0.037359     
% th_min = 6.250128440027647e-004 (new)         %%%   0.003951

