function y = ComSameBul(ii)
% i,j表示输入文件的序号
% y返回的是相关度
DiffMids = ['c1_mid.dat',
            'c2_mid.dat',
            'c3_mid.dat',
            'c4_mid.dat'];
Rootpath = 'D:\b\3';

for i = 1:4
   for j = 1:4
       for w=1:3
           d1 = load([Rootpath '\' '77T' int2str(1) '-' int2str(ii) '\' 'c' int2str(i) '_' int2str(w) '.dat' ]);
           d2 = load([Rootpath '\' '77T' int2str(2) '-' int2str(ii) '\' 'c' int2str(j) '_' int2str(w) '.dat' ]);
           d1=d1';
           d2=d2';
           plot(d1(:,1),d1(:,2));
           s = d1(13:140,2);
            ls = length(s);
            [C,L]=wavedec(s,8,'db3');
            [thr,sorh,keepapp]=ddencmp('den','wv',s);
            clean=wdencmp('gbl',C,L,'db3',5,thr,sorh,keepapp);
            t=clean(1:ls);
            lt=length(t);
            [C,L]=wavedec(t,8,'db1');
            D1=wrcoef('d',C,L,'db1',1);
            D2=wrcoef('d',C,L,'db1',2);
            D3=wrcoef('d',C,L,'db1',3);
            d1_D3=D3;
            for k = 1:22
                s = d2(k:k+127,2);
                ls = length(s);
                [C,L]=wavedec(s,8,'db3');
                [thr,sorh,keepapp]=ddencmp('den','wv',s);
                clean=wdencmp('gbl',C,L,'db3',5,thr,sorh,keepapp);
                t=clean(1:ls);
                lt=length(t);
                [C,L]=wavedec(t,8,'db1');
                D1=wrcoef('d',C,L,'db1',1);
                D2=wrcoef('d',C,L,'db1',2);
                D3=wrcoef('d',C,L,'db1',3);
                d2_D3(k,:)=D3;
            end
            maxi = 0;
            for k =1:22
                temp = corrcoef(d1_D3,d2_D3(k,:));
                if(temp(1,2)>maxi)
                    maxi = temp(1,2);
                end
            end
            r_tem(w)=maxi;
       end
       r_temp(i,j)=mean(r_tem);
    end
end
c=0;
maxy=0;
for i=1:4
    for j=1:4
        p=j+c;
        if(p>4)
            p=p-4;
        end
        r(i,j)=r_temp(j,p);
    end
    c=c+1;
end
ymax = 0;
for i = 1:4
    r(i,:)=sort(r(i,:),'descend');
    tempp = (r(i,1)+r(i,2))/2.0;
    if(tempp>ymax)
        ymax=tempp;
        i
    end
end

y=ymax;


            