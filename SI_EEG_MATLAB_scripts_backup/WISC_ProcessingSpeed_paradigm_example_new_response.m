pausekey = KbName('p');
SITE = 'N';     % T = TCD, C = City College, E = EGI in City College
port=0;
par.nrpages = 1;

par.runID= subj_ID{1,1};
par.ExaminationDate =subj_ID{2,1};
 par.recordEEG = 0;

if subj_ID{4,1} == 'y'
par.useEL = 1;  % use the eye tracker?
else  par.useEL = 0; end;

%if subj_ID{5,1} == 'y'
%par.useEL_Calib = 1;  % use the eye tracker?
%else par.useEL_Calib = 0; end;

monitorwidth_cm = 40;   % monitor width in cm
dist_cm = 57;  % viewing distance in cm
%%
color_white = [255 255 255]
BGcolor = color_white ;
hz = 100;
 
whichScreen = 1;

[scresw, scresh]=Screen('WindowSize',whichScreen);  % Get screen resolution
center = [scresw scresh]/2;
fixRect = [center-2 center+2];  % fixation dot
cm2px = scresw/monitorwidth_cm;  % multiplication factor to convert cm to pixels
deg2px = dist_cm*cm2px*pi/180;      % multiplication factor to convert degrees to pixels (uses aproximation tanT ~= T).

%clear
%[X, map] = imread('Users/nicolaslanger/Desktop/AA_CCNY/WISC_Symbol_Search.bmp');

filepath_stimuli  = '/home/eeg/PsychToolbox_Experiments/Simon/WISC_PS/single_stimuli/Practice/'
filepath_responses = '/home/eeg/PsychToolbox_Experiments/Simon/WISC_PS/responses/'
files_stimuli = dir('/home/eeg/PsychToolbox_Experiments/Simon/WISC_PS/single_stimuli/Practice/*.bmp')
files_responses = dir('/home/eeg/PsychToolbox_Experiments/Simon/WISC_PS/responses/*.bmp')

filepath_page = '/home/eeg/PsychToolbox_Experiments/Simon/WISC_PS/'
files_page = dir('/home/eeg/PsychToolbox_Experiments/Simon/WISC_PS/next_page.bmp')

names = {}
for i = 1:size(files_stimuli,1)
    
   names{end+1,1} =files_stimuli(i,1).name;
   all_images(i,:,:,:)= imread([filepath_stimuli, files_stimuli(i,1).name]);
end


for i = 1:size(files_responses,1)
   responses(i,:,:,:)= imread([filepath_responses,files_responses(i,1).name]);
end

next_page = imread([filepath_page,files_page(1,1).name]);
%figure
%image(squeeze(all_images(1,:,:,:)));
%axis square;

%% Order of the Original WISC Symbol Search
order_example = [1 2 1 3 4 5 6;...
                7 3 8 9 10 11 12;...
                13 4 7 13 15 16 2;...
                17 2 18 15 19 8 1 ];

%% Start Paradigm

% trigger codes - can only use these 15: [1 4 5 8 9 12 13 16 17 20 21 24 25 28 29]
par.CD_START  = 1;
par.CD_BUTTONS = [14 15 16];


%Initiate NetStation Connection, Synchronization, and Recording
if par.recordEEG
 %   NetStation('Connect','10.0.0.42')
    NetStation('Synchronize')
    NetStation('StartRecording')
end

%if par.useEL ; Eyetracker_connection_example, 
% end



correct_resp = [1 0 1 0]
Screen('Preference','SkipSyncTests',1)
Screen('Preference', 'VisualDebugLevel', 0);
window = Screen('OpenWindow', whichScreen, BGcolor);

par.activated_resp = zeros(1,4,2)+2;
x = []; y=[];whichButton = [];
SetMouse([638-20],51,1); %SetMouse([1280+638-20],51,1);
for pp = 1:par.nrpages


%if par.useEL, cross = [400,300];f = figure;h1 = plot(cross(1), cross(2),'+');xlim([0 800]);ylim([0 600]);hold ;end
    %window_eye = Screen('OpenWindow', whichScreen_eye, [], [0 0 1280/3 1024/3]); end;



