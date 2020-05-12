clear;
clc;

%使用3点权重平滑09号卫星alpha beta上的白噪声
data=load('data\meadata_06_00.txt');
[nx,ny]=size(data);
t=data(:,1);
alpha=data(:,2);
beta=data(:,3);

s=0.95;
aalpha=zeros(nx,1);
abeta=zeros(nx,1);
delt1=zeros(nx,1);
delt2=zeros(nx,1);

for i=2:nx-1
    aalpha(i)=(1-s)/2*alpha(i-1)+s*alpha(i)+(1-s)/2*alpha(i+1);
    abeta(i)=(1-s)/2*beta(i-1)+s*beta(i)+(1-s)/2*beta(i+1);
end

aalpha(1)=alpha(1);
abeta(1)=beta(1);
aalpha(nx)=alpha(nx);
abeta(nx)=beta(nx);

% newdata=[t aalpha abeta];
% fid=fopen('meadata_09_00_new.txt','w');
% if fid==0
%     disp('File Open Error!');
% end
% 
% [max_row, max_col] = size(newdata);
% for row=1:max_row
%     for col=1:max_col-1
%         fprintf(fid,'%15g\t',newdata(row,col));
%     end
%     fprintf(fid,'%15g\n',newdata(row,max_col));
% end
% fclose(fid);

alpha_ad=zeros(nx+1,1);
beta_ad=zeros(nx+1,1);
t_ad=[50:0.2:170]';
for i=2:nx
    alpha_ad(i)=(aalpha(i)-aalpha(i-1))/(t(i)-t(i-1))*(t_ad(i)-t(i-1))+aalpha(i-1);
    beta_ad(i)=(abeta(i)-abeta(i-1))/(t(i)-t(i-1))*(t_ad(i)-t(i-1))+abeta(i-1);
end
alpha_ad(1)=(aalpha(2)-aalpha(1))/(t(2)-t(1))*(50-t(1))+aalpha(1);
beta_ad(1)=(abeta(2)-abeta(1))/(t(2)-t(1))*(50-t(1))+abeta(1);

alpha_ad(nx+1)=(aalpha(nx)-aalpha(nx-1))/(t(nx)-t(nx-1))*(t_ad(nx+1)-t(nx))+aalpha(nx);
beta_ad(nx+1)=(abeta(nx)-abeta(nx-1))/(t(nx)-t(nx-1))*(t_ad(nx+1)-t(nx))+abeta(nx);

data_ad=[t_ad alpha_ad beta_ad];
fid=fopen('meadata_06_00_new.dat','w');
if fid==0
    disp('File Open Error!');
end

[max_row, max_col] = size(data_ad);
for row=1:max_row
    for col=1:max_col-1
        fprintf(fid,'%20.12f',data_ad(row,col));
    end
    fprintf(fid,'%20.12f',data_ad(row,max_col));
    fprintf(fid,'\n');
end
fclose(fid);
