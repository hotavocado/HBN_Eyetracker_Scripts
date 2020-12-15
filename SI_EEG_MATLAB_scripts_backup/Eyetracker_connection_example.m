% GazeContingent.m
%
% This script shows how to connect to SMI eye tracking application, 
% calibrate the eye tracker and draw the gaze data on the screen 
%
% for running this script the psych toolbox for Matlab needed 
% http://psychtoolbox.org
%
% Author: SMI GmbH
% June, 2012

%===========================
%Initialisation
%===========================

%clear all variables, connections, ...
%clear all
% clc
warning('off', 'all');

connected = 0;

addpath('C:\Program Files\SMI\iView X SDK\include\')
addpath('C:\Program Files\SMI\iView X SDK\lib\')
addpath('C:\Program Files\SMI\iView X SDK\Examples\Matlab\Matlab 7.11\GazeContingent\')
%addpath(genpath('C:\toolbox\Psychtoolbox\'));

% load the iViewX API library
%loadlibrary('iViewXAPI.dll', 'iViewXAPI.h');


[pSystemInfoData, pSampleData, pEventData, pAccuracyData, CalibrationData] = InitiViewXAPI();

CalibrationData.method = int32(5);
CalibrationData.visualization = int32(1);
CalibrationData.displayDevice = int32(1); % primary screen (0) other: (1)
CalibrationData.speed = int32(0);
CalibrationData.autoAccept = int32(0); % manually (0), automatic aceptance (1)
CalibrationData.foregroundBrightness = int32(250);
CalibrationData.backgroundBrightness = int32(230);
CalibrationData.targetShape = int32(2);
CalibrationData.targetSize = int32(20);
CalibrationData.targetFilename = int8('');
pCalibrationData = libpointer('CalibrationStruct', CalibrationData);


disp('Define Logger')
calllib('iViewXAPI', 'iV_SetLogger', int32(1), formatString(256, int8('iViewXSDK_Matlab_GazeContingent_Demo.txt')))


disp('Connect to iViewX')
ret = calllib('iViewXAPI', 'iV_Connect', formatString(16, int8('127.0.0.1')), int32(4444), formatString(16, int8('127.0.0.1')), int32(5555))
switch ret
    case 1
        connected = 1;
    case 104
         msgbox('Could not establish connection. Check if Eye Tracker is running', 'Connection Error', 'modal');
    case 105
         msgbox('Could not establish connection. Check the communication Ports', 'Connection Error', 'modal');
    case 123
         msgbox('Could not establish connection. Another Process is blocking the communication Ports', 'Connection Error', 'modal');
    case 200
         msgbox('Could not establish connection. Check if Eye Tracker is installed and running', 'Connection Error', 'modal');
    otherwise
         msgbox('Could not establish connection', 'Connection Error', 'modal');
end


 % if connected

	disp('Get System Info Data')
	calllib('iViewXAPI', 'iV_GetSystemInfo', pSystemInfoData)
	get(pSystemInfoData, 'Value')

%% Calibration
%	disp('Calibrate iViewX')
%	calllib('iViewXAPI', 'iV_SetupCalibration', pCalibrationData)
%	calllib('iViewXAPI', 'iV_Calibrate')
%%

% clear recording buffer
	%	calllib('iViewXAPI', 'iV_ClearRecordingBuffer');

		% start recording
	%	calllib('iViewXAPI', 'iV_StartRecording');

		% show first image 
	%	calllib('iViewXAPI', 'iV_SendImageMessage', formatString(256, int8('start_eye_recording')));


	%disp('Validate Calibration')
	%calllib('iViewXAPI', 'iV_Validate')


	%disp('Show Accuracy')
	%calllib('iViewXAPI', 'iV_GetAccuracy', pAccuracyData, int32(0))
	%get(pAccuracyData,'Value')
%%
% whichScreen_eye = 1;
%       whichScreen = 1;
% 
% 	exitLoop = 0;
% 	try 
% 
% 		% define screen, needs to be adjusted to different stimulus screens
% 		window_eye = Screen('OpenWindow', whichScreen_eye, [], [0 0 1280/3 1024/3]); %window = Screen('OpenWindow', whichScreen]);
% 		window= Screen('OpenWindow', whichScreen, [], [400 0 450+1280/3 1024/3]); %window = Screen('OpenWindow', whichScreen]);
% 
%         HideCursor;  
% 
% 		while ~(exitLoop)         
% 
% 			if (calllib('iViewXAPI', 'iV_GetSample', pSampleData) == 1)
% 
% 				% get sample
 %				Smp = libstruct('SampleStruct', pSampleData);
% 
% 				x0 = Smp.leftEye.gazeX;
% 				y0 = Smp.leftEye.gazeY;
% 				Screen('DrawDots', window_eye, [x0/3,y0/3], 20, [0 0 0])
               %   Screen('DrawTexture', window_eye, BLstim(s), [], [center center] + stimrect);
% 				Screen(window_eye, 'Flip')
 %				pause(0.01);
%                 
%                 Screen('DrawDots', window, [x0/3,y0/3], 20, [0 0 0])
% 
%			end        
% 
% 			 %end experiment after a mouse button has been pushed
% 			if (waitForMouseNonBlocking)
% 				exitLoop = 1;
% 			end
% 		end
% 
% 	% catch
% 		% catch if errors appears
% 		Screen('CloseAll'); 
% 		ShowCursor
% 		s = lasterror
% end
%     
%end
% 
% 
 %disp('Disconnect')
% 
% % release screen
% Screen('CloseAll'); 
% ShowCursor

 %disconnect from iViewX 
%calllib('iViewXAPI', 'iV_Disconnect')

%pause(1);
%clear all

% unload iViewX API libraray
% unloadlibrary('iViewXAPI');
