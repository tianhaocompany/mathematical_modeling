tt=zeros(1,3);
for i=1:21
macth33(i,1)=paixu(i,1)*0.2+paixu(1,2)*0.8;
end
for i=1:21
    paixu(i,4)=macth33(i,1);
end
for i=2:21
    if paixu(i,4)>paixu(1,4)
      tt=paixu(1,:);
      paixu(1,:)=paixu(i,:);
      paixu(i,:)=tt(1,:);
    end
end
for i=3:21
    if paixu(i,4)>paixu(2,4)
      tt=paixu(2,:);
      paixu(2,:)=paixu(i,:);
      paixu(i,:)=tt(1,:);
    end
end
for i=4:21
    if paixu(i,4)>paixu(3,4)
      tt=paixu(3,:);
      paixu(3,:)=paixu(i,:);
      paixu(i,:)=tt(1,:);
    end
end
for i=5:21
    if paixu(i,4)>paixu(4,4)
      tt=paixu(4,:);
      paixu(4,:)=paixu(i,:);
      paixu(i,:)=tt(1,:);
    end
end
for i=6:21
    if paixu(i,4)>paixu(5,4)
      tt=paixu(5,:);
      paixu(5,:)=paixu(i,:);
      paixu(i,:)=tt(1,:);
    end
end
for i=7:21
    if paixu(i,4)>paixu(6,4)
      tt=paixu(6,:);
      paixu(6,:)=paixu(i,:);
      paixu(i,:)=tt(1,:);
    end
end
for i=8:21
    if paixu(i,4)>paixu(7,4)
      tt=paixu(7,:);
      paixu(7,:)=paixu(i,:);
      paixu(i,:)=tt(1,:);
    end
end
for i=9:21
    if paixu(i,4)>paixu(8,4)
      tt=paixu(8,:);
      paixu(8,:)=paixu(i,:);
      paixu(i,:)=tt(1,:);
    end
end       
for i=10:21
    if paixu(i,4)>paixu(9,4)
      tt=paixu(9,:);
      paixu(9,:)=paixu(i,:);
      paixu(i,:)=tt(1,:);
    end
end       