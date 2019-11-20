TestingAcu = zeros(6, 1);
TrainingAcu = zeros(6, 1);

X = data(1:20,:);
ShowFace(X,5);

load ORLfacedata
for i = 1:50
    X = data([1:10, 291:300],:);
    Y = labels([1:10,291:300]);
    [Xtr_a, Xte_a, Ytr_a, Yte_a] = PartitionData(X, Y, 3);
    B{i,1} = Xtr_a;
    B{i,2} = Xte_a;
    B{i,3} = Ytr_a;
    B{i,4} = Yte_a;
    figure(1); ShowFace(Xtr, 3);
    figure(2); ShowFace(Xte, 7);
end;

for k = 1:1:6
    Testing Accuracy
    for i = 1:50
        Correct = 0;
        for j = 1:14
            Y = knearest(3, B{i,2}(j,:), B{i,1}, B{i,3});
            if Y == B{i,4}(j,1)
                Correct = Correct+1;
            end
        end;
        Crt(i,1) = Correct;
        Acu(i,1) = Correct/14;
    end;
    TotalCrt = 0;
    for i = 1:50
        TotalCrt = TotalCrt + Crt(i,1);
    end;
    TestingAcu(k) = TotalCrt/700;

    Training Accuracy
    for i = 1:50
        Correct = 0;
        for j = 1:6
            Y = knearest(3, B{i,1}(j,:), B{i,1}, B{i,3});
            if Y == B{i,3}(j,1)
                Correct = Correct+1;
            end
        end;
        Crt(i,1) = Correct;
        Acu(i,1) = Correct/6;
    end;
    TotalCrt = 0;
    for i = 1:50
        TotalCrt = TotalCrt + Crt(i,1);
    end;
    TrainingAcu(k) = TotalCrt/300;
end;

k = 1:1:6;
for i = 1:1:6
    y(i,1) = mean(CalculateAccuracy(i, B, 6, 1));
    e(i,1) = std(CalculateAccuracy(i, B, 6, 1));
end;
figure(3); errorbar(k, y, e)
xlabel('k');
ylabel('TraingAccuracy');
title('Part1.a Training Accuracy');

k = 1:1:6;
for i = 1:1:6
    y(i,1) = mean(CalculateAccuracy(i, B, 14, 2));
    e(i,1) = std(CalculateAccuracy(i, B, 14, 2));
end;
figure(4); errorbar(k, y, e)
xlabel('k');
ylabel('TestingAccuracy');
title('Part1.a Testing Accuracy');

Observe the classification results of the k-NN classifier on 
different datasets using the ShowResult.m function.
for i = 1:50
    for j = 1:14
        B{i,5}(j,1) = knearest(3, B{i,2}(j,:), B{i,1}, B{i,3});
    end;
end;
figure(5); ShowResult(B{1,2}, B{1,4}, B{1,5}, 5)
figure(6); ShowResult(B{30,2}, B{30,4}, B{30,5}, 5)