stimrectT = [-15 -15 15 15]; % defines the rescaling / changing size of the stimuli



textures = [];
for i = 1:size(all_images,1)
textures(i,1) = Screen('MakeTexture', window, squeeze(all_images(i,:,:,:)));
end
resp_textures = [];
for i = 1:size(responses,1)
resp_textures(i,1) = Screen('MakeTexture', window, squeeze(responses(i,:,:,:)));
end
next_page_texture = Screen('MakeTexture', window, next_page);

pos_y = 0:-1.5:-11; %11
pos_x = [17,13, 6 2 -2 -6 -10];
pos_resp =[-17, -14];

fprintf('THE SUBJECT IS READING THE INSTRUCTIONS AND PERFORMING THE EXAMPLE TASK');
Screen('TextSize', window, 12);
Screen('DrawText', window, 'The task is to figure out if either one of the two first symbols', 0.05*scresw, 0.05*scresh, 0);
Screen('DrawText', window, 'are presented again in the same line.', 0.05*scresw, 0.10*scresh, 0);
Screen('DrawText', window, 'Press with the left mouse button YES and NO boxes to select your answer.', 0.05*scresw, 0.15*scresh, 0);
Screen('DrawText', window, 'If you accidently press the wrong button you can make a correction by', 0.05*scresw, 0.25*scresh, 0);
Screen('DrawText', window, 'simply clicking on the other response.', 0.05*scresw, 0.30*scresh, 0);
Screen('DrawText', window, 'You have 2 minutes to solve as many trials as possible.', 0.05*scresw, 0.35*scresh, 0);
Screen('DrawText', window, 'This is just an EXAMPLE. Try it!', 0.05*scresw, 0.45*scresh, 0);

Screen('DrawText', window, 'Do not forget to press the arrow to go to the next page', 0.05*scresw, 0.85*scresh, 0);

for j = 1:4
for i = 1:7
Screen('DrawTexture', window, textures(order_example(j,i),1), [], [center center] + [0 50 0 50] + [-deg2px*pos_x(i) -deg2px*pos_y(j) -deg2px*pos_x(i) -deg2px*pos_y(j)] + stimrectT);
end
end

% first is NO, second is YES

% rescaling factor for response size box:
stimrectT_resp = [-40 -30 40 30];

for j = 1:4
for i = 1:2
Screen('DrawTexture', window, resp_textures(i,1), [], [center center]  + [0 50 0 50]+ [-deg2px*pos_resp(i) -deg2px*pos_y(j) -deg2px*pos_resp(i) -deg2px*pos_y(j)] + stimrectT);
% define space for response selection
resp_size_box(j,i,:) = [center center]  + [0 50 0 50]+ [-deg2px*pos_resp(i) -deg2px*pos_y(j) -deg2px*pos_resp(i) -deg2px*pos_y(j)] + stimrectT_resp;
resp_cross(j,i,:) = [center center]  + [0 50 0 50] + [-deg2px*pos_resp(i) -deg2px*pos_y(j) -deg2px*pos_resp(i) -deg2px*pos_y(j)] + stimrectT;
end
end

pos_line_y = 16.5:1.5:37; %3
for j = 1:5
Screen('DrawLine', window,[0 0 0],50,deg2px*pos_line_y(j)+5, scresw-50, deg2px*pos_line_y(j)+5,1);
end

Screen('DrawTexture', window, next_page_texture, [], [760 565 760 565] + stimrectT_resp);



%if par.recordEEG, sendtrigger(par.CD_START,port,SITE,0), end
%if par.useEL, calllib('iViewXAPI', 'iV_SendImageMessage', formatString(256, int8([ num2str(num2str(par.CD_START))])));end;
Screen('Flip', window, [],1,1); % [],1 means that it stays until the next flip
yes = zeros(4,1);
no = zeros(4,1);

%correct response for page 2

perf = 0;
correction = zeros(4,1);
whichButton = 1 ;% initially, will be updated
% get Response clicks

%% get response
HideCursor
%SetMouse(1680,300,1) % middle of the second screen
%SetMouse([1280+638-20],51,1)
SetMouse([638-20],51,1)
ShowCursor(0,whichScreen)


