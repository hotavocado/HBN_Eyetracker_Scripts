HideCursor
screenNumber=max(Screen('Screens'));

white=WhiteIndex(screenNumber);
black=BlackIndex(screenNumber);
gray=round((white+black)/2);
% Open a double buffered fullscreen window and draw a gray background
% and front and back buffers.

[w, screenRect]=Screen('OpenWindow',screenNumber, 0,[],32,2);

Screen('FillRect',w, gray);
Screen('Flip',w);


host='10.0.0.44'; %host='10.0.0.43';
port_EL=6666;

ivx=iViewXInitDefaults([],[], host, port_EL);
ivx.localport=4444;
ivx.window = w;
ivx.screenHSize = 800;
ivx.screenVSize = 600;
ivx.absCalPos = [400 300; 200 6; 792 150; 600 594; 8 450];
ivx.nCalPoints = 5;


% open connection for receiving data
[success, ivx]=iViewX('openconnection', ivx);
[success, ivx]=iViewX('clearbuffer', ivx);
clc
disp('Press the Calibrate Button on the eye-tracker PC!!')
[success, ivx]=iViewX('calibrate', ivx);
stop=1;
if success~=1
    fprintf([mfilename ': calibration failed\n']);
    stop=1;
end

[success, ivx]=iViewX('startrecording', ivx);
[success, ivx]=iViewX('message', ivx, 'start_eye_recording');
disp('Eye-tracker recording started!!')
ShowCursor
