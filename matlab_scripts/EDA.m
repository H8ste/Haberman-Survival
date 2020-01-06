clc
clear
close all;

% Load data
data = importdata('../src/haberman.data');
labels = ["Age", "Year of operation", "Positive axillary nodes", "Survival status"];


% High level statistics of dataset

%%
% number of entries
data_count = size(data,1);

formatSpec = 'Dataset contains %u entries\n\n';
fprintf(formatSpec,data_count); 


%%
% feature information
data_featureCount = size(data,2)-1;
formatSpec = 'Dataset contains %u features\n\t\t%s\t\t%s\t%s\n';
fprintf(formatSpec,data_featureCount,labels(1:3)); 

datasplit_lived = data(data(:,4)==1,:);
datasplit_lived_count = size(datasplit_lived,1);

datasplit_died = data(data(:,4)==2,:);
datasplit_died_count = size(datasplit_died,1);

%Survived
disp('Survived');
data_mean = [sum(datasplit_lived(:,1))/datasplit_lived_count,sum(datasplit_lived(:,2))/datasplit_lived_count,...
    sum(datasplit_lived(:,3))/datasplit_lived_count];
data_std = [std(datasplit_lived(:,1)),std(datasplit_lived(:,2)),std(datasplit_lived(:,3))];
data_min = [min(datasplit_lived(:,1)),min(datasplit_lived(:,2)),min(datasplit_lived(:,3))];
data_25 = [prctile(datasplit_lived(:,1),25),prctile(datasplit_lived(:,2),25),prctile(datasplit_lived(:,3),25)];
data_50 = [prctile(datasplit_lived(:,1),50),prctile(datasplit_lived(:,2),50),prctile(datasplit_lived(:,3),50)];
data_75 = [prctile(datasplit_lived(:,1),75),prctile(datasplit_lived(:,2),75),prctile(datasplit_lived(:,3),75)];
data_max = [max(datasplit_lived(:,1)),max(datasplit_lived(:,2)),max(datasplit_lived(:,3))];
formatSpec1 = 'count\t%i\t\t\t%i\t\t\t\t%i\nmean\t%.3f\t\t%.3f\t\t\t%.3f\n';
formatSpec2 = 'std\t\t%.3f\t\t%.3f\t\t\t%.3f\nmin\t\t%.3f\t\t%.3f\t\t\t%.3f\n';
formatSpec3 = '25%%\t\t%.3f\t\t%.3f\t\t\t%.3f\n50%%\t\t%.3f\t\t%.3f\t\t\t%.3f\n';
formatSpec4 = '75%%\t\t%.3f\t\t%.3f\t\t\t%.3f\nmax\t\t%.3f\t\t%.3f\t\t\t%.3f\n\n';
fprintf(strcat(formatSpec1,formatSpec2,formatSpec3,formatSpec4),...
    datasplit_lived_count,datasplit_lived_count,datasplit_lived_count,data_mean,data_std,data_min,...
    data_25,data_50,data_75,data_max); 

%Died
disp('Died');
data_mean = [sum(datasplit_died(:,1))/datasplit_died_count,sum(datasplit_died(:,2))/datasplit_died_count,...
    sum(datasplit_died(:,3))/datasplit_died_count];
data_std = [std(datasplit_died(:,1)),std(datasplit_died(:,2)),std(datasplit_died(:,3))];
data_min = [min(datasplit_died(:,1)),min(datasplit_died(:,2)),min(datasplit_died(:,3))];
data_25 = [prctile(datasplit_died(:,1),25),prctile(datasplit_died(:,2),25),prctile(datasplit_died(:,3),25)];
data_50 = [prctile(datasplit_died(:,1),50),prctile(datasplit_died(:,2),50),prctile(datasplit_died(:,3),50)];
data_75 = [prctile(datasplit_died(:,1),75),prctile(datasplit_died(:,2),75),prctile(datasplit_died(:,3),75)];
data_max = [max(datasplit_died(:,1)),max(datasplit_died(:,2)),max(datasplit_died(:,3))];
formatSpec1 = 'count\t%i\t\t\t%i\t\t\t\t%i\nmean\t%.3f\t\t%.3f\t\t\t%.3f\n';
formatSpec2 = 'std\t\t%.3f\t\t%.3f\t\t\t%.3f\nmin\t\t%.3f\t\t%.3f\t\t\t%.3f\n';
formatSpec3 = '25%%\t\t%.3f\t\t%.3f\t\t\t%.3f\n50%%\t\t%.3f\t\t%.3f\t\t\t%.3f\n';
formatSpec4 = '75%%\t\t%.3f\t\t%.3f\t\t\t%.3f\nmax\t\t%.3f\t\t%.3f\t\t\t%.3f\n\n';
fprintf(strcat(formatSpec1,formatSpec2,formatSpec3,formatSpec4),...
    datasplit_died_count,datasplit_died_count,datasplit_died_count,data_mean,data_std,data_min,...
    data_25,data_50,data_75,data_max); 

