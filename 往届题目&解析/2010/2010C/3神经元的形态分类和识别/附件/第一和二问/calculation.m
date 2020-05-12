function result=calculation(featureExtractNum,filename)
A=xlsread(filename);%filename='all.xls';
% featureExtractNum=[1 2 4 5 8 13];
N=length(featureExtractNum);
selectedF=A(:,[1 featureExtractNum+1]);
[M N]=size(selectedF);
Temp=[];
fid=fopen('data.txt','w');
for i=1:M
    for j=1:N
        if j==1
            Temp=num2str(selectedF(i,j));
            fprintf(fid,'%s ',Temp);
        else
            Temp=[num2str(j-1) ':' num2str(selectedF(i,j))];
            fprintf(fid,'%s ',Temp);
        end
    end
    fprintf(fid,'\r\n');
end
fclose(fid);
[statu, result]=system('SVM\svm-scale.exe data.txt>a.txt');
fid=fopen('a.txt');
fidtr=fopen('train.txt','w');
fidte=fopen('test.txt','w');
count=0;
while ~feof(fid)
    count=count+1;
    fline=fgetl(fid);
    if count<=51
        fprintf(fidtr,'%s\r\n',fline);
    else
        fprintf(fidte,'%s\r\n',fline);
    end
end
fclose(fid);
fclose(fidtr);
fclose(fidte);
[statu, result]=system('SVM\svm-train.exe -c 10000 -t 1 -r 1 -g 1 train.txt model.txt');
[statu, result]=system('SVM\svm-predict.exe test.txt model.txt result.txt');
result