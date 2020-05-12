function NewZ = CorrectZround( Zdata )
% 对测量初始Z数据进行修正
% 将Z数据四舍五入保留四位小数
%
% 输入：
%     Zdata: *.dat文件中的z坐标
% 输出：
%     NewZ：修正后的z坐标，具有四位小数
%   
%     例如：
%          Zdata = [0.139449,0.139469,0.139549];
%          CorrectZround( Zdata )
%
%     将会输出：
%          0.1394 0.1395 0.1395
%        

NewZ = round(fix(Zdata * 1e5)/10)/1e4;

end