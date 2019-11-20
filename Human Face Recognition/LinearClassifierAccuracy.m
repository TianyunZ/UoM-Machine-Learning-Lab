function result = LinearClassifierAccuracy(num, test, totalTrain, D)
totalTest = num*test;
for i = 1:50
    correct = 0;
    Ytr = zeros(totalTrain,num);
    Yte = zeros(totalTest,num);
    Xtr = [ones(totalTrain,1) D{i,1}];
    for j = 1:totalTrain
        Ytr(j,D{i,3}(j)) = 1;
    end
    for j = 1:totalTest
        Yte(j,D{i,4}(j)) = 1;
    end
    W{1,i} = pinv(Xtr)*Ytr;
    Temp = [ones(totalTest,1) D{i,2}];
    Ypred{1,i} = Temp * W{1,i};
    for j = 1:totalTest
        Y_pred(j,i) = SortDist(Ypred{1,i}(j,:));
        if Y_pred(j,i) == D{i,4}(j)
            correct = correct+1;
        end
    end
    LnrAcu(i) = correct/totalTest;
end
result = LnrAcu;