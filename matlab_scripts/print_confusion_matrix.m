function [] = print_confusion_matrix(confusion_matrix,classes,title)
%PRINT_CONFUSION_MATRIX Takes computed conf_mat and prints it to console
%   Detailed explanation goes here
spec = 'Confusion matrix for:\t%s\n';
fprintf(spec,title);
fprintf(1,'True\t| Estimated Labels\n');
spec = 'Labels\t|\t%s\t%s\t| Totals\n';

fprintf(spec,classes(:,1),classes(:,2));
fprintf(1,'--------|-----------|-------\n');
spec = '%s\t\t|\t%d\t%d\t|\t%d\n';
fprintf(spec,classes(:,1),confusion_matrix(1,1),confusion_matrix(1,2), ...
    (confusion_matrix(1,1) + confusion_matrix(1,2)));
fprintf(spec,classes(:,2),confusion_matrix(2,1),confusion_matrix(2,2), ...
    (confusion_matrix(2,1) + confusion_matrix(2,2)));
fprintf(1,'--------|-----------|-------\n');
spec = 'Totals\t|\t%d\t%d\t|\t%d\n';

fprintf(spec,confusion_matrix(1,1)+confusion_matrix(2,1), ...
    confusion_matrix(1,2)+confusion_matrix(2,2), ...
    confusion_matrix(1,1)+confusion_matrix(2,1)+...
    confusion_matrix(1,2)+confusion_matrix(2,2));
fprintf(1,'\n')
end

