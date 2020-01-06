clc
clear
clear classes 
close all;
prwaitbar report
prwarning off
clf('reset')

load haberman.mat
load seed.mat

labels = ["Age", "Year of operation", "Positive axillary nodes", "Survival status"];

figure(1); 
scatterd(converted_input,3,'legend');
xlabel('Age')
ylabel('Year of Operation')
zlabel('Axillary nodes')

K = size(getlablist(converted_input),1);
M = size(getdata(converted_input),1);

% Extracting training (y) and test data (x)
%seed = randreset;
%state = randreset
[Testing,Training] = gendat(converted_input,[20 20],seed);
% [Testing,Training] = gendat(converted_input,[20 20]);


% Feature selection
% figure(2);
% mdl = fscnca(+Training,Training.nlab);
% relevant_features = [];
% for i = 1:1:size(mdl.FeatureWeights)
%     if mdl.FeatureWeights(i) > 0.01
%        relevant_features = [relevant_features i];
%        disp('New feature found'); 
%        disp(i);
%        disp(mdl.FeatureWeights(i));
%        disp('');
%     end
% end
% 
% % Plotting found features
% plot(mdl.FeatureWeights,'*');
% xlabel('Feature'); xlim([0.5 3.5]); xticks([1 2 3]);
% grid minor
% ax = gca; ax.XGrid = 'off'; ax.YGrid = 'on';

%evaluating each possible permutation of the dataset features:
%       [1,2,3] [1,2] [1,3] [2,3] [1] [2] [3]
%%
% [1,2,3]
fprintf(1,'Evaluating classifiers for all subsets\n');
% fprintf(1,'!!!![1,2,3]!!!!\n')
[QDC123_results,QDC123_classifier] = evaluateClassifier(Training,Testing,'qdc',['roc','conf_matrix','cross_validation']);
[LDC123_results,LDC123_classifier] = evaluateClassifier(Training,Testing,'ldc',['roc','conf_matrix','cross_validation']);
[KNNC123_results,KNNC123_classifier] = evaluateClassifier(Training,Testing,'knnc',['roc','conf_matrix','cross_validation']);


%%
% [1,2]
% Removing feature 3 from both training and test set
% fprintf(1,'!!!![1,2]!!!!\n')
temp = struct(Training);
temp.data = temp.data(:,[1 2]); temp.featsize = 2; 
temp.featlab = temp.featlab([1 2],:); temp.featdom = {temp.featdom(1), temp.featdom(2)};
Training12 = prdataset(temp,temp.nlab);
clear temp;
temp = struct(Testing);
temp.data = temp.data(:,[1 2]); temp.featsize = 2; 
temp.featlab = temp.featlab([1 2],:); temp.featdom = {temp.featdom(1), temp.featdom(2)};
Testing12 = prdataset(temp,temp.nlab);

[QDC12_results,QDC12_classifier] = evaluateClassifier(Training12,Testing12,...
    'qdc',['roc','conf_matrix','cross_validation']);
[LDC12_results,LDC12_classifier] = evaluateClassifier(Training12,Testing12,...
    'ldc',['roc','conf_matrix','cross_validation']);
[KNNC12_results,KNNC12_classifier] = evaluateClassifier(Training12,Testing12,...
    'knnc',['roc','conf_matrix','cross_validation']);


%%
% [1,3]
% Removing feature 2 from both training and test set
% fprintf(1,'!!!![1,3]!!!!\n')
temp = struct(Training);
temp.data = temp.data(:,[1 3]); temp.featsize = 2; 
temp.featlab = temp.featlab([1 3],:); temp.featdom = {temp.featdom(1), temp.featdom(3)};
Training13 = prdataset(temp,temp.nlab);
clear temp;
temp = struct(Testing);
temp.data = temp.data(:,[1 3]); temp.featsize = 2; 
temp.featlab = temp.featlab([1 3],:); temp.featdom = {temp.featdom(1), temp.featdom(3)};
Testing13 = prdataset(temp,temp.nlab);

[QDC13_results,QDC13_classifier] = evaluateClassifier(Training13,Testing13,...
    'qdc',['roc','conf_matrix','cross_validation']);
[LDC13_results,LDC13_classifier] = evaluateClassifier(Training13,Testing13,...
    'ldc',['roc','conf_matrix','cross_validation']);
[KNNC13_results,KNNC13_classifier] = evaluateClassifier(Training13,Testing13,...
    'knnc',['roc','conf_matrix','cross_validation']);



%%
% [2,3]
% Removing feature 1 from both training and test set
% fprintf(1,'!!!![2,3]!!!!\n')
temp = struct(Training);
temp.data = temp.data(:,[2 3]); temp.featsize = 2; 
temp.featlab = temp.featlab([2 3],:); temp.featdom = {temp.featdom(2), temp.featdom(3)};
Training23 = prdataset(temp,temp.nlab);
clear temp;
temp = struct(Testing);
temp.data = temp.data(:,[2 3]); temp.featsize = 2; 
temp.featlab = temp.featlab([2 3],:); temp.featdom = {temp.featdom(2), temp.featdom(3)};
Testing23 = prdataset(temp,temp.nlab);

[QDC23_results,QDC23_classifier] = evaluateClassifier(Training23,Testing23,...
    'qdc',['roc','conf_matrix','cross_validation']);
