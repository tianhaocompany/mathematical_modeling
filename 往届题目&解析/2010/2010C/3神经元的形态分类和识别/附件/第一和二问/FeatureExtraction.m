function [Surface, Soma_Surface, N_stems, N_bifs, N_branch, N_tips, Type, Diameter, diameter_pow]=FeatureExtraction(A)
data=A.data;
P=A.p;
[m,n]=size(data);
Surface=0;
Soma_Surface=0;
N_stems=0;
N_bifs=0;
mark=0;
for i=1:m
    if data(i,7)==-1
        mark=i;
        Soma_Surface=4*pi*data(i,6)*data(i,6);
    else
    r1=data(i,6);
    r2=data(data(i,7),6);
    Dx=abs(data(i,3)-data(data(i,7),3));
    Dy=abs(data(i,4)-data(data(i,7),4));
    Dz=abs(data(i,5)-data(data(i,7),5));
    h=sqrt(Dx*Dx+Dy*Dy+Dz*Dz);
%     Surface=Surface+pi.*(r1+r2).*sqrt(h.*h.*P+(r1-r2).*(r1-r2));
    Surface=Surface+2*pi.*h.*r1;
    end
end

if mark~=0
    for i=1:m
        if data(i,7)==mark
        N_stems=N_stems+1;
        end
    end
end

temp=zeros(m,1);
for i=1:m
    if data(i,7)==mark
        temp(mark)=temp(mark)+1;
    end
    if temp(i)~=-1
    for j=i+1:m
        if data(i,7)~=-1 && data(i,7)==data(j,7) && temp(j)~=-1
            temp(i)=temp(i)+1;
            temp(j)=-1;
        end
    end
    end
end
temp(find(temp==-1))=0;
N_bifs=length(find(temp~=0));
N_branch=sum(temp)+N_bifs;

N_tips=m-length(unique(data(:,7)));

Type=sum(data(:,2));

Diameter=2*sum(data(:,6));

diameter_pow=sum((2*data(:,6)).^1.5);
