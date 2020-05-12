function result=generate_code(t1,t2)
 t1(5)
 t2(5)
c1=generate_c(t1(1),t2(1));
c2=generate_c(t1(2),t2(2));
c3=generate_c(t1(3),t2(3));
c4=generate_c(t1(4),t2(4));
c5=generate_c(t1(5),t2(5))

l1=length(c1);
l2=length(c2);
l3=length(c3);
l4=length(c4);
l5=length(c5)

ll=max([l1,l2,l3,l4,l5])

result=zeros(ll,6);

for i=1:l1
  result(i,1)=c1(i)
end

for i=1:l2
  result(i,2)=c2(i)
end

for i=1:l3
  result(i,3)=c3(i)
end

for i=1:l4
  result(i,4)=c4(i)
end

for i=1:l5
  result(i,5)=c5(i)
end