w = zeros(1025,50);
LnrAcu = zeros(1,50);
LnrTraAcu = zeros(1,50);

for i = 1:50
    correct = 0;
    Xtr = [ones(6,1) B{i,1}];
    w(:,i) = pinv(Xtr)*B{i,3};
    Temp = [ones(14,1) B{i,2}];
    ypred(:,i) = Temp * w(:,i);
    for j = 1:14
        if (ypred(j,i)-15.5) < 0
            ypred(j,i) = 1;
        else
            ypred(j,i) = 30;
        end
        if ypred(j,i) == B{i,4}(j)
            correct = correct+1;
        end
    end
    LnrAcu(i) = correct/14;
end
num = 1:50;
figure(6); plot(num, LnrAcu)
xlabel('No.of database');
ylabel('TestingAccuracy');
title('Part2.a Testing Accuracy');

for i = 1:50
    correct = 0;
    Xtr = [ones(6,1) B{i,1}];
    w(:,i) = pinv(Xtr)*B{i,3};
    Temp = [ones(6,1) B{i,1}];
    ytpred(:,i) = Temp * w(:,i);
    for j = 1:6
        if (ytpred(j,i)-15.5) < 0
            ytpred(j,i) = 1;
        else
            ytpred(j,i) = 30;
        end
        if ytpred(j,i) == B{i,3}(j)
            correct = correct+1;
        end
    end
    LnrTraAcu(i) = correct/6;
end
num = 1:50;
figure(7); plot(num, LnrTraAcu)
xlabel('No.of database');
ylabel('TrainingAccuracy');
title('Part2.a Training Accuracy');

figure(4); ShowResult(B{4,2}, B{4,4}, ypred(:,4), 5)
title('Classification result of Dataset 4')
figure(5); ShowResult(B{13,2}, B{13,4}, ypred(:,13), 5)
title('Classification result of Dataset 13')