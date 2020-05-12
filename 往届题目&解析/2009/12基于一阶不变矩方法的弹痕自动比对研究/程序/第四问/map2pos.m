function y = map2pos(m,k,len)
% 输入：m：第m行
%       k：第k列
%       len：11*2*4,其中11是枪支数，2是每个枪支的弹头数，4是每个弹头的擦痕数
% 功能：将输入的在矩阵中位置为（m,k）的点进行映射。将矩阵上三角按行搜索再按列搜索
%       所得到的序号输出。比如len=88时，（1，2）序号为1，（1，3）序号为2，
%       （1，88）序号为87，（2，3）序号为88，以此类推。
%  eigenId = map(zd1(aa),zd2a(aa))
%  len = 88;
index = [len-1:-1:1];
pos = 0;
if m >=2 
    for ii = 1:m-1
        pos = pos + index(ii);
    end
end
pos = pos + k - m;
y = pos;

