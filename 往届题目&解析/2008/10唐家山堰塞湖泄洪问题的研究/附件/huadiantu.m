clc
clear
load X710.mat
x=x4;
axis ij
hold on
for i=1:678
    for j=1:1032
        if x(i,j)==1
            plot(j,i,'r')
        end
    end
end