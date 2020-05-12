newp=0.0000;
totalnum=13;


rangeindex=1;
rangetable=zeros(100,5); %巡逻到的点数，巡逻点比率，平均覆盖率，覆盖到90%的数目，三点全覆盖数目
for rangeindex=18:18;
    rangeindex
    
   for i=1:totalnum
    current(i,1)=ppoint(i,totalnum-9)+1;
     current(i,2)=0;
end

carRecord = zeros(1500,20);
patrolRecord = zeros(1350,2);

carindex=1;
while carindex<=1500
    
    if mod(carindex,50)==0
        for ci=1:1350
            patrolRecord(ci,1)=0;
        end
    end
    
    maxLong=0; %17辆车走的最远的那辆
    
for i=1:totalnum
    index=1;
    %获取每辆车可能的前进点
    allSitu=zeros(4,5);
    for j=1:1501
        if newroad(j,1)==current(i,1)
            allSitu(index,1)=newroad(j,2);
            index=index+1;
        end
        if newroad(j,2)==current(i,1)
        	allSitu(index,1)=newroad(j,1);
        	index=index+1;
        end
    end
    
    cur=current(i,1);
    %给每个可能点评分
    for j=1:4
    	num=0;
        if allSitu(j,1)>0
            current(i,1)=allSitu(j,1);

            imp1=0;imp2=0;imp3=0;
             for p=1:totalnum
                if newlagroad2(101,current(p,1))<1503.6697 || newlagroad2(103,current(p,1))<1511.8248 || newlagroad2(110,current(p,1))<1503.6697 || newlagroad2(112,current(p,1))<1475.324
                    imp1=1;
                end
                if newlagroad2(123,current(p,1))<1521.546 || newlagroad2(141,current(p,1))<1478.7411
                    imp2=1;
                end
                if newlagroad2(277,current(p,1))<1636.6667
                    imp3=1;
                end
            end

              if imp1==0 || imp2==0 || imp3==0
                allSitu(j,3)=0;
            else
                allSitu(j,3)=2;
            end


            for i1=1:1350
                for j1=1:totalnum
                    dis = newlagroad2(i1,(current(j1,1)));
                    onmap=0;
                    if dis<2500
                        onmap=1;
                        break;
                    end
                end
                if onmap==1
                    num=num+1;
                end
            end

            if (num/1350)>0.9
               allSitu(j,2)=1;
            else
                allSitu(j,2)=0;
            end

            allSitu(j,4)=num/1350;
        end
    end
    
    %选择一个最优的
    best=1;
    for p2=1:4
        allSitu(p2,5)=allSitu(p2,2)+allSitu(p2,3)+allSitu(p2,4);
        if allSitu(p2,1)>0 && patrolRecord(allSitu(p2,1),1)==0
            allSitu(p2,5)=allSitu(p2,5)+0.0002*rangeindex;
        end
        if allSitu(p2,5)>allSitu(best,5)
            best=p2;
        end
    end
    
    current(i,2)=current(i,2)+newlagroad2(cur,allSitu(best,1));
    if current(i,2)>maxLong 
        maxLong=current(i,2);
    end
    
    current(i,1)=allSitu(best,1);
    
    carRecord(carindex,i)=allSitu(best,1);
    patrolRecord(allSitu(best,1),1)=patrolRecord(allSitu(best,1),1)+1;
    patrolRecord(allSitu(best,1),2)=patrolRecord(allSitu(best,1),2)+1;
end
    carRecord(carindex,19)=allSitu(best,4);
    carRecord(carindex,20)=allSitu(best,3);
    carindex=carindex+1;

    %时间校准 --------------------------------
    hasOne=0; %进行了时间校准 1
    
for i=1:totalnum
    if maxLong-current(i,2)>200   %只前进落后的车
        
    hasOne=1;
    index=1;
    %获取每辆车可能的前进点
    allSitu=zeros(4,5);
    for j=1:1501
        if newroad(j,1)==current(i,1)
            allSitu(index,1)=newroad(j,2);
            index=index+1;
        end
        if newroad(j,2)==current(i,1)
        	allSitu(index,1)=newroad(j,1);
        	index=index+1;
        end
    end
    
    cur=current(i,1);
    %给每个可能点评分
    for j=1:4
    	num=0;
        if allSitu(j,1)>0
            current(i,1)=allSitu(j,1);

            imp1=0;imp2=0;imp3=0;
             for p=1:totalnum
                if newlagroad2(101,current(p,1))<1503.6697 || newlagroad2(103,current(p,1))<1511.8248 || newlagroad2(110,current(p,1))<1503.6697 || newlagroad2(112,current(p,1))<1475.324
                    imp1=1;
                end
                if newlagroad2(123,current(p,1))<1521.546 || newlagroad2(141,current(p,1))<1478.7411
                    imp2=1;
                end
                if newlagroad2(277,current(p,1))<1636.6667
                    imp3=1;
                end
            end

             if imp1==0 || imp2==0 || imp3==0
                allSitu(j,3)=0;
            else
                allSitu(j,3)=2;
            end


            for i1=1:1350
                for j1=1:totalnum
                    dis = newlagroad2(i1,(current(j1,1)));
                    onmap=0;
                    if dis<2500
                        onmap=1;
                        break;
                    end
                end
                if onmap==1
                    num=num+1;
                end
            end

            
             if (num/1350)>0.9
               allSitu(j,2)=1;
            else
                allSitu(j,2)=0;
            end

            allSitu(j,4)=num/1350;
        end
    end
    
    %选择一个最优的
    best=1;
    for p2=1:4
        allSitu(p2,5)=allSitu(p2,2)+allSitu(p2,3)+allSitu(p2,4);
        if allSitu(p2,1)>0 && patrolRecord(allSitu(p2,1),1)==0
            allSitu(p2,5)=allSitu(p2,5)+0.0002*rangeindex;
        end
        if allSitu(p2,5)>allSitu(best,5)
            best=p2;
        end
    end
    
    current(i,2)=current(i,2)+newlagroad2(cur,allSitu(best,1));
    if current(i,2)>maxLong 
        maxLong=current(i,2);
    end
    
    current(i,1)=allSitu(best,1);
    
    carRecord(carindex,i)=allSitu(best,1);
    patrolRecord(allSitu(best,1),1)=patrolRecord(allSitu(best,1),1)+1;
    patrolRecord(allSitu(best,1),2)=patrolRecord(allSitu(best,1),2)+1;
    end
end
if hasOne==1
    carRecord(carindex,19)=allSitu(best,4);
    carRecord(carindex,20)=allSitu(best,3);
    carindex=carindex+1;
end
    
     %时间校准 END--------------------------------

end

range=0;
for i=1:1350
    if patrolRecord(i,2)>0
        range=range+1;
    end
end

rangetable(rangeindex+1,1)=range;
rangetable(rangeindex+1,2)=range/1350;

reachrate=0;
reach90=0;
reachimport=0;
for i=1:1500
    reachrate=reachrate+carRecord(i,19);
    if carRecord(i,19)>0.9
        reach90=reach90+1;
    end
    if carRecord(i,20)>0
        reachimport=reachimport+1;
    end
end
reachrate=reachrate/1500;

rangetable(rangeindex+1,3)=reachrate;
rangetable(rangeindex+1,4)=reach90;
rangetable(rangeindex+1,5)=reachimport;

end