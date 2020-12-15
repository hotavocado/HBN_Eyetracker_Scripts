%% Digit Span



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


%%

monitorwidth_cm = 40;   % monitor width in cm
dist_cm = 68;  % viewing distance in cm

whichScreen = 2;
%whichScreen_eye = 1;

[scresw, scresh]=Screen('WindowSize',whichScreen);  % Get screen resolution
center = [scresw scresh]/2;     % useful to have the pixel coordinates of the very center of the screen (usually where you have someone fixate)
fixRect = [center-2 center+2];  % fixation dot
hz=Screen('FrameRate', whichScreen,1);

cm2px = scresw/monitorwidth_cm;  % multiplication factor to convert cm to pixels
deg2px = dist_cm*cm2px*pi/180;      % multiplication factor to convert degrees to pixels (uses aproximation tanT ~= T).

load gammafnCRT   % load the gamma function parameters for this monitor - or some other CRT and hope they're similar! (none of our questions rely on precise quantification of physical contrast)
maxLum = GrayLevel2Lum(255,Cg,gam,b0);
par.BGcolor=Lum2GrayLevel(maxLum/2,Cg,gam,b0);

 
whichScreen = 2;

par.CD_START  = 98;
 par.CD_eyeO = 20;
 par.CD_eyeC = 30
 

%Initiate NetStation Connection, Synchronization, and Recording
if par.recordEEG
    %NetStation('Connect','10.0.0.42')
    NetStation('Synchronize')
    NetStation('StartRecording')
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Sound Stuff %% STIMULI

%% FORWARD

wavfilename_probe_forward_1a = 'C:\PsychToolbox_Experiments\Simon\digit_span\Digit_span_forward_1a.wav'
wavfilename_probe_forward_1b = 'C:\PsychToolbox_Experiments\Simon\digit_span\Digit_span_forward_1b.wav'
wavfilename_probe_forward_2a = 'C:\PsychToolbox_Experiments\Simon\digit_span\Digit_span_forward_2a.wav'
wavfilename_probe_forward_2b = 'C:\PsychToolbox_Experiments\Simon\digit_span\Digit_span_forward_2b.wav'
wavfilename_probe_forward_3a = 'C:\PsychToolbox_Experiments\Simon\digit_span\Digit_span_forward_3a.wav'
wavfilename_probe_forward_3b = 'C:\PsychToolbox_Experiments\Simon\digit_span\Digit_span_forward_3b.wav'
wavfilename_probe_forward_4a = 'C:\PsychToolbox_Experiments\Simon\digit_span\Digit_span_forward_4a.wav'
wavfilename_probe_forward_4b = 'C:\PsychToolbox_Experiments\Simon\digit_span\Digit_span_forward_4b.wav'
wavfilename_probe_forward_5a = 'C:\PsychToolbox_Experiments\Simon\digit_span\Digit_span_forward_5a.wav'
wavfilename_probe_forward_5b = 'C:\PsychToolbox_Experiments\Simon\digit_span\Digit_span_forward_5b.wav'
wavfilename_probe_forward_6a = 'C:\PsychToolbox_Experiments\Simon\digit_span\Digit_span_forward_6a.wav'
wavfilename_probe_forward_6b = 'C:\PsychToolbox_Experiments\Simon\digit_span\Digit_span_forward_6b.wav'
wavfilename_probe_forward_7a = 'C:\PsychToolbox_Experiments\Simon\digit_span\Digit_span_forward_7a.wav'
wavfilename_probe_forward_7b = 'C:\PsychToolbox_Experiments\Simon\digit_span\Digit_span_forward_7b.wav'

