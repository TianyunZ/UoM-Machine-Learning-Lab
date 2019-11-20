%load ORLfacedata
for i = 1:50
    [Xtr, Xte, Ytr, Yte] = PartitionData(data, labels, 5);
    D{i,1} = Xtr;
    D{i,2} = Xte;
    D{i,3} = Ytr;
    D{i,4} = Yte;
    figure(1); ShowFace(Xtr, 5);
    figure(2); ShowFace(Xte, 5);
end;

%   Pick one dataset. Implement the leave-one-out cross-validation to decide 
%   the value of the hyperparameter k for the k-NN classifier.  Compute the 
%   testing accuracy for this selected k value. 

y = zeros(11,1);
eb = zeros(11,1);
k = 1:11;

for i = 1:11
    y(i) = mean(LOOAccuracy(i, D{1, 1}, D{1, 3}));
    eb(i) = std(LOOAccuracy(i, D{1, 1}, D{1, 3}));
end;
figure(1); errorbar(k, y, eb)
xlabel('k');
ylabel('AverageAccuracy');
title('Part1.b Leave-one-out Accuracy');

Correct = 0;
for j = 1:200
    Y = knearest(3, D{1,2}(j,:), D{1,1}, D{1,3});
    if Y == D{1,4}(j,1)
        Correct = Correct+1;
    end
end;
TestingAccuracy = Correct/200

AvgTestingAcu = mean(CalculateAccuracy(1,D,200,2))
StdTestingAcu = std(CalculateAccuracy(1,D,200,2))

TestAcu = zeros(40,1);
TrainAcu = zeros(40,1);
for i = 1:40
    for j = 1:50
        E{j,1} = D{j,1};
        E{j,2} = D{j,2}(5*(i-1)+1: 5*i,:);
        E{j,3} = D{j,3};
        E{j,4} = D{j,4}(5*(i-1)+1: 5*i,:);
    end;
    TestAcu(i) = mean(CalculateAccuracy(1, E, 5, 2));
    TrainAcu(i) = mean(CalculateAccuracy(1, E, 5, 1));
end;
num = 1:40;
figure(7); plot(num, TestAcu)
xlabel('subject');
ylabel('TestingAccuracy');
title('Testing Accuracy of k-NN Classifier');