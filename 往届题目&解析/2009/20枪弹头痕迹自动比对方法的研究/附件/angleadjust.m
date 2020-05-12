function [ax]= angleadjust(b)
%此函数为姿态角的角度调整
if b<90
    ax=90-b;
elseif b>=90&&b<=180
        ax=180-b;
       ax=90+ax;
else error('wrong');
end 

