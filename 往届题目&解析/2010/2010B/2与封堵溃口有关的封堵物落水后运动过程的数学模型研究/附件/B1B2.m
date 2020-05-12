function B1B2
% 2010年全国研究生数学建模B题
% 1小题2小题主要程序。用来计算模型及识别其中的系数。
% 程序分为
% a程序运行参数选择；
% b符号计算解出模型的特解；
% c选择截面积、速度、投放高度及试验数据；
% d基于包映射的二分法搜索
% 等四部分。
% 吉林大学10183003小组。2010年9月。
clc;
%程序运行参数选择
flgSharp=1; %重物形状选择。1大实心方体2大空心方体3小空心方体4小空心蜂巢5大空心蜂巢6大实心蜂巢7小实心蜂巢8大三角9小三角
flgV=1;     %重物速度选择。1代表v=0.55，2代表v=0.47，3代表v=0.4。
flgH=1;     %重物高度选择。1代表H=0，2代表H=0.05，3代表H=0.12。
flgPose=1;  %重物姿态选择。1代表平放，2代表立放，3代表竖放。
%选择说明：
% 选择1大实心方体时，flgV、flgH可任意选择。
% 选择2大空心方体3小空心方体4小空心蜂巢5大空心蜂巢6大实心蜂巢7小实心蜂巢8大三角9小三角时，
% flgV、flgH只能选择[1,1]或[2,2]，其余数据没有填入。
% 另外，选择8大三角9小三角时，flgPose只能选择1平放。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%符号计算解出模型的特解
sy=dsolve('m*D2sy=m*g-pw*g*Tj-A1*pw*c1*Dsy^2-A2*c2*Dsy','Dsy(0)=g*sqrt(2*H/g)','sy(0.04)=0');
sx=dsolve('m*D2sx=A3*pw*c3*(v-Dsx)^2+A4*c4*(v-Dsx)','Dsx(0)=0','sx(0.04)=0');
%常数部分赋值
g=9.8; %#ok<*NASGU> %重力加速度
pw=1000; %#ok<NASGU> %水密度
ps=2300; %重物密度
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%选择截面积、速度、投放高度及试验数据
if flgSharp==1
    strSharp='大实心方体' %#ok<NASGU,NOPRT> %在command windows中输出形状
    Tj=0.08*0.08*0.04; %重物体积
    if flgV==1
        v=0.55 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.08);
                A2=(0.08*0.04*4);
                A3=(0.08*0.04);
                A4=(0.08*0.08*2+0.08*0.04*2);
                %试验数据
                y55=[27,25.83333333,25.25,22.91666667,20,18.13333333,15.8,13.58333333,10.78333333,7.166666667,2.733333333,0.166666667,-0.416666667]/100;
                x55=[-1.833333333,-1.6,-1.25,-0.666666667,0.15,0.85,2.716666667,4,5.633333333,8.666666667,10.88333333,12.16666667,13.1]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.04);
                A2=(0.08*0.08*2+0.08*0.04*2);
                A3=(0.08*0.08);
                A4=(0.08*0.04*4);
                %试验数据
                y55=[27,24.66666667,22.33333333,18.83333333,15.8,12.41666667,8.333333333,5.066666667,1.216666667,0.05]/100;
                x55=[-1.95,-1.833333333,-1.6,-0.2,1.666666667,3.883333333,6.333333333,9.25,13.21666667,15.08333333]/100;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.04);
                A2=(0.08*0.08*2+0.08*0.04*2);
                A3=(0.08*0.04);
                A4=(0.08*0.08*2+0.08*0.04*2);
                %试验数据
                y55=[26.41667,24.66666667,22.56666667,19.41666667,16.5,13,8.333333333,5.416666667,2.5]/100;
                x55=[-1.25,-0.783333333,-0.666666667,-0.433333333,0.266666667,1.666666667,2.6,3.416666667,5.75]/100;
            end
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.08);
                A2=(0.08*0.04*4);
                A3=(0.08*0.04);
                A4=(0.08*0.08*2+0.08*0.04*2);
                %试验数据
                y55=[27.58333333,24.66666667,21.16666667,16.26666667,14.05,10.08333333,5.766666667,1.333333333]/100;
                x55=[0.85,2.25,3.533333333,5.866666667,6.916666667,8.783333333,11.11666667,14.26666667]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.04);
                A2=(0.08*0.08*2+0.08*0.04*2);
                A3=(0.08*0.08);
                A4=(0.08*0.04*4);
                %试验数据
                y55=[28.28333333,24.66666667,17.66666667,12.76666667,7.283333333,3.083333333]/100;
                x55=[-1.6,-0.783333333,-0.55,0.733333333,2.016666667,2.25]/100;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.04);
                A2=(0.08*0.08*2+0.08*0.04*2);
                A3=(0.08*0.04);
                A4=(0.08*0.08*2+0.08*0.04*2);
                %试验数据
                y55=[26.53333333,21.16666667,17.66666667,13,7.75,4.25,0.166666667]/100;
                x55=[-0.55,0.733333333,1.55,2.833333333,4.583333333,6.916666667,8.55]/100;
            end
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.08);
                A2=(0.08*0.04*4);
                A3=(0.08*0.04);
                A4=(0.08*0.08*2+0.08*0.04*2);
                %试验数据
                y55=[28.16666667,25.83333333,21.16666667,15.33333333,11.83333333,8.333333333,4.25,1.333333333,0.166666667]/100;
                x55=[-0.666666667,1.666666667,3.416666667,4.583333333,6.333333333,8.083333333,9.95,12.16666667,13.91666667]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.04);
                A2=(0.08*0.08*2+0.08*0.04*2);
                A3=(0.08*0.08);
                A4=(0.08*0.04*4);
                %试验数据
                y55=[26.41666667,19.41666667,14.16666667,7.75,4.25,3.083333333]/100;
                x55=[-0.083333333,0.5,1.083333333,2.25,4,5.166666667]/100;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.04);
                A2=(0.08*0.08*2+0.08*0.04*2);
                A3=(0.08*0.04);
                A4=(0.08*0.08*2+0.08*0.04*2);
                %试验数据
                y55=[26.41666667,18.25,13.58333333,7.75,3.083333333]/100;
                x55=[-1.25,-0.433333333,1.083333333,4,8.083333333]/100;
            end
        end
    end
    if flgV==2
        v=0.47 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.08);
                A2=(0.08*0.04*4);
                A3=(0.08*0.04);
                A4=(0.08*0.08*2+0.08*0.04*2);
                %试验数据
                y55=[27,25.83333333,24.08333333,22.33333333,20,17.08333333,14.75,11.25,8.333333333,4.833333333,1.333333333,-1.583333333]/100;
                x55=[-1.716666667,-1.366666667,-0.783333333,-0.433333333,1.083333333,2.25,4,5.166666667,6.916666667,8.666666667,10.76666667,11.7]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.04);
                A2=(0.08*0.08*2+0.08*0.04*2);
                A3=(0.08*0.08);
                A4=(0.08*0.04*4);
                %试验数据
                y55=[25.83333333,24.66666667,22.33333333,19.41666667,16.5,13.58333333,8.916666667,6.583333333,1.916666667]/100;
                x55=[-0.083333333,0.15,0.85,1.666666667,2.833333333,5.05,7.5,9.833333333,14.5]/100;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.04);
                A2=(0.08*0.08*2+0.08*0.04*2);
                A3=(0.08*0.04);
                A4=(0.08*0.08*2+0.08*0.04*2);
                %试验数据
                y55=[27,24.66666667,22.91666667,19.41666667,16.26666667,12.41666667,7.75,3.666666667]/100;
                x55=[-0.666666667,-0.433333333,-0.083333333,0.5,1.433333333,2.25,3.416666667,5.166666667]/100;
            end
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.08);
                A2=(0.08*0.04*4);
                A3=(0.08*0.04);
                A4=(0.08*0.08*2+0.08*0.04*2);
                %试验数据
                y55=[28.75,27,23.5,19.3,15.91666667,12.65,9.733333333,5.416666667,2.5]/100;
                x55=[-0.666666667,-0.433333333,0.266666667,0.5,2.133333333,3.766666667,5.4,7.5,8.666666667]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.04);
                A2=(0.08*0.08*2+0.08*0.04*2);
                A3=(0.08*0.08);
                A4=(0.08*0.04*4);
                %试验数据
                y55=[27.58333333,25.36666667,20,15.91666667,10.66666667,6.583333333,4.25]/100;
                x55=[-0.316666667,0.383333333,1.666666667,2.716666667,4,6.333333333,9.833333333]/100;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.04);
                A2=(0.08*0.08*2+0.08*0.04*2);
                A3=(0.08*0.04);
                A4=(0.08*0.08*2+0.08*0.04*2);
                %试验数据
                y55=[28.16666667,26.41666667,19.76666667,15.91666667,12.41666667,7.75,3.666666667]/100;
                x55=[-0.433333333,0.266666667,0.5,1.083333333,2.25,2.833333333,3.65]/100;
            end
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.08);
                A2=(0.08*0.04*4);
                A3=(0.08*0.04);
                A4=(0.08*0.08*2+0.08*0.04*2);
                %试验数据
                y55=[27.58333333,23.5,18.25,14.75,11.83333333,8.333333333,4.25,2.5,0.75]/100;
                x55=[-0.666666667,1.083333333,1.666666667,2.25,3.416666667,5.166666667,6.916666667,8.666666667,10.41666667]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.04);
                A2=(0.08*0.08*2+0.08*0.04*2);
                A3=(0.08*0.08);
                A4=(0.08*0.04*4);
                %试验数据
                y55=[25.83333333,20,14.16666667,7.75,3.083333333]/100;
                x55=[-0.083333333,1.666666667,2.6,3.416666667,4]/100;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.04);
                A2=(0.08*0.08*2+0.08*0.04*2);
                A3=(0.08*0.04);
                A4=(0.08*0.08*2+0.08*0.04*2);
                %试验数据
                y55=[27.58333333,20,14.75,10.43333333,4.833333333,3.083333333]/100;
                x55=[-0.666666667,0.5,1.433333333,1.783333333,2.833333333,3.183333333]/100;
            end
        end
    end
    if flgV==3
        v=0.4 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.08);
                A2=(0.08*0.04*4);
                A3=(0.08*0.04);
                A4=(0.08*0.08*2+0.08*0.04*2);
                %试验数据
                y55=[27.58333333,23.5,19.41666667,15.33333333,11.25,7.75,3.666666667,1.333333333]/100;
                x55=[-0.083333333,0.733333333,1.666666667,2.833333333,4,5.166666667,6.333333333,8.666666667]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.04);
                A2=(0.08*0.08*2+0.08*0.04*2);
                A3=(0.08*0.08);
                A4=(0.08*0.04*4);
                %试验数据
                y55=[27,25.83333333,24.43333333,20,17.08333333,13.58333333,10.08333333,7.166666667,2.5,0.166666667]/100;
                x55=[-1.6,-1.25,-0.9,-0.666666667,-0.083333333,1.9,4,5.75,8.666666667,10.41666667]/100;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.04);
                A2=(0.08*0.08*2+0.08*0.04*2);
                A3=(0.08*0.04);
                A4=(0.08*0.08*2+0.08*0.04*2);
                %试验数据
                y55=[27,20,16.5,10.9,4.6,3.433333333]/100;
                x55=[-0.083333333,0.266666667,0.616666667,1.666666667,2.6,2.833333333]/100;
            end
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.08);
                A2=(0.08*0.04*4);
                A3=(0.08*0.04);
                A4=(0.08*0.08*2+0.08*0.04*2);
                %试验数据
                y55=[27,22.91666667,18.83333333,15.33333333,10.66666667,8.916666667,4.833333333,1.333333333,0.75]/100;
                x55=[-1.25,-0.666666667,-0.083333333,1.083333333,2.25,3.416666667,5.166666667,6.333333333,7.5]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.04);
                A2=(0.08*0.08*2+0.08*0.04*2);
                A3=(0.08*0.08);
                A4=(0.08*0.04*4);
                %试验数据
                y55=[28.16666667,24.08333333,18.83333333,14.16666667,9.5,4.833333333,1.45]/100;
                x55=[-1.716666667,-0.666666667,-0.083333333,1.666666667,4,6.333333333,8.9]/100;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=(0.08*0.04);
                A2=(0.08*0.08*2+0.08*0.04*2);
                A3=(0.08*0.04);
                A4=(0.08*0.08*2+0.08*0.04*2);
                %试验数据
                y55=[28.16666667,25.83333333,20,16.5,10.66666667,6.583333333,3.083333333]/100;
                x55=[-1.25,-0.666666667,-0.083333333,0.266666667,1.083333333,1.666666667,2.483333333]/100;
            end
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
    end
