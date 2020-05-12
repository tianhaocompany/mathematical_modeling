%% 对两两子弹之间的特征峰匹配数据分析，得出最终的匹配度
load resD4    %为main主程序生成的数据库文件

D1=resdata;

%对信息进行处理，最后生成一个N*N的矩阵，第(m，n）个元素代表第m个子弹和第n个子弹的匹配程度。
D12=cell(22,22);
D13=zeros(22,22);
D23=zeros(22,22);
DD13=zeros(22,22);
s=zeros(22,22);
daa=[2 3 4 5];
D120=cell(size(daa,2),1);
for ida=1:size(daa,2)

    
da=daa(ida);

for ii4=1:21
        for jj4=ii4+1:22
        aa=zeros(4,4);
        aa2=zeros(4,4);
        for i=1:4
            for j=1:4
                 aa(i,j)=D1{ii4,jj4}{i,j}(da); 
            end
        end
        for i=1:4
            for j=1:4
               if aa(j,i)>1
                  aa(j,i)=1/aa(j,i);
               end
            end
        end
        aa2(:,1)=[aa(1,1) aa(2,2) aa(3,3) aa(4,4)]';
        aa2(:,2)=[aa(1,2) aa(2,3) aa(3,4) aa(4,1)]';
        aa2(:,1)=[aa(1,3) aa(2,4) aa(3,1) aa(4,2)]';
        aa2(:,1)=[aa(1,4) aa(2,1) aa(3,2) aa(4,3)]';
        
        D13(ii4,jj4)=max(mean(aa2,1));
 
       end
end

DD13=D13+D13';


a00=[12,6,11,17,1,18,13,7,2,19,14,8,3,20,15,9,4,21,16,10,5,22];
for i=1:22
    for j=1:22
        D23(a00(i),a00(j))=DD13(i,j);
    end
end

D120{ida}=D23;
%s=s+D120{ida};
if ida>1
    D120{ida}=sqrt(D120{ida}.*D120{ida-1});
end

end
D23=D120{ida};
DD03=D23;
DA=zeros(22,12);
%找出最匹配的前5个子弹。
for i=1:22
    p=zeros(1,5);b=zeros(1,5);
    for j=1:5
    [p1 b1]=max(DD03(i,:));
    p(j)=p1;b(j)=b1;
    DD03(i,b1)=0;

    end
  DA(i,1:5)=b;DA(i,6:10)=p;  
end
D23=D23   %输出各子弹间匹配的矩阵
DA=DA     %输出前5个匹配的子弹