%%
% number of classes
data_classes = unique(data(:,4));
data_classCount = size(data_classes,1);
formatSpec = 'Dataset contains %u classes\n\tSurvived\tDied\n\t%i\t\t\t%i\n\n';
fprintf(formatSpec,data_classCount,data_classes); 

%%
% data-points per class
% data_surv = []; data_died = [];
% for c = 1:1:size(data,1)
%     if data(c,4)==data_classes(1)
%         data_surv = [data_surv; data(c,:)]; 
%     elseif data(c,4)==data_classes(2)
%         data_died = [data_died; data(c,:)]; 
%     end
% end
formatSpec = 'Dataset contains the following entries for each class\n\tSurvived\tDied\n\t%i\t\t\t%i\n\t%.2f%%\t\t%.2f%%\n\n';
fprintf(formatSpec,size(datasplit_lived,1),size(datasplit_died,1),100*size(datasplit_lived,1)/data_count,100*size(datasplit_died,1)/data_count); 

%% Finding distribution of data
% Loads prdataset
load haberman.mat

% Priors
[prior,lablist] = getprior(converted_input,1);
% Mean and covariance %% 0 == unbiased
[mean, covariance] = meancov(converted_input,0);


%% Observations

disp('Found observations:');
disp('- Dataset consist of 2 classes [1, 2] and 3 features [Age, Year_operation, Axil_nodes]');
disp('- Each entry consist a measurement of both features ');
disp('- Dataset contains imbalanced amount of entries for each class [225, 81]');
disp('- Dataset contains non-normalized/standardized data');
disp('- The age of the patients within the dataset varies from 30 to 83, with a mean of 52');
disp('- The mean varies little between patients who survived and those whoe died, in respect to age and year of operation.');
disp('- It is also seen that 50% of the patients who survived have no axil_nodes');
%%
% % Perform Univariate analysis as to understand which features are useful
% % towards classification
% 
% %%%
% % Histogram
% clear g;
% for i = 1:1:3
%     g(1,i)=gramm('x',data(:,i),'color',data(:,4));
%     g(1,i).stat_bin('normalization','pdf','geom','overlaid_bar');
%     g(1,i).set_names('x',labels(i),'y','Probability','color','Survival status');
%     
%     %g(1,i).set_names('y','Probability');
%     %g(1,i).set_names('color','Survival status');
% end
% 
% %Violin
% violin_x = data(:,4);
% for idx = 1:numel(violin_x)
%     violin_x(idx) = 0;
% end
% for i = 1:1:3
%     g(2,i)=gramm('x',data(:,4),'y',data(:,i),'color',data(:,4));
%     g(2,i).stat_violin('normalization','area ','dodge',0,'fill','edge');
%     g(2,i).stat_boxplot('width',0.15);
%     g(2,i).set_names('x','Survival Status','y',labels(i),'color','Survival status','row','Subject');
%     g(2,i).axe_property('xlim',[0 3]);
% end
% 
% g.draw();

%%
figure();
for i = 1:1:3
    subplot(3,1,i);
    hold on;
    pd1 = fitdist(datasplit_lived(:,i),'kernel','BandWidth',1);
    x = min(datasplit_lived(:,i)):0.2:max(datasplit_lived(:,i));
    y1 = pdf(pd1,x);
    plot(x,y1,'Color','g','LineStyle','-')
    histogram(datasplit_lived(:,i),'FaceAlpha',0.2,'Normalization','probability' ...
        ,'BinWidth',0.25,'FaceColor','g');
    pd2 = fitdist(datasplit_died(:,i),'kernel','BandWidth',1);
    x = min(datasplit_died(:,i)):0.2:max(datasplit_died(:,i));
    y2 = pdf(pd2,x);
    plot(x,y2,'Color','r','LineStyle','--')
    histogram(datasplit_died(:,i),'FaceAlpha',0.2,'Normalization','probability' ...
        ,'BinWidth',0.25,'FaceColor','r');
    xlabel(labels(:,i));
    legend
    hold off;
end
temp = struct(converted_input);
temp.featlab = ['1';'2';'3'];
temp2 = prdataset(temp,temp.nlab);
Priors = getprior(temp2)
[~,Covariances_matrices] = meancov(temp2)
struct(converted_input);

figure()
scatterd(converted_input,3);
xlabel(labels(:,1));ylabel(labels(:,2));zlabel(labels(:,3));
legend
grid on