end
if flgSharp==2
    strSharp='大空心方体' %#ok<NASGU,NOPRT> %在command windows中输出形状
    Tj=(0.08*0.08-0.04*0.04)*0.04; %重物体积
    if flgV==1
        v=0.55 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0048;	
                A2=0.0128;
                A3=0.0032;	
                A4=0.016;
                %试验数据
                y55=[28.05,27,24.55,22.91666667,18.95,16.73333333,15.56666667,13,8.333333333,3.783333333,1.216666667,-0.416666667]/100;
                x55=[-1.95,-1.716666667,-1.25,-0.433333333,1.083333333,2.25,4.233333333,6.916666667,8.666666667,12.05,14.5,16.48333333]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0032;	
                A2=0.016;	
                A3=0.0048;	
                A4=0.0128;
                %试验数据
                y55=[27,24.66666667,23.5,20.58333333,18.83333333,16.5,13,8.916666667,6.233333333,3.9,3.083333333,2.5,1.916666667,1.333333333,0.283333333]/100;
                x55=[-2.3,-1.95,-1.716666667,-1.483333333,-0.666666667,0.266666667,2.833333333,5.75,6.566666667,8.433333333,8.9,11.11666667,13.68333333,15.43333333,17.41666667]/100;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0032;	
                A2=0.016;	
                A3=0.0032;	
                A4=0.016;
                %试验数据
                y55=[27.58333333,25.83333333,23.5,21.4,18.83333333,16.5,13,10.55,4.6,2.616666667]/100;
                x55=[-1.833333333,-1.716666667,-1.6,-1.25,-0.083333333,0.5,1.783333333,3.3,5.166666667,6.916666667]/100;
            end
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
    end
    if flgV==2
        v=0.47 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0048;
                A2=0.0128;
                A3=0.0032;
                A4=0.016;
                %试验数据
                y55=[28.75,25.25,21.16666667,17.66666667,14.16666667,9.966666667,7.166666667,4.016666667,0.75]/100;
                x55=[-0.55,0.033333333,1.083333333,1.666666667,4,5.516666667,6.916666667,8.083333333,10.06666667]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0032;	
                A2=0.016;	
                A3=0.0048;	
                A4=0.0128;
                %试验数据
                y55=[28.75,25.25,20.58333333,17.66666667,14.16666667,9.5,4.833333333,4.25]/100;
                x55=[-0.666666667,-0.316666667,0.5,1.666666667,2.833333333,3.766666667,4.816666667,5.75]/100;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0032;	
                A2=0.016;	
                A3=0.0032;	
                A4=0.016;
                %试验数据
                y55=[28.75,25.6,21.16666667,15.91666667,14.16666667,10.08333333,6.466666667,3.083333333]/100;
                x55=[1.083333333,1.316666667,1.666666667,2.6,3.416666667,4.7,6.916666667,8.083333333]/100;
            end
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
    end
    if flgV==3
        v=0.4 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
        return;
    end
