function [x,x_fval]=my_crossover(M,fval)
mi=-0.2;
ma=1.2;
x_fval=10;
l=0;
while ~l
    a=zeros(1,size(M,2));
    MI=mi;
    MA=ma;
    for i=1:size(M,2)-1
        a(i)=MI+rand*(MA-MI);
        MI=max(mi,MI-a(i));
        MA=min(ma,MA-a(i));
    end
    a(size(M,2))=1-sum(a);
    x=zeros(size(M,1),1);
    for i=1:size(M,2)
        x=x+a(i)*M(:,i);
    end
    flag=my_ifinregion(x);
    x_fval=my_CD(x);
    if flag==1&&(x_fval<max(fval))
        l=1;
    end
end