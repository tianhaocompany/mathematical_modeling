function error_times=SVM_C_LOOCV
load matlab3;
y=zeros(40,1);
for i1=1:14
    y(i1,1)=-1;
end
for i2=15:40
    y(i2,1)=1;
end
error_times=zeros(35,1);
for i=2:36
    x=zeros(40,i);
    for j=1:i
         x(1:14,j)=(DATA(result(i-1,j),1:14))';
         x(15:40,j)=(DATA(result(i-1,j),23:48))';
    end
    
    for k=1:40
        x1=zeros(40,i);
        x1(1:40,1:i)=x(1:40,1:i);
        y1=zeros(40,1);
        y1(1:40,1)=y(1:40,1);
        temp_x=zeros(1,i);
        temp_x(1,1:i)=x1(k,1:i);
        x1(k,1:i)=x1(40,1:i);
        x1(40,1:i)=temp_x(1,1:i);
        temp_y=y1(k,1);
        y1(k,1)=y1(40,1);
        y1(40,1)=temp_y;
        x_train=zeros(39,i);
        y_train=zeros(39,1);
        x_train(1:39,1:i)=x1(1:39,1:i);
        y_train(1:39,1)=y1(1:39,1);
        %%%%%%%%%%%%%代入libsvm函数svm_train训练支持向量机分类器%%%%%%%%%%%%%%%
        cmd=['-s 0'];
        model=svmtrain(y_train,x_train,cmd);
        mse_train=zeros(3,1);
        [y_train,mse_train]=svmpredict(y1(40,1),x1(40,:),model);
        error_times(i-1,1)=error_times(i-1,1)+0.5*abs(y1(40,1)-y_train);
    end
end