fine = 0;
while fine < 1;
 
    
         %draw over white 

            
            
            
 [clicks,x(end+1,1),y(end+1,1),whichButton(end+1,1)] = GetClicks(whichScreen,0);    
            
 
targ = 1 ;
%     if size(x,1)>1
%         return
%     end
%     
    for resp_b = 1:4
        

    
    
if par.activated_resp(pp,resp_b,1) == 2 && par.activated_resp(pp,resp_b,2) == 2 && x(end) >= resp_cross(resp_b,2,1) && x(end) <= resp_cross(resp_b,2,3) && y(end) >= resp_cross(resp_b,2,2) && y(end) <= resp_cross(resp_b,2,4);
            %yes(c,1) =1;
            targ = 0;
          
            par.activated_resp(pp,resp_b,1) = 1; par.activated_resp(pp,resp_b,2) = 0; 
            Screen('FillRect',window, [255 255 255], [0.58*scresw 0.50*scresh 0.58*scresw+400 0.50*scresh+20]);  
            %Screen('FillRect',window, [255 255 255], [0.05*scresw 0.86*scresh 0.25*scresw+500 0.86*scresh+100]); 
             
            Screen('DrawLine', window,[0 0 0],resp_cross(resp_b,2,1),resp_cross(resp_b,2,2), resp_cross(resp_b,2,3), resp_cross(resp_b,2,4),2);
            Screen('DrawLine', window,[0 0 0],resp_cross(resp_b,2,1),resp_cross(resp_b,2,4), resp_cross(resp_b,2,3), resp_cross(resp_b,2,2),2);
            Screen('Flip', window, [],1);
            
            if correct_resp(resp_b) == squeeze(par.activated_resp(1,resp_b ,1))
               disp(['Trial',num2str(resp_b), ': Correct'])
            else
            disp(['Trial',num2str(resp_b), ': Wrong'])
            end;
               
                
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5                

