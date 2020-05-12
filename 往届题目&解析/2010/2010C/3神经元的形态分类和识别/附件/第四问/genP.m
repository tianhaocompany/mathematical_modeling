function p = genP()
p = zeros(16383,14);

for i = 1:16383
    s = dec2bin(i);
    s = num2str(s);
    t = zeros(1,14-length(s));
    s= [t s];
    for k = 1:14
        switch s(k)
            case '1'
                p(i,k) = 1;
            case '0'
                p(i,k) = 0;
        end
    end
end