end
if flgSharp==3
    strSharp='小空心方体' %#ok<NASGU,NOPRT> %在command windows中输出形状
    Tj=(0.04*0.04-0.02*0.02)*0.02; %重物体积
    if flgV==1
        v=0.55 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0012;	
                A2=0.0048;	
                A3=0.0008;	
                A4=0.004;
                %试验数据
                y55=[28.75,27,24.55,22.45,20.58333333,18.83333333,15.91666667,11.83333333,8.333333333,5.416666667,1.333333333,-0.416666667,-1]/100;
                x55=[-1.833333333,-1.483333333,-0.55,2.716666667,4.7,7.616666667,10.41666667,13.33333333,15.9,18,20.33333333,22.66666667,22.9]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0008;	
                A2=0.004;	
                A3=0.0012;	
                A4=0.0048;
                %试验数据
                y55=[28.16666667,27,25.25,23.5,22.33333333,18.83333333,17.66666667,14.16666667,10.66666667,8.333333333,6,2.5,0.4,-1]/100;
                x55=[-2.3,-1.95,-1.133333333,-0.666666667,0.5,2.833333333,4.583333333,7.5,9.833333333,11.58333333,13.33333333,15.78333333,16.6,18]/100;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0008;	
                A2=0.004;	
                A3=0.0008;	
                A4=0.004;
                %试验数据
                y55=[28.75,27.58333333,25.83333333,24.78333333,22.33333333,21.16666667,19.65,15.91666667,11.83333333,8.333333333,5.183333333,2.5,0.166666667]/100;
                x55=[-1.833333333,-1.483333333,-1.483333333,-0.433333333,0.5,1.666666667,2.25,4.583333333,7.5,8.9,10.06666667,12.16666667,15.2]/100;
            end
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
    end
    if flgV==2
        v=0.47 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0012;	
                A2=0.0048;	
                A3=0.0008;	
                A4=0.004;
                %试验数据
                y55=[26.41666667,22.91666667,20.46666667,16.5,12.41666667,10.08333333,6.583333333,3.083333333,0.166666667,-1.583333333]/100;
                x55=[-1.25,-0.083333333,0.5,2.833333333,5.166666667,6.333333333,9.25,10.06666667,11.93333333,13.68333333]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0008;	
                A2=0.004;	
                A3=0.0012;	
                A4=0.0048;
                %试验数据
                y55=[28.75,24.66666667,21.75,18.25,15.56666667,12.18333333,10.08333333,7.283333333,4.833333333,2.5,0.166666667]/100;
                x55=[-0.083333333,0.5,1.433333333,2.366666667,4,5.166666667,6.333333333,8.666666667,9.833333333,11,12.16666667]/100;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0008;	
                A2=0.004;	
                A3=0.0008;	
                A4=0.004;
                %试验数据
                y55=[27,23.03333333,18.25,15.33333333,13,10.43333333,7.75,4.833333333,2.5,0.166666667]/100;
                x55=[0.033333333,0.5,2.25,3.533333333,5.75,7.5,9.833333333,11.23333333,13.33333333,15.66666667]/100;
            end
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
    end
    if flgV==3
        v=0.4 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
        return;
    end
