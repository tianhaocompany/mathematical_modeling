hold on
m=max(size(H));
subplot(2,2,1),plot(Q(1:m)),title('溃口流量Q')
subplot(2,2,2),plot(H(1:m)),title('溃口深度H')
subplot(2,2,3),plot(V(1:m)),title('水库蓄水量Hw')
subplot(2,2,4),plot(b(1:m)),title('溃口展宽B')
