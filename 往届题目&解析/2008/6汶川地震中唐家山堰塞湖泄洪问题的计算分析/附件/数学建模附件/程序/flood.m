function y=flood(h,b,v,v0)
%计算有缺口的流量
%h 当前深度
%b 当前溃口宽度
%v,v0 当前库容，上次库容
%bm=70;
bm=300;
hh=h-(42-newton(v0,v));
if hh>0
    y=1.71*b*hh^(1.5)+1.2*hh^(2.5)*h/((bm-b)/2);
    %y=1.71*b*hh^(1.5)+1.2*hh^(2.5)*h/((bm-b)/2);
    %4.5
else
    y=0;
end

