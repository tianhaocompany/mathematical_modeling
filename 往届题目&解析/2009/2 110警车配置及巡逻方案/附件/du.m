% 所有节点度算法
for i=1:307
    num=0;
     for j=1:458
          if s(j)==i  %出度计算
              num=num+1;
          end
          if e(j)==i  %入度计算
              num=num+1;
          end
     end
     N(i)=num  ; %显示总的度数
    
end
    