[LDC23_results,LDC23_classifier] = evaluateClassifier(Training23,Testing23,...
    'ldc',['roc','conf_matrix','cross_validation']);
[KNNC23_results,KNNC23_classifier] = evaluateClassifier(Training23,Testing23,...
    'knnc',['roc','conf_matrix','cross_validation']);



%%
% [1]
% Removing feature 2 and 3 from both training and test set
% fprintf(1,'!!!![1]!!!!\n')
temp = struct(Training);
temp.data = temp.data(:,[1]); temp.featsize = 1; 
temp.featlab = temp.featlab([1],:); temp.featdom = {temp.featdom(1)};
Training1 = prdataset(temp,temp.nlab);
clear temp;
temp = struct(Testing);
temp.data = temp.data(:,[1]); temp.featsize = 1; 
temp.featlab = temp.featlab([1],:); temp.featdom = {temp.featdom(1)};
Testing1 = prdataset(temp,temp.nlab);

[QDC1_results,QDC1_classifier] = evaluateClassifier(Training1,Testing1,...
    'qdc',['roc','conf_matrix','cross_validation']);
[LDC1_results,LDC1_classifier] = evaluateClassifier(Training1,Testing1,...
    'ldc',['roc','conf_matrix','cross_validation']);
[KNNC1_results,KNNC1_classifier] = evaluateClassifier(Training1,Testing1,...
    'knnc',['roc','conf_matrix','cross_validation']);



%%
% [2]
% Removing feature 1 and 3 from both training and test set
% fprintf(1,'!!!![2]!!!!\n')
temp = struct(Training);
temp.data = temp.data(:,[2]); temp.featsize = 1; 
temp.featlab = temp.featlab([2],:); temp.featdom = {temp.featdom(2)};
Training2 = prdataset(temp,temp.nlab);
clear temp;
temp = struct(Testing);
temp.data = temp.data(:,[2]); temp.featsize = 1; 
temp.featlab = temp.featlab([2],:); temp.featdom = {temp.featdom(2)};
Testing2 = prdataset(temp,temp.nlab);

[QDC2_results,QDC2_classifier] = evaluateClassifier(Training2,Testing2,...
    'qdc',['roc','conf_matrix','cross_validation']);
[LDC2_results,LDC2_classifier] = evaluateClassifier(Training2,Testing2,...
    'ldc',['roc','conf_matrix','cross_validation']);
[KNNC2_results,KNNC2_classifier] = evaluateClassifier(Training2,Testing2,...
    'knnc',['roc','conf_matrix','cross_validation']);


%%
% [3]
% Removing feature 1 and 3 from both training and test set
% fprintf(1,'!!!![3]!!!!\n')
temp = struct(Training);
temp.data = temp.data(:,[3]); temp.featsize = 1; 
temp.featlab = temp.featlab([3],:); temp.featdom = {temp.featdom(3)};
Training3 = prdataset(temp,temp.nlab);
clear temp;
temp = struct(Testing);
temp.data = temp.data(:,[3]); temp.featsize = 1; 
temp.featlab = temp.featlab([3],:); temp.featdom = {temp.featdom(3)};
Testing3 = prdataset(temp,temp.nlab);

[QDC3_results,QDC3_classifier] = evaluateClassifier(Training3,Testing3,...
    'qdc',['roc','conf_matrix','cross_validation']);
[LDC3_results,LDC3_classifier] = evaluateClassifier(Training3,Testing3,...
    'ldc',['roc','conf_matrix','cross_validation']);
[KNNC3_results,KNNC3_classifier] = evaluateClassifier(Training3,Testing3,...
    'knnc',['roc','conf_matrix','cross_validation']);

%%
%combining all the results into a cell array

clc;
% qdc_results = {QDC1_results,QDC2_results,QDC3_results,QDC12_results...
%     ,QDC13_results,QDC23_results,QDC123_results};
% ldc_results = {LDC1_results,LDC2_results,LDC3_results,LDC12_results...
%     ,LDC13_results,LDC23_results,LDC123_results};
% knnc_results = {KNNC1_results,KNNC2_results,KNNC3_results,KNNC12_results...
%     ,KNNC13_results,KNNC23_results,KNNC123_results};
qdc_results = {QDC3_results...
    ,QDC13_results,QDC23_results,QDC123_results};
ldc_results = {LDC3_results...
    ,LDC13_results,LDC23_results,LDC123_results};
knnc_results = {KNNC3_results...
    ,KNNC13_results,KNNC23_results,KNNC123_results};
all_results = {qdc_results,ldc_results,knnc_results};
% permutations = {'1','2','3','1,2','1,3','2,3','1,2,3'};
permutations = {'3','1,3','2,3','1,2,3'};

cross_val_bestperm_qdc = [];
cross_val_bestperm_ldc = [];
cross_val_bestperm_knnc = [];
prwarning off
% Checking using cross validation error
%for each classifier type
% disp(size(all_results,2));
for i = 1:1:size(all_results,2)
    lowest_err = 300;
%   for each permutation
    for k = 1:1:size(all_results{1,i},2)
        if all_results{1,i}{1,k}(3).data(:,1) < lowest_err
            lowest_err = all_results{1,i}{1,k}(3).data(:,1);
            switch i
                case 1
                    cross_val_bestperm_qdc = [k;all_results{1,i}{1,k}(3).data(:,1)];
                case 2
                    cross_val_bestperm_ldc = [k;all_results{1,i}{1,k}(3).data(:,1)];
                case 3
                    cross_val_bestperm_knnc = [k;all_results{1,i}{1,k}(3).data(:,1)];
            end
        end
    end
