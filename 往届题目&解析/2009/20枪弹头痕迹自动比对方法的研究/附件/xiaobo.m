
 
 clc
 
file1=['E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77T1-1504519'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77t1-1812492'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77T1-1814688'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77T1-1928033'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77T1-1931817'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77T2-1203959'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77t2-1811345'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77T2-1814117'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77T2-1923252'
     'E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77T2-1930832'
      'E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77T1-1202999'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77T1-1203959'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77t1-1811345'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77t1-1814117'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77T1-1923252'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77T1-1930832'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77T2-1202999'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77T2-1504519'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77t2-1812492'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77T2-1814688'
     'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77T2-1928033'
      'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77T2-1931817'
    ];
file2=['E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77T1-1504519'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77t1-1812492'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77T1-1814688'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77T1-1928033'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77T1-1931817'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77T2-1203959'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77t2-1811345'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77T2-1814117'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77T2-1923252'
     'E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77T2-1930832'
      'E:\数模2009\数模2009\bdata\B题－第四问题的数据之一\第四问题的数据之一\77T1-1202999'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77T1-1203959'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77t1-1811345'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77t1-1814117'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77T1-1923252'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77T1-1930832'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77T2-1202999'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77T2-1504519'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77t2-1812492'
    'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77T2-1814688'
     'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77T2-1928033'
      'E:\数模2009\数模2009\bdata\B题－第四问题的数据之二\第四问题的数据之二\77T2-1931817'
    ];

 
pose_m=zeros(22,22);
 
% h = waitbar(0,'Please wait...');
for mmm=1:22
    mmm
    for nnn=mmm+1:22
%   waitbar(((mmm-1)*22+nnn)/22/22)     
file11=strcat(file2(mmm,:),'\c1.dat');
file21=strcat(file2(mmm,:),'\c2.dat');
file31=strcat(file2(mmm,:),'\c3.dat');
file41=strcat(file2(mmm,:),'\c4.dat');

load (file11);
load (file21);
load (file31);
load (file41);


c1=reshape(c1(:,3),564,756);
c2=reshape(c2(:,3),564,756);
c3=reshape(c3(:,3),564,756);
c4=reshape(c4(:,3),564,756);

cc1=c1;
cc2=c2;
cc3=c3;
cc4=c4;

file11=strcat(file1(nnn,:),'\c1.dat');
file21=strcat(file1(nnn,:),'\c2.dat');
file31=strcat(file1(nnn,:),'\c3.dat');
file41=strcat(file1(nnn,:),'\c4.dat');

load (file11);
load (file21);
load (file31);
load (file41);

c1=reshape(c1(:,3),564,756);
c2=reshape(c2(:,3),564,756);
c3=reshape(c3(:,3),564,756);
c4=reshape(c4(:,3),564,756);

[pc1] = pol_fit(c1(:,150:600));
[pc2] = pol_fit(c2(:,150:600));
[pc3] = pol_fit(c3(:,150:600));
[pc4] = pol_fit(c4(:,150:600));

[pcc1] = pol_fit(cc1(:,150:600));
[pcc2] = pol_fit(cc2(:,150:600));
[pcc3] = pol_fit(cc3(:,150:600));
[pcc4] = pol_fit(cc4(:,150:600));


        M=M_m(mmm,nnn);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if M == 1
 
pose1 = abs(waveltmethod(pc1)-waveltmethod(pcc1));
pose2 = abs(waveltmethod(pc2)-waveltmethod(pcc2));
pose3 = abs(waveltmethod(pc3)-waveltmethod(pcc3));
pose4 = abs(waveltmethod(pc4)-waveltmethod(pcc4));

pose=[pose1,pose2,pose3,pose4];
pose=sort(pose);
pose=(pose(3)+pose(4))/2;
end


if M == 2
 
pose1 = abs(waveltmethod(pc1)-waveltmethod(pcc2));
pose2 = abs(waveltmethod(pc2)-waveltmethod(pcc3));
pose3 = abs(waveltmethod(pc3)-waveltmethod(pcc4));
pose4 = abs(waveltmethod(pc4)-waveltmethod(pcc1));

pose=[pose1,pose2,pose3,pose4];
pose=sort(pose);
pose=(pose(3)+pose(4))/2;

end


if M == 3
pose1 = abs(waveltmethod(pc1)-waveltmethod(pcc3));
pose2 = abs(waveltmethod(pc2)-waveltmethod(pcc4));
pose3 = abs(waveltmethod(pc3)-waveltmethod(pcc1));
pose4 = abs(waveltmethod(pc4)-waveltmethod(pcc2));

pose=[pose1,pose2,pose3,pose4];
pose=sort(pose);
pose=(pose(3)+pose(4))/2;

end


if M == 4

pose1 = abs(waveltmethod(pc1)-waveltmethod(pcc4));
pose2 = abs(waveltmethod(pc2)-waveltmethod(pcc1));
pose3 = abs(waveltmethod(pc3)-waveltmethod(pcc2));
pose4 = abs(waveltmethod(pc4)-waveltmethod(pcc3));

pose=[pose1,pose2,pose3,pose4];
pose=sort(pose);
pose=(pose(3)+pose(4))/2;

end

pose_m(mmm,nnn)=pose;

    end
end
