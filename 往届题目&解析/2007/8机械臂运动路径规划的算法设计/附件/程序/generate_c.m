function r=generate_c(t1,t2)
 n=floor(abs(t1-t2)/2);
 
 nd=abs(t1-t2)-2*n;
 
   r=zeros(n,1)+2;
 if nd~=0
    r=[r;nd];
 end
 
 if t1>t2
     r=-r;
 end
 