end
disp('Using average error from cross-validation:');
disp('Found best QDC permutation:');
disp(permutations{1,round(cross_val_bestperm_qdc(1))});
disp('Found best LDC permutation:');
disp(permutations{1,round(cross_val_bestperm_ldc(1))});
disp('Found best KNNC permutation:');
disp(permutations{1,round(cross_val_bestperm_knnc(1))});
fprintf(1,'\n')

% qdc_classifiers = {QDC1_classifier,QDC2_classifier,QDC3_classifier,QDC12_classifier...
%     ,QDC13_classifier,QDC23_classifier,QDC123_classifier};
% ldc_classifiers = {LDC1_classifier,LDC2_classifier,LDC3_classifier,LDC12_classifier...
%     ,LDC13_classifier,LDC23_classifier,LDC123_classifier};
% knnc_classifiers = {KNNC1_classifier,KNNC2_classifier,KNNC3_classifier,KNNC12_classifier...
%     ,KNNC13_classifier,KNNC23_classifier,KNNC123_classifier};
% permutations = {'3','1,3','2,3','1,2,3'};
qdc_classifiers = {QDC3_classifier...
    ,QDC13_classifier,QDC23_classifier,QDC123_classifier};
ldc_classifiers = {LDC3_classifier...
    ,LDC13_classifier,LDC23_classifier,LDC123_classifier};
knnc_classifiers = {KNNC3_classifier...
    ,KNNC13_classifier,KNNC23_classifier,KNNC123_classifier};
all_classifier = {qdc_classifiers,ldc_classifiers,knnc_classifiers};

% all_training_sets = {Training1,Training2,Training3,Training12,Training13,Training23,Training};
% all_testing_sets = {Testing1,Testing2,Testing3,Testing12,Testing13,Testing23,Testing};
all_training_sets = {Training3,Training13,Training23,Training};
all_testing_sets = {Testing3,Testing13,Testing23,Testing};

testc_bestperm_qdc = [];
testc_bestperm_ldc = [];
testc_bestperm_knnc = [];

% Checking using testc error
%for each classifier type
for i = 1:1:size(all_classifier,2)
    lowest_err = 300;
%   for each permutation
    for k = 1:1:size(all_classifier{1,i},2)
        [error,~] = testc(all_testing_sets{1,k}*all_classifier{1,i}{1,k});
        if error < lowest_err
            lowest_err = error;
            switch i
                case 1
                    testc_bestperm_qdc = [k;error];
                case 2
                    testc_bestperm_ldc = [k;error];
                case 3
                    testc_bestperm_knnc = [k;error];
            end
        end
    end
end
disp('Using error estimate from testc:');
disp('Found best QDC permutation:');
disp(permutations{1,round(testc_bestperm_qdc(1))});
disp('Found best LDC permutation:');
disp(permutations{1,round(testc_bestperm_ldc(1))});
disp('Found best KNNC permutation:');
disp(permutations{1,round(testc_bestperm_knnc(1))});

%concatenate the found permutations
shown_results = {permutations{1,round(testc_bestperm_qdc(1))}...
     ,permutations{1,round(testc_bestperm_ldc(1))}...,
     ,permutations{1,round(testc_bestperm_knnc(1))}...
     ,permutations{1,round(cross_val_bestperm_qdc(1))}...
     ,permutations{1,round(cross_val_bestperm_ldc(1))}...
     ,permutations{1,round(cross_val_bestperm_knnc(1))}};
shown_results = unique(shown_results)

%% [1,2,3]
%Scatterplot the data