end
if flgSharp==4
    strSharp='小空心蜂巢' %#ok<NASGU,NOPRT> %在command windows中输出形状
    Tj=0.001133125*0.012; %重物体积
    if flgV==1
        v=0.55 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.001133125;	
                A2=0.002742;	
                A3=0.0006;	
                A4=0.00330546;
                %试验数据
                y55=[28.75,26.41666667,24.31666667,22.91666667,20.35,16.5,14.28333333,11.83333333,9.616666667,7.516666667,5.416666667,3.666666667,1.333333333,-1,-2.166666667]/100;
                x55=[-1.95,-0.55,0.266666667,1.316666667,3.3,6.45,7.85,11.58333333,12.51666667,15.43333333,18,20.91666667,23.6,26.16666667,28.26666667]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0006;	
                A2=0.00330546;	
                A3=0.001133125;	
                A4=0.002742;
                %试验数据
                y55=[28.75,27.35,25.83333333,23.5,21.75,20,18.01666667,15.91666667,14.16666667,11.83333333,10.08333333,7.75,6,3.666666667,1.916666667,-0.766666667,-1.816666667,-2.05]/100;
                x55=[-3.466666667,-3,-2.183333333,-1.6,0.616666667,2.833333333,4.7,7.383333333,9.6,11.93333333,14.61666667,17.41666667,19.75,22.43333333,24.65,27.56666667,29.08333333,31.41666667]/100;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0006;	
                A2=0.00330546;	
                A3=0.0005196;	
                A4=0.00466626;
                %试验数据
                y55=[28.75,27.35,25.83333333,23.5,21.16666667,15.33333333,12.65,10.08333333,7.166666667,3.666666667,0.166666667,-1]/100;
                x55=[-2.183333333,-1.833333333,-1.483333333,-0.783333333,1.433333333,2.483333333,4.116666667,6.333333333,8.666666667,10.53333333,13.1,14.5]/100;
            end
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
    end
    if flgV==2
        v=0.47 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.001133125;	
                A2=0.002742;	
                A3=0.0006;	
                A4=0.00330546;
                %试验数据
                y55=[28.75,26.41666667,24.31666667,22.91666667,20.35,16.5,14.28333333,11.83333333,9.616666667,7.516666667,5.416666667,3.666666667,1.333333333,-1,-2.166666667]/100;
                x55=[-1.95,-0.55,0.266666667,1.316666667,3.3,6.45,7.85,11.58333333,12.51666667,15.43333333,18,20.91666667,23.6,26.16666667,28.26666667]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0006;	
                A2=0.00330546;	
                A3=0.001133125;	
                A4=0.002742;
                %试验数据
                y55=[28.75,27.35,25.83333333,23.5,21.75,20,18.01666667,15.91666667,14.16666667,11.83333333,10.08333333,7.75,6,3.666666667,1.916666667,-0.766666667,-1.816666667,-2.05]/100;
                x55=[-3.466666667,-3,-2.183333333,-1.6,0.616666667,2.833333333,4.7,7.383333333,9.6,11.93333333,14.61666667,17.41666667,19.75,22.43333333,24.65,27.56666667,29.08333333,31.41666667]/100;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0006;	
                A2=0.00330546;	
                A3=0.0005196;	
                A4=0.00466626;
                %试验数据
                y55=[28.75,27.35,25.83333333,23.5,21.16666667,15.33333333,12.65,10.08333333,7.166666667,3.666666667,0.166666667,-1]/100;
                x55=[-2.183333333,-1.833333333,-1.483333333,-0.783333333,1.433333333,2.483333333,4.116666667,6.333333333,8.666666667,10.53333333,13.1,14.5]/100;
            end
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
    end
    if flgV==3
        v=0.4 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
        return;
    end
