function [speed,dirt,speed_id]=cloud_speed_AB(cloud_id,c_move)
I=size(cloud_id,1);
speed_id=zeros(2288,2288);
speed=zeros(I,1);
dirt=zeros(I,1);
for i=1:I
    if ~(c_move(i,1)==0  & c_move(i,2)==0)
        c_movex=cloud_id(i,1);
        c_movey=cloud_id(i,2);
        c_x=c_movex-c_move(i,1);
        c_y=c_movey-c_move(i,2);

        [j1,w1]=xy2jingwei(c_x,c_y);
        [j2,w2]=xy2jingwei(c_movex,c_movey);
        temp=geodistance([j1,w1],[j2,w2],6);% 6坐标代号,程序中经纬度已转换
        if temp~=0
            speed(i)=temp/1800;
            x1=min([c_x,c_movex]);x2=max([c_x,c_movex]);
            y1=min([c_y,c_movey]);y2=max([c_y,c_movey]);
            speed_id(x1:x2,y1:y2)=speed_id(x1:x2,y1:y2)+1;
        else
            speed(i)=0;
        end
        % 风向
        j1=j1*(pi/180);%% 单位转换 ！！！！！！！！！ 换成弧度
        w1=w1*(pi/180);
        j2=j2*(pi/180);
        w2=w2*(pi/180);
        gm=acos(sin(w1)*sin(w2)+cos(w1)*cos(w2)*cos(j2-j1));
        wind_dirt=acos((sin(w2)-cos(gm)*sin(w1))/sin(gm)*cos(w1));
        wind_dirt=wind_dirt/(pi/180);% 换成 度!!
        if  j2>j1
            dirt(i)=wind_dirt;
        else
            dirt(i)=306-wind_dirt;
        end
    end
end