elseif par.activated_resp(pp,resp_b,2) == 1 && par.activated_resp(pp,resp_b,1) == 0 && x(end) >= resp_cross(resp_b,2,1) && x(end) <= resp_cross(resp_b,2,3) && y(end) >= resp_cross(resp_b,2,2) && y(end) <= resp_cross(resp_b,2,4);
            %yes(c,1) =1;
            targ = 0;
       
            par.activated_resp(pp,resp_b,1) = 1; par.activated_resp(pp,resp_b,2) = 0;
            
    
         %   Screen('DrawTexture', window, resp_textures(i,1), [], [center center]  + [0 50 0 50]+ [-deg2px*pos_resp(i) -deg2px*pos_y(j) -deg2px*pos_resp(i) -deg2px*pos_y(j)] + stimrectT);
            Screen('DrawTexture', window, resp_textures(1,1), [], [center center] + [0 50 0 50] + [-deg2px*pos_resp(1) -deg2px*pos_y(resp_b) -deg2px*pos_resp(1) -deg2px*pos_y(resp_b)] + stimrectT);
            
            Screen('FillRect',window, [255 255 255], [0.58*scresw 0.50*scresh 0.58*scresw+400 0.50*scresh+20]);  
            %Screen('FillRect',window, [255 255 255], [0.05*scresw 0.86*scresh 0.25*scresw+500 0.86*scresh+100]); 
            
            Screen('DrawLine', window,[0 0 0],resp_cross(resp_b,2,1),resp_cross(resp_b,2,2), resp_cross(resp_b,2,3), resp_cross(resp_b,2,4),2);
            Screen('DrawLine', window,[0 0 0],resp_cross(resp_b,2,1),resp_cross(resp_b,2,4), resp_cross(resp_b,2,3), resp_cross(resp_b,2,2),2);
            Screen('Flip', window, [],1);
            
        if correct_resp(resp_b) == squeeze(par.activated_resp(1,resp_b ,1))
                    disp(['Trial',num2str(resp_b), ': Correct'])
                    else
                    disp(['Trial',num2str(resp_b), ': Wrong'])
                    end;
               
                
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5                

  elseif par.activated_resp(pp,resp_b,1) == 2 && par.activated_resp(pp,resp_b,2) == 2 && x(end) >= resp_cross(resp_b,1,1) && x(end) <= resp_cross(resp_b,1,3) && y(end) >= resp_cross(resp_b,1,2) && y(end) <= resp_cross(resp_b,1,4);
            %no(c,1) = 1;
            targ = 0;
          
            par.activated_resp(pp,resp_b,2) = 1; par.activated_resp(pp,resp_b,1) = 0;
            Screen('FillRect',window, [255 255 255], [0.58*scresw 0.50*scresh 0.58*scresw+400 0.50*scresh+20]);  
           % Screen('FillRect',window, [255 255 255], [0.05*scresw 0.86*scresh 0.25*scresw+500 0.86*scresh+100]); 
            
            Screen('DrawLine', window,[0 0 0],resp_cross(resp_b,1,1),resp_cross(resp_b,1,2), resp_cross(resp_b,1,3), resp_cross(resp_b,1,4),2);
            Screen('DrawLine', window,[0 0 0],resp_cross(resp_b,1,1),resp_cross(resp_b,1,4), resp_cross(resp_b,1,3), resp_cross(resp_b,1,2),2);
          Screen('Flip', window, [],1);
            
        if correct_resp(resp_b) == squeeze(par.activated_resp(1,resp_b ,1))
                    disp(['Trial',num2str(resp_b), ': Correct'])
                    else
                    disp(['Trial',num2str(resp_b), ': Wrong'])
                    end;         
                
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5                

  elseif par.activated_resp(pp,resp_b,1) == 1 && par.activated_resp(pp,resp_b,2) == 0 && x(end) >= resp_cross(resp_b,1,1) && x(end) <= resp_cross(resp_b,1,3) && y(end) >= resp_cross(resp_b,1,2) && y(end) <= resp_cross(resp_b,1,4);
            %no(c,1) = 1;
            targ = 0;
          
            par.activated_resp(pp,resp_b,2) = 1; par.activated_resp(pp,resp_b,1) = 0;
            
             Screen('DrawTexture', window, resp_textures(2,1), [], [center center]+ [0 50 0 50]  + [-deg2px*pos_resp(2) -deg2px*pos_y(resp_b) -deg2px*pos_resp(2) -deg2px*pos_y(resp_b)] + stimrectT);
            
            Screen('FillRect',window, [255 255 255], [0.58*scresw 0.50*scresh 0.58*scresw+400 0.50*scresh+20]);  
           % Screen('FillRect',window, [255 255 255], [0.05*scresw 0.86*scresh 0.25*scresw+500 0.86*scresh+100]); 
            
            Screen('DrawLine', window,[0 0 0],resp_cross(resp_b,1,1),resp_cross(resp_b,1,2), resp_cross(resp_b,1,3), resp_cross(resp_b,1,4),2);
            Screen('DrawLine', window,[0 0 0],resp_cross(resp_b,1,1),resp_cross(resp_b,1,4), resp_cross(resp_b,1,3), resp_cross(resp_b,1,2),2);
          Screen('Flip', window, [],1);
            
        if correct_resp(resp_b) == squeeze(par.activated_resp(1,resp_b ,1))
                    disp(['Trial',num2str(resp_b), ': Correct'])
                    else
                    disp(['Trial',num2str(resp_b), ': Wrong'])
                    end;                          
  
elseif sum(sum(par.activated_resp(pp,:,:))) == 4 && x(end) >= 700 && x(end) <= 800 && y(end) >= 555 && y(end) <= 600;              
fine = 1;
targ = 0;
%trial_duration(pp,end+1,1) = toc;
elseif sum(sum(par.activated_resp(pp,:,:))) < 4  && x(end) >= 700 && x(end) <= 800 && y(end) >= 555 && y(end) <= 600;              
     targ = 0;
    Screen('TextSize', window, 12);       
    Screen('DrawText', window, 'You have not completed all the trials.', 0.05*scresw, 0.90*scresh, [255 0 0]);
             Screen('DrawText', window, 'Please complete all trials before you proceed to the next page.', 0.05*scresw, 0.95*scresh, [255 0 0]);