if sum(ismember(shown_results,{'1,2,3'})) == 1 
    disp('Press for next set of plots');
    pause
    disp('[1,2,3]');
    figure()
    hold on;
    subplot(3,1,1)
    scatterd(Training,3);
    subplot(3,1,2)
    scatterd(Training,3);
    subplot(3,1,3)
    scatterd(Training,3);

    %Show classifier boundaries
    subplot(3,1,1)
    plotm(QDC123_classifier,4);
        xlabel(labels(1));ylabel(labels(2));zlabel(labels(3));
        title('Features:[1 2 3]  Classifier:QDC')
        legend('Survived','Died','Survived Contours','Died contours',...
            'Location','bestoutside')
    subplot(3,1,2)
    plotm(LDC123_classifier,4);
        xlabel(labels(1));ylabel(labels(2));zlabel(labels(3));
        title('Features:[1 2 3]  Classifier:LDC')
        legend('Survived','Died','Survived Contours','Died contours',...
            'Location','bestoutside')
    subplot(3,1,3)
    plotm(KNNC123_classifier,4);
        xlabel(labels(1));ylabel(labels(2));zlabel(labels(3));
        title('Features:[1 2 3]  Classifier:KNNC')
        legend('Survived','Died','Survived Contours','Died contours',...
            'Location','bestoutside')
    %Show ROC plots
    figure()
    roc_plot = QDC123_results(1).data;
    roc_plot.error = [roc_plot.error;LDC123_results(1).data.error;...
        KNNC123_results(1).data.error];
    roc_plot.std = [roc_plot.std;LDC123_results(1).data.std;...
        KNNC123_results(1).data.std];
    roc_plot.xvalues = [roc_plot.xvalues;LDC123_results(1).data.xvalues;...
        KNNC123_results(1).data.xvalues];
    roc_plot.names = [roc_plot.names;LDC123_results(1).data.names;...
        KNNC123_results(1).data.names];
    [roc_plot.error roc_plot.xvalues roc_plot.ylabel roc_plot.xlabel] ...
    = deal(1-roc_plot.xvalues,roc_plot.error,'True Positive Rate','False Positive Rate ');
    plote(roc_plot);
    title('Features:[1,2,3]  ROC Curve ')

    %Show confusion matrix
    figure()
    subplot(3,1,1);
    heatmap(QDC123_results(2).data,'ColorbarVisible','off');
    title('Subset:[1,2,3]   Method: QDC');
    xlabel('Estimated Labels'); ylabel('True Labels');
    subplot(3,1,2);
    heatmap(LDC123_results(2).data,'ColorbarVisible','off');
    title('Subset:[1,2,3]   Method: LDC');
    xlabel('Estimated Labels'); ylabel('True Labels');
    subplot(3,1,3);
    heatmap(KNNC123_results(2).data,'ColorbarVisible','off');
    title('Subset:[1,2,3]   Method: KNNC');
    xlabel('Estimated Labels'); ylabel('True Labels');
    print_confusion_matrix(QDC123_results(2).data,['1' '2'],'qdc');
    print_confusion_matrix(LDC123_results(2).data,['1' '2'],'ldc');
    print_confusion_matrix(KNNC123_results(2).data,['1' '2'],'knnc');

    %Show cross-validation error
    spec = '%s  \t|\tCross validation error:\t%f\n';
    fprintf(spec,'qdc',QDC123_results(3).data(:,1));
    fprintf(spec,'ldc',LDC123_results(3).data(:,1));
    fprintf(spec,'knnc',KNNC123_results(3).data(:,1));
    fprintf(1,'\n')
    %Show performance estimation
    fprintf(1,'qdc   \t|\t'); testc(Testing*QDC123_classifier)
    fprintf(1,'ldc   \t|\t'); testc(Testing*LDC123_classifier)
    fprintf(1,'knnc\t|\t');   testc(Testing*KNNC123_classifier)
    fprintf(1,'-----------------------------------------------\n')
    fprintf(1,'\n')
end
%% [1,2]
%Scatterplot the data

if sum(ismember(shown_results,{'1,2'})) == 1 
    disp('Press for next set of plots');
    pause
    disp('[1,2]');
    figure()
    hold on;
    subplot(3,1,1)
    scatterd(Training12,2);
    subplot(3,1,2)
    scatterd(Training12,2);
    subplot(3,1,3)
    scatterd(Training12,2);

    %Show classifier boundaries %maybe use different plotm fucntionhere
    subplot(3,1,1)
    plotm(QDC12_classifier,2);
    plotc(QDC12_classifier);
        xlabel(labels(1));ylabel(labels(2));
        title('Features:[1 2]  Classifier:QDC')
        legend('Survived','Died','Survived Contours','Died contours',...
            'Location','bestoutside')
    subplot(3,1,2)
    plotm(LDC12_classifier,2);
    plotc(LDC12_classifier);
        xlabel(labels(1));ylabel(labels(2));
        title('Features:[1 2]  Classifier:LDC')
        legend('Survived','Died','Survived Contours','Died contours',...
            'Location','bestoutside')
    subplot(3,1,3)
    plotm(KNNC12_classifier,2);
    plotc(KNNC12_classifier);
        xlabel(labels(1));ylabel(labels(2));
        title('Features:[1 2]  Classifier:KNNC')
        legend('Survived','Died','Survived Contours','Died contours',...
            'Location','bestoutside')
    %Show ROC plots
    figure()
    roc_plot = QDC12_results(1).data;
    roc_plot.error = [roc_plot.error;LDC12_results(1).data.error;...
        KNNC12_results(1).data.error];
    roc_plot.std = [roc_plot.std;LDC12_results(1).data.std;...
        KNNC12_results(1).data.std];
    roc_plot.xvalues = [roc_plot.xvalues;LDC12_results(1).data.xvalues;...
        KNNC12_results(1).data.xvalues];
    roc_plot.names = [roc_plot.names;LDC12_results(1).data.names;...
        KNNC12_results(1).data.names];
    [roc_plot.error roc_plot.xvalues roc_plot.ylabel roc_plot.xlabel] ...
    = deal(1-roc_plot.xvalues,roc_plot.error,'True Positive Rate','False Positive Rate ');
    plote(roc_plot);
    title('Features:[1 2]  ROC Curve ')

    %Show confusion matrix
    figure()
    subplot(3,1,1);
    heatmap(QDC12_results(2).data,'ColorbarVisible','off');
    title('Subset:[1,2]   Method: QDC');
    xlabel('Estimated Labels'); ylabel('True Labels');
    subplot(3,1,2);
    heatmap(LDC12_results(2).data,'ColorbarVisible','off');
    title('Subset:[1,2]   Method: LDC');
    xlabel('Estimated Labels'); ylabel('True Labels');
    subplot(3,1,3);
    heatmap(KNNC12_results(2).data,'ColorbarVisible','off');
    title('Subset:[1,2]   Method: KNNC');
    xlabel('Estimated Labels'); ylabel('True Labels');
