
cd C:\PsychToolbox_Experiments\Simon\AA_eyetracker_data\
%[data,textt] = xlsread('Enitan_WISC_ProcSpeed Samples.txt');
%data = importdata('Enitan_WISC_ProcSpeed Samples.txt', '\t');
% [data, var, cas] = tblread('Enitan_WISC_ProcSpeed Samples.txt', '\t');


           
eyetr = Enitan_eyetr


idx_start = [];
idx_NEW_PAGE = [];
 idx_RESP = [];
  idx_CORR = [];
  idx_CORR_RESP = [];
  idx_header = [];
  
for i = 1:size(eyetr,1)

if isempty(strmatch('# Message: 1', eyetr{i,4},'exact')) == 0;
    idx_start(end+1,1) = i; end;
    
    if isempty(strmatch('# Message: 20', eyetr{i,4},'exact')) == 0;
    idx_NEW_PAGE(end+1,1) = i; end;

    if isempty(strmatch('# Message: 14', eyetr{i,4},'exact')) == 0;
    idx_RESP(end+1,1) = i; end;

    if isempty(strmatch('# Message: 15', eyetr{i,4},'exact')) == 0;
    idx_CORR(end+1,1) = i; end;
    
if isempty(strmatch('# Message: 16', eyetr{i,4},'exact')) == 0;
    idx_CORRRESP(end+1,1) = i; end;

if isempty(strmatch('Time', eyetr{i,1},'exact')) == 0;
    idx_header(end+1,1) = i; end;

end

%Sampling Rate of Eyetracker = 60Hz => 100ms = 6 timepoints
time_window = [6 30]

%L_X_px_TG_L = [];
%L_X_px_start = [];

% for i = 1:size(eyetr,2)
%     
%     
% for j = 1:size(idx_TG_L,1)        
% if isempty(strmatch('L Raw X [px]', eyetr{idx_header,i},'exact')) == 0;
%     L_X_px_TG_L(j,:) =[eyetr{(idx_TG_L(j)-time_window(1)):(idx_TG_L(j)-1),i}, eyetr{((idx_TG_L(j)+1):(idx_TG_L(j)+1)+time_window(2)),i}]; end;
% end
% 
% for j = 1:size(idx_start,1)        
% if isempty(strmatch('L Raw X [px]', eyetr{idx_header,i},'exact')) == 0;
%     L_X_px_start(j,:) =[eyetr{(idx_start(j)-time_window(1)):(idx_start(j)-1),i}, eyetr{((idx_start(j)+1):(idx_start(j)+1)+time_window(2)),i}]; end;
% end
% 
% 
% 
% end


% all_R_X_px = [];
% all_R_Y_px = [];
% all_L_X_px = [];
% all_L_Y_px = [];

all_R_X_px = zeros(size(eyetr,1),1);
all_R_Y_px = zeros(size(eyetr,1),1);
all_L_X_px = zeros(size(eyetr,1),1);
all_L_Y_px = zeros(size(eyetr,1),1);


for i = 1:size(eyetr,2)
for j = idx_header+1:size(eyetr,1)

    
%if isempty(strmatch('L Raw X [px]', eyetr{idx_header,i},'exact')) == 0 && isnumeric(cell2mat(eyetr(j,i))) == 1 && isempty(cell2mat(eyetr(j,i))) == 0 ;
if isempty(strmatch('L POR X [px]', eyetr(idx_header,i),'exact')) == 0 && isnumeric(cell2mat(eyetr(j,i))) == 1 && isempty(cell2mat(eyetr(j,i))) == 0 ;

%all_L_X_px(end+1,1) = cell2mat(eyetr(j,i)); end;
all_L_X_px(j,1) = cell2mat(eyetr(j,i)); end;

