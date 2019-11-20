close all;
clear all;
fname = input('Enter a filename to load data for training/testing: ','s');
load(fname);

% Disrupt the order of data.
rowrank = randperm(size(spambase, 1));
spambase = spambase(rowrank, :);

% Divide the spamdata into 10 parts where 9 parts for training and 1 part
% for testing.
% AttributeSet = zeros(4140, 57);
% LabelSet = zeros(4140, 1);

for i = 1:9
   A{i} = spambase( (460*(i-1)+1): (460*i), :); 
   B{i} = spambase( (460*(i-1)+1): (460*i), 58);
end
A{10} = spambase( 4141: 4601, :); 
B{10} = spambase( 4141: 4601, 58);

AttributeSet{1} = [A{2}; A{3}; A{4}; A{5}; A{6}; A{7}; A{8}; A{9}; A{10}];
LabelSet{1} = [B{2}; B{3}; B{4}; B{5}; B{6}; B{7}; B{8}; B{9}; B{10}];
testAttributeSet{1} = A{1};
validLabel{1} = B{1};
TrainResult{1} = NBTrain(AttributeSet{1}, LabelSet{1});
[predictLabel, accuracy] = NBTest( TrainResult{1}, testAttributeSet{1}, validLabel{1});
accuracy(1) = accuracy;
for CrossTime = 2:10
    AttributeSet{CrossTime} = A{1};
    LabelSet{CrossTime} = B{1};
    for i = 2:10
       if (i~=CrossTime) 
            AttributeSet{CrossTime} = [AttributeSet{CrossTime}; A{i}];
            LabelSet{CrossTime} = [LabelSet{CrossTime}; B{i}];
       end
    end
    testAttributeSet{CrossTime} = A{CrossTime};
    validLabel{CrossTime} = B{CrossTime};
    
    TrainResult{CrossTime} = NBTrain(AttributeSet{CrossTime}, LabelSet{CrossTime});
    [predictLabel, accuracy(CrossTime)] = NBTest( TrainResult{CrossTime}, testAttributeSet{CrossTime}, validLabel{CrossTime});
end;

AccuracyMean = mean(accuracy);
AccuracyStd = std(accuracy);

fprintf('********************************************** \n');
fprintf('Mean of Accuracy on Dataset %s: %f \n', fname, AccuracyMean);
fprintf('Standard Deviation of Accuracy on Dataset %s: %f \n', fname, AccuracyStd);
fprintf('********************************************** \n');