%     print_confusion_matrix(QDC12_results(2).data,['1' '2'],'qdc');
%     print_confusion_matrix(LDC12_results(2).data,['1' '2'],'ldc');
%     print_confusion_matrix(KNNC12_results(2).data,['1' '2'],'knnc');

    %Show cross-validation error
    spec = '%s  \t|\tCross validation error:\t%f\n';
    fprintf(spec,'qdc',QDC12_results(3).data(:,1));
    fprintf(spec,'ldc',LDC12_results(3).data(:,1));
    fprintf(spec,'knnc',KNNC12_results(3).data(:,1));
    fprintf(1,'\n')
    %Show performance estimation
    fprintf(1,'qdc   \t|\t'); testc(Testing12*QDC12_classifier)
    fprintf(1,'ldc   \t|\t'); testc(Testing12*LDC12_classifier)
    fprintf(1,'knnc\t|\t');   testc(Testing12*KNNC12_classifier)
    fprintf(1,'-----------------------------------------------\n')
    fprintf(1,'\n')
end
%% [1,3]
%Scatterplot the data

if sum(ismember(shown_results,{'1,3'})) == 1 
    disp('Press for next set of plots');
    pause
    figure()
    disp('[1,3]');
    hold on;
    subplot(3,1,1)
    scatterd(Training13,2);
    subplot(3,1,2)
    scatterd(Training13,2);
    subplot(3,1,3)
    scatterd(Training13,2);

    %Show classifier boundaries %maybe use different plotm fucntionhere
    subplot(3,1,1)
    plotm(QDC13_classifier,2);
    plotc(QDC13_classifier);
        xlabel(labels(1));ylabel(labels(3));
        title('Features:[1 3]  Classifier:QDC')
        legend('Survived','Died','Survived Contours','Died contours',...
            'Location','bestoutside')
    subplot(3,1,2)
    plotm(LDC13_classifier,2);
    plotc(LDC13_classifier);
        xlabel(labels(1));ylabel(labels(3));
        title('Features:[1 3]  Classifier:LDC')
        legend('Survived','Died','Survived Contours','Died contours',...
            'Location','bestoutside')
    subplot(3,1,3)
    plotm(KNNC13_classifier,2);
    plotc(KNNC13_classifier);
        xlabel(labels(1));ylabel(labels(3));
        title('Features:[1 3]  Classifier:KNNC')
        legend('Survived','Died','Survived Contours','Died contours',...
            'Location','bestoutside')
    %Show ROC plots
    figure()
    roc_plot = QDC13_results(1).data;
    roc_plot.error = [roc_plot.error;LDC13_results(1).data.error;...
        KNNC13_results(1).data.error];
    roc_plot.std = [roc_plot.std;LDC13_results(1).data.std;...
        KNNC13_results(1).data.std];
    roc_plot.xvalues = [roc_plot.xvalues;LDC13_results(1).data.xvalues;...
        KNNC13_results(1).data.xvalues];
    roc_plot.names = [roc_plot.names;LDC13_results(1).data.names;...
        KNNC13_results(1).data.names];
    [roc_plot.error roc_plot.xvalues roc_plot.ylabel roc_plot.xlabel] ...
    = deal(1-roc_plot.xvalues,roc_plot.error,'True Positive Rate','False Positive Rate ');
    plote(roc_plot);
    title('Features:[1 3]  ROC Curve ')

    %Show confusion matrix
    figure()
    subplot(3,1,1);
    heatmap(QDC13_results(2).data,'ColorbarVisible','off');
    title('Subset:[1,3]   Method: QDC');
    xlabel('Estimated Labels'); ylabel('True Labels');
    subplot(3,1,2);
    heatmap(LDC13_results(2).data,'ColorbarVisible','off');
    title('Subset:[1,3]   Method: LDC');
    xlabel('Estimated Labels'); ylabel('True Labels');
    subplot(3,1,3);
    heatmap(KNNC13_results(2).data,'ColorbarVisible','off');
    title('Subset:[1,3]   Method: KNNC');
    xlabel('Estimated Labels'); ylabel('True Labels');
%     print_confusion_matrix(QDC13_results(2).data,['1' '2'],'qdc');
%     print_confusion_matrix(LDC13_results(2).data,['1' '2'],'ldc');
%     print_confusion_matrix(KNNC13_results(2).data,['1' '2'],'knnc');

    %Show cross-validation error
    spec = '%s  \t|\tCross validation error:\t%f\n';
    fprintf(spec,'qdc',QDC13_results(3).data(:,1));
    fprintf(spec,'ldc',LDC13_results(3).data(:,1));
    fprintf(spec,'knnc',KNNC13_results(3).data(:,1));
    fprintf(1,'\n')
    %Show performance estimation
    fprintf(1,'qdc   \t|\t'); testc(Testing13*QDC13_classifier)
    fprintf(1,'ldc   \t|\t'); testc(Testing13*LDC13_classifier)
    fprintf(1,'knnc\t|\t');   testc(Testing13*KNNC13_classifier)
    fprintf(1,'-----------------------------------------------\n')
    fprintf(1,'\n')
end
%% [2,3]
%Scatterplot the data

