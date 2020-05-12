clear all
num=10000;
num_under=0;
check=0.01;

data=lognrnd(0.5,0.25,num,1);
[data_sort,I]=sort(data);

num_under=num*(1-check);
group=num_under/50;
mask=zeros(num_under,1);
for i=1:(group)
    mask(i*50)=1;
end
mask=[mask ;ones(num-num_under,1)];
data_real=data_sort.*mask;
data_dis1=data_sort;
data_real2=data_real+0.0001;
for i=1:group
    data_dis1((1+(i-1)*50):(49+(i-1)*50))=data_sort(i*50).*ones(49,1);
end
data_dis2=data_sort;
f = ceil(num_under.*rand(group,1))
random=data_sort(f);
for i=1:group
    data_dis2((1+(i-1)*50):(50+(i-1)*50))=random(i).*ones(50,1)
end




