function [series_numII,series_array_filterII]=NT_II(del1_num,boundryII)
load matlab_filter;
numII=2000-del1_num;
arrayII=zeros(numII,63);
arrayII(1:numII,1:63)=array_filter011(1:numII,1:63);
times=80;
series_numII=zeros(1,times);
series_array_filterII=zeros(times,numII,63);
nb=7; % 取该值时 注意“%%%%%%%%%%%%%%%%$$$$$$$$$$$$$$$$$$$$$$”处
count1=0;
for i=1:times
    k=1;
    array_temp1=zeros(numII,63);
    
    count1=count1+1;
    if count1>=20
        count1=0;
        nb=nb-1;
    end
    for j=1:numII
        aa_temp=mod(20+nb*(i-1),62);
        if aa_temp<0.01&&aa_temp>-0.01
            aa_temp=62;
        end
        %%%%%%%%%%%%%%%%$$$$$$$$$$$$$$$$$$$$$$
        if 1+mod(nb*(i-1),62)<aa_temp
            temp_V=max(arrayII(j,1+mod(nb*(i-1),62):aa_temp))/min(arrayII(j,1+mod(nb*(i-1),62):aa_temp));
        else
            temp_V=max(max(arrayII(j,1:aa_temp)),max(arrayII(j,1+mod(nb*(i-1),62):62)))/min(min(arrayII(j,1:aa_temp)),min(arrayII(j,1+mod(nb*(i-1),62):62)));
        end
        
        if temp_V>boundryII
            array_temp1(k,1:63)=arrayII(j,1:63);
            k=k+1;
        end
    end
    arrayII(1:(k-1),1:63)=array_temp1(1:(k-1),1:63);
    numII=k-1;
    series_numII(1,i)=numII;
    series_array_filterII(i,1:numII,1:63)=arrayII(1:numII,1:63);
end
array_filter_res=zeros(numII,63);
array_filter_res(1:k,1:63)=arrayII(1:k,1:63);
t=1:times;
plot(t,series_numII);