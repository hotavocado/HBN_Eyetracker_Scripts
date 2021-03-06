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
port_EL=5005;

ivx=iViewXInitDefaults([],[], host, port_EL);
ivx.localport=4444;
ivx.window = w;
ivx.screenHSize = 800;
ivx.screenVSize = 600;
% includes calibration plus validation points
% ivx.absCalPos = [400 300; 200 30; 760 150; 600 570; 40 450; 200 150; 600 150; 200 450; 600 450];
ivx.absCalPos = [400 300; 200 30; 760 150; 600 570; 40 450];

% open connection for receiving data
clc
disp('Press the Space Bar on the eye-tracker PC  to initiate calibration!!')
[result, ivx]=iViewXCalibrate(ivx)

%% Validation
ivx.absCalPos = [200 150; 600 150; 200 450; 600 450];

clc
disp('Press the Space Bar on the eye-tracker PC  to initiate validation!!')
[result, ivx]=iViewXValidate(ivx)





