%close all
%clear all

moviename1 = '/home/eeg/PsychToolbox_Experiments/Simon/Clips/Diary_of_a_Wimpy_Kid_Trailer.mp4'; % duration 2min
%moviename2 = '/home/eeg/PsychToolbox_Experiments/Simon/Clips/EHow_Math_v2.mp4'; % duration 1:305min
moviename3 = '/home/eeg/PsychToolbox_Experiments/Simon/Clips/Fun_Fractals_v2.m4v'; % duration 4:40min
%moviename4 = '/home/eeg/PsychToolbox_Experiments/Simon/Clips/Pre_Alg_Cut.mp4'; % duration 1:30min
%moviename5 = '/home/eeg/PsychToolbox_Experiments/Simon/Clips/ReadingClip_Cut.mp4'; %duration 2:48 mind
moviename6 = '/home/eeg/PsychToolbox_Experiments/Simon/Clips/Three_Little_Kittens_Despicable_Me.mp4'; %2:50min
moviename7 = '/home/eeg/PsychToolbox_Experiments/Simon/Clips/The_Present.mp4'; %4:18min

%movie_presentation_order = {};
%moviename_select = {moviename1(41:end); moviename2(41:end); moviename3(41:end); moviename4(41:end); moviename5(41:end); moviename6(41:end)};
%moviename_all = {moviename1; moviename2; moviename3; moviename4; moviename5; moviename6};

movie_presentation_order = {};
moviename_select = {moviename1(41:end); moviename3(41:end); moviename6(41:end); moviename7(41:end)};
moviename_all = {moviename1; moviename3; moviename6; moviename7};

[exclude,v] = listdlg('PromptString','Select a movies to exclude:',...
                'SelectionMode','multiple','ListSize',[300,160],'CancelString','INCLUDE ALL',...
                'OKString','EXCLUDE selected','ListString',moviename_select);

all_for_rand = [1 2 3];           
 
% all_for_rand = 1:1:6;     
 
ind = randperm(length(all_for_rand))

block_perm = all_for_rand(ind);
            
 if isempty(exclude)== 0 
        
      block_perm = all_for_rand(ind);
     block_perm  = setxor(block_perm ,exclude,'stable'); 
 else
     block_perm = all_for_rand(ind);
 end
block_perm(4) = 4;
%     
%      % number 3 (fun fractals is a own block)
%     ind_fractals = find(block_perm ==3);
    
    
        
    
  
pausekey = KbName('p');
SITE = 'N';     % T = TCD, C = City College, E = EGI in City College
port=0;     
     
par.runID= subj_ID{1,1};
par.ExaminationDate =subj_ID{2,1};
if subj_ID{3,1} == 'y'
par.recordEEG = 1;
else par.recordEEG = 0; end;

if subj_ID{4,1} == 'y'
par.useEL = 1;  % use the eye tracker?
else  par.useEL = 0; end;

if subj_ID{5,1} == 'y'
par.useEL_Calib = 1;  % use the eye tracker?
else par.useEL_Calib = 0; end;

monitorwidth_cm = 40;   % monitor width in cm
dist_cm = 68;  % viewing distance in cm
%%
color_white = [255 255 255]
par.BGcolor = color_white ;
hz = 100;
 
whichScreen = 1;
[scresw, scresh]=Screen('WindowSize',whichScreen);
center = [scresw scresh]/2;  
% Instructions:
Screen('Preference','SkipSyncTests',1)
Screen('Preference', 'VisualDebugLevel', 0);
window = Screen('OpenWindow', whichScreen, par.BGcolor);
 Screen('TextSize', window, 21);
Screen('DrawText', window, 'Now you can watch video clips', 0.15*scresw, 0.40*scresh, 0);
Screen('DrawText', window, 'Enjoy!', 0.15*scresw, 0.50*scresh, 0);
Screen('DrawText', window, 'Press to begin', 0.15*scresw, 0.60*scresh, 0);
Screen('Flip', window); 
% Waits for the user to press a button before starting
[clicks,x,y,whichButton] = GetClicks(whichScreen,0);

%% if callibration
if subj_ID{5,1} == 'y'
%window = Screen('OpenWindow', whichScreen, par.BGcolor);
files_eye_calib = dir('/home/eeg/PsychToolbox_Experiments/Simon/general_matlabfiles/eye_calib.bmp');
filepath_eye_calib = '/home/eeg/PsychToolbox_Experiments/Simon/general_matlabfiles/';
eye_calib_img = imread([filepath_eye_calib,files_eye_calib(1,1).name]);
eye_calib = Screen('MakeTexture', window, eye_calib_img);
stimrect_calib = [-20 -20 20 20];
 
Screen('TextSize', window, 18);
Screen('DrawText', window, 'First we have to measure the position of your eyes.', 0.05*scresw, 0.40*scresh, 0);
Screen('DrawText', window, 'Just follow with your eyes the circle:', 0.05*scresw, 0.45*scresh, 0);
Screen('DrawTexture', window, eye_calib, [], [center(1)-10 450 center(1)+10 470] + stimrect_calib);
Screen('DrawText', window, 'Press to begin', 0.05*scresw, 0.65*scresh, 0);
Screen('Flip', window); 
fprintf('THE SUBJECT IS READING THE INSTRUCTIONS...');
    [clicks,x,y,whichButton] = GetClicks(whichScreen,0);
else par.useEL_Calib = 0; end;



save([par.runID , '_movie_order'],'block_perm','exclude','movie_presentation_order', 'moviename_all','moviename_select','par')    

