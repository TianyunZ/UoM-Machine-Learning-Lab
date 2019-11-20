function [predictLabel, accuracy] = NBTest( TrainResult, testAttributeSet, validLabel)
[testNum,~] = size(testAttributeSet);
classNum = max(validLabel)+1;
C = ones(testNum, classNum);
predictLabel = zeros(testNum, 1);
flag = TrainResult{4};

% Check if the datasaet is discrete or continuous.
if  (~flag)
    B = TrainResult{1};
    totalNum = TrainResult{2};
    trainNum = TrainResult{3};
    for i = 1:testNum
        for k = 1:classNum
            for j = 1:57
                C(i, k) = C(i, k) * B{k}( testAttributeSet(i, j)+1, j);
            end;
            C(i, k) = C(i, k) * totalNum(k)/trainNum;
        end;
        [~, predictLabel(i)] = max(C(i,:));
        predictLabel(i) = predictLabel(i) - 1;
    end;
    t = 0;
    for i = 1:testNum
        if predictLabel(i) == validLabel(i);
            t = t + 1;
        end;
    end;
    accuracy = t/testNum;
else
    trainNum = TrainResult{1};
    totalNum = TrainResult{2};
    Mean = TrainResult{3};
    Std = TrainResult{5};
    temp = zeros(57, classNum);

    for i = 1:testNum
        for k = 1:classNum
            for j = 1:57
                if (Std(k, j) == 0)
                    if (testAttributeSet(i, j) ~= Mean(k, j))
                        C(i, k) = 2.2251e-308;
                    end
                else
                    temp(j, k) = exp(-(testAttributeSet(i, j)-Mean(k, j))^2/(2*Std(k, j)))/((2*pi*Std(k, j))^0.5);
                    C(i, k) = C(i, k) * temp(j, k);
                end
            end;
            C(i, k) = C(i, k) * totalNum(k)/trainNum;
        end;
        [~, predictLabel(i)] = max(C(i,:));
        predictLabel(i) = predictLabel(i) - 1;
    end;
    t = 0;
    for i = 1:testNum
        if predictLabel(i) == validLabel(i);
            t = t + 1;
        end;
    end;
    accuracy = t/testNum;

end;

