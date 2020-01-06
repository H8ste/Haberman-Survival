clc
clear
clear classes 
close all;
prwaitbar report
prwarning off
clf('reset')

load haberman.mat
load seed.mat

[Testing,Training] = gendat(converted_input,[20 20],seed);

%evaluating each possible permutation of the dataset features:
%       [1,2,3] [1,2] [1,3] [2,3] [1] [2] [3]

% [1,2,3]
results = [];
results = [results;converted_input*feateval('in-in')];
disp('Found the following error rates for each permuation of the feature set');
disp('[1,2,3]')
disp(results(1))

% [1,2]
temp = struct(converted_input);
temp.data = temp.data(:,[1,2]); temp.featsize = 2;
Training_12 = prdataset(temp,temp.nlab);
results = [results;Training_12*feateval('in-in')];
disp('[1,2]')
disp(results(2))

% [1,3]
temp = struct(converted_input);
temp.data = temp.data(:,[1,3]); temp.featsize = 2;
Training_13 = prdataset(temp,temp.nlab);
results = [results;Training_13*feateval('in-in')];
disp('[1,3]')
disp(results(3))

% [2,3]
temp = struct(converted_input);
temp.data = temp.data(:,[2,3]); temp.featsize = 2;
Training_23 = prdataset(temp,temp.nlab);
results = [results;Training_23*feateval('in-in')];
disp('[2,3]')
disp(results(4))

% [1]
temp = struct(converted_input);
temp.data = temp.data(:,[1]); temp.featsize = 1;
Training_1 = prdataset(temp,temp.nlab);
results = [results;Training_1*feateval('in-in')];
disp('[1]')
disp(results(5))

% [2]
temp = struct(converted_input);
temp.data = temp.data(:,[2]); temp.featsize = 1;
Training_2 = prdataset(temp,temp.nlab);
results = [results;Training_2*feateval('in-in')];
disp('[2]')
disp(results(6))

% [3]
temp = struct(converted_input);
temp.data = temp.data(:,[3]); temp.featsize = 1;
Training_3 = prdataset(temp,temp.nlab);
results = [results;Training_3*feateval('in-in')];
disp('[3]')
disp(results(7))

disp('Top feature set:')
permutations = {'1,2,3','1,2','1,3','2,3','1','2','3'};
[bestScalarCriterion,I] = max(results);
disp(permutations(I));
disp(bestScalarCriterion);