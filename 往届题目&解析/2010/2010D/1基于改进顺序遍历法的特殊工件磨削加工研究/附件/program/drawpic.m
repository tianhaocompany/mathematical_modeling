function drawpic(x,y,z)
y1=zeros(1,150);%对应于坐标x,y,z的可表示为脉冲形式的新坐标数组
x1=zeros(1,150);
z1=zeros(1,150);
for i=1:70     %对各个点坐标构造相应的脉冲序列，若某个坐标值为1，则使其对应于新数列中的两个
               %连续的元素
   if y(i)==1
       y1(1+(i-1)*2)=1;
       y1(2+(i-1)*2)=0;
   else
       y1(1+(i-1)*2)=0;
       y1(2+(i-1)*2)=0;
   end
end
for i=1:75
    x1(1+(i-1)*2)=1;
    x1(2+(i-1)*2)=0;
end
for i=1:70           %构造z坐标的脉冲形式坐标，存入在z1数列中
    if z(i)==1
       z1(1+(i-1)*2)=1;
       z1(2+(i-1)*2)=0;
    else
        z1(1+(i-1)*2)=0;
       z1(2+(i-1)*2)=0;
    end
end
subplot(3,1,2),stairs(x,y1),title('y轴方向的脉冲图形');
subplot(3,1,1),stairs(x,x1),title('x轴方向的脉冲图形');
subplot(3,1,3),stairs(x,z1),title('转动角度的脉冲图形');