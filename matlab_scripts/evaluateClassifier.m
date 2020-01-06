function [outputArg1,classifier] = evaluateClassifier(Train,Test,M,E)
%EVALUATECLASSIFIER Evaluates a classifier
%   D: A matrix containing both training and testing set [TRAIN;TEST]
%   M: Character array containing which ml method to use ->
%         qdc
%         ldc
%   E: A matrix containing the evaluation method to use on the
%   aformentioned input arguments (D + M)
outputArg1 = [];

switch M
    case 'qdc'
        W = qdc(Train);
        classifier = W;
        if ismember('roc',E) == true
%             disp('Computing ROC');
            temp.data = prroc(Test,Train*{qdc},1,100); temp.data.names = 'qdc ';
            temp.type = 'plote'; temp.method = 'roc';
            if size(outputArg1,1) == 0
                outputArg1 = [temp];
            else
                outputArg1 = [outputArg1;temp];
            end
            clear temp;
        end
        if ismember('conf_matrix',E) == true
%             disp('Computing Confusion Matrix');
            temp.data = confmat(Test*W);
            temp.type = 'disp'; temp.method = 'conf_matrix';
            if size(outputArg1,1) == 0
                outputArg1 = [temp];
            else
                outputArg1 = [outputArg1;temp];
            end
        end
        if ismember('cross_validation',E) == true
            [ERR, STDS] = prcrossval(Train,qdc,5);
            temp.data = [ERR STDS];
            temp.type = 'disp'; temp.method = 'cross_validation';
            if size(outputArg1,1) == 0
                outputArg1 = [temp];
            else
                outputArg1 = [outputArg1;temp];
            end
        end
    case 'knnc'
        [W,~,Error] = knnc(Train);
        classifier = W;
        if ismember('roc',E) == true
%             disp('Computing ROC');
            temp.data = prroc(Test,Train*{knnc},1,100); temp.data.names = 'knnc';
            temp.type = 'plote'; temp.method = 'roc';
            if size(outputArg1,1) == 0
                outputArg1 = [temp];
            else
                outputArg1 = [outputArg1;temp];
            end
            clear temp;
        end
        if ismember('conf_matrix',E) == true
%             disp('Computing Confusion Matrix');
            temp.data = confmat(Test*W);
            temp.type = 'disp'; temp.method = 'conf_matrix';
            if size(outputArg1,1) == 0
                outputArg1 = [temp];
            else
                outputArg1 = [outputArg1;temp];
            end
        end
        if ismember('cross_validation',E) == true
            [ERR, STDS] = prcrossval(Train,knnc,5);
            temp.data = [ERR STDS];
            temp.type = 'disp'; temp.method = 'cross_validation';
            if size(outputArg1,1) == 0
                outputArg1 = [temp];
            else
                outputArg1 = [outputArg1;temp];
            end
        end
    case 'ldc'
        W = ldc(Train);
        classifier = W;
        if ismember('roc',E) == true
%             disp('Computing ROC');
            temp.data = prroc(Test,Train*{ldc},1,100); temp.data.names = 'ldc ';
            temp.type = 'plote'; temp.method = 'roc';
            if size(outputArg1,1) == 0
                outputArg1 = [temp];
            else
                outputArg1 = [outputArg1;temp];
            end
            clear temp;
        end
        if ismember('conf_matrix',E) == true
%             disp('Computing Confusion Matrix');
            temp.data = confmat(Test*W);
            temp.type = 'disp'; temp.method = 'conf_matrix';
            if size(outputArg1,1) == 0
                outputArg1 = [temp];
            else
                outputArg1 = [outputArg1;temp];
            end
        end
        if ismember('cross_validation',E) == true
            [ERR, STDS] = prcrossval(Train,ldc,5);
            temp.data = [ERR STDS];
            temp.type = 'disp'; temp.method = 'cross_validation';
            if size(outputArg1,1) == 0
                outputArg1 = [temp];
            else
                outputArg1 = [outputArg1;temp];
            end
        end
    otherwise
        disp('no training method was provided');
        disp('please provide one to proceed');
end

