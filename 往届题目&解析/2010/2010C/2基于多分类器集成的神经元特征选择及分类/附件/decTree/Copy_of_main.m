clc;
clear;

load train;
load traintest;
test=traintest;

cls=5;

feature=train(1:51,1:43);
if cls==7
    label=train(1:51,45);
end
if cls==5
    label=train(1:51,44);
end
testfeature=test(:,1:43);

load traintestlabel;
testlabel=traintestlabel;


[r,c]=size(testfeature);
[rtrain,ctrain]=size(feature);

for i=1:c
    suma=0;
    for j=1:r
        suma=suma+abs(testfeature(j,i));
    end
    testfeature(:,i)=testfeature(:,i)/suma;
    
end

for i=1:ctrain
    suma=0;
     for j=1:rtrain
        suma=suma+abs(feature(j,i));
    end
    
    feature(:,i)=feature(:,i)/suma;
end

train_labels    = label;          % contains the labels of the trainset
train_data      = abs(feature);          % contains the train data
[train_labels,sindex]=sort(train_labels);    % we sort the labels to ensure that the first label is '1', the second '2' etc
train_data=train_data(sindex,:);
if cls==5
    test_labels     = testlabel(:,1);           % contains the labels of the testset
end
if cls==7
    test_labels     = testlabel(:,1);           % contains the labels of the testset
end
test_data       = abs(testfeature);           % contains the test data
%%

t = treefit(train_data,train_labels,'method','regression','splitmin',1)

treedisp(t);

% Find the minimum-cost tree.
[c,s,n,best] = treetest(t,'cross',test,testlabel);
tmin = treeprune(t,'level',best);

% Plot smallest tree within 1 std of minimum cost tree.
[mincost,minloc] = min(c);

plot(n,c,'b-o',...
     n(best+1),c(best+1),'bs',...
     n,(mincost+s(minloc))*ones(size(n)),'k--');
xlabel('叶子节点数目')
ylabel('分类误差')


%D = C4_5(train_data, train_labels, 0.4, region)