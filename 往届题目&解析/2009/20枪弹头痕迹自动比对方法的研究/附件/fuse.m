
aa=maxrou_m(find(maxrou_m>0));
thegma=std(aa);
u=mean(aa);
dt=thegma*6/100;
x=linspace(u-3*thegma,u+3*thegma,100);
pdf1=(1/(sqrt(2*pi)*thegma))*exp(-(x-u).^2/(2*thegma^2));
plot(x,pdf1)

aa=thega_m(find(thega_m>0));
thegma=std(aa);
u=mean(aa);
dt=thegma*6/100;
x=linspace(u-3*thegma,u+3*thegma,100);
pdf2=(1/(sqrt(2*pi)*thegma))*exp(-(x-u).^2/(2*thegma^2));
plot(x,pdf1)

 aa=pose_m(find(pose_m>0));
thegma=std(aa);
u=mean(aa);
dt=thegma*6/100;
x=linspace(u-3*thegma,u+3*thegma,100);
pdf3=(1/(sqrt(2*pi)*thegma))*exp(-(x-u).^2/(2*thegma^2));
plot(x,pdf1)

p1=zeros(22,22);
p2=zeros(22,22);
p2=zeros(22,22);
for mmm1=1:22
    for nnn1=1:22
        
        
        aa=maxrou_m(find(maxrou_m>0));
thegma=std(aa);
u=mean(aa);
dt=thegma*6/100;
p1(mmm1,nnn1)=sum(pdf1(1:floor((maxrou_m(mmm1,nnn1)-(u-3*thegma))/dt-1))*dt);


aa=thega_m(find(thega_m>0));
thegma=std(aa);
u=mean(aa);
dt=thegma*6/100;
p2(mmm1,nnn1)=sum(pdf2(1:floor((2*u-thega_m(mmm1,nnn1)-(u-3*thegma))/dt-1))*dt);

aa=pose_m(find(pose_m>0));
thegma=std(aa);
u=mean(aa);
dt=thegma*6/100;
p3(mmm1,nnn1)=sum(pdf3(1:floor((2*u-pose_m(mmm1,nnn1)-(u-3*thegma))/dt-1))*dt);


    end
end
for m=1:22
    for n=1:m
        P(m,n)=0;
    end
end