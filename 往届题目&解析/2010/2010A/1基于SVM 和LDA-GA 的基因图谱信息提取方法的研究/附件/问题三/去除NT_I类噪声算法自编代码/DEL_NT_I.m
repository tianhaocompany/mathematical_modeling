function array_filterNT_I_I=DEL_NT_I(del_n,del_boundry) % 
load matlab3;
array_filterNT_I_I=zeros(2000-del_n,63);
k=1;
for i=1:2000
    if max(DATA(i,:))/min(DATA(i,:))>del_boundry
        array_filterNT_I_I(k,1:62)=DATA(i,1:62);
        array_filterNT_I_I(k,63)=i;
        k=k+1;
    end
end