[y_probe_forward_1a, freq1] = wavread(wavfilename_probe_forward_1a);
[y_probe_forward_1b, freq2] = wavread(wavfilename_probe_forward_1b);
[y_probe_forward_2a, freq1] = wavread(wavfilename_probe_forward_2a);
[y_probe_forward_2b, freq2] = wavread(wavfilename_probe_forward_2b);
[y_probe_forward_3a, freq1] = wavread(wavfilename_probe_forward_3a);
[y_probe_forward_3b, freq2] = wavread(wavfilename_probe_forward_3b);
[y_probe_forward_4a, freq1] = wavread(wavfilename_probe_forward_4a);
[y_probe_forward_4b, freq2] = wavread(wavfilename_probe_forward_4b);
[y_probe_forward_5a, freq1] = wavread(wavfilename_probe_forward_5a);
[y_probe_forward_5b, freq2] = wavread(wavfilename_probe_forward_5b);
[y_probe_forward_6a, freq1] = wavread(wavfilename_probe_forward_6a);
[y_probe_forward_6b, freq2] = wavread(wavfilename_probe_forward_6b);
[y_probe_forward_7a, freq1] = wavread(wavfilename_probe_forward_7a);
[y_probe_forward_7b, freq2] = wavread(wavfilename_probe_forward_7b);

wavedata_probe_forward_1a = y_probe_forward_1a';
wavedata_probe_forward_1b = y_probe_forward_1b';
wavedata_probe_forward_2a = y_probe_forward_2a';
wavedata_probe_forward_2b = y_probe_forward_2b';
wavedata_probe_forward_3a = y_probe_forward_3a';
wavedata_probe_forward_3b = y_probe_forward_3b';
wavedata_probe_forward_4a = y_probe_forward_4a';
wavedata_probe_forward_4b = y_probe_forward_4b';
wavedata_probe_forward_5a = y_probe_forward_5a';
wavedata_probe_forward_5b = y_probe_forward_5b';
wavedata_probe_forward_6a = y_probe_forward_6a';
wavedata_probe_forward_6b = y_probe_forward_6b';
wavedata_probe_forward_7a = y_probe_forward_7a';
wavedata_probe_forward_7b = y_probe_forward_7b';

duration_probe_forward_1a = size(wavedata_probe_forward_1a,2)/freq1
duration_probe_forward_1b = size(wavedata_probe_forward_1b,2)/freq1
duration_probe_forward_2a = size(wavedata_probe_forward_2a,2)/freq1
duration_probe_forward_2b = size(wavedata_probe_forward_2b,2)/freq1
duration_probe_forward_3a = size(wavedata_probe_forward_3a,2)/freq1
duration_probe_forward_3b = size(wavedata_probe_forward_3b,2)/freq1
duration_probe_forward_4a = size(wavedata_probe_forward_4a,2)/freq1
duration_probe_forward_4b = size(wavedata_probe_forward_4b,2)/freq1
duration_probe_forward_5a = size(wavedata_probe_forward_5a,2)/freq1
duration_probe_forward_5b = size(wavedata_probe_forward_5b,2)/freq1
duration_probe_forward_6a = size(wavedata_probe_forward_6a,2)/freq1
duration_probe_forward_6b = size(wavedata_probe_forward_6b,2)/freq1
duration_probe_forward_7a = size(wavedata_probe_forward_7a,2)/freq1
duration_probe_forward_7b = size(wavedata_probe_forward_7b,2)/freq1

nrchannels = size(wavedata_probe_forward_1a,1); % Number of rows == number of channels.
% Add 15 msecs latency on Windows, to protect against shoddy drivers:
sugLat = [];
if IsWin
    sugLat = 0.015;
end

InitializePsychSound(0)

pamaster = PsychPortAudio('Open', [], 1+8, 1, freq1, nrchannels, [], sugLat);

pasound_probe_forward_1a = PsychPortAudio('OpenSlave', pamaster, 1);
pasound_probe_forward_1b  = PsychPortAudio('OpenSlave', pamaster, 1);
pasound_probe_forward_2a = PsychPortAudio('OpenSlave', pamaster, 1);
pasound_probe_forward_2b  = PsychPortAudio('OpenSlave', pamaster, 1);
pasound_probe_forward_3a = PsychPortAudio('OpenSlave', pamaster, 1);
pasound_probe_forward_3b  = PsychPortAudio('OpenSlave', pamaster, 1);
pasound_probe_forward_4a = PsychPortAudio('OpenSlave', pamaster, 1);
pasound_probe_forward_4b  = PsychPortAudio('OpenSlave', pamaster, 1);
pasound_probe_forward_5a = PsychPortAudio('OpenSlave', pamaster, 1);
pasound_probe_forward_5b  = PsychPortAudio('OpenSlave', pamaster, 1);
pasound_probe_forward_6a = PsychPortAudio('OpenSlave', pamaster, 1);
pasound_probe_forward_6b  = PsychPortAudio('OpenSlave', pamaster, 1);
pasound_probe_forward_7a = PsychPortAudio('OpenSlave', pamaster, 1);
pasound_probe_forward_7b  = PsychPortAudio('OpenSlave', pamaster, 1);