end
if flgSharp==5
    strSharp='大空心蜂巢' %#ok<NASGU,NOPRT> %在command windows中输出形状
    Tj=0.0045325*0.025; %重物体积
    if flgV==1
        v=0.55 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0045325;	
                A2=0.0075;	
                A3=0.0025;	
                A4=0.013395;
                %试验数据
                y55=[27.58333333,26.18333333,24.66666667,23.03333333,21.05,19.41666667,16.38333333,14.75,11.71666667,8.916666667,7.05,2.5,0.166666667,-1]/100;
                x55=[-1.25,-0.9,-0.433333333,0.966666667,2.483333333,3.883333333,6.916666667,9.25,10.53333333,13.33333333,14.03333333,16.95,19.16666667,20.56666667]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0025;	
                A2=0.013395;	
                A3=0.0045325;	
                A4=0.011425;
                %试验数据
                y55=[27.7,27,26.18333333,23.5,20.58333333,18.01666667,15.33333333,12.3,9.85,7.4,4.833333333,2.383333333,-0.416666667,-0.766666667]/100;
                x55=[-0.783333333,-0.666666667,-0.316666667,0.5,2.25,4.816666667,7.266666667,10.41666667,12.51666667,14.38333333,16.71666667,18.58333333,21.5,22.66666667]/100;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0025;	
                A2=0.013395;	
                A3=0.002165;
                A4=0.01609;
                %试验数据
                y55=[27,25.83333333,24.66666667,21.75,19.41666667,16.5,13,11.01666667,9.5,6,3.083333333,0.166666667,-1]/100;
                x55=[-0.666666667,-0.316666667,0.266666667,1.083333333,2.25,3.416666667,5.166666667,6.566666667,7.5,12.05,13.33333333,15.31666667,16.83333333]/100;
            end
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
    end
    if flgV==2
        v=0.47 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0045325;	
                A2=0.0075;	
                A3=0.0025;	
                A4=0.013395;
                %试验数据
                y55=[27.93333333,24.31666667,22.33333333,18.25,16.5,14.75,10.08333333,7.75,4.133333333,1.333333333,-1]/100;
                x55=[1.083333333,2.25,2.833333333,4,5.75,6.916666667,8.666666667,9.833333333,12.4,14.5,16.83333333]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0025;	
                A2=0.013395;	
                A3=0.0045325;	
                A4=0.011425;
                %试验数据
                y55=[26.41666667,21.16666667,18.25,14.16666667,8.333333333,5.416666667,3.083333333]/100;
                x55=[-0.666666667,-0.083333333,1.666666667,3.416666667,5.75,7.5,9.6]/100;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0025;	
                A2=0.013395;	
                A3=0.002165;	
                A4=0.01609;
                %试验数据
                y55=[28.16666667,24.08333333,20.58333333,16.5,13,8.683333333,4.833333333]/100;
                x55=[1.083333333,1.666666667,2.133333333,2.95,4.233333333,5.516666667,6.916666667]/100;
            end
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
    end
    if flgV==3
        v=0.4 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
        return;
    end
