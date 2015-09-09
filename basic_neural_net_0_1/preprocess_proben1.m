function preprocess_proben1(dummy_arg)
% This is the entry point for preprocessing data.

    if nargin == 0 %%debug
        clc
    end

    function read_dt_files(filename, data_name)
        fid = fopen(filename,'r');
        if fid ~= -1
            data = fscanf(fid, '%*8c%d\n', [2, 1]);
            input_count = sum(data);
            
            data = fscanf(fid, '%*9c%d\n', [2, 1]);
            output_count = sum(data);
            
            data = fscanf(fid, '%*18c%d\n', [1, 1]);            
            training_count = data;
            
            data = fscanf(fid, '%*20c%d\n', [1, 1]);           
            validation_count = data;
            
            data = fscanf(fid, '%*14c%d\n', [1, 1]);           
            test_count = data;
            
            sample_count = training_count + validation_count + test_count;
            
            data = fscanf(fid, '%g', [input_count + output_count, sample_count])';
            
            training.inputs = data(1:training_count, 1:input_count);
            training.outputs = data(1:training_count, (input_count+1):end);
            training.classes = classes_from_outputs(training.outputs);
            validation_start = training_count + 1;
            validation_end = training_count + validation_count;
            
            validation.inputs = data(validation_start:validation_end, 1:input_count);
            validation.outputs = data(validation_start:validation_end, (input_count+1):end);
            validation.classes = classes_from_outputs(validation.outputs);           
            
            output_start = validation_end + 1;
            
            test.inputs = data(output_start:end, 1:input_count);
            test.outputs = data(output_start:end, (input_count+1):end);
            test.classes = classes_from_outputs(test.outputs);

            save(data_name, 'training', 'validation', 'test', ...
                'input_count', 'output_count', ...
                'training_count', 'validation_count', 'test_count');
            
        else
             fprintf('\t\tERROR: Could not open the file. Please check the path.\n');
        end
        
        
    end

    filenames = {...   
            './proben1/building/building1.dt',...
            './proben1/building/building2.dt',...
            './proben1/building/building3.dt',...
            './proben1/cancer/cancer1.dt',...
            './proben1/cancer/cancer2.dt',...
            './proben1/cancer/cancer3.dt',...
            './proben1/card/card1.dt',...
            './proben1/card/card2.dt',...
            './proben1/card/card3.dt',...
            './proben1/diabetes/diabetes1.dt',...
            './proben1/diabetes/diabetes2.dt',...
            './proben1/diabetes/diabetes3.dt',...
            './proben1/flare/flare1.dt',...
            './proben1/flare/flare2.dt',...
            './proben1/flare/flare3.dt',...
            './proben1/gene/gene1.dt',...
            './proben1/gene/gene2.dt',...
            './proben1/gene/gene3.dt',...
            './proben1/glass/glass1.dt',...
            './proben1/glass/glass2.dt',...
            './proben1/glass/glass3.dt',...
            './proben1/heart/heart1.dt',...
            './proben1/heart/heart2.dt',...
            './proben1/heart/heart3.dt',...
            './proben1/heart/heartc1.dt',...
            './proben1/heart/heartc2.dt',...
            './proben1/heart/heartc3.dt',...            
            './proben1/heart/hearta1.dt',...
            './proben1/heart/hearta2.dt',...
            './proben1/heart/hearta3.dt',...
            './proben1/heart/heartac1.dt',...
            './proben1/heart/heartac2.dt',...
            './proben1/heart/heartac3.dt',...  
            './proben1/horse/horse1.dt',...  
            './proben1/horse/horse2.dt',...  
            './proben1/horse/horse3.dt',...  
            './proben1/mushroom/mushroom1.dt',...
            './proben1/mushroom/mushroom2.dt',...
            './proben1/mushroom/mushroom3.dt',...        
            './proben1/soybean/soybean1.dt',...
            './proben1/soybean/soybean2.dt',...
            './proben1/soybean/soybean3.dt',...        
            './proben1/thyroid/thyroid1.dt',...
            './proben1/thyroid/thyroid2.dt',...
            './proben1/thyroid/thyroid3.dt',...
        };

    global preprocessed_names;
    
    preprocessed_names = {...
            'building1',...
            'building2',...
            'building3',...
            'cancer1',...
            'cancer2',...
            'cancer3',...
            'card1',...
            'card2',...
            'card3',...
            'diabetes1',...
            'diabetes2',...
            'diabetes3',...
            'flare1',...
            'flare2',...
            'flare3',...
            'gene1',...
            'gene2',...
            'gene3',...
            'glass1',...
            'glass2',...
            'glass3',...
            'heart1',...
            'heart2',...
            'heart3',...
            'heartc1',...
            'heartc2',...
            'heartc3',...
            'hearta1',...
            'hearta2',...
            'hearta3',...
            'heartac1',...
            'heartac2',...
            'heartac3',...
            'horse1'...
            'horse2'...
            'horse3'...
            'mushroom1',...
            'mushroom2',...
            'mushroom3',...        
            'soybean1',...
            'soybean2',...
            'soybean3',...        
            'thyroid1',...
            'thyroid2',...
            'thyroid3',...
    };
    
    fprintf('\tPreprocessing proben1...\n');

    for k=1:length(filenames)
        fprintf('\t\t Preprocessing %s\n', char(filenames(k)));        
        read_dt_files(char(filenames(k)), char(preprocessed_names(k)));        
    end
end    