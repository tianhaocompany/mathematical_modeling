clear all
close all
clear  
clc
fid1=fopen('pre_pro.txt','r');
data1=fscanf(fid1,'%g',[62,1909]);
data=data1';



biaohao=[1696 643 1560 457 1855 1094 1798 67 691];%冗余+主成分0.5最优组合
for i=1:length(biaohao)
    for j=1:1909
        if (j==biaohao(i))  
            P1=data(j,1:14);
            P2=data(j,23:48);
            P(i,1:40)=[P1 P2];
            break;
        end
    end
end



T=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ]; 



net=newgrnn(P,T);                        % create neural network




for i=1:length(biaohao)
    for j=1:1909
        if (j==biaohao(i))  
            P3=data(j,15:22);
            P4=data(j,49:62);
            PP(i,1:22)=[P3 P4];
            break;
        end
    end
end


T1=[ 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; 
out = round(sim(net,PP));  

diff = [T1 - 2*out];
detections = length(find(diff==-1))        
false_positives = length(find(diff==1))   
true_positives = length(find(diff==0))    
false_alarms = length(find(diff==-2))    

Nt = size(PP,2);                   
fprintf('Total testing samples: %d\n', Nt);


cm = [detections false_positives; false_alarms true_positives];
correct=cm(1,1)+cm(2,2);
correct_ratio=correct/22;
fprintf('正确个数：%g\n\n',correct);
fprintf('正确率： %g\n\n',correct_ratio);