function [c1]=filter(c1)
%ÂË²¨´¦Àí
thegma=std(reshape(c1,1,[]));
[m,n]=size(c1);

M=5;
N=5;
for mm=1:m
    for nn=1:n
        time_matrix=c1(max(mm-5,1):min(mm+5,m),max(nn-5,1):min(nn+5,n));
        sum_matrix=time_matrix(time_matrix>c1(mm,nn)-2*thegma & ...
                       time_matrix<c1(mm,nn)+2*thegma);
        if numel(sum_matrix)>min(M+1,N+1)
        c1(mm,nn)=sum(sum_matrix)/numel(sum_matrix);
        else
            c1(mm,nn)=mean(time_matrix(:));
            sum_matrix=time_matrix(time_matrix>c1(mm,nn)-2*thegma & ...
                       time_matrix<c1(mm,nn)+2*thegma);
            c1(mm,nn)=sum(sum_matrix)/numel(sum_matrix);
        end
    end
end
