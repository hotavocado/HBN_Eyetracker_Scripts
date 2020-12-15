par.useEL = 0;
par.recordEEG = 1;
par.useEL_Calib = 0;


NetStation('Connect','10.0.0.42')


color_white = [255 255 255]
par.BGcolor = color_white ;
hz = 100;
 
whichScreen = 2;
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


moviename1 = 'C:\PsychToolbox_Experiments\Simon\Clips\Diary_of_a_Wimpy_Kid_Trailer.mp4'; % duration 2min
moviename2 = 'C:\PsychToolbox_Experiments\Simon\Clips\EHow_Math_v2.mp4'; % duration 1:305min
moviename3 = 'C:\PsychToolbox_Experiments\Simon\Clips\Fun_Fractals_v2.mp4'; % duration 4:40min
moviename4 = 'C:\PsychToolbox_Experiments\Simon\Clips\Pre_Alg_Cut.mp4'; % duration 1:30min
moviename5 = 'C:\PsychToolbox_Experiments\Simon\Clips\ReadingClip_Cut.mp4'; %duration 2:48 mind
moviename6 = 'C:\PsychToolbox_Experiments\Simon\Clips\Three_Little_Kittens_Despicable_Me.mp4'; %2:50min

moviename_all = {moviename1; moviename2; moviename3; moviename4; moviename5; moviename6};

%% 1st Movie
par.CD_START  = 83;
par.CD_END = 103;
 %par.CD_SECONDS = 44;
%tt = 0;

%Initiate NetStation Connection, Synchronization, and Recording
if par.recordEEG
 %   NetStation('Connect','10.0.0.42')
    NetStation('Synchronize')
    NetStation('StartRecording')
end

if par.useEL && par.useEL_Calib; Eyetracker_connection_calib; 
elseif par.useEL == 1 && par.useEL_Calib == 0; Eyetracker_connection_passive; end

Screen('Preference','SkipSyncTests',1)
Screen('Preference', 'VisualDebugLevel', 0);
hsc = Screen('OpenWindow',whichScreen);

[moviePtr duration fps count] = Screen('OpenMovie',hsc,moviename_all{3});
Screen('PlayMovie',moviePtr,1);
%format long;
%sec1 = zeros(count,1);
%i = 1;
%time = GetSecs;

 if par.recordEEG,NetStation('Event',num2str(par.CD_START));  end
    if par.useEL, calllib('iViewXAPI', 'iV_SendImageMessage', formatString(256, int8([ num2str(num2str(par.CD_START))])));end;


while 1
    tex = Screen('GetMovieImage', hsc, moviePtr);
    
    if tex<=0 || KbCheck;
        NetStation('Event',num2str(par.CD_END));
        break
    end
    Screen('DrawTexture',hsc,tex);
    Screen('Flip',hsc);
   % vbl = Screen('Flip',hsc);
    %if vbl >=time+1 %Tests if a second has passed 
    %    time = vbl; %changes testing value of time    
    %   tt = tt+1;
%if par.recordEEG, sendtrigger(tt,port,SITE,0); end
%            if par.useEL, calllib('iViewXAPI', 'iV_SendImageMessage', formatString(256, int8([ num2str(tt)])));end;
            
      %  sec1(i) = vbl; %here you can change what you want done at per second 
     %   i = i+1;% In this case it gives the time that is detected as 1 second
      Screen('Close',tex);     
end

    

        
%Screen('PlayMovie', moviePtr, 0);
Screen('CloseMovie', moviePtr);
Screen('TextSize', window, 25);
Screen('DrawText', window, 'THE END OF THE MOVIE ', 0.18*scresw, 0.45*scresh, 0);
Screen('DrawText', window, 'We proceed with the next task... ', 0.18*scresw, 0.55*scresh, 0);
Screen('Flip', window,1);
WaitSecs(3)
Screen('CloseAll');
sca


if par.useEL, 
      % stop recording
		calllib('iViewXAPI', 'iV_StopRecording');
    
    % save recorded data
		eyetr_data = formatString(64, int8('User1'));
		description = formatString(64, int8('Description1'));
		ovr = int32(1);
		filename = formatString(256, int8(['C:\PsychToolbox_Experiments\Simon\AA_eyetracker_data\' subj_ID{1,1} '_Video1' '.idf']));
		calllib('iViewXAPI', 'iV_SaveData', filename, description, eyetr_data, ovr)
    
    calllib('iViewXAPI', 'iV_Disconnect'); end;% unloadlibrary('iViewXAPI');end



NetStation('StopRecording')