%if isempty(strmatch('L Raw Y [px]', eyetr{idx_header,i},'exact')) == 0 && isnumeric(cell2mat(eyetr(j,i))) == 1 && isempty(cell2mat(eyetr(j,i))) == 0 ;
if isempty(strmatch('L POR Y [px]', eyetr(idx_header,i),'exact')) == 0 && isnumeric(cell2mat(eyetr(j,i))) == 1 && isempty(cell2mat(eyetr(j,i))) == 0 ;
    
    %all_L_Y_px(end+1,1) = cell2mat(eyetr(j,i)); end;
    all_L_Y_px(j,1) = cell2mat(eyetr(j,i)); end;


%if isempty(strmatch('R Raw X [px]', eyetr{idx_header,i},'exact')) == 0 && isnumeric(cell2mat(eyetr(j,i))) == 1 && isempty(cell2mat(eyetr(j,i))) == 0 ;
if isempty(strmatch('R POR X [px]', eyetr(idx_header,i),'exact')) == 0 && isnumeric(cell2mat(eyetr(j,i))) == 1 && isempty(cell2mat(eyetr(j,i))) == 0 ;

    %all_R_X_px(end+1,1) = cell2mat(eyetr(j,i)); end;
    all_R_X_px(j,1) = cell2mat(eyetr(j,i)); end;

%if isempty(strmatch('R Raw Y [px]', eyetr{idx_header,i},'exact')) == 0 && isnumeric(cell2mat(eyetr(j,i))) == 1 && isempty(cell2mat(eyetr(j,i))) == 0 ;
if isempty(strmatch('R POR Y [px]', eyetr(idx_header,i),'exact')) == 0 && isnumeric(cell2mat(eyetr(j,i))) == 1 && isempty(cell2mat(eyetr(j,i))) == 0 ;

    %all_R_Y_px(end+1,1) = cell2mat(eyetr(j,i)); end;
    all_R_Y_px(j,1) = cell2mat(eyetr(j,i)); end;
end
end


%% average left and right eye


all_X_px = mean([all_L_X_px all_R_X_px],2);
all_Y_px = mean([all_L_Y_px all_R_Y_px],2);

%all_X_px = all_X_px(1655:end,:);
%all_Y_px = all_Y_px(1655:end,:);
%%
whichScreen = 2;
   color_white = [255 255 255];
BGcolor = color_white ;

page_path = 'C:\PsychToolbox_Experiments\Simon\WISC_PS\page_printscreens\'
page_name = 'page2.jpg'
page2 = imread([page_path, page_name]);

%% PLOTTING

monitorwidth_cm = 40;   % monitor width in cm
dist_cm = 57;  % viewing distance in cm
%%
color_white = [255 255 255]
BGcolor = color_white ;
hz = 100;
 
whichScreen = 2;

[scresw, scresh]=Screen('WindowSize',whichScreen);  % Get screen resolution
center = [scresw scresh]/2;
fixRect = [center-2 center+2];  % fixation dot
cm2px = scresw/monitorwidth_cm;  % multiplication factor to convert cm to pixels
deg2px = dist_cm*cm2px*pi/180;  

window = Screen('OpenWindow', whichScreen, BGcolor);
lineperline = 11:-1.5:-11;
j =1;
  

page2_t = Screen('MakeTexture', window, page2);
  Screen('BlendFunction', window, GL_ONE, GL_ZERO);
  % Screen('BlendFunction', window, GL_DST_ALPHA, GL_ZERO);
Screen('DrawTexture', window, page2_t, []); 
for i = idx_NEW_PAGE:size(all_X_px,1)

      if i == idx_RESP(j,1);
   j = j+1;
    end
    
    %Screen('DrawDots', window, [all_X_px(i,1),all_Y_px(i,1)], 10, [255 0 0]); Screen(window, 'Flip',[],1);
if all_X_px(i,1)>0
Screen('BlendFunction', window, GL_DST_ALPHA, GL_ZERO);
% Screen('BlendFunction', window, GL_ONE_MINUS_DST_ALPHA, GL_ONE);
 Screen('DrawDots', window, [all_X_px(i,1),center(1,2)+ -deg2px*lineperline(1,j)], 10, [255 0 0], [],1); Screen(window, 'Flip',[],1);
        
    WaitSecs(50/1000) %adapt that to the relative duration of the page
 
end
end
sca
