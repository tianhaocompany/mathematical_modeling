% 计算某区域巡逻节点的次数
clc;
a=[210 203 220 226 215 228 251 253 295 306 305 304 299 280 261 241 242 226220 227 225 210

];
k=0;
for i=1:length(a)
  if a(i)~=0
    count=1;
    for j=i+1:length(a)
        if a(i)==a(j)
            count=count+1;
            a(j)=0;
        end
    end
       k=k+1;
      C(k)=count;
  end
end

% 计算巡逻节点对应度
k=0;
for i=1:length(a)
    if a(i)~=0
        k=k+1;
      for j=1:307
         if a(i)==j
             D(k)=N(j);
         end
      end
    end
end
% 每个节点优先度计算
pro=C./D
a=a';
C=C';
D=D';
pro=pro';
%计算均值
M=mean(pro)
%计算方差
S=std(pro)