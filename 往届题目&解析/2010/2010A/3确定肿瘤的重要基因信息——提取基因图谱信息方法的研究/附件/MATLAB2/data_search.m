function M_set=data_search(h_set)
%根据h_set中的EST找到在data1911中的列
load EST;
load data1911
M_set=[];
for i=1:1:length(h_set)
    for j=1:1:length(h)
        if strcmp(h(j),h_set(i))
            M_set(:,i)=M(:,j);
        end
    end
end
            