% Create audio buffers prefilled with the 3 sounds:
pabuffer_probe_forward_1a = PsychPortAudio('CreateBuffer', [], wavedata_probe_forward_1a);
pabuffer_probe_forward_1b = PsychPortAudio('CreateBuffer', [], wavedata_probe_forward_1b);
pabuffer_probe_forward_2a = PsychPortAudio('CreateBuffer', [], wavedata_probe_forward_2a);
pabuffer_probe_forward_2b = PsychPortAudio('CreateBuffer', [], wavedata_probe_forward_2b);
pabuffer_probe_forward_3a = PsychPortAudio('CreateBuffer', [], wavedata_probe_forward_3a);
pabuffer_probe_forward_3b = PsychPortAudio('CreateBuffer', [], wavedata_probe_forward_3b);
pabuffer_probe_forward_4a = PsychPortAudio('CreateBuffer', [], wavedata_probe_forward_4a);
pabuffer_probe_forward_4b = PsychPortAudio('CreateBuffer', [], wavedata_probe_forward_4b);
pabuffer_probe_forward_5a = PsychPortAudio('CreateBuffer', [], wavedata_probe_forward_5a);
pabuffer_probe_forward_5b = PsychPortAudio('CreateBuffer', [], wavedata_probe_forward_5b);
pabuffer_probe_forward_6a = PsychPortAudio('CreateBuffer', [], wavedata_probe_forward_6a);
pabuffer_probe_forward_6b = PsychPortAudio('CreateBuffer', [], wavedata_probe_forward_6b);
pabuffer_probe_forward_7a = PsychPortAudio('CreateBuffer', [], wavedata_probe_forward_7a);
pabuffer_probe_forward_7b = PsychPortAudio('CreateBuffer', [], wavedata_probe_forward_7b);


% Start master immediately, wait for it to be started. We won't stop the
% master until the end of the session.
PsychPortAudio('Start', pamaster, 0, 0, 1);

% Set the masterVolume for the master: This volume setting affects all
% attached sound devices. We set this to 0.5, so it doesn't blow out the
% ears of our listeners...
PsychPortAudio('Volume', pamaster, 0.5);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%Place full path for movie here.  For example, 
% moviename = 'C:\Users\Desktop\moviename.avi'
Screen('Preference','SkipSyncTests',1)
Screen('Preference', 'VisualDebugLevel', 0);
window = Screen('OpenWindow', whichScreen, par.BGcolor);

% eyeO = [10:60:310];
% eyeC = [30:60:330];

% eyeO = [10:60:370];
% eyeC = [30:60:390];



files_eye_calib = dir('C:\PsychToolbox_Experiments\Simon\general_matlabfiles\eye_calib.bmp')
filepath_eye_calib = 'C:\PsychToolbox_Experiments\Simon\general_matlabfiles\'
eye_calib_img = imread([filepath_eye_calib,files_eye_calib(1,1).name]);
eye_calib = Screen('MakeTexture', window, eye_calib_img);
stimrect_calib = [-20 -20 20 20];


 if par.recordEEG, sendtrigger(par.CD_START,port,SITE,0), end
    if par.useEL, calllib('iViewXAPI', 'iV_SendImageMessage', formatString(256, int8([ num2str(num2str(par.CD_START))])));end;

    
    Screen('TextSize', window, 21);
Screen('DrawText', window, 'Fixate on the central cross.', 0.2*scresw, 0.15*scresh, 255);
    Screen('TextSize', window, 17);
