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
zlabel('Axillary nodes')
hold off
grid on

figure()
binWidth = 0.1;
banWidth = 0.08;
names = {'Age', 'Operation Year', 'Axillary nodes'};
for i = 1:1:3
    for j = 1:1:3
        subplot(3,3,(3*i)-3+j); grid on;
        xlabel(names{j}); ylabel(names{i}); 
        hold on;
        if j == i
            if j == 3
                banWidth = 0.034;
            end
            livedpts = (min(matrix_survived(:,j)):0.001:1);
            deadpts = (min(matrix_survived(:,j)):0.001:1);
            oof1 = histogram(matrix_survived(:,j),'FaceColor', 'g','Normalization', 'pdf','BinWidth',binWidth);
            oof2 = histogram(matrix_died(:,j),'FaceColor', 'r','Normalization', 'pdf','BinWidth',binWidth);
            [survived,x1] = ksdensity(matrix_survived(:,j),livedpts, 'Function','pdf', 'Bandwidth',banWidth);
            plot(x1,survived,'-g');
            [died,x2] = ksdensity(matrix_died(:,j),deadpts, 'Function','pdf', 'Bandwidth', banWidth);
            plot(x2,died,'-r');
            prex_parzen
        else
            xlim([0 1]); ylim([0 1]);
            plot(matrix_died(:,j), matrix_died(:,i),'or');
            plot(matrix_survived(:,j), matrix_survived(:,i),'og');
        end
        hold off;
    end
end


% [y1,x1] = ksdensity(matrix_survived(:,2),livedpts, 'Function','pdf', 'Bandwidth',banWidth);
%           
% [y2,x1] = ksdensity(matrix_survived(:,3),livedpts, 'Function','pdf', 'Bandwidth',banWidth);
%        
% figure() 
% subplot(2,2,1)
% histogram2(y1,y2,100)
% title('lived axillary vs lived year of operation');
% 
% [y1,x1] = ksdensity(matrix_survived(:,1),livedpts, 'Function','pdf', 'Bandwidth',banWidth);
%      
% [y2,x1] = ksdensity(matrix_survived(:,3),livedpts, 'Function','pdf', 'Bandwidth',banWidth);
%         
% 
% subplot(2,2,2)
% histogram2(y1,y2,100)
% title('lived axillary vs age');
% 
% [y1,x1] = ksdensity(matrix_survived(:,1),livedpts, 'Function','pdf', 'Bandwidth',banWidth);
%    
% [y2,x1] = ksdensity(matrix_survived(:,2),livedpts, 'Function','pdf', 'Bandwidth',banWidth);
%  
% 
% subplot(2,2,3)
% histogram2(y1,y2,100)
% title('lived axillary vs age');
% 
% 
% 
% 
% figure()
% [y1,x1] = ksdensity(matrix_died(:,2),livedpts, 'Function','pdf', 'Bandwidth',banWidth);
%         
% [y2,x1] = ksdensity(matrix_died(:,3),livedpts, 'Function','pdf', 'Bandwidth',banWidth);
%         
% figure() 
% subplot(2,2,1)
% histogram2(y1,y2,100)
% title('died axillary vs died year of operation');
% 
% [y1,x1] = ksdensity(matrix_died(:,1),livedpts, 'Function','pdf', 'Bandwidth',banWidth);
%           
% [y2,x1] = ksdensity(matrix_died(:,3),livedpts, 'Function','pdf', 'Bandwidth',banWidth);
%           
% 
% subplot(2,2,2)
% histogram2(y1,y2,100)
% title('died axillary vs age');
% 
% [y1,x1] = ksdensity(matrix_died(:,1),livedpts, 'Function','pdf', 'Bandwidth',banWidth);
%             
% [y2,x1] = ksdensity(matrix_died(:,2),livedpts, 'Function','pdf', 'Bandwidth',banWidth);
%           
% 
% subplot(2,2,3)
% histogram2(y1,y2,100)
% title('died axillary vs age');