if sum(ismember(shown_results,{'2,3'})) == 1 
    disp('Press for next set of plots');
    pause
    disp('[2,3]');
    figure()
    hold on;
    subplot(3,1,1)
    scatterd(Training23,2);
    subplot(3,1,2)
    scatterd(Training23,2);
    subplot(3,1,3)
    scatterd(Training23,2);

    %Show classifier boundaries %maybe use different plotm fucntionhere
    subplot(3,1,1)
    plotm(QDC23_classifier,2);
    plotc(QDC23_classifier);
        xlabel(labels(2));ylabel(labels(3));
        title('Features:[2 3]  Classifier:QDC')
        legend('Survived','Died','Survived Contours','Died contours',...
            'Location','bestoutside')
    subplot(3,1,2)
    plotm(LDC23_classifier,2);
    plotc(LDC23_classifier);
        xlabel(labels(2));ylabel(labels(3));
        title('Features:[2 3]  Classifier:LDC')
        legend('Survived','Died','Survived Contours','Died contours',...
            'Location','bestoutside')
    subplot(3,1,3)
    plotm(KNNC23_classifier,2);
    plotc(KNNC23_classifier);

        xlabel(labels(2));ylabel(labels(3));
        title('Features:[2 3]  Classifier:KNNC')
        legend('Survived','Died','Survived Contours','Died contours',...
            'Location','bestoutside')
    %Show ROC plots
    figure()
    roc_plot = QDC23_results(1).data;
    roc_plot.error = [roc_plot.error;LDC23_results(1).data.error;...
        KNNC23_results(1).data.error];
    roc_plot.std = [roc_plot.std;LDC23_results(1).data.std;...
        KNNC23_results(1).data.std];
    roc_plot.xvalues = [roc_plot.xvalues;LDC23_results(1).data.xvalues;...
        KNNC23_results(1).data.xvalues];
    roc_plot.names = [roc_plot.names;LDC23_results(1).data.names;...
        KNNC23_results(1).data.names];
    [roc_plot.error roc_plot.xvalues roc_plot.ylabel roc_plot.xlabel] ...
    = deal(1-roc_plot.xvalues,roc_plot.error,'True Positive Rate','False Positive Rate ');
    plote(roc_plot);
    title('Features:[2 3]  ROC Curve ')

    %Show confusion matrix
        figure()
    subplot(3,1,1);
    heatmap(QDC23_results(2).data,'ColorbarVisible','off');
    title('Subset:[2,3]   Method: QDC');
    xlabel('Estimated Labels'); ylabel('True Labels');
    subplot(3,1,2);
    heatmap(LDC23_results(2).data,'ColorbarVisible','off');
    title('Subset:[2,3]   Method: LDC');
    xlabel('Estimated Labels'); ylabel('True Labels');
    subplot(3,1,3);
    heatmap(KNNC23_results(2).data,'ColorbarVisible','off');
    title('Subset:[2,3]   Method: KNNC');
    xlabel('Estimated Labels'); ylabel('True Labels');
%     print_confusion_matrix(QDC23_results(2).data,['1' '2'],'qdc');
%     print_confusion_matrix(LDC23_results(2).data,['1' '2'],'ldc');
%     print_confusion_matrix(KNNC23_results(2).data,['1' '2'],'knnc');

    %Show cross-validation error
    spec = '%s  \t|\tCross validation error:\t%f\n';
    fprintf(spec,'qdc',QDC23_results(3).data(:,1));
    fprintf(spec,'ldc',LDC23_results(3).data(:,1));
    fprintf(spec,'knnc',KNNC23_results(3).data(:,1));
    fprintf(1,'\n')
    %Show performance estimation
    fprintf(1,'qdc   \t|\t'); testc(Testing23*QDC23_classifier)
    fprintf(1,'ldc   \t|\t'); testc(Testing23*LDC23_classifier)
    fprintf(1,'knnc\t|\t');   testc(Testing23*KNNC23_classifier)
    fprintf(1,'-----------------------------------------------\n')
    fprintf(1,'\n')
end
%% [1]
%Scatterplot the data

