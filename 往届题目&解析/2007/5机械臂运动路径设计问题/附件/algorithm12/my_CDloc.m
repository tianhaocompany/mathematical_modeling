function x=my_CDloc
% 结合演化算法和牛顿迭代法求C，D点的坐标
global P epsn
popsize=20;
k=0;
lg=0;
fval_x=1;
while fval_x>epsn||~lg
    M=my_initialize(popsize);
    fval=my_CD(M);
    [F,F_index]=sort(fval);
    num=F_index(1:5);
    M_num=M(:,num);
    fval_num=fval(num);
    [MC,MC_fval]=my_crossover(M_num,fval_num);
    [worst,index]=max(fval);
    if MC_fval<worst
        M(:,index)=MC;
        fval(index)=MC_fval;
    end
    [mi,index_flag]=min(fval);
    x=M(:,index_flag);
    lgx=1;
    while lgx
        x=my_newton(x);
        fval_x=my_CD(x);
        lgx=my_ifinregion(x);
        if fval_x<epsn
            break
        end
    end
    lg=lgx;
    k=1+k;
end