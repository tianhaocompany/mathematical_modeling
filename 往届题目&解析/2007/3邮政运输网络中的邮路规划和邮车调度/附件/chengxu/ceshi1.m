clear
%global path   %path 为路径，pn为并行方案
global  n distance
 n=4
   %load D2 distance
   load data_D data_D
   distance=data_D;
   cities = max(size(distance));
   temp=zeros(cities+n);
   temp(1:cities,1:cities)=distance;
  for i=1:n
    temp(cities+i,:)=[distance(1,:),ones(1,n)*9999];
    temp(cities+i,1)=9999;
    temp(:,cities+i)=temp(cities+i,:)';
  end
   distance=temp;
  [m,pn]=size(distance);
path=[1	6	18	5	26	11	23	12	13	14	15	21	17	16	25	3	2	...
    22	4	24	10	8	19	20	9	7];
 D2_fitness_1(path)