function TrainResult = NBTrain(AttributeSet, LabelSet)
[trainNum,~] = size(AttributeSet);
attributeValue = max(max(AttributeSet))+1;
classNum = max(LabelSet)+1;
flag = 0; % flag=0 means the dataset is discrete and flag=1 means continuous.
totalNum = zeros(1, classNum);

% Check if the datasaet is discrete or continuous.
if ~any( round( AttributeSet(:, 1)) ~= AttributeSet(:, 1))
    m = 1;
    for k = 1:classNum
        A{k} = zeros(attributeValue, 57); % Record the number of each value of each feature of each class.
        B{k} = zeros(attributeValue, 57); % Record the probability of each value of each feature of each class.
    end;
    for i = 1:trainNum
        for j = 1:57
            t = AttributeSet(i, j) + 1;
            A{LabelSet(i)+1}(t, j)  =  A{LabelSet(i)+1}(t, j) + 1;
        end;
    end;
    for k = 1:classNum
        for i = 1:attributeValue
            totalNum(k) = totalNum(k) + A{k}(i, 1);
        end;
    end;
    for k = 1:classNum
        for i = 1:attributeValue
            for j = 1:57
                B{k}(i, j) = (A{k}(i, j)+m/attributeValue)/(totalNum(k)+m);
            end;
        end;
    end;
    TrainResult{1} = B;
    TrainResult{2} = totalNum;
    TrainResult{3} = trainNum;
    TrainResult{4} = flag;
else
    flag = 1;
    sum = zeros(classNum, 57);
    num = zeros(classNum, 57);
    Mean = zeros(classNum, 57);
    Std = zeros(classNum, 57);
    for j = 1:57
        for i = 1:trainNum
            sum(LabelSet(i)+1, j) = sum(LabelSet(i)+1, j) + AttributeSet(i, j);
            num(LabelSet(i)+1, j) = num(LabelSet(i)+1, j) + 1;
        end;
    end;
    for k = 1:classNum
        for j = 1:57
            Mean(k, j) = sum(k, j)/num(k, j);
        end;
    end;
    for j = 1:57
        for i = 1:trainNum
            Std(LabelSet(i)+1, j) = Std(LabelSet(i)+1, j) + (AttributeSet(i, j) - Mean(LabelSet(i)+1, j))^2;
        end;
    end;
    for k = 1:classNum
        for j = 1:57
            Std(k, j) = Std(k, j)/num(k, j);
        end;
    end
    for i = 1:trainNum
        totalNum(LabelSet(i)+1) = totalNum(LabelSet(i)+1)+1;
    end;
    TrainResult{1} = trainNum;
    TrainResult{2} = totalNum;
    TrainResult{3} = Mean;
    TrainResult{4} = flag;
    TrainResult{5} = Std;
end;

