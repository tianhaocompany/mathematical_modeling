function A = ReadSWC(filename)
fid = fopen(filename);
A.data = [];
A.p = 1;
cnt = 1;
while ~feof(fid)
    fline = fgetl(fid);
    if fline(1) == '#'
        if findstr(fline, '%')
            p = fline(6:12);
            p = str2num(p);
            A.p = p .* 0.01;
        end
        continue;
    end
    A.data(cnt,:) = str2num(fline);
    cnt = cnt + 1;
end
    
    
            
