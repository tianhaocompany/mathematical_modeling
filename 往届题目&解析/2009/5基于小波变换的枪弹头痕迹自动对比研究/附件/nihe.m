RootPath = 'D:\b\3';
DiffGuns = ['77-1203959',
            '77-1504519',
            '77-1811345',
            '77-1812492',
            '77-1923252',
            '77-1928033'];
DiffBullet = ['T1',
              'T2'];
DiffCurves = ['c1.dat',
              'c2.dat',
              'c3.dat',
              'c4.dat'];
DiffLines = ['c_line1.dat',
              'c_line2.dat',
              'c_line3.dat',
              'c_line4.dat'];
          
DiffName = ['pointC1.txt',
            'pointC2.txt',
            'pointC3.txt',
            'pointC4.txt'];
 
for i=1:size(DiffGuns,1)
    for j=1:size(DiffBullet,1)
        for k = 1:size(DiffLines,1)
            
            po=load([RootPath '\' DiffGuns(i,1:2) DiffBullet(j,:) DiffGuns(i,3:length(DiffGuns(i,:))) '\' DiffLines(k,:)]);% 按转置格式村数据。
            n=size(po,1);
            z=po(:,3)';
            y=po(:,2)';
            x=po(:,1)';
%x=[1 1.5 2 2.5 3 3.5 4 4.5 5];
%y=[-8.1 -7.2 -6.2 -5.5 -4.8 -3.8 -3 -2.2 -1.3];
%z=[-12 -11.8 -10.7 -9.5 -8.2 -7 -6 -4.5 -3.5];
%n=length(x);
            
        %    hold on
            F=[y;ones(n,1)';];
            M=F*F';
            N=F*x';
            O=F*z';
            A=(M\N)'
            B=(M\O)'
            x1=A(1)*y+A(2);
            z1=B(1)*y+B(2);
            y1=y;
        %    plot3(x,y,z,'o')
        %    hold on
        %    plot3(x1,y1,z1,'r-','linewidth',3)
            x3(1,2)=0;
            x3(1,1)=A(1)*x3(1,2)+A(2);
            x3(1,3)=B(1)*x3(1,2)+B(2);
            x3(2,2)=2.076250;
            x3(2,1)=A(1)*x3(2,2)+A(2);
            x3(2,3)=B(1)*x3(2,2)+B(2);
            save([RootPath '\' DiffGuns(i,1:2) DiffBullet(j,:) DiffGuns(i,3:length(DiffGuns(i,:))) '\' DiffName(k,:)],'x3','-ascii')
        end
     end
 end