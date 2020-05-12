% BW1 = edge(pc1,'canny',0.1);
% BW2 = edge(pcc1,'canny',0.1);
% BW1 =double(BW1);
% BW2 =double(BW2);
% maskb=BW1|BW2 ;
t1w=pc1(50:250,200:300);
sumt=zeros(300,350);
for mm=1:300
    for nn=1:350
%         maskb=BW1(50:250,200:300)|BW2(mm:mm+200,nn:nn+100);
        tt=abs(pcc1(mm:mm+200,nn:nn+100)-t1w) %.*double(maskb);
    sumt(mm,nn)=mean(tt(:));
    end
end