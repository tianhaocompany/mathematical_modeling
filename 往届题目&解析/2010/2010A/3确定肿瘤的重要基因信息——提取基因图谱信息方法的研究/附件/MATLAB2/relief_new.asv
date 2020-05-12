function [M_sorted,h_sorted]=relief_new(M,h)
[r,c]=size(M);
W=zeros(1,c);%权值
for i=1:1:r
    X=M(i,:);
    MM=[];
    NN=[];
    if i>=1&&i<=22
        for m=1:1:22;
            if m==i
                MM(m)=Inf;
                continue;
            end
            MM(m)=dist(X,M(m,:)');
        end
        [V,I]=min(MM);
        In=M(I,:);        
        for n=23:1:r
            NN(n-22)=dist(X,M(n,:)');
        end
        [VV,II]=min(NN);
        Out=M(II+22,:);
    else
        for m=1:1:22;
            MM(m)=dist(X,M(m,:)');
        end
        [V,I]=min(MM);
        Out=M(I,:);
        for n=23:1:r
            if n==i
                NN(n-22)=Inf;
                continue;                
            end
            NN(n-22)=dist(X,M(n,:)');
        end
        [VV,II]=min(NN);
        In=M(II+22,:);
    end
    for j=1:1:c
        W(j)=W(j)-(X(j)-In(j))^2/r+(X(j)-Out(j))^2/r;%更新权值，没有取绝对值
    end
end
[W_des,index]=sort(W,'descend');

M_sorted=M(:,index);
h_sorted=h(index);