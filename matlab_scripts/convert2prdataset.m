clc
clear

disp('Converting file:');
disp('"../src/parsed_src/parsed.data"');
disp(' ')

if isfile("../src/parsed_src/parsed.data")
    data_input = importdata("../src/parsed_src/parsed.data",','); labels = data_input(:,4);
    structtemp = struct(prdataset(data_input(:,1:3),labels)); structtemp.name = 'Haberman dataset with labels';
    structtemp.featdom = {'Age', 'Year of operation', 'Positive axillary nodes'};
    structtemp.featlab = [(labels);(labels);(labels)];
%     structtemp.featlab = {'Age', 'Year of operation', 'Positive axilllary nodes'};
    converted_input = prdataset(structtemp);
    disp(data_input);
    clear labels; clear structtemp;
    save('haberman','converted_input','-v7.3','-nocompression');
    
    structtemp = struct(prdataset(data_input(:,1:3))); structtemp.name = 'Haberman dataset without labels';
    converted_input_without_labels = prdataset(structtemp);
    
    %clear data_input; clear labels; clear structtemp;
    save('converted_input','converted_input_without_labels','-v7.3','-nocompression');
    
    disp('Done. Converted file from .data to .mat');
else
    clear
    disp('haberman.data found in /src/ has yet to be converted');
    disp('Please run parse_input.py found in /python_script/ prior to running this script');
end