% %ind_fractals = 1;
% i = 1;
% if isempty(ind_fractals) == 0 && ind_fractals == 1 || isempty(ind_fractals) == 0 && ind_fractals == 2 
% 
% 
% %% 1st Movie
% par.CD_START  = 83;
% par.CD_END = 103;
% 
%  %par.CD_SECONDS = 44;
% %tt = 0;
% 
% %Initiate NetStation Connection, Synchronization, and Recording
% if par.recordEEG
%  %   NetStation('Connect','10.0.0.42')
%     NetStation('Synchronize')
%     NetStation('StartRecording')
% end
% 
% if par.useEL && par.useEL_Calib; Eyetracker_connection_calib; 
% elseif par.useEL == 1 && par.useEL_Calib == 0; Eyetracker_connection_passive; end
%  
% 
% [d p] = playmovie(moviename_all{3}, num2str(par.CD_START), num2str(par.CD_END), ivx, i)
% %[d p] = playmovie(moviename_all{block_perm(2)}, num2str(par.CD_START), num2str(par.CD_END), ivx, i)
% 
% %Screen('PlayMovie', moviePtr, 0);
% Screen('TextSize', window, 25);
% Screen('DrawText', window, 'THE END OF THE MOVIE ', 0.18*scresw, 0.45*scresh, 0);
% Screen('DrawText', window, 'We proceed with the next task... ', 0.18*scresw, 0.55*scresh, 0);
% Screen('Flip', window,1);
% WaitSecs(3)
% Screen('CloseAll');
% sca
% 
%  movie_presentation_order{end+1,1} = moviename_all{3}(41:end);
% 
% else 
%     
    
    
%% 1st Movie
par.CD_START  = 80+block_perm(1);
par.CD_END = 100+block_perm(1);
 %par.CD_SECONDS = 44;
%tt = 0;

%Initiate NetStation Connection, Synchronization, and Recording
if par.recordEEG
 %   NetStation('Connect','10.0.0.42')
    NetStation('Synchronize')
    NetStation('StartRecording')
end

%% OPEN THE PORTS TO BE ABLE TO SEND TRIGGERS
if par.useEL, open_udp_socket; end

if par.useEL && par.useEL_Calib; Eyetracker_connection_calib, 
elseif par.useEL == 1 && par.useEL_Calib == 0; Eyetracker_connection_passive; end




[d p] = playmovie(moviename_all{block_perm(1)}, num2str(par.CD_START), num2str(par.CD_END),sock)
        


sca    
movie_presentation_order{end+1,1} = moviename_select(block_perm(1));




if par.useEL, 
    pnet(sock,'write','end');
pnet(sock,'writepacket');
    % stop recording   
%     
% [success, ivx]=iViewX('stoprecording', ivx);
% [success, ivx]=iViewX('datafile', ivx, ['C:\PsychToolbox_Experiments\Simon\AA_eyetracker_data\' subj_ID{1,1} '_Video1'  '.idf']);
% 
% [success, ivx]=iViewX('clearbuffer', ivx);
% [success, ivx]=iViewX('closeconnection', ivx);
% if success~=1
%     fprintf([mfilename ': could not close connection./n']);
% end
end




NetStation('StopRecording')
save([par.runID , '_movie_order'],'block_perm','exclude','movie_presentation_order', 'moviename_all','moviename_select','par')    
 
save([par.runID , '_Video1'],'block_perm','exclude','movie_presentation_order','par') 
close all
clearvars -except select subj_ID metafile subj_Name 



% 
% %% 3rd Movie
% 
% 
% par.CD_START  = 83;
% %par.CD_SECONDS = 44;
% tt= 0;
% 
% %Initiate NetStation Connection, Synchronization, and Recording
% % if par.recordEEG
% %     NetStation('Connect','10.0.0.42')
% %     NetStation('Synchronize')
% %     NetStation('StartRecording')
% % end
% % 
% % if par.useEL && par.useEL_Calib; Eyetracker_connection_calib, 
% % elseif par.useEL == 1 && par.useEL_Calib == 0; Eyetracker_connection_passive; end
% 
% 
% %Place full path for movie here.  For example, 
% % moviename = '/home/eeg/Users/Desktop/moviename.avi'
% 
% Screen('Preference','SkipSyncTests',1)
% Screen('Preference', 'VisualDebugLevel', 0);
% hsc = Screen('OpenWindow',whichScreen);
% 
% [moviePtr duration fps count] = Screen('OpenMovie',hsc,moviename3);
% Screen('PlayMovie',moviePtr,1);
% format long;
% sec1 = zeros(count,1);
% i = 1;
% time = GetSecs;
% 
%  if par.recordEEG, sendtrigger(par.CD_START,port,SITE,0), end
%     if par.useEL, calllib('iViewXAPI', 'iV_SendImageMessage', formatString(256, int8([ num2str(num2str(par.CD_START))])));end;
% 
% 
% while ~KbCheck
%     tex = Screen('GetMovieImage', hsc, moviePtr);
%     
%     if tex<=0
%         break
%     end
%     Screen('DrawTexture',hsc,tex);
%     vbl = Screen('Flip',hsc);
%     if vbl >=time+1 %Tests if a second has passed 
%         time = vbl; %changes testing value of time    
%        tt = tt+1;
% if par.recordEEG, sendtrigger(tt,port,SITE,0); end
%             if par.useEL, calllib('iViewXAPI', 'iV_SendImageMessage', formatString(256, int8([ num2str(tt)])));end;
%             
%         sec1(i) = vbl; %here you can change what you want done at per second 
%         i = i+1;% In this case it gives the time that is detected as 1 second
%                        
%     end
%     Screen('Close',tex);
% end
%         
% Screen('PlayMovie', moviePtr, 0);
% Screen('CloseMovie', moviePtr);
% Screen('CloseAll');
% sca

% j = find(sec1);
% sec1 = sec1(j);
% timediff = diff(sec1); % will give the difference of each value of sec1
%NetStation('Disconnect')