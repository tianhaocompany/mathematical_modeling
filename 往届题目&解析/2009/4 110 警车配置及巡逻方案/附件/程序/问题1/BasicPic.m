load 增加6个点的道路信息和W距阵.mat;

plot(Point2(:,2),Point2(:,3),'.r');

for l=1:464
    hold on;
    Z=[Road2(l,4),Road2(l,5);Road2(l,6),Road2(l,7)];
    plot(Z(:,1),Z(:,2));
end

for l=1:cnum
    hold on;
    plot(Point2(C(1,l),2),Point2(C(1,l),3),'or');
    plot(Point2(C(1,l),2),Point2(C(1,l),3),'xr');
    plot(Point2(C(1,l),2),Point2(C(1,l),3),'+r');
    plot(Point2(C(1,l),2),Point2(C(1,l),3),'*r');
    plot(Point2(C(1,l),2),Point2(C(1,l),3),'sr');
    plot(Point2(C(1,l),2),Point2(C(1,l),3),'dr');
    plot(Point2(C(1,l),2),Point2(C(1,l),3),'vr');
    plot(Point2(C(1,l),2),Point2(C(1,l),3),'^r');
    plot(Point2(C(1,l),2),Point2(C(1,l),3),'<r');
    plot(Point2(C(1,l),2),Point2(C(1,l),3),'>r');
    plot(Point2(C(1,l),2),Point2(C(1,l),3),'pr');
    plot(Point2(C(1,l),2),Point2(C(1,l),3),'hr');
end

for l=1:313
    if juleilist(2,l)==1
        plot(Point2(juleilist(1,l),2),Point2(juleilist(1,l),3),'xb');
    elseif juleilist(2,l)==2
        plot(Point2(juleilist(1,l),2),Point2(juleilist(1,l),3),'ob');
    elseif juleilist(2,l)==3
        plot(Point2(juleilist(1,l),2),Point2(juleilist(1,l),3),'pb');
    elseif juleilist(2,l)==4
        plot(Point2(juleilist(1,l),2),Point2(juleilist(1,l),3),'+b');
    elseif juleilist(2,l)==5
        plot(Point2(juleilist(1,l),2),Point2(juleilist(1,l),3),'sb');
    elseif juleilist(2,l)==6
        plot(Point2(juleilist(1,l),2),Point2(juleilist(1,l),3),'hb');
    elseif juleilist(2,l)==7
        plot(Point2(juleilist(1,l),2),Point2(juleilist(1,l),3),'sb');
    elseif juleilist(2,l)==8
        plot(Point2(juleilist(1,l),2),Point2(juleilist(1,l),3),'sb');
    elseif juleilist(2,l)==9
        plot(Point2(juleilist(1,l),2),Point2(juleilist(1,l),3),'vb');
    elseif juleilist(2,l)==10
        plot(Point2(juleilist(1,l),2),Point2(juleilist(1,l),3),'<b');
    elseif juleilist(2,l)==11
        plot(Point2(juleilist(1,l),2),Point2(juleilist(1,l),3),'>b');
    elseif juleilist(2,l)==12
        plot(Point2(juleilist(1,l),2),Point2(juleilist(1,l),3),'^b');
    elseif juleilist(2,l)==13
        plot(Point2(juleilist(1,l),2),Point2(juleilist(1,l),3),'ob');
    end
end
