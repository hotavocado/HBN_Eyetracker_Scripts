port_EL = 6666;

quality_calib = 0;
while quality_calib == 0;
HideCursor
screenNumber=max(Screen('Screens'));

white=WhiteIndex(screenNumber);
black=BlackIndex(screenNumber);
gray=round((white+black)/2);
% Open a double buffered fullscreen window and draw a gray background
% and front and back buffers.

Screen('Preference','SkipSyncTests',1)
Screen('Preference', 'VisualDebugLevel', 0);
[w, screenRect]=Screen('OpenWindow',screenNumber, 0,[],32,2);

Screen('FillRect',w, gray);
Screen('Flip',w);


host='10.0.0.111'; 
porport_EL=5005;
%porport_EL=4444;% Lai


ivx=iViewXInitDefaults([],[], host, port_EL);
ivx.localport=4444;
ivx.window = w;
ivx.screenHSize = 800;
ivx.screenVSize = 600;
% includes calibration plus validation points
% ivx.absCalPos = [400 300; 200 30; 760 150; 600 570; 40 450; 200 150; 600 150; 200 450; 600 450];
ivx.absCalPos = [400 300; 200 30; 760 150; 600 570; 40 450];



% WaitSecs(2)
% %  pnet(sock,'write','test');
% %  pnet(sock,'writepacket');
%   pnet(sock,'write','qual_no');
%  pnet(sock,'writepacket');
 
 
%h = msgbox('CLICK THE SPACEBAR ON THE LINUX-PC AFTER YOU STARTED THE PYTHON SCRIPT')
%[clicks,xxx,yyy,whichButton] = GetClicks(whichScreen,0);   
%close(h)
clc
disp('RUN THE PYTHON SCRIPT. THEN Press the Space Bar on the eye-tracker PC  to initiate calibration!!')
[result, ivx]=iViewXCalibrate(ivx)

%% Validation
ivx.absCalPos = [200 150; 600 150; 200 450; 600 450];

clc
disp('Press the Space Bar on the eye-tracker PC  to initiate validation!!')
[result, ivx]=iViewXValidate(ivx)


sel_qual_calib = questdlg('Is the accuracy of the calibration good enough? (lower than 3.5 degrees)');
if strmatch('Yes',sel_qual_calib,'exact');
    quality_calib = 1; 
    %% sends the name to the eyetracker PC
 eyetr_sendtrigger('name',sock);
 eyetr_sendtrigger(subj_ID{1,1},sock);
elseif strmatch('No',sel_qual_calib,'exact');
    quality_calib = 0;
    pnet(sock,'write','end');
 pnet(sock,'writepacket');
 WaitSecs(2)
    end
end




