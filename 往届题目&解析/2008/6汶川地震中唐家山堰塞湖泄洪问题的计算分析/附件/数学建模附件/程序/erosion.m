function y=erosion(H,V,Q,B)
%H H(i)缺口深度
%V H(i)库容
%Q Q(i)流量（上一个）
%B B(i)上一个溃口底宽
H_water=newton(20,V);
H_water_gc=710+H_water;
deltaH=H_water_gc-752+H;
Pb=2*deltaH+B;
Lb=803;
deltaT=10/60;
p=0.1;%空隙率 1-p
ks=0.01;%运输效率19
y=H+Q*deltaT*3600*ks/(Pb*Lb*(1-p));

