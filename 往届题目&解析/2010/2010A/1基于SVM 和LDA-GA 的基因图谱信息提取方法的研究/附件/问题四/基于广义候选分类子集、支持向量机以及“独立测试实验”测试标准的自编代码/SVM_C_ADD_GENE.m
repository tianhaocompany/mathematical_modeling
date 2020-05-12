function [error_times_test]=SVM_C
load matlab_data_after_filter02;
y=zeros(40,1);
yt=zeros(22,1);
for i1=1:14
    y(i1,1)=-1;
end
for i2=15:40
    y(i2,1)=1;
end
for i3=1:8
    yt(i3,1)=-1;
end
for i4=9:22
    yt(i4,1)=1;
end
test_result=zeros(22,35);
test_mse=zeros(3,35);
error_times_test=zeros(35,1);
for i=2:36
    x=zeros(40,i+1);
    for j=1:i+1
        x(1:14,j)=(DATA(result_add(i-1,j),1:14))';
        x(15:40,j)=(DATA(result_add(i-1,j),23:48))';
    end
    %%%%%%%%%%%%%代入libsvm函数svm_train训练支持向量机分类器%%%%%%%%%%%%%%%
    cmd=['-s 0'];
    % cmd=['-c ',num2str(C),' -g ',num2str(s),' -s 3 ' ,'-p ',num2str(e)];
    model=svmtrain(y,x,cmd);
    %%%%%%%%%%%%测试集检验%%%%%%%%%%%%%%%%%%%%
    xt=zeros(22,i+1);
    for k=1:i+1
        xt(1:8,k)=(DATA(result_add(i-1,k),15:22))';
        xt(9:22,k)=(DATA(result_add(i-1,k),49:62))';
    end
    [test_result(:,i-1),test_mse(:,i-1)]=svmpredict(yt,xt,model);
    for m=1:22
        error_times_test(i-1,1)=error_times_test(i-1,1)+0.5*abs(test_result(m,i-1)-yt(m,1));
    end
%     test_mse(1,i-1)=a;
end