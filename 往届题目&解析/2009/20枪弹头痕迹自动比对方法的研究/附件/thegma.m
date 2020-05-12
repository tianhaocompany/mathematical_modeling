clc
if M == 1
[master_img1,slave_img1]=pingyi_offset_fun(pc1(50:500,100:400),pcc1);
[master_img2,slave_img2]=pingyi_offset_fun(pc2(50:500,100:400),pcc2);
[master_img3,slave_img3]=pingyi_offset_fun(pc3(50:500,100:400),pcc3);
[master_img4,slave_img4]=pingyi_offset_fun(pc4(50:500,100:400),pcc4);
de1=master_img1-slave_img1;
thegma1=std(reshape(de1,1,[]));
de2=master_img2-slave_img2;
thegma2=std(reshape(de2,1,[]));
de3=master_img3-slave_img3;
thegma3=std(reshape(de3,1,[]));
de4=master_img4-slave_img4;
thegma4=std(reshape(de4,1,[]));
thega=[thegma1,thegma2,thegma3,thegma4];
thega=sort(thega);
thega=thega(3)+thega(4)
end


if M == 2
[master_img1,slave_img1]=pingyi_offset_fun(pc1(50:500,100:400),pcc2);
[master_img2,slave_img2]=pingyi_offset_fun(pc2(50:500,100:400),pcc3);
[master_img3,slave_img3]=pingyi_offset_fun(pc3(50:500,100:400),pcc4);
[master_img4,slave_img4]=pingyi_offset_fun(pc4(50:500,100:400),pcc1);
de1=master_img1-slave_img1;
thegma1=std(reshape(de1,1,[]));
de2=master_img2-slave_img2;
thegma2=std(reshape(de2,1,[]));
de3=master_img3-slave_img3;
thegma3=std(reshape(de3,1,[]));
de4=master_img4-slave_img4;
thegma4=std(reshape(de4,1,[]));
thega=[thegma1,thegma2,thegma3,thegma4];
thega=sort(thega);
thega=thega(3)+thega(4)

end


if M == 3
[master_img1,slave_img1]=pingyi_offset_fun(pc1(50:500,100:400),pcc3);
[master_img2,slave_img2]=pingyi_offset_fun(pc2(50:500,100:400),pcc4);
[master_img3,slave_img3]=pingyi_offset_fun(pc3(50:500,100:400),pcc1);
[master_img4,slave_img4]=pingyi_offset_fun(pc4(50:500,100:400),pcc2);
de1=master_img1-slave_img1;
thegma1=std(reshape(de1,1,[]));
de2=master_img2-slave_img2;
thegma2=std(reshape(de2,1,[]));
de3=master_img3-slave_img3;
thegma3=std(reshape(de3,1,[]));
de4=master_img4-slave_img4;
thegma4=std(reshape(de4,1,[]));
thega=[thegma1,thegma2,thegma3,thegma4];
thega=sort(thega);
thega=thega(3)+thega(4)

end


if M == 4

[master_img1,slave_img1]=pingyi_offset_fun(pc1(50:500,100:400),pcc4);
[master_img2,slave_img2]=pingyi_offset_fun(pc2(50:500,100:400),pcc1);
[master_img3,slave_img3]=pingyi_offset_fun(pc3(50:500,100:400),pcc2);
[master_img4,slave_img4]=pingyi_offset_fun(pc4(50:500,100:400),pcc3);
de1=master_img1-slave_img1;
thegma1=std(reshape(de1,1,[]));
de2=master_img2-slave_img2;
thegma2=std(reshape(de2,1,[]));
de3=master_img3-slave_img3;
thegma3=std(reshape(de3,1,[]));
de4=master_img4-slave_img4;
thegma4=std(reshape(de4,1,[]));
thega=[thegma1,thegma2,thegma3,thegma4];
thega=sort(thega);
thega=thega(3)+thega(4)

end