end
if flgSharp==6
    strSharp='大实心蜂巢' %#ok<NASGU,NOPRT> %在command windows中输出形状
    Tj=0.006495*0.025; %重物体积
    if flgV==1
        v=0.55 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.006495;	
                A2=0.0075;	
                A3=0.0025;	
                A4=0.01732;
                %试验数据
                y55=[28.16666667,27.58333333,24.78333333,22.33333333,21.16666667,19.41666667,16.96666667,15.33333333,12.53333333,9.733333333,6.583333333,3.783333333,0.75,-0.766666667]/100;
                x55=[-1.25,-0.9,-0.083333333,1.666666667,1.666666667,3.416666667,5.75,7.5,10.88333333,12.75,15.66666667,18.58333333,21.85,24.76666667]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0025;	
                A2=0.01732;	
                A3=0.006495;	
                A4=0.0075;
                %试验数据
                y55=[26.41666667,25.83333333,24.2,22.45,20,16.73333333,15.45,13.11666667,11.25,8.333333333,5.533333333,2.5,0.166666667,-0.533333333]/100;
                x55=[-1.833333333,-1.833333333,-1.25,-0.9,0.033333333,2.95,5.166666667,7.5,9.833333333,12.28333333,16.36666667,19.16666667,21.38333333,22.9]/100;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0025;	
                A2=0.01732;	
                A3=0.002165;	
                A4=0.01799;
                %试验数据
                y55=[27.58333333,25.95,23.5,20.23333333,16.73333333,12.3,6.233333333,3.2]/100;
                x55=[-1.25,-0.783333333,-0.55,0.033333333,0.616666667,1.9,2.6,3.883333333]/100;
            end
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
    end
    if flgV==2
        v=0.47 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.006495;	
                A2=0.0075;	
                A3=0.0025;	
                A4=0.01732;
                %试验数据
                y55=[27,24.08333333,22.91666667,19.41666667,16.5,14.75,12.06666667,9.5,6.583333333,3.083333333,0.05]/100;
                x55=[-0.083333333,0.5,0.966666667,1.666666667,3.416666667,5.166666667,6.333333333,8.083333333,11,13.1,15.43333333]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0025;	
                A2=0.01732;	
                A3=0.006495;	
                A4=0.0075;
                %试验数据
                y55=[28.16666667,24.66666667,19.41666667,14.16666667,9.733333333,4.833333333,1.566666667]/100;
                x55=[-0.2,0.266666667,0.85,2.833333333,6.1,10.06666667,15.08333333]/100;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0025;	
                A2=0.01732;	
                A3=0.002165;	
                A4=0.01799;
                %试验数据
                y55=[27.58333333,24.66666667,19.41666667,14.75,11.25,6.233333333,2.5]/100;
                x55=[-0.083333333,0.266666667,0.5,1.2,2.25,3.65,5.166666667]/100;
            end
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
    end
    if flgV==3
        v=0.4 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
        return;
    end
end
if flgSharp==7
    strSharp='小实心蜂巢' %#ok<NASGU,NOPRT> %在command windows中输出形状
    Tj=0.00162375*0.012; %重物体积
    if flgV==1
        v=0.55 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.00162375;	
                A2=0.0018;	
                A3=0.0006;	
                A4=0.0042867;
                %试验数据
                y55=[28.75,28.16666667,27,24.78333333,23.03333333,21.16666667,18.01666667 ,15.33333333,11.95,9.5,6.583333333,3.083333333,1.45,-1.233333333]/100;
                x55=[-2.883333333,-2.416666667,-1.833333333,-1.133333333,-0.083333333,2.25,5.05,6.916666667,9.25,12.05,13.56666667,15.66666667,16.83333333,18.23333333]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0006;	
                A2=0.0042867;	
                A3=0.00162375;	
                A4=0.0018;
                %试验数据
                y55=[28.16666667,26.41666667,25.25,22.91666667,21.16666667,18.95,14.28333333,10.78333333,8.916666667,5.883333333,3.083333333,0.05,-1.583333333]/100;
                x55=[-2.066666667,-1.716666667,-1.25,-0.083333333,2.25,4.933333333,10.76666667,11.11666667,13.56666667,15.08333333,16.83333333,18.23333333,19.28333333]/100;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0006;	
                A2=0.0042867;	
                A3=0.0005196;	
                A4=0.0056475;
                %试验数据
                y55=[28.75,27.58333333,26.41666667,23.73333333,18.83333333,16.5,11.83333333,8.333333333,6.583333333,3.9,0.75,-1.583333333,-2.05]/100;
                x55=[-1.833333333,-1.6,-1.25,-0.783333333,-0.083333333,0.5,2.25,4.583333333,5.75,6.566666667,8.666666667,10.3,12.16666667]/100;
            end
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
    end
    if flgV==2
        v=0.47 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.00162375;	
                A2=0.0018;	
                A3=0.0006;	
                A4=0.0042867;
                %试验数据
                y55=[27.58333333,25.6,21.98333333,18.25,15.33333333,12.06666667,8.916666667,6.583333333,4.25,0.166666667,-1.583333333]/100;
                x55=[-0.9,-0.433333333,1.083333333,3.183333333,5.4,7.733333333,9.6,11,12.16666667,13.33333333,13.91666667]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0006;	
                A2=0.0042867;	
                A3=0.00162375;	
                A4=0.0018;
                %试验数据
                y55=[26.53333333,24.08333333,15.33333333,8.916666667,5.416666667,2.5,0.166666667]/100;
                x55=[-0.666666667,0.5,1.9,5.75,10.41666667,15.66666667,18]/100;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0006;	
                A2=0.0042867;	
                A3=0.0005196;	
                A4=0.0056475;
                %试验数据
                y55=[27,21.16666667,17.2,10.9,3.666666667,0.166666667]/100;
                x55=[-1.366666667,-1.016666667,-0.083333333,0.733333333,1.783333333,4]/100;
            end
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
    end
    if flgV==3
        v=0.4 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
        return;
    end
