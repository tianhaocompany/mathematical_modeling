function index_matrix=FFSMLOOP
% load matlab3;
% % 寻找前两个g1,g2
% g1=0;
% g2=0;
% max=0;
% for i=1:1415
%     if max<array2000(1,i)
%         max=array2000(1,i);
%         g1=i;
%     end
% end
% max=0;
% for i=1:1415
%     if max<array2000(1,i)&&i~=g1
%         max=array2000(1,i);
%         g2=i;
%     end
% end
% 搜寻g1，g2完毕
% 查表得
g1=190;
g2=16;
i=2;
index=zeros(1,50);
index(1,1)=g1;
index(1,2)=g2;
index_matrix=zeros(49,50);
index_matrix(1,1:50)=index(1,1:50);
% t=Bhatt(2,index);
flag_loop=0;
while i<36
    if flag_loop==0
    %%%%%%%%%%%%%%%%%%%%%%%%%
    max_i_1=0;
    max_j=0;
    index_temp1(1,1:50)=index_matrix(i-1,1:50);
    for j=1:254
        flag1=0;
        for k=1:i
            if j==index_temp1(1,k)
                flag1=1;
                break;
            end
        end
        if flag1==0
            index_temp1(1,i+1)=j;
            temp1=Bhatt(i+1,index_temp1);
            if max_i_1<temp1
                max_i_1=temp1;
                max_j=j;
            end
        end
    end
    index_temp1(1,i+1)=max_j;
    index_matrix(i,1:50)=index_temp1(1,1:50);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    index_new=zeros(1,50);
    max1=0;
    max_except_j=0;
    index_new(1,1:50)=index_matrix(i,1:50);
    for j=1:i+1
        % 第j个元素和最后一个进行交换
        index_temp2(1,1:50)=index_matrix(i,1:50);
        temp2=0;
        temp2=index_temp2(1,j);
        index_temp2(1,j)=index_temp2(1,i+1);
        index_temp2(1,i+1)=temp2;
        % index_new(1,i)=0;
        temp3=Bhatt(i,index_temp2);
        if max1<temp3
            max1=temp3;
            max_except_j=j;
        end    
    end
    temp4=0;
    temp4=index_new(1,max_except_j);
    index_new(1,max_except_j)=index_new(1,i+1);
    index_new(1,i+1)=temp4; %index_new 即为所求F'
    index_new(1,i+1)=0;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    flag_loop=0;
    if max1<=Bhatt(i,index_matrix(i-1,1:50))
        i=i+1;
    else
        index_matrix(i-1,1:50)=index_new(1,1:50);
%         index(1,1:50)=index_new(1,1:50);
        if i>2
            flag_loop=1;
            i=i-1;
        end
    end
end