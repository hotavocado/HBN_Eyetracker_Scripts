%% for the eye-tracking files

clear all
path =  'C:\PsychToolbox_Experiments\Simon\AA_eyetracker_data\New\'

files = dir([path 'm*'])

all_names = {}
for i = 1:size(files,1)
    
    all_names{end+1,1} = files(i,1).name ;
    
end

all_names_s  = {}

for i = 1:size(files,1)
    
    all_names_s{end+1,1} = all_names{i,1}(1,1:9);
end

unique_names = unique(all_names_s);

for i = 1:size(unique_names,1)
     
    cd  'C:\PsychToolbox_Experiments\Simon\AA_eyetracker_data\New\new\'
    mkdir(unique_names{i,1})
    
  cd  'C:\PsychToolbox_Experiments\Simon\AA_eyetracker_data\New\'  
    spec_files = dir([unique_names{i,1}, '*'])
      spec_files_n = {};
      for j = 1:size(spec_files,1)
      spec_files_n{end+1,1} = spec_files(j,1).name ;
      end

    for k = 1:size(spec_files_n,1)
    movefile(cell2mat(spec_files_n(k,1)),['C:\PsychToolbox_Experiments\Simon\AA_eyetracker_data\New\new\', unique_names{i,1},'/'])
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% for the par files


clear all
path =  'C:\PsychToolbox_Experiments\Simon\AA_PAR-FILES\NEW\'

files = dir([path 'm*'])

all_names = {}
for i = 1:size(files,1)
    
    all_names{end+1,1} = files(i,1).name ;
    
end

all_names_s  = {}

for i = 1:size(files,1)
    
    all_names_s{end+1,1} = all_names{i,1}(1,1:9);
end

unique_names = unique(all_names_s);


for i = 1:size(unique_names,1)
     
    cd  'C:\PsychToolbox_Experiments\Simon\AA_PAR-FILES\NEW\new\'
    mkdir(unique_names{i,1})
    
  cd  'C:\PsychToolbox_Experiments\Simon\AA_PAR-FILES\NEW\'  
    spec_files = dir([unique_names{i,1}, '*'])
      spec_files_n = {};
      for j = 1:size(spec_files,1)
      spec_files_n{end+1,1} = spec_files(j,1).name ;
      end

    for k = 1:size(spec_files_n,1)
    movefile(cell2mat(spec_files_n(k,1)),['C:\PsychToolbox_Experiments\Simon\AA_PAR-FILES\NEW\new\', unique_names{i,1},'/'])
    end
    
end