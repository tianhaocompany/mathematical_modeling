%% 子弹匹配程序  
load resdata  %导入储存数据库

%对第4题，每两颗子弹对比，每个子弹的任意两两面匹配  输出resD4
for ii4=1:21
       for jj4=ii4+1:22
           DAc=cell(4,4);
         for ii01=1:4   
         
m=(ii4-1)*4+ii01;           %%%
for ii02=1:4
    ii4=ii4
    jj4=jj4
    ii01=ii01
    ii02=ii02    
n=(jj4-1)*4+ii02;
U001=resdata{m,2};
U002=resdata{n,2};
U01=[U001 ones(size(U001,1),1)];
U02=[U002 ones(size(U002,1),1)*2];
ee1=0.7;ee2=1.3;yy=[1 2 3 4];

U01(:,5:7)=0;
U02(:,5:7)=0;

Udata=[U01;U02];

for i01=1:size(U01,1)
    for i012=1:size(U01,1)
        if mean(U01(i012,yy)>=U01(i01,yy)*ee1)==1&&mean(U01(i012,yy)<=U01(i01,yy)*ee2)==1
            U01(i01,5)=U01(i01,5)+1;
        end
    end
    for i012=1:size(U02,1)
        if mean(U02(i012,yy)>=U01(i01,yy)*ee1)==1&&mean(U02(i012,yy)<=U01(i01,yy)*ee2)==1
            U01(i01,6)=U01(i01,6)+1;
        end
    end
    
end

for i01=1:size(U02,1)
    for i012=1:size(U01,1)
        if mean(U01(i012,yy)>=U02(i01,yy)*ee1)==1&&mean(U01(i012,yy)<=U02(i01,yy)*ee2)==1
            U02(i01,5)=U02(i01,5)+1;
        end
    end
    for i012=1:size(U02,1)
        if mean(U02(i012,yy)>=U02(i01,yy)*ee1)==1&&mean(U02(i012,yy)<=U02(i01,yy)*ee2)==1
            U02(i01,6)=U02(i01,6)+1;
        end
    end
    
end

Udata=[U01;U02];



Udata(:,7)=sqrt(Udata(:,5).*Udata(:,6));
UU2=sortrows(Udata,-7);
UU3=[UU2 zeros(size(UU2,1),1)];
UU3(:,[5 6])=0;
maxuu=size(UU3,1)
for i=1:maxuu
   if UU3(i,9)~=2;
    for j=i+1:maxuu
        if UU3(j,9)~=2;
        if mean(UU3(j,yy)>=UU3(i,yy)*ee1)==1&&mean(UU3(j,yy)<=UU3(i,yy)*ee2)==1 %当前匹配
            UU3(j,9)=2;
            if UU3(j,8)==1
                UU3(i,5)=UU3(i,5)+1;
            end
             if UU3(j,8)==2
                UU3(i,6)=UU3(i,6)+1;
            end
        end
        end
        
    end
   end
end
    
UU3(:,7)=sqrt(UU3(:,5).*UU3(:,6));
UU4=sortrows(UU3,-7);

TH=zeros(7,1);

b2=size(U01,1)/size(U02,1);
TH(1,1)=sum(UU3(1:3,6)*b2,1)/sum(UU3(1:3,5),1);

UU5=sortrows(UU3,-5);
TH(2,1)=sum(UU5(1:3,6)*b2,1)/sum(UU5(1:3,5),1);
TH(4,1)=sum(UU5(1:5,6)*b2,1)/sum(UU5(1:5,5),1);
UU6=sortrows(UU3,-6);
TH(3,1)=sum(UU6(1:3,6)*b2,1)/sum(UU6(1:3,5),1);
TH(5,1)=sum(UU6(1:5,6)*b2,1)/sum(UU6(1:5,5),1);

TH(6)=resdata{m,1};
TH(7)=resdata{n,1};


DAc{ii01,ii02}=TH';

TH'


end
     end
    load resD4  %  resD4=cell(22,22);save resD4 resD4
    resD4{ii4,jj4}=DAc;
      save resD4 resD4
end
end