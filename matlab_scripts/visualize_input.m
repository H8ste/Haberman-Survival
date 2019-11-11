clc
clear
close all;

data_input = importdata("../src/parsed_src/parsed.data",',');

matrix_survived = []; matrix_died = [];

for c = 1:1:size(data_input,1)
    if data_input(c,4)==0
        matrix_survived = [matrix_survived; data_input(c,:)]; 
    elseif data_input(c,4)==1
        matrix_died = [matrix_died; data_input(c,:)]; 
    end
end
figure()
hold on
for c = 1:2
    if c == 1
        plot3(matrix_survived(:,1),matrix_survived(:,2),matrix_survived(:,3),'og');
    elseif c == 2
        plot3(matrix_died(:,1),matrix_died(:,2),matrix_died(:,3),'or');
    end
end


xlabel('Age')
ylabel('Operation year')
zlabel('Positive Duration axillary nodes')
hold off
grid on

figure()
binSize = 10;
names = {'Age', 'Operation Year', 'Axillary nodes'};
for i = 1:1:3
    for j = 1:1:3
        subplot(3,3,(3*i)-3+j); grid on;
        ylabel(names{i}); xlabel(names{j});
        
        hold on;
        if j == i
            histogram(matrix_died(:,i),binSize,'FaceColor', 'g','Normalization','probability','BinWidth', 1/binSize);
            histogram(matrix_survived(:,i),binSize,'FaceColor', 'r','Normalization','probability','BinWidth',1/binSize);
            [f,xi] = ksdensity(matrix_died(:,j));
            plot(xi,f,'r');
            [f,xj] = ksdensity(matrix_survived(:,j));
            plot(xj,f,'g');
        else
            xlim([0 1]); ylim([0 1]);
            plot(matrix_died(:,i), matrix_died(:,j),'or');
            plot(matrix_survived(:,i), matrix_survived(:,j),'og');
        end
        hold off;
    end
end

%random forest classifier

