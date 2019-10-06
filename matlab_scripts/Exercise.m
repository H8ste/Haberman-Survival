close all;
prload detection
struct(z);

class1.data = getdata(seldat(z,1));
class2.data = getdata(seldat(z,2));

% extracting training (y) and test data (x)
[y,x] = gendat(z,[round(size(class1.data,1)*0.3) round(size(class1.data,1)*0.3)]);

% Builiding classifiers
w1 = qdc(y); w2 = ldc(y); w3 = nmsc(y); w4 = knnc(y);

figure(1)
z*scatterd;hold on;
subplot(221);scatterd(z);hold on; plotm(w1,2);
subplot(222);scatterd(z);hold on; plotm(w2,2);
subplot(223);scatterd(z);hold on; plotm(w3,2);
subplot(224);scatterd(z);hold on; plotm(w4,2);

disp('Classification errors are:');
disp([testc(x*w1) testc(x*w2) testc(x*w3) testc(x*w4)])

%% Toolbox - ROC plots from exercise 2
% figure(2)
% r1 = roc(x*w1); plote(r1);
% figure
% r2 = roc(x*w2); plote(r2);
% figure
% r3 = roc(x*w3); plote(r3);
% figure
% r4 = roc(x*w4); plote(r4);

%% ROC plots
w = qdc(y);                       % Train a classifier with train data
r = prroc(x*w);                     % Compute the ROC curve with test data (see pp.40)
r.error = 1 - r.error;            % Just to get something similar to Fig 2.13(b)

% Plot and input the labels
figure(3)
plote(r); xlabel('P_{fa}'); ylabel('P_{det}'); axis equal tight; grid on;


%% This might be used for manual something
class1.mean = mean(class1.data); class2.mean = mean(class2.data); 
class1.var = var(class1.data); class2.var = var(class2.data);

% in example for this...
threshhold = (class2.mean - class1.mean)/2