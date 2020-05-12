function res=lhgl(x)
res12=hguanlian(x(:,1),x(:,2));
res13=hguanlian(x(:,1),x(:,3));
res14=hguanlian(x(:,1),x(:,4));
res23=hguanlian(x(:,2),x(:,3));
res24=hguanlian(x(:,2),x(:,4));
res34=hguanlian(x(:,3),x(:,4));
res=[res12 res13 res14 res23 res24 res34];
