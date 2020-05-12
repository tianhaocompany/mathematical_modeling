function r = com(a,b,p)

d=0;
for i = 1:3
    for j = 1:3
        d = d + dist(i,j,a,b,p);
    end
end

r = d./9;