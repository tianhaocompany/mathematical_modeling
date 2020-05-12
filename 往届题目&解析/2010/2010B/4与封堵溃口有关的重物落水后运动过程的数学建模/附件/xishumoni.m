%
clc
clear all
syms y t
S=solve('y=-0.757*t+2.826*t^2-0.04','t');
y0=0.275
S=subs(S, y, y0)
for i=1:2
    if S(i) > 0
        T = S(i)
        x=1.311*T + 0.1079*exp(-12.15*T) - 0.1079
    end
end
