% d为水的深度
% V0为水的速度
% 求解重物触底时候X方向的位置偏移量
function x=xValue(d,v0)
A=1.074;
B=1.0363;
V2=-4.3641;
C4=(V2-B)/(V2+B);
m=1500;
mf=652;
Sx=0.752;
Sy=0.752;
temp=exp(d/A);
Td=((1+C4)*temp+sqrt(((1+C4)*temp)*((1+C4)*temp)-4*C4))/(2*C4);
t=A*log(Td)/B;
x=v0*t-((m+mf)/(1050*Sx))*log(1050*Sx*v0*t+m+mf)+((m+mf)/(1050*Sx))*log(m+mf);
