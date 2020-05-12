function [SX]=Mod_Scale(x,mx,mn,T)
if T==0 %min 
    SX=x-abs(mx-mn)*0.1;
else
    SX=x+abs(mx-mn)*0.1;
end;