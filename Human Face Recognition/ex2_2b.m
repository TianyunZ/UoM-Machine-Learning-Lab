LnrMultAcu = LinearClassifierAccuracy(40, 5, 200, D);

KNNPred = CalculateAccuracy(1, D, 200, 2);

num = 1:50;
plot(num, LnrMultAcu,'b')
hold on
plot(num, KNNPred,'r')
xlabel('No.of database');
ylabel('TestingAccuracy');
title('Part2.b Testing Accuracy');
legend('Linear','KNN');

for i = 1:40
    for j = 1:50
        E{j,1} = D{j,1};
        E{j,2} = D{j,2}(5*(i-1)+1: 5*i,:);
        E{j,3} = D{j,3};
        E{j,4} = D{j,4}(5*(i-1)+1: 5*i,:);
    end;
    TestAcu(i) = mean(LinearClassifierAccuracy(1, 5, 200, E));
    TrainAcu(i) = mean(LinearClassifierAccuracy(1, 5, 200, E));
end;
num = 1:40;
figure(7); plot(num, TestAcu)
xlabel('subject');
ylabel('TestingAccuracy');
title('Testing Accuracy of Linear Classifier');