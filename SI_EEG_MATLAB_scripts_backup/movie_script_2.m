
 SITE = 'N';     % N for netstation (EGI)

 port=0;
% par.runID=subj_ID{1,1};
% par.ExaminationDate =subj_ID{2,1};
% if subj_ID{3,1} == 'y'
%par.recordEEG = 1;
% else par.recordEEG = 0; end;
% 
% if subj_ID{4,1} == 'y'
% par.useEL = 1;  % use the eye tracker?
% else par.recordEL = 0; end;
% 
% monitorwidth_cm = 40;   % monitor width in cm
% dist_cm = 57;  % viewing distance in cm
% 
% whichScreen = 1;
% whichScreen_eye = 1;
% 
% [scresw, scresh]=Screen('WindowSize',whichScreen);  % Get screen resolution
% center = [scresw scresh]/2;     % useful to have the pixel coordinates of the very center of the screen (usually where you have someone fixate)
% fixRect = [center-2 center+2];  % fixation dot
% hz=Screen('FrameRate', whichScreen,1);
% 
% cm2px = scresw/monitorwidth_cm;  % multiplication factor to convert cm to pixels
% deg2px = dist_cm*cm2px*pi/180;      % multiplication factor to convert degrees to pixels (uses aproximation tanT ~= T).
% 
% load gammafnCRT   % load the gamma function parameters for this monitor - or some other CRT and hope they're similar! (none of our questions rely on precise quantification of physical contrast)
% maxLum = GrayLevel2Lum(255,Cg,gam,b0);
% par.BGcolor=Lum2GrayLevel(maxLum/2,Cg,gam,b0);
% 
% %%%%%%%%% IMPORTANT SETTINGS
% par.videoFrate = 100%75% 100%%60 ;   % Monitor refresh rate
% par.FlickF = par.videoFrate./[5 4];      % Flicker frequencies of two stimuli in Hz
% % par.FlickF = par.FlickF(randperm(2));   % randomize frequency assignment
% % to left and right (this was done for the PD study but I don't think it's necessary becaus we're not interested in asymmetries in left-tilted vs right-tilted perception - if there are differences, it is quite possible that it is due to the different flicker rates, but that's fine)
% 
% % Note the left-tilted stimulus is always stimulus "1" and right-tilted stimulus "2"
% par.ReverseOrPulse = 1; % Phase reversing = 1, pattern pulse = 2.
% par.numtargets = 48;
% par.secs_btw_targs =  [2.8 4.4 6]%[2 2 2]; %[6 9 12]*40/75; %[2 2 2]*40/100% [2 2 2]*40/75 %[2 2 2]*40/60  %[6 9 12]*40/75;%;
% par.spatfreq = 1;       % Spatial frequency of gratings
% par.outerrad_deg = 6;   % in DEGREES
% par.innerrad_deg = 1;   % in DEGREES
% par.targrampdur = 1.6 %80/75 %80/60%; % 1.6 % in sec. Return ramp will be at double rate. Choose multiple of 0.2!
% par.BLcontrast = 0.5;    % contrast
% par.targChange = 0.5; % Max 0.5 for complete disappearance of other grating
% 
% par.eyeFBK = 0;

%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

%function SimpleMovieDemo(moviename, windowrect)
% Most simplistic demo on how to play a movie.
%
% SimpleMovieDemo(moviename [, windowrect=[]]);
%
% This bare-bones demo plays a single movie whose name has to be provided -
% including the full filesystem path to the movie - exactly once, then
% exits. This is the most minimalistic way of doing it. For a more complex
% demo see PlayMoviesDemo. The remaining demos show more advanced concepts
% like proper timing etc.
%
% The demo will play our standard DualDiscs.mov movie if the 'moviename' is
% omitted.
%

% History:
% 02/05/2009  Created. (MK)
% 06/17/2013  Cleaned up. (MK)

% Check if Psychtoolbox is properly installed:
AssertOpenGL;

filepath = 'C:\PsychToolbox_Experiments\Simon\';


%if nargin < 1 || isempty(moviename)
    % No moviename given: Use our default movie:
    moviename = [ filepath '71_AV.mp4' ];
%end

%if nargin < 2 || isempty(windowrect)
    windowrect = [];
%end

% Wait until user releases keys on keyboard:
KbReleaseWait;

% Select screen for display of movie:
%screenid = max(Screen('Screens'));
screenid = 2

%for i = 1:5

try
   
    % Open 'windowrect' sized window on screen, with black [0] background color:
    win = Screen('OpenWindow', screenid, 0, windowrect);
     
    % Open movie file:
    movie = Screen('OpenMovie', win, moviename);
      
    sendtrigger(13,port,SITE,1);
    %if par.recordEEG, sendtrigger(par.CD_Dot_OFF(pos_num),port,SITE,1); end
    % Start playback engine:
    
    Screen('PlayMovie', movie, 1);
   tic
    % Playback loop: Runs until end of movie or keypress:
    while ~KbCheck
        % Wait for next movie frame, retrieve texture handle to it
        tex = Screen('GetMovieImage', win, movie);
        
        % Valid texture returned? A negative value means end of movie reached:
        if tex<=0
            % We're done, break out of loop:
            break;
        end
         %mov_beg = GetSecs; 
    
        % Draw the new texture immediately to screen:
        Screen('DrawTexture', win, tex);
        
    
       % sendtrigger(......)
            
             
       % Update display:
        Screen('Flip', win);
        
        
        
        % Release texture:
        Screen('Close', tex);
        
      
        
    end
    
    % Stop playback:
    Screen('PlayMovie', movie, 0);
   
    % Close movie:
    Screen('CloseMovie', movie);
       %mov_end = GetSecs; 
       %duration =  mov_end - mov_beg;
    duration = toc
       
       % Close Screen, we're done:
    Screen('CloseAll');
    
catch %#ok<CTCH>
   % 
  %   
    sca;
    psychrethrow(psychlasterror);
   
%end

%return

end