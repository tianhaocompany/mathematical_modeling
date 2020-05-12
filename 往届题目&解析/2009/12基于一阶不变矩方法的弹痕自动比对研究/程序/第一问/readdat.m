function [ x,y,z ] = readdat( filename )
% 读取题目中给出的 *.dat 文件，并对z坐标进行有效数字修正
% 输入:
%       filename  --- 文件名
% 输出:
%       x: 数据的x坐标
%       y: 数据的y坐标 
%       z: 数据的z坐标，经过有效数字位数的修正，保留了4位小数
%  

% By Liu Yu
% 2009 - 9 - 19 

fid = fopen( filename, 'r' );
if -1 == fid
    error('Wrong file type or file not exist!')
end

% Read file
s = fscanf(fid,'%g %g %g ' , [3,inf] );
fclose(fid);
s = s';
x = s(:,1);
y = s(:,2);
z = CorrectZround( s(:,3) );

