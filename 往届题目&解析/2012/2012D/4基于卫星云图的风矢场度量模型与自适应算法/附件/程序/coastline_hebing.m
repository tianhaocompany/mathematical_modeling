% ‘ÿ»Î∫£∞∂œﬂæÿ’Û
load coastline0.txt
hold on


% figure
for i=1:max(size(coastline0))
    [b_xyz(i,1),b_xyz(i,2)]=jingwei2xyz(coastline0(i,1),coastline0(i,2));
end

% b_xyz_1=b_xyz(:,1);
% b_xyz_2=-1*b_xyz(:,2)+2288;
% plot(2288-b_xyz_2(:,1),2288-b_xyz_1(:,1),'b.','MarkerSize',3);

plot(b_xyz(:,2),b_xyz(:,1),'b.','MarkerSize',1);
% view([0,-90])