if sum(ismember(shown_results,{'1'})) == 1 
    disp('Press for next set of plots');
    pause
    disp('[1]');
    figure()
    hold on;
    subplot(3,1,1)
    scatterd(Training1,1);
    subplot(3,1,2)
    scatterd(Training1,1);
    subplot(3,1,3)
    scatterd(Training1,1);

    %Show classifier boundaries %maybe use different plotm fucntionhere
    subplot(3,1,1)
    % plotc(QDC23_classifier);
    plotm(QDC1_classifier,2);
        xlabel(labels(1));
        title('Features:[1]  Classifier:QDC')
        legend('Survived','Died','Survived Contours','Died contours',...
            'Location','bestoutside')
    subplot(3,1,2)
    % plotc(LDC1_classifier);
    plotm(LDC1_classifier,2);
        xlabel(labels(1))
        title('Features:[1]  Classifier:LDC')
        legend('Survived','Died','Survived Contours','Died contours',...
            'Location','bestoutside')
    subplot(3,1,3)
    % plotc(KNNC1_classifier);
    plotm(KNNC1_classifier,2);
        xlabel(labels(1))
        title('Features:[1]  Classifier:KNNC')
        legend('Survived','Died','Survived Contours','Died contours',...
            'Location','bestoutside')
    %Show ROC plots
    figure()
    roc_plot = QDC1_results(1).data;
    roc_plot.error = [roc_plot.error;LDC1_results(1).data.error;...
        KNNC1_results(1).data.error];
    roc_plot.std = [roc_plot.std;LDC1_results(1).data.std;...
        KNNC1_results(1).data.std];
    roc_plot.xvalues = [roc_plot.xvalues;LDC1_results(1).data.xvalues;...
        KNNC1_results(1).data.xvalues];
    roc_plot.names = [roc_plot.names;LDC1_results(1).data.names;...
        KNNC1_results(1).data.names];
    [roc_plot.error roc_plot.xvalues roc_plot.ylabel roc_plot.xlabel] ...
    = deal(1-roc_plot.xvalues,roc_plot.error,'True Positive Rate','False Positive Rate ');
    plote(roc_plot);
    title('Features:[1]  ROC Curve ')

    %Show confusion matrix
        figure()
    subplot(3,1,1);
    heatmap(QDC1_results(2).data,'ColorbarVisible','off');
    title('Subset:[1]   Method: QDC');
    xlabel('Estimated Labels'); ylabel('True Labels');
    subplot(3,1,2);
    heatmap(LDC1_results(2).data,'ColorbarVisible','off');
    title('Subset:[1]   Method: LDC');
    xlabel('Estimated Labels'); ylabel('True Labels');
    subplot(3,1,3);
    heatmap(KNNC1_results(2).data,'ColorbarVisible','off');
    title('Subset:[1]   Method: KNNC');
    xlabel('Estimated Labels'); ylabel('True Labels');
%     print_confusion_matrix(QDC1_results(2).data,['1' '2'],'qdc');
%     print_confusion_matrix(LDC1_results(2).data,['1' '2'],'ldc');
%     print_confusion_matrix(KNNC1_results(2).data,['1' '2'],'knnc');

    %Show cross-validation error
    spec = '%s  \t|\tCross validation error:\t%f\n';
    fprintf(spec,'qdc',QDC1_results(3).data(:,1));
    fprintf(spec,'ldc',LDC1_results(3).data(:,1));
    fprintf(spec,'knnc',KNNC1_results(3).data(:,1));
    fprintf(1,'\n')
    %Show performance estimation
    fprintf(1,'qdc   \t|\t'); testc(Testing1*QDC1_classifier)
    fprintf(1,'ldc   \t|\t'); testc(Testing1*LDC1_classifier)
    fprintf(1,'knnc\t|\t');   testc(Testing1*KNNC1_classifier)
    fprintf(1,'-----------------------------------------------\n')
    fprintf(1,'\n')
end
%% [2]
%Scatterplot the data

if sum(ismember(shown_results,{'2'})) == 1 
    disp('Press for next set of plots');
    pause
    disp('[2]');
    figure()
    hold on;
    subplot(3,1,1)
    scatterd(Training2,1);
    subplot(3,1,2)
    scatterd(Training2,1);
    subplot(3,1,3)
    scatterd(Training2,1);

    %Show classifier boundaries %maybe use different plotm fucntionhere
    subplot(3,1,1)
    % plotc(QDC23_classifier);
    plotm(QDC2_classifier,2);
        xlabel(labels(2));
        title('Features:[2]  Classifier:QDC')
        legend('Survived','Died','Survived Contours','Died contours',...
            'Location','bestoutside')
    subplot(3,1,2)
    % plotc(LDC2_classifier);
    plotm(LDC2_classifier,2);
        xlabel(labels(2))
        title('Features:[2]  Classifier:LDC')
        legend('Survived','Died','Survived Contours','Died contours',...
            'Location','bestoutside')
    subplot(3,1,3)
    % plotc(KNNC2_classifier);
    plotm(KNNC2_classifier,2);
        xlabel(labels(2))
        title('Features:[2]  Classifier:KNNC')
        legend('Survived','Died','Survived Contours','Died contours',...
            'Location','bestoutside')
    %Show ROC plots
    figure()
    roc_plot = QDC2_results(1).data;
    roc_plot.error = [roc_plot.error;LDC2_results(1).data.error;...
        KNNC2_results(1).data.error];
    roc_plot.std = [roc_plot.std;LDC2_results(1).data.std;...
        KNNC2_results(1).data.std];
    roc_plot.xvalues = [roc_plot.xvalues;LDC2_results(1).data.xvalues;...
        KNNC2_results(1).data.xvalues];
    roc_plot.names = [roc_plot.names;LDC2_results(1).data.names;...
        KNNC2_results(1).data.names];
    [roc_plot.error roc_plot.xvalues roc_plot.ylabel roc_plot.xlabel] ...
    = deal(1-roc_plot.xvalues,roc_plot.error,'True Positive Rate','False Positive Rate ');
    plote(roc_plot);
    title('Features:[2]  ROC Curve ')

    %Show confusion matrix
        figure()
    subplot(3,1,1);
    heatmap(QDC2_results(2).data,'ColorbarVisible','off');
    title('Subset:[2]   Method: QDC');
    xlabel('Estimated Labels'); ylabel('True Labels');
    subplot(3,1,2);
    heatmap(LDC2_results(2).data,'ColorbarVisible','off');
    title('Subset:[2]   Method: LDC');
    xlabel('Estimated Labels'); ylabel('True Labels');
    subplot(3,1,3);
    heatmap(KNNC2_results(2).data,'ColorbarVisible','off');
    title('Subset:[2]   Method: KNNC');
    xlabel('Estimated Labels'); ylabel('True Labels');
