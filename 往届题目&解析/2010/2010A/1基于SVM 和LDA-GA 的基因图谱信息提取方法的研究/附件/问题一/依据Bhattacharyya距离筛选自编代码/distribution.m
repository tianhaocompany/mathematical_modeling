function [distribute,k,array_filter1]=distribution(array2000)
load matlab3;
distribute=zeros(1,10);
array_filter1=zeros(388,63);
k=1;
for i=1:2000
    if array2000(1,i)<0.1
        distribute(1,1)=distribute(1,1)+1;
    end
        if array2000(1,i)>=0.1&&array2000(1,i)<0.2
        distribute(1,2)=distribute(1,2)+1;
        array_filter1(k,1:62)=DATA(i,1:62);
        array_filter1(k,63)=i;
        k=k+1;
    end
        if array2000(1,i)>=0.2&&array2000(1,i)<0.3
        distribute(1,3)=distribute(1,3)+1;
                array_filter1(k,1:62)=DATA(i,1:62);
        array_filter1(k,63)=i;
        k=k+1;
    end
        if array2000(1,i)>=0.3&&array2000(1,i)<0.4
        distribute(1,4)=distribute(1,4)+1;
                array_filter1(k,1:62)=DATA(i,1:62);
        array_filter1(k,63)=i;
        k=k+1;
    end
        if array2000(1,i)>=0.4&&array2000(1,i)<0.5
        distribute(1,5)=distribute(1,5)+1;
                array_filter1(k,1:62)=DATA(i,1:62);
        array_filter1(k,63)=i;
        k=k+1;
    end
        if array2000(1,i)>=0.5&&array2000(1,i)<0.6
        distribute(1,6)=distribute(1,6)+1;
                array_filter1(k,1:62)=DATA(i,1:62);
        array_filter1(k,63)=i;
        k=k+1;
    end
        if array2000(1,i)>=0.6&&array2000(1,i)<0.7
        distribute(1,7)=distribute(1,7)+1;
                array_filter1(k,1:62)=DATA(i,1:62);
        array_filter1(k,63)=i;
        k=k+1;
    end
        if array2000(1,i)>=0.7&&array2000(1,i)<0.8
        distribute(1,8)=distribute(1,8)+1;
                array_filter1(k,1:62)=DATA(i,1:62);
        array_filter1(k,63)=i;
        k=k+1;
    end
        if array2000(1,i)>=0.8&&array2000(1,i)<0.9
        distribute(1,9)=distribute(1,9)+1;
                array_filter1(k,1:62)=DATA(i,1:62);
        array_filter1(k,63)=i;
        k=k+1;
    end
        if array2000(1,i)>=0.9
             distribute(1,10)=distribute(1,10)+1;
                     array_filter1(k,1:62)=DATA(i,1:62);
        array_filter1(k,63)=i;
        k=k+1;
         end
     end