end
if flgSharp==8
    strSharp='大三角' %#ok<NASGU,NOPRT> %在command windows中输出形状
    Tj=0.117851*0.06^3; %重物体积
    if flgV==1
        v=0.55 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0015588;	
                A2=0.0015588;	
                A3=0.0015588;	
                A4=0.0015588;
                %试验数据
                y55=[28.16666667,27.23333333,26.76666667,24.66666667,23.15,22.33333333,20,15.91666667,14.16666667,11.83333333,10.66666667,8.333333333,6,4.833333333,2.266666667,0.166666667]/100;
                x55=[-1.25,-0.9,-0.666666667,0.5,1.2,2.833333333,5.75,9.6,12.75,15.66666667,17.53333333,20.33333333,23.83333333,26.16666667,29.2,31.18333333]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
                strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
                return;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
                strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
                return;
            end
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
    end
    if flgV==2
        v=0.47 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0015588;	
                A2=0.0015588;	
                A3=0.0015588;	
                A4=0.0015588;
                %试验数据
                y55=[27.58333333,25.25,21.16666667,17.66666667,15.33333333,12.41666667,10.08333333,7.516666667,4.833333333,3.083333333,1.916666667,0.75]/100;
                x55=[-0.55,-0.083333333,2.25,4.583333333,5.75,7.733333333,10.41666667,12.86666667,15.66666667,18.58333333,21.5,23.83333333]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
                strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
                return;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
                strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
                return;
            end
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
    end
    if flgV==3
        v=0.4 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
        return;
    end
end
if flgSharp==9
    strSharp='小三角' %#ok<NASGU,NOPRT> %在command windows中输出形状
    Tj=0.117851*0.03^3; %重物体积
    if flgV==1
        v=0.55 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0003897;
                A2=0.0003897;
                A3=0.0003897;
                A4=0.0003897;
                %试验数据
                y55=[28.75,27.11666667,26.06666667,25.36666667,23.73333333,21.16666667,19.3,17.08333333,15.33333333,14.16666667,11.25,9.5,8.333333333,6,4.366666667,2.5,1.216666667,-0.416666667]/100;
                x55=[-2.416666667,-1.716666667,-0.666666667,0.616666667,2.6,6.333333333,9.25,11,13.33333333,14.5,19.16666667,21.5,24.41666667,26.51666667,28.73333333,32.7,34.56666667,37.13333333]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
                strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
                return;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
                strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
                return;
            end
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
    end
    if flgV==2
        v=0.47 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                A1=0.0003897;
                A2=0.0003897;
                A3=0.0003897;
                A4=0.0003897;
                %试验数据
                y55=[26.41666667,22.33333333,20,17.9,16.73333333,15.33333333,13,10.66666667,9.5,7.166666667,6,3.9,2.5,1.333333333,-0.416666667]/100;
                x55=[-0.666666667,1.083333333,3.416666667,5.283333333,6.566666667,9.716666667,11,13.1,13.91666667,16.25,16.83333333,18.23333333,19.16666667,20.56666667,22.08333333]/100;
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
                strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
                return;
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
                strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
                return;
            end
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
            return;
        end
    end
    if flgV==3
        v=0.4 %#ok<NASGU,NOPRT> %在command windows中输出速度
        if flgH==1
            H=0 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        if flgH==2
            H=0.05 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        if flgH==3
            H=0.12 %#ok<NASGU,NOPRT> %在command windows中输出投放高度
            if flgPose==1
                strPose='平放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==2
                strPose='立放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
            if flgPose==3
                strPose='竖放' %#ok<NASGU,NOPRT> %在command windows中输出姿态
                %各面截面积
                %试验数据
            end
        end
        strWarnning='！！数据未填入！！' %#ok<NOPRT,NASGU>
        return;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%重物质量计算
