function draw_f(x,y,vel,ang,pres)
% 画风矢量符号
% 输入： x,y坐标，速度，角度，压强
%%
f_length = 50;
f_patit = 7;
f_width = 12;
ang = ang/180*pi+pi;
%%
if vel<20
    num_bar = 1;
elseif vel<40
    num_bar = 2;
else
    num_bar = 3;
end

%%
if pres<=200
    color_pres = 'r';
elseif pres<=500
    color_pres = 'g';
else
    color_pres = 'b';
end
%%
for i=1:num_bar
    pstart(i,1) = x + (f_length-f_patit*(i-1))*sin(ang);
    pstart(i,2) = y - (f_length-f_patit*(i-1))*cos(ang);
    pend(i,1) = pstart(i,1) + f_width*cos(ang);
    pend(i,2) = pstart(i,2) + f_width*sin(ang);
end
%%
plot( [x pstart(1,1)] , [y pstart(1,2)] , 'LineWidth', 1, 'Color', color_pres);
for i=1:num_bar
    plot( [pstart(i,1) pend(i,1)] , [pstart(i,2) pend(i,2)] , 'LineWidth', 1, 'Color', color_pres);
end