%     print_confusion_matrix(QDC2_results(2).data,['1' '2'],'qdc');
%     print_confusion_matrix(LDC2_results(2).data,['1' '2'],'ldc');
%     print_confusion_matrix(KNNC2_results(2).data,['1' '2'],'knnc');

    %Show cross-validation error
    spec = '%s  \t|\tCross validation error:\t%f\n';
    fprintf(spec,'qdc',QDC2_results(3).data(:,1));
    fprintf(spec,'ldc',LDC2_results(3).data(:,1));
    fprintf(spec,'knnc',KNNC2_results(3).data(:,1));
    fprintf(1,'\n')
    %Show performance estimation
    fprintf(1,'qdc   \t|\t'); testc(Testing2*QDC2_classifier)
    fprintf(1,'ldc   \t|\t'); testc(Testing2*LDC2_classifier)
    fprintf(1,'knnc\t|\t');   testc(Testing2*KNNC2_classifier)
    fprintf(1,'-----------------------------------------------\n')
    fprintf(1,'\n')
end
%% [3]
%Scatterplot the data
if sum(ismember(shown_results,{'3'})) == 1 
    disp('Press for next set of plots');
    pause
    disp('[3]');
    figure()
    hold on;
    subplot(3,1,1)
    scatterd(Training3,1);
    subplot(3,1,2)
    scatterd(Training3,1);
    subplot(3,1,3)
    scatterd(Training3,1);

    %Show classifier boundaries %maybe use different plotm fucntionhere
    subplot(3,1,1)
    % plotc(QDC33_classifier);
    plotm(QDC3_classifier,2);
        xlabel(labels(3));
        title('Features:[3]  Classifier:QDC')
        legend('Survived','Died','Survived Contours','Died contours',...
            'Location','bestoutside')
    subplot(3,1,2)
    % plotc(LDC2_classifier);
    plotm(LDC3_classifier,2);
        xlabel(labels(3))
        title('Features:[3]  Classifier:LDC')
        legend('Survived','Died','Survived Contours','Died contours',...
            'Location','bestoutside')
    subplot(3,1,3)
    % plotc(KNNC2_classifier);
    plotm(KNNC3_classifier,2);
        xlabel(labels(3))
        title('Features:[3]  Classifier:KNNC')
        legend('Survived','Died','Survived Contours','Died contours',...
            'Location','bestoutside')
    %Show ROC plots
    figure()
    roc_plot = QDC3_results(1).data;
    roc_plot.error = [roc_plot.error;LDC3_results(1).data.error;...
        KNNC3_results(1).data.error];
    roc_plot.std = [roc_plot.std;LDC3_results(1).data.std;...
        KNNC3_results(1).data.std];
    roc_plot.xvalues = [roc_plot.xvalues;LDC3_results(1).data.xvalues;...
        KNNC3_results(1).data.xvalues];
    roc_plot.names = [roc_plot.names;LDC3_results(1).data.names;...
        KNNC3_results(1).data.names];
    [roc_plot.error roc_plot.xvalues roc_plot.ylabel roc_plot.xlabel] ...
    = deal(1-roc_plot.xvalues,roc_plot.error,'True Positive Rate','False Positive Rate ');
    plote(roc_plot);
    title('Features:[3]  ROC Curve ')

    %Show confusion matrix
    figure()
    subplot(3,1,1);
    heatmap(QDC3_results(2).data,'ColorbarVisible','off');
    title('Subset:[3]   Method: QDC');
    xlabel('Estimated Labels'); ylabel('True Labels');
    subplot(3,1,2);
    heatmap(LDC3_results(2).data,'ColorbarVisible','off');
    title('Subset:[3]   Method: LDC');
    xlabel('Estimated Labels'); ylabel('True Labels');
    subplot(3,1,3);
    heatmap(KNNC3_results(2).data,'ColorbarVisible','off');
    title('Subset:[3]   Method: KNNC');
    xlabel('Estimated Labels'); ylabel('True Labels');
%     print_confusion_matrix(QDC3_results(2).data,['1' '2'],'qdc');
%     print_confusion_matrix(LDC3_results(2).data,['1' '2'],'ldc');
%     print_confusion_matrix(KNNC3_results(2).data,['1' '2'],'knnc');

    %Show cross-validation error
    spec = '%s  \t|\tCross validation error:\t%f\n';
    fprintf(spec,'qdc',QDC3_results(3).data(:,1));
    fprintf(spec,'ldc',LDC3_results(3).data(:,1));
    fprintf(spec,'knnc',KNNC3_results(3).data(:,1));
    fprintf(1,'\n')
    %Show performance estimation
    fprintf(1,'qdc   \t|\t'); testc(Testing3*QDC3_classifier)
    fprintf(1,'ldc   \t|\t'); testc(Testing3*LDC3_classifier)
    fprintf(1,'knnc\t|\t');   testc(Testing3*KNNC3_classifier)
    fprintf(1,'-----------------------------------------------\n')
    fprintf(1,'\n')
end
%%
%  plotf(converted_input,1);
pause;
close all

prwarning on