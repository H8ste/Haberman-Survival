clc
clear
clear classes 
close all;
prwaitbar report

clf('reset')

load haberman.mat


K = size(getlablist(converted_input),1);
M = size(getdata(converted_input),1);

% struct(converted_input)
% 
class1.data = getdata(seldat(converted_input,1));
class2.data = getdata(seldat(converted_input,2));
% 
% % extracting training (y) and test data (x)
[y,x] = gendat(converted_input,[round(size(class1.data,1)*0.6) round(size(class1.data,1)*0.3)]);
% 
% % Builiding classifiers
% w1 = qdc(y); w2 = ldc(y); w3 = nmsc(y); w4 = knnc(y);
% 
% 
% 
% figure(1)
% scatterd(converted_input);hold on;
% subplot(221);scatterd(converted_input,3);hold on; plotm(w1,5);hold off;
% subplot(222);scatterd(converted_input,3);hold on; plotm(w2,5);hold off;
% subplot(223);scatterd(converted_input,3);hold on; plotm(w3,2);hold off;
% subplot(224);scatterd(converted_input,3);hold on; plotm(w4,2);hold off;
% 
% 
% 
% disp('Classification errors are:');
% disp([testc(x*w1) testc(x*w2) testc(x*w3) testc(x*w4)])
%
% figure(2); hold on;
% subplot(221);r1 = prroc(x,w1,2,100); hold on;plote(r1);hold off;
% subplot(222);r2 = prroc(x,w2,2,100); hold on;plote(r2);hold off;
% subplot(223);r3 = prroc(x,w3,2,100); hold on;plote(r3);hold off;
% subplot(224);r4 = prroc(x,w4,2,100); hold on;plote(r4);hold off;

%{
% Find parameters for each class
for k=1:K
   class(k).mean = mean(getdata(seldat(y,k)))';
   class(k).cov = cov(getdata(seldat(y,k)));
   class(k).prior = size(getdata(seldat(y,k)),1)/M; %amount of each class found in datainput compared to total seen
   class(k).scalar = -log(det(class(k).cov))+2*log(class(k).prior)-class(k).mean'*inv(class(k).cov)*class(k).mean;
   class(k).vector = 2*inv(class(k).cov)*class(k).mean;
   class(k).matrix = -inv(class(k).cov);
end

% Load data without labels
load haberman_without_labels.mat

% Find total number of feature vectors
M=size(getdata(x),1); 
x2 = getdata(x)';

% Classify each feature vector
J=zeros(K,1); C=zeros(M,1);
for m=1:M
    for k=1:K
        J(k)=class(k).scalar+x2(:,m)'*class(k).vector+x2(:,m)'*class(k).matrix*x2(:,m); 
    end
    [tmp,C(m)]=max(J); 
end

% Calculate error rate
E = sum(C~=x.nlab)/M

%}

% n = 50; a = 2; b = 1.5;
% x = (-2:0.01:10)'; y = gampdf(x,a,b);
% z = dataset(gamrnd(a,b,n,1),genlab(n));
% 
% w = parzenm(z,1);
% 
% figure; scatterd(z); axis([-2 10 0 0.3]);
% plotm(w,1); hold on; plot(x,y,':');
[W1,H] = parzendc(y);
W2 = ldc(y);
W3 = qdc(y);




%figure()
%scatterd(y);
%plotc({W});

% results = [ ; ; ]; lowestResults= [100;100;100]; prwarning(0); W4 =
% randomforestc(y); for decisionTrees = 170:1:300
%     disp(decisionTrees) for featureSize = 1:1:3
%         Classifier = randomforestc(y,decisionTrees,featureSize);
%         %disp('DecisionTrees: '); %disp(decisionTrees)
%         %disp('FeatureSize: ' ); %disp(featureSize); %disp('TestResults:
%         ' ); %disp(testc(x*Classifier)); %results = [results,
%         [decisionTrees;featureSize;testc(x*Classifier)]]; if
%         testc(x*Classifier) < lowestResults(3,:,1)
%             disp('lower result has been found:'); disp('new:');
%             disp(testc(x*Classifier)); disp('old:');
%             disp(lowestResults(3,:,1)); lowestResults =
%             [decisionTrees;featureSize;testc(x*Classifier)]; W4 =
%             Classifier;
%         end
%     end
% end
prwarning(2);
disp('Done');



W4 = naivebc(y);

[W5] = svc(y,proxm('p',3));
[W6, ~ , ER] = knnc(y,5);

%%sample = x;
%%grouphat = predict(W5, sample);
figure()
subplot(3,2,1);
type = 4;
scatterd(y,2)                      % show scatterplot
plotm(W5,type); plotc(W5);
hold on; 
%scatterd(y(J,:),3,'o')
title('W5 - Support vector machine')
xlabel('Age')
ylabel('Year of Operation')
zlabel('Axillary nodes')

subplot(3,2,2);
scatterd(y,2)                      % show scatterplot
plotm(W1,type);  plotc(W1);
hold on; 
%scatterd(y(J,:),3,'o')
title('W1 - ParzenDC')
xlabel('Age')
ylabel('Year of Operation')
zlabel('Axillary nodes')


subplot(3,2,3);
scatterd(y,2)                      % show scatterplot
plotm(W2,type); plotc(W2);
hold on; 
%scatterd(y(J,:),3,'o')
title('W2 - LDC')
xlabel('Age')
ylabel('Year of Operation')
zlabel('Axillary nodes')

subplot(3,2,4);
scatterd(y,2)                      % show scatterplot
plotm(W3,type); plotc(W3);
hold on; 
%scatterd(y(J,:),3,'o')
title('W3 - QDC')
xlabel('Age')
ylabel('Year of Operation')
zlabel('Axillary nodes')

subplot(3,2,5);
scatterd(y,2)                      % show scatterplot
plotm(W4,type);  plotc(W4);
hold on; 
%scatterd(y(J,:),3,'o')
title('W4 - Naive bayes')
xlabel('Age')
ylabel('Year of Operation')
zlabel('Axillary nodes')

subplot(3,2,6);
scatterd(y,2)                      % show scatterplot
plotm(W6,type); plotc(W6);
hold on; 
%scatterd(y(J,:),3,'o')
title('W4 - KNC')
xlabel('Age')
ylabel('Year of Operation')
zlabel('Axillary nodes')


disp([testc(x*W1), testc(x*W2), testc(x*W3), testc(x*W4), testc(x*W5)]);
% plot classifier 

%figure; scatterd(y,2);
%plotm(w,1); 

%figure(); hold on;
%plot3(results(1,:),results(2,:),results(3,:));



prwaitbar
prwaitbar(0)             %closes loop level
prwaitbar off             %removes waitbar