m=ps*Tj; %#ok<NASGU> 
%将上述各个参数代入模型
sy=subs(sy);
sx=subs(sx);
%试验数据坐标平移%因照相机位置数据失真处理在execl中，不在此处。上述数据都是处理后的。
s0=y55(1)-y55; %纵向数据
r0=x55-x55(1); %横向数据
%基于包映射的二分法搜索
%纵向搜索
elim=0.000001;
c1l=0; %c1搜索范围左端
c1r=2; %c1搜索范围右端
c2l=0; %c2搜索范围左端
c2r=0.1; %c2搜索范围右端
pt1x=c1l;
pt1y=c2l;
pt3x=c1r;
pt3y=c2r;
for i=1:20
    pt2x=pt3x;
    pt2y=pt1y;
    pt4x=pt1x;
    pt4y=pt3y;
    pt9x=(pt1x+pt3x)/2;
    pt9y=(pt1y+pt3y)/2;
    pt5x=(pt1x+pt9x)/2;
    pt5y=(pt1y+pt9y)/2;
    pt6x=(pt2x+pt9x)/2;
    pt6y=(pt2y+pt9y)/2;
    pt7x=(pt3x+pt9x)/2;
    pt7y=(pt3y+pt9y)/2;
    pt8x=(pt4x+pt9x)/2;
    pt8y=(pt4y+pt9y)/2;
    j5=fun(sy,pt5x,pt5y,s0);
    j6=fun(sy,pt6x,pt6y,s0);
    j7=fun(sy,pt7x,pt7y,s0);
    j8=fun(sy,pt8x,pt8y,s0);
    [Jmin,minI]=min([j5,j6,j7,j8]);
    if Jmin<elim
        break;
    end
    if minI==1
        pt3x=pt9x;
        pt3y=pt9y;
    end
    if minI==2
        pt1x=(pt1x+pt2x)/2;
        pt1y=(pt1y+pt2y)/2;
        pt3x=(pt2x+pt3x)/2;
        pt3y=(pt2y+pt3y)/2;
    end
    if minI==3
        pt1x=pt9x;
        pt1y=pt9y;
    end
    if minI==4
        pt1x=(pt1x+pt4x)/2;
        pt1y=(pt1y+pt4y)/2;
        pt3x=(pt4x+pt3x)/2;
        pt3y=(pt4y+pt3y)/2;
    end
   
end
c1=pt9x %#ok<NOPRT> %在command windows中输出参数c1
c2=pt9y %#ok<NOPRT> %在command windows中输出参数c2
%画出此参数下的纵向示意图
sy=subs(sy,{'c1','c2'},{c1,c2});
sy=subs(sy,'t',0.04:0.04:0.04*length(s0));
plot(0.04:0.04:0.04*length(s0),sy);
hold on;
plot(0.04:0.04:0.04*length(s0),s0,'+');
%横向搜索
elim=0.000001;
c3l=0; %c3搜索范围左端
c3r=2; %c3搜索范围右端
c4l=0; %c4搜索范围左端
c4r=0.1; %c4搜索范围右端
pt1x=c3l;
pt1y=c4l;
pt3x=c3r;
pt3y=c4r;
for i=1:20
    pt2x=pt3x;
    pt2y=pt1y;
    pt4x=pt1x;
    pt4y=pt3y;
    pt9x=(pt1x+pt3x)/2;
    pt9y=(pt1y+pt3y)/2;
    pt5x=(pt1x+pt9x)/2;
    pt5y=(pt1y+pt9y)/2;
    pt6x=(pt2x+pt9x)/2;
    pt6y=(pt2y+pt9y)/2;
    pt7x=(pt3x+pt9x)/2;
    pt7y=(pt3y+pt9y)/2;
    pt8x=(pt4x+pt9x)/2;
    pt8y=(pt4y+pt9y)/2;
    k5=fun2(sx,pt5x,pt5y,r0);
    k6=fun2(sx,pt6x,pt6y,r0);
    k7=fun2(sx,pt7x,pt7y,r0);
    k8=fun2(sx,pt8x,pt8y,r0);
    [Jmin,minI]=min([k5,k6,k7,k8]);
    if Jmin<elim
        break;
    end
    if minI==1
        pt3x=pt9x;
        pt3y=pt9y;
    end
    if minI==2
        pt1x=(pt1x+pt2x)/2;
        pt1y=(pt1y+pt2y)/2;
        pt3x=(pt2x+pt3x)/2;
        pt3y=(pt2y+pt3y)/2;
    end
    if minI==3
        pt1x=pt9x;
        pt1y=pt9y;
    end
    if minI==4
        pt1x=(pt1x+pt4x)/2;
        pt1y=(pt1y+pt4y)/2;
        pt3x=(pt4x+pt3x)/2;
        pt3y=(pt4y+pt3y)/2;
    end
end
c3=pt9x %#ok<NOPRT> %在command windows中输出参数c3
c4=pt9y %#ok<NOPRT> %在command windows中输出参数c4
%画出此参数下的横向示意图
sx=subs(sx,{'c3','c4'},{c3,c4});
sx=subs(sx,'t',0.04:0.04:0.04*length(r0));
plot(0.04:0.04:0.04*length(r0),sx);
hold on;
plot(0.04:0.04:0.04*length(r0),r0,'*');
hold off;
%得出对应具体c1、c2的识别性能指标
function j=fun(s,c1,c2,s0) %#ok<INUSL>
s=subs(s);%将c1、c2代入纵向模型
s=subs(s,'t',0.04:0.04:0.04*length(s0));%将t序列代入模型
j=(s-s0)*(s-s0)';%识别性能指标为二次平方和
j=vpa(j);
j=double(j);
%得出对应具体c3、c4的识别性能指标
function k=fun2(r,c3,c4,r0) %#ok<INUSL>
r=subs(r);%将c3、c4代入横向模型
r=subs(r,'t',0.04:0.04:0.04*length(r0));%将t序列代入模型
k=(r-r0)*(r-r0)';%识别性能指标为二次平方和
k=vpa(k);
k=double(k);