Screen('DrawText', window, 'I am going to say some numbers. Listen carefully!', 0.05*scresw, 0.35*scresh, 255);
Screen('DrawText', window, 'and when I am through, say them right after me.', 0.05*scresw, 0.40*scresh, 255);
%Screen('DrawText', window, 'If I say:', 0.05*scresw, 0.5*scresh, 255);
if subj_ID{5,1} == 'y'
Screen('DrawText', window, 'First we have to measure the position of your eyes.', 0.05*scresw, 0.60*scresh, 255);
Screen('DrawText', window, 'Just follow with your eyes the circle:', 0.05*scresw, 0.65*scresh, 255);
Screen('DrawTexture', window, eye_calib, [], [center(1)-10 450 center(1)+10 470] + stimrect_calib);
else par.useEL_Calib = 0; end;
Screen('Flip', window); 
[clicks,x,y,whichButton] = GetClicks(whichScreen,0);    
fprintf('THE SUBJECT IS READING THE INSTRUCTIONS');

%% Calibration
if par.useEL && par.useEL_Calib; Eyetracker_connection_calib; 
elseif par.useEL == 1 && par.useEL_Calib == 0; Eyetracker_connection_passive; end
if par.useEL && par.useEL_Calib;
window = Screen('OpenWindow', whichScreen, par.BGcolor);
end
time = GetSecs;
%while ~KbCheck
 
%sec1 = zeros(count,1);
i = 1;
t = 1;
tr = 1


    while t <2 %8 if  you want to run 6 cycles
        
        
    %% 1st trial
        
   % tex = Screen('GetMovieImage', hsc, moviePtr);
    Screen('DrawText', window, 'Ready for the first one?', 0.31*scresw, 0.1*scresh, 255);
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
    
    [start_clicks,x,y,whichButton] = GetClicks(whichScreen,0);  
    
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
        if par.recordEEG, sendtrigger(tr,port,SITE,0); end
        if par.useEL, calllib('iViewXAPI', 'iV_SendImageMessage', formatString(256, int8([ num2str(num2str(tr))])));end;
      
        pahandle = PsychPortAudio('Open', [], [], 0, [], nrchannels);
        PsychPortAudio('FillBuffer', pahandle, pasound_probe_forward_1a);
        PsychPortAudio('Start', pahandle, 1, 0, 1);
        [end_clicks,x,y,whichButton_1st] = GetClicks(whichScreen,0); 
        digit_forward_total_score(tr) = whichButton_1st;
        tr = tr+1;
        
   %     
        
    Screen('DrawText', window, 'Ready?', 0.45*scresw, 0.1*scresh, 255);
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
    
    [start_clicks,x,y,whichButton] = GetClicks(whichScreen,0);  
    
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
        if par.recordEEG, sendtrigger(tr,port,SITE,0); end
        if par.useEL, calllib('iViewXAPI', 'iV_SendImageMessage', formatString(256, int8([ num2str(num2str(tr))])));end;
      
        pahandle = PsychPortAudio('Open', [], [], 0, [], nrchannels);
        PsychPortAudio('FillBuffer', pahandle, pasound_probe_forward_1b);
        PsychPortAudio('Start', pahandle, 1, 0, 1);
        [end_clicks,x,y,whichButton_2nd] = GetClicks(whichScreen,0); 
        digit_forward_total_score(tr) = whichButton_2nd; 
        tr = tr+1;
        
