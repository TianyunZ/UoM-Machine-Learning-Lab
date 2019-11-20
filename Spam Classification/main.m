close all;
clear all;
fname = input('Enter a filename to load data for training/testing: ','s');
load(fname);

% Put your NB training function below
%[ "Parameter List" ] = NBTrain(AttributeSet, LabelSet); 
% NB training
TrainResult = NBTrain(AttributeSet, LabelSet);

% Put your NB test function below
%[predictLabel, accuracy] = NBTest( "Parameter List" , testAttributeSet, validLabel); 
% NB test
[predictLabel, accuracy] = NBTest( TrainResult, testAttributeSet, validLabel);

fprintf('********************************************** \n');
fprintf('Overall Accuracy on Dataset %s: %f \n', fname, accuracy);
fprintf('********************************************** \n');

% Confusion matrix
C = confusionmat(validLabel, predictLabel);
plotconfusion(validLabel',predictLabel', fname)
