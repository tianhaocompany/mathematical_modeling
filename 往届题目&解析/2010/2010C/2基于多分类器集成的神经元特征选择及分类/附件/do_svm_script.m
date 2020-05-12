%% classification script using SVM
% The classification is done in a script which makes it a easier to change. However feel free to make it into a function
% as the other stages above.

clc;
clear;

load train;
load test;

cls=7;

feature=train(1:51,1:43);
if cls==7
    label=train(1:51,45);
end
if cls==5
    label=train(1:51,44);
end
testfeature=test(:,1:43);

load testlabel;
addpath('libsvm');


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
    test_labels     = testlabel(:,2);           % contains the labels of the testset
end
if cls==7
    test_labels     = testlabel(:,1);           % contains the labels of the testset
end
test_data       = abs(testfeature);           % contains the test data
%%



%% here you should of course use crossvalidation !
cc=500;
options=sprintf('-s 0 -t 3 -c %f -b 1',cc);
model=svmtrain(train_labels,train_data,options);
[predict_label, accuracy , dec_values] = svmpredict(test_labels,test_data, model,'-b 1');
