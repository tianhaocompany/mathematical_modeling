function [bestx,index,x_min,x_max]=test(h,D)
%D是被替换一列的（一个基因）的数据，h是其EST集合
XX1=D(1:10,:);
XX2=D(13:20,:);
XX3=D(22,:);
X1=[XX1;XX2;XX3];
XXX1=D(23:42,:);
XXX2=D(45:54,:);
XXX3=D(58:62,:);
X2=[XXX1;XXX2;XXX3];
trnX = [X1;X2];
Y1 = ones(19,1);
Y2 = -ones(35,1);
trnY = [Y1;Y2];
C=20000;
ker='rfb';%erfb与之运行结果一样
[nsv alpha bias] = svc(trnX,trnY,ker,C);%w即alpha,bias即b
% [h_min,err_min alpha bias]=RFE_Relief(D,h)
% X3=D(16:22,:);
% X4=D(23:32,:);
% tstX = [X3;X4];
% Y3 = ones(7,1);
% Y4 = -ones(10,1);
% tstY = [Y3;Y4];

index=0;
for i=1:1:length(h)
    if strcmp(h(i),'Hsa.6317')%h =     'Hsa.2928'    'Hsa.2291'    'Hsa.6814'    'Hsa.6317'    'Hsa.627'
        
        % 'Hsa.6814''Hsa.549' 'Hsa.37937'
        
        A=trnX(:,i);
        x_min=min(A);
        x_max=max(A);
        index=i;%被x替换的那一列
        break;
    end
end
error1=0;
error2=0;
error=45;
error1_a=[];
error2_a=[];
error_a=[];
bestx=x_min;
f=inf;
kk=1;

for x=x_min:0.01:x_max
    trnX(:,index)=x*ones(54,1);
    error1 = svcerror([X1;X2],trnY,trnX(1:19,:),Y1,ker,alpha,bias);
    error2 = svcerror([X1;X2],trnY,trnX(20:54,:),Y2,ker,alpha,bias);
    
    error1_a(kk)=error1;
    error2_a(kk)=error2;
    error_a(kk)=error1+error2;
    kk=kk+1;
    if error1+error2<error
        error=error1+error2;
        bestx=x;
    end
end
    error1_a
    error2_a
    error_a

% for x=x_min:0.01:x_max
%     trnX(:,index)=x*ones(45,1);
%     %trnX=stdTrans(trnX);%标准化变换
%     %     error1=0;
%     %     error2=0;
%     %     for k=1:1:15
%     n = size(trnX,1);
%     m = size(trnX,1);
%     H = zeros(m,n);
%     for i=1:m
%         for j=1:n
%             H(i,j) = trnY(j)*svkernel(ker,trnX(i,:),trnX(j,:));
%         end
%     end
%
%     s=length(find((sign(H*alpha + bias)==trnY)==0));
%     d=(sign(H*alpha + bias)==trnY);
%     error1=length(find(d(1:15)==0))
%     error2=length(find(d(16:end)==0))
%     error1_a(kk)=error1;
%     error2_a(kk)=error2;
%     error_a(kk)=error1+error2;
%     kk=kk+1;
%
%     if s<f
%         bestx=x;
%         f=s;
%         d=(sign(H*alpha + bias)==trnY);
%         error1=length(find(d(1:15)==0));
%         error2=length(find(d(16:end)==0));
%     end
%     %     end
%
%     %     for j=1:1:30
%     %         if alpha*X2(j,:)+bias>0
%     %             error2=error2+1;
%     %         end
%     %         n = size(trnX,1);
%     %         m = size(trnX,1);
%     %         H = zeros(m,n);
%     %         for i=1:m
%     %             for j=1:n
%     %                 H(i,j) = trnY(j)*svkernel(ker,trnX(i,:),trnX(j,:));
%     %             end
%     %         end
%     %
%     %         s=length(find((sign(H*alpha + bias)==trnY)==0));
%     %         if s<f
%     %             bestx=x;
%     %             f=s
%     %         end
%     %     end
%     %     if error1+error2<error
%     %         error=error1+error2;
%     %         bestx=x;
%     %         flag=1;
%     %
%     %     end
% end
error1
error2
figure
plot(x_min:0.01:x_max,error1_a,'Color','red');
figure
plot(x_min:0.01:x_max,error2_a,'Color','green');
figure
plot(x_min:0.01:x_max,error_a,'Color','blue');
% if x_min==bestx
%     error=45;
%     for x=x_max:-0.1:x_min
%         trnX(:,index)=x*ones(45,1);
%         trnX=stdTrans(trnX);%标准化变换
%         error1=0;
%         error2=0;
%         for i=1:1:15
%             if alpha*X1(i,:)+bias<0
%                 error1=error1+1;
%             end
%         end
%         for j=1:1:30
%             if alpha*X2(j,:)+bias>0
%                 error2=error2+1;
%             end
%         end
%         if error1+error2<error
%             error=error1+error2;
%             bestx=x;
%         end
%     end
% end
% bestx