%              Screen('FillRect',window, [255 255 255], [0.05*scresw 0.86*scresh 0.25*scresw+500 0.86*scresh+100]); Screen('Flip', window, [],1);
             Screen('Flip', window, [],1); %WaitSecs(3);

end             
    end           
if targ == 1 
        
            Screen('TextSize', window, 12);
            Screen('DrawText', window, 'No Response recognized: Try Again', 0.58*scresw, 0.50*scresh, [255 0 0]);
            Screen('Flip', window, [],1); %WaitSecs(2);
            %[clicks,x(c,1),y(c,1),whichButton] = GetClicks(whichScreen,0);
            %Screen('FillRect',window, [255 255 255], [0.58*scresw 0.05*scresh 0.58*scresw+400 0.05*scresh+20]);  
            %Screen('Flip', window, [],1);    
                

            
            

end
end

 

      
end

squeeze(par.activated_resp(1,:,:));
 perf = 0;
for i = 1:4
  if correct_resp(i) == squeeze(par.activated_resp(1,i,1))
%     disp(['Trial',num2str(c), ': Correct'])
%     par.resp_click(pp,c) = 1;
    perf = perf+1; 
  end;end

disp(['PERFORMANCE IN THE EXAMPLE: ',num2str(perf), ' of 4', ' correct'])

Screen('TextSize', window, 21);
Screen('DrawText', window, 'EXAMPLE FINISHED', 0.25*scresw, 0.90*scresh, 0);
Screen('TextSize', window, 16);
Screen('DrawText', window, ['You did: ',num2str(perf), ' of 4', ' correct'], 0.25*scresw, 0.95*scresh, 0);
Screen('Flip', window); 
[clicks,x,y,whichButton] = GetClicks(whichScreen,0);

sca;
close all
clearvars -except select subj_ID metafile subj_Name

%save([par.runID , '_WISC_ProcSpeed'],'par', 'trial_duration')

% if par.useEL, 
%     
%     % stop recording
% 		calllib('iViewXAPI', 'iV_StopRecording');
% 
% 		% save recorded data
% 		eyetr_data = formatString(64, int8('User1'));
% 		description = formatString(64, int8('Description1'));
% 		ovr = int32(1);
% 		filename = formatString(256, int8(['/home/eeg/PsychToolbox_Experiments/Simon/AA_eyetracker_data/' subj_ID{1,1} '_WISC_ProcSpeed' '.idf']));
% 		calllib('iViewXAPI', 'iV_SaveData', filename, description, eyetr_data, ovr)
%     
%     calllib('iViewXAPI', 'iV_Disconnect'); end; %unloadlibrary('iViewXAPI');end

%exitLoop = 1

% NetStation('StopRecording')

% %% Show response size box
% 
% stimrectT_resp = [-40 -30 40 30];
% 
% %resp_cross = [center center] + [-deg2px*pos_resp(i) -deg2px*pos_y(j) -deg2px*pos_resp(i) -deg2px*pos_y(j)] + stimrectT_resp
% 
% window = Screen('OpenWindow', whichScreen, BGcolor);


% Screen('DrawLine', window,[255 0 0],resp_cross(1,1,1),resp_cross(1,1,2), resp_cross(1,1,3), resp_cross(1,1,2),2);
% Screen('DrawLine', window,[255 0 0],resp_cross(1,1,1),resp_cross(1,1,4), resp_cross(1,1,3), resp_cross(1,1,4),2);
% Screen('DrawLine', window,[255 0 0],resp_cross(1,1,1),resp_cross(1,1,2), resp_cross(1,1,1), resp_cross(1,1,4),2);
% Screen('DrawLine', window,[255 0 0],resp_cross(1,1,3),resp_cross(1,1,2), resp_cross(1,1,3), resp_cross(1,1,4),2);
% 
%Screen('Flip', window);
% 
% %resp_cross = [center center] + [-deg2px*(pos_resp(i)-1) -deg2px*(pos_y(j)-1) -deg2px*(pos_resp(i)+1) -deg2px*(pos_y(j)+1)] + stimrectT

