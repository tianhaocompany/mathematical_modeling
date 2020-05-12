%机器人指尖达到目标点P的指令集合
tic
clear
clc
global P epsn
Loc0=[0    0    0      0    0
      0    0    255    510  510
      0    140  140    140  75 ];
Axis0=[0 1 1 0 1 0
      0 0 0 1 0 0
      1 0 0 0 0 1];
Cen0=[0   0   0     0   0   0
      0   0 255  510  510  510
      0 140 140  140  140  75];
P0=[20 -200 120];
Loc=Loc0;
Axis=Axis0;
Cen=Cen0;
P=P0;
epsn=1e-3;
f=norm(Loc(:,5)-P');
result=zeros(2,1);
k=1;
Total=zeros(1,6);
Distance=0;
while f>0.5
    lgx=1;
    while lgx 
        [sita,number]=my_choose(Loc,P,f);
        [NewLoc,NewP,NewCen,NewAxis,weiyi]=my_change(Loc,P,Cen,Axis,sita*pi/180,number);
        ff=norm(NewLoc(:,5)-NewP');
        if ff<f
            Loc=NewLoc;
            P=NewP;
            Cen=NewCen;
            Axis=NewAxis;
            Distance=Distance+weiyi;
            lgx=0;
        end
    end
    result(:,k)=[sita number]';
    Total(number)=Total(number)+sita;
    k=k+1;
    f=ff;
end
Order=zeros(ceil(size(result,2)/5),6);
number=ones(1,5);
for i=1:size(result,2)
    Order(number(result(2,i)),result(2,i))=result(1,i);
    number(result(2,i))=number(result(2,i))+1;
end
toc