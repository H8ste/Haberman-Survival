clc
clear

data_input = importdata("../src/parsed_src/parsed.data",',');

count_survived = 0;
count_died = 0;

matrix_survived = [];
matrix_died = [];

for c = 1:1:size(data_input,1)
    if data_input(c,4)==0
        matrix_survived = [matrix_survived; data_input(c,:)]; 
    elseif data_input(c,4)==1
        matrix_died = [matrix_died; data_input(c,:)]; 
    end
end

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
zlabel('Positive Duration sxillary nodes')
hold off
grid on

