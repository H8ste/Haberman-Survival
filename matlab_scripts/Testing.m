clc;
clear;
load fisheriris;

rng(0,'twister'); % For reproducibility
%Count amount of entries
numObs = length(species);
%Create order (random permuations)
p = randperm(numObs);
%Randomize entries with respect to permuations
meas = meas(p,:);
%Reorder label matrix with respect to permutations
species = species(p);

%Split into training and test samples
half = floor(numObs/2);
training = meas(1:half,:);
trainingSpecies = species(1:half);

%Create classifier using input data and input data labels
Mdl = fitcdiscr(training,trainingSpecies);

%Using test samples,
sample = meas(half+1:end,:);
%Predict the samples with respect to the created classifier
grouphat = predict(Mdl,sample);

%Compare the predicted samples with the test samples uing confusionmat
group = species(half+1:end);
[C,order] = confusionmat(group,grouphat,'Order',{'setosa','versicolor','virginica'})