if whichButton_1st == 3 && whichButton_2nd == 3 
% EEG
NetStation('StopRecording')
%Eye-tracker
% stop recording
calllib('iViewXAPI', 'iV_StopRecording');
% save recorded data
eyetr_data = formatString(64, int8('User1'));
description = formatString(64, int8('Description1'));
ovr = int32(1);
filename = formatString(256, int8(['C:\PsychToolbox_Experiments\Simon\AA_eyetracker_data\' subj_ID{1,1} '_Digit_Span_forward' '.idf']));
calllib('iViewXAPI', 'iV_SaveData', filename, description, eyetr_data, ovr)
calllib('iViewXAPI', 'iV_Disconnect'); 

clear whichButton_1st whichButton_2nd
clearvars -except select subj_ID metafile subj_Name t
%unloadlibrary('iViewXAPI');end
sca
t = t+1;
WaitSecs(4)
return
end;
        
        
        clear whichButton_1st whichButton_2nd
        
    %% 2nd trial     
     Screen('DrawText', window, 'Ready?', 0.45*scresw, 0.1*scresh, 255);
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
    
    [start_clicks,x,y,whichButton] = GetClicks(whichScreen,0);  
    
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
        if par.recordEEG, sendtrigger(tr,port,SITE,0); end
        if par.useEL, calllib('iViewXAPI', 'iV_SendImageMessage', formatString(256, int8([ num2str(num2str(tr))])));end;
      
        pahandle = PsychPortAudio('Open', [], [], 0, [], nrchannels);
        PsychPortAudio('FillBuffer', pahandle, pasound_probe_forward_2a);
        PsychPortAudio('Start', pahandle, 1, 0, 1);
        [end_clicks,x,y,whichButton_1st] = GetClicks(whichScreen,0); 
        digit_forward_total_score(tr) = whichButton_1st;
        tr = tr+1;
    
    %
    
    Screen('DrawText', window, 'Ready?', 0.45*scresw, 0.1*scresh, 255);
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
    
    [start_clicks,x,y,whichButton] = GetClicks(whichScreen,0);  
    
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
        if par.recordEEG, sendtrigger(tr,port,SITE,0); end
        if par.useEL, calllib('iViewXAPI', 'iV_SendImageMessage', formatString(256, int8([ num2str(num2str(tr))])));end;
      
        pahandle = PsychPortAudio('Open', [], [], 0, [], nrchannels);
        PsychPortAudio('FillBuffer', pahandle, pasound_probe_forward_2b);
        PsychPortAudio('Start', pahandle, 1, 0, 1);
        [end_clicks,x,y,whichButton_2nd] = GetClicks(whichScreen,0); 
        digit_forward_total_score(tr) = whichButton_2nd;
        tr = tr+1;
        
if whichButton_1st == 3 && whichButton_2nd == 3 
% EEG
NetStation('StopRecording')
%Eye-tracker
% stop recording
calllib('iViewXAPI', 'iV_StopRecording');
% save recorded data
eyetr_data = formatString(64, int8('User1'));
description = formatString(64, int8('Description1'));
ovr = int32(1);
filename = formatString(256, int8(['C:\PsychToolbox_Experiments\Simon\AA_eyetracker_data\' subj_ID{1,1} '_Digit_Span_forward' '.idf']));
calllib('iViewXAPI', 'iV_SaveData', filename, description, eyetr_data, ovr)
calllib('iViewXAPI', 'iV_Disconnect'); 

clear whichButton_1st whichButton_2nd
clearvars -except select subj_ID metafile subj_Name t
%unloadlibrary('iViewXAPI');end
sca
t = t+1;
WaitSecs(4)
return
end;
        
        clear whichButton_1st whichButton_2nd
        
        
%%%%%%%        

    %% 3rd trial     
     Screen('DrawText', window, 'Ready?', 0.45*scresw, 0.1*scresh, 255);
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
    
    [start_clicks,x,y,whichButton] = GetClicks(whichScreen,0);  
    
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
        if par.recordEEG, sendtrigger(tr,port,SITE,0); end
        if par.useEL, calllib('iViewXAPI', 'iV_SendImageMessage', formatString(256, int8([ num2str(num2str(tr))])));end;
      
        pahandle = PsychPortAudio('Open', [], [], 0, [], nrchannels);
        PsychPortAudio('FillBuffer', pahandle, pasound_probe_forward_3a);
        PsychPortAudio('Start', pahandle, 1, 0, 1);
        [end_clicks,x,y,whichButton_1st] = GetClicks(whichScreen,0); 
        digit_forward_total_score(tr) = whichButton_1st;
        tr = tr+1;
        
        %
        
    Screen('DrawText', window, 'Ready?', 0.45*scresw, 0.1*scresh, 255);
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
    
    [start_clicks,x,y,whichButton] = GetClicks(whichScreen,0);  
    
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
        if par.recordEEG, sendtrigger(tr,port,SITE,0); end
        if par.useEL, calllib('iViewXAPI', 'iV_SendImageMessage', formatString(256, int8([ num2str(num2str(tr))])));end;
      
        pahandle = PsychPortAudio('Open', [], [], 0, [], nrchannels);
        PsychPortAudio('FillBuffer', pahandle, pasound_probe_forward_3b);
        PsychPortAudio('Start', pahandle, 1, 0, 1);
        [end_clicks,x,y,whichButton_2nd] = GetClicks(whichScreen,0);
        digit_forward_total_score(tr) = whichButton_2nd;
        tr = tr+1;
        
        
if whichButton_1st == 3 && whichButton_2nd == 3 
% EEG
NetStation('StopRecording')
%Eye-tracker
% stop recording
calllib('iViewXAPI', 'iV_StopRecording');
% save recorded data
eyetr_data = formatString(64, int8('User1'));
description = formatString(64, int8('Description1'));
ovr = int32(1);
filename = formatString(256, int8(['C:\PsychToolbox_Experiments\Simon\AA_eyetracker_data\' subj_ID{1,1} '_Digit_Span_forward' '.idf']));
calllib('iViewXAPI', 'iV_SaveData', filename, description, eyetr_data, ovr)
calllib('iViewXAPI', 'iV_Disconnect'); 

clear whichButton_1st whichButton_2nd
clearvars -except select subj_ID metafile subj_Name t
%unloadlibrary('iViewXAPI');end
sca
t = t+1;
WaitSecs(4)
return
end;
        
        clear whichButton_1st whichButton_2nd
        
%%%%%%% 

    %% 4rd trial     
     Screen('DrawText', window, 'Ready?', 0.45*scresw, 0.1*scresh, 255);
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
    
    [start_clicks,x,y,whichButton] = GetClicks(whichScreen,0);  
    
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
        if par.recordEEG, sendtrigger(tr,port,SITE,0); end
        if par.useEL, calllib('iViewXAPI', 'iV_SendImageMessage', formatString(256, int8([ num2str(num2str(tr))])));end;
      
        pahandle = PsychPortAudio('Open', [], [], 0, [], nrchannels);
        PsychPortAudio('FillBuffer', pahandle, pasound_probe_forward_4a);
        PsychPortAudio('Start', pahandle, 1, 0, 1);
        [end_clicks,x,y,whichButton_1st] = GetClicks(whichScreen,0); 
        digit_forward_total_score(tr) = whichButton_1st;
        tr = tr+1;
        
        %
        
    Screen('DrawText', window, 'Ready?', 0.45*scresw, 0.1*scresh, 255);
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
    
    [start_clicks,x,y,whichButton] = GetClicks(whichScreen,0);  
    
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
        if par.recordEEG, sendtrigger(tr,port,SITE,0); end
        if par.useEL, calllib('iViewXAPI', 'iV_SendImageMessage', formatString(256, int8([ num2str(num2str(tr))])));end;
      
        pahandle = PsychPortAudio('Open', [], [], 0, [], nrchannels);
        PsychPortAudio('FillBuffer', pahandle, pasound_probe_forward_4b);
        PsychPortAudio('Start', pahandle, 1, 0, 1);
        [end_clicks,x,y,whichButton_2nd] = GetClicks(whichScreen,0); 
        digit_forward_total_score(tr) = whichButton_2nd;
        tr = tr+1;
        
if whichButton_1st == 3 && whichButton_2nd == 3 
% EEG
NetStation('StopRecording')
%Eye-tracker
% stop recording
calllib('iViewXAPI', 'iV_StopRecording');
% save recorded data
eyetr_data = formatString(64, int8('User1'));
description = formatString(64, int8('Description1'));
ovr = int32(1);
filename = formatString(256, int8(['C:\PsychToolbox_Experiments\Simon\AA_eyetracker_data\' subj_ID{1,1} '_Digit_Span_forward' '.idf']));
calllib('iViewXAPI', 'iV_SaveData', filename, description, eyetr_data, ovr)
calllib('iViewXAPI', 'iV_Disconnect'); 

clear whichButton_1st whichButton_2nd
clearvars -except select subj_ID metafile subj_Name t
%unloadlibrary('iViewXAPI');end
sca
t = t+1;
WaitSecs(4)
return
end;
clear whichButton_1st whichButton_2nd


 %% 5th trial     
     Screen('DrawText', window, 'Ready?', 0.45*scresw, 0.1*scresh, 255);
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
    
    [start_clicks,x,y,whichButton] = GetClicks(whichScreen,0);  
    
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
        if par.recordEEG, sendtrigger(tr,port,SITE,0); end
        if par.useEL, calllib('iViewXAPI', 'iV_SendImageMessage', formatString(256, int8([ num2str(num2str(tr))])));end;
      
        pahandle = PsychPortAudio('Open', [], [], 0, [], nrchannels);
        PsychPortAudio('FillBuffer', pahandle, pasound_probe_forward_5a);
        PsychPortAudio('Start', pahandle, 1, 0, 1);
        [end_clicks,x,y,whichButton_1st] = GetClicks(whichScreen,0); 
        digit_forward_total_score(tr) = whichButton_1st;
        tr = tr+1;
        
        %
        
    Screen('DrawText', window, 'Ready?', 0.45*scresw, 0.1*scresh, 255);
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
    
    [start_clicks,x,y,whichButton] = GetClicks(whichScreen,0);  
    
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
        if par.recordEEG, sendtrigger(tr,port,SITE,0); end
        if par.useEL, calllib('iViewXAPI', 'iV_SendImageMessage', formatString(256, int8([ num2str(num2str(tr))])));end;
      
        pahandle = PsychPortAudio('Open', [], [], 0, [], nrchannels);
        PsychPortAudio('FillBuffer', pahandle, pasound_probe_forward_5b);
        PsychPortAudio('Start', pahandle, 1, 0, 1);
        [end_clicks,x,y,whichButton_2nd] = GetClicks(whichScreen,0); 
        digit_forward_total_score(tr) = whichButton_2nd;
        tr = tr+1;
        
if whichButton_1st == 3 && whichButton_2nd == 3 
% EEG
NetStation('StopRecording')
%Eye-tracker
% stop recording
calllib('iViewXAPI', 'iV_StopRecording');
% save recorded data
eyetr_data = formatString(64, int8('User1'));
description = formatString(64, int8('Description1'));
ovr = int32(1);
filename = formatString(256, int8(['C:\PsychToolbox_Experiments\Simon\AA_eyetracker_data\' subj_ID{1,1} '_Digit_Span_forward' '.idf']));
calllib('iViewXAPI', 'iV_SaveData', filename, description, eyetr_data, ovr)
calllib('iViewXAPI', 'iV_Disconnect'); 

clear whichButton_1st whichButton_2nd
clearvars -except select subj_ID metafile subj_Name t
%unloadlibrary('iViewXAPI');end
sca
t = t+1;
WaitSecs(4)
return
end;
clear whichButton_1st whichButton_2nd

 %% 6th trial     
     Screen('DrawText', window, 'Ready?', 0.45*scresw, 0.1*scresh, 255);
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
    
    [start_clicks,x,y,whichButton] = GetClicks(whichScreen,0);  
    
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
        if par.recordEEG, sendtrigger(tr,port,SITE,0); end
        if par.useEL, calllib('iViewXAPI', 'iV_SendImageMessage', formatString(256, int8([ num2str(num2str(tr))])));end;
      
        pahandle = PsychPortAudio('Open', [], [], 0, [], nrchannels);
        PsychPortAudio('FillBuffer', pahandle, pasound_probe_forward_6a);
        PsychPortAudio('Start', pahandle, 1, 0, 1);
        [end_clicks,x,y,whichButton_1st] = GetClicks(whichScreen,0); 
        digit_forward_total_score(tr) = whichButton_1st;
        tr = tr+1;
        
        %
        
    Screen('DrawText', window, 'Ready?', 0.45*scresw, 0.1*scresh, 255);
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
    
    [start_clicks,x,y,whichButton] = GetClicks(whichScreen,0);  
    
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
        if par.recordEEG, sendtrigger(tr,port,SITE,0); end
        if par.useEL, calllib('iViewXAPI', 'iV_SendImageMessage', formatString(256, int8([ num2str(num2str(tr))])));end;
      
        pahandle = PsychPortAudio('Open', [], [], 0, [], nrchannels);
        PsychPortAudio('FillBuffer', pahandle, pasound_probe_forward_6b);
        PsychPortAudio('Start', pahandle, 1, 0, 1);
        [end_clicks,x,y,whichButton_2nd] = GetClicks(whichScreen,0); 
        digit_forward_total_score(tr) = whichButton_2nd;
        tr = tr+1;
        
if whichButton_1st == 3 && whichButton_2nd == 3 
% EEG
NetStation('StopRecording')
%Eye-tracker
% stop recording
calllib('iViewXAPI', 'iV_StopRecording');
% save recorded data
eyetr_data = formatString(64, int8('User1'));
description = formatString(64, int8('Description1'));
ovr = int32(1);
filename = formatString(256, int8(['C:\PsychToolbox_Experiments\Simon\AA_eyetracker_data\' subj_ID{1,1} '_Digit_Span_forward' '.idf']));
calllib('iViewXAPI', 'iV_SaveData', filename, description, eyetr_data, ovr)
calllib('iViewXAPI', 'iV_Disconnect'); 

clear whichButton_1st whichButton_2nd
clearvars -except select subj_ID metafile subj_Name t
%unloadlibrary('iViewXAPI');end
sca
t = t+1;
WaitSecs(4)
return
end;
clear whichButton_1st whichButton_2nd

 %% 7th trial     
     Screen('DrawText', window, 'Ready?', 0.45*scresw, 0.1*scresh, 255);
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
    
    [start_clicks,x,y,whichButton] = GetClicks(whichScreen,0);  
    
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
        if par.recordEEG, sendtrigger(tr,port,SITE,0); end
        if par.useEL, calllib('iViewXAPI', 'iV_SendImageMessage', formatString(256, int8([ num2str(num2str(tr))])));end;
      
        pahandle = PsychPortAudio('Open', [], [], 0, [], nrchannels);
        PsychPortAudio('FillBuffer', pahandle, pasound_probe_forward_7a);
        PsychPortAudio('Start', pahandle, 1, 0, 1);
        [end_clicks,x,y,whichButton_1st] = GetClicks(whichScreen,0); 
        digit_forward_total_score(tr) = whichButton_1st;
        tr = tr+1;
        
        %
        
    Screen('DrawText', window, 'Ready?', 0.45*scresw, 0.1*scresh, 255);
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
    
    [start_clicks,x,y,whichButton] = GetClicks(whichScreen,0);  
    
    Screen('DrawLine', window,[0 0 0],center(1)-7,center(2), center(1)+7,center(2));
    Screen('DrawLine', window,[0 0 0],center(1),center(2)-7, center(1),center(2)+7);
    Screen('Flip',window);
        if par.recordEEG, sendtrigger(tr,port,SITE,0); end
        if par.useEL, calllib('iViewXAPI', 'iV_SendImageMessage', formatString(256, int8([ num2str(num2str(tr))])));end;
      
        pahandle = PsychPortAudio('Open', [], [], 0, [], nrchannels);
        PsychPortAudio('FillBuffer', pahandle, pasound_probe_forward_7b);
        PsychPortAudio('Start', pahandle, 1, 0, 1);
        [end_clicks,x,y,whichButton_2nd] = GetClicks(whichScreen,0); 
        digit_forward_total_score(tr) = whichButton_2nd;
        tr = tr+1;
        
%if whichButton_1st == 3 && whichButton_2nd == 3 
% EEG
NetStation('StopRecording')
%Eye-tracker
% stop recording
calllib('iViewXAPI', 'iV_StopRecording');
% save recorded data
eyetr_data = formatString(64, int8('User1'));
description = formatString(64, int8('Description1'));
ovr = int32(1);
filename = formatString(256, int8(['C:\PsychToolbox_Experiments\Simon\AA_eyetracker_data\' subj_ID{1,1} '_Digit_Span_forward' '.idf']));
calllib('iViewXAPI', 'iV_SaveData', filename, description, eyetr_data, ovr)
calllib('iViewXAPI', 'iV_Disconnect'); 

clear whichButton_1st whichButton_2nd
clearvars -except select subj_ID metafile subj_Name t
%unloadlibrary('iViewXAPI');end
sca
t = t+1;
WaitSecs(4)
return
%end;
clear whichButton_1st whichButton_2nd



    end

    
%PsychPortAudio('Stop', [], 0, 0);
PsychPortAudio('DeleteBuffer');    
PsychPortAudio('Close');

clearvars -except select subj_ID metafile subj_Name t
close all        
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


        