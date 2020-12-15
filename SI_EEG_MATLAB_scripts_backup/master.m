%% Running Eye tracker
%
%% Calibration:
%% 2. start Matlab Calibration
%% 1. start Python script (must be started manually for each paradigm), to actually start calibration space bar needs to be pressed


% start_python = 1;
% while start_python == 1
% sel_start_python = questdlg('DID YOU START THE PYTHON SCRIPT ON THE EYE-TRACKER?');
% if strmatch('Yes',sel_start_python,'exact');
%     start_python = 0; 
% 
% elseif strmatch('No',sel_start_python,'exact');
%     start_python = 1;
%     end
% end



subj_ID{1,1} = 'LANGER51NIC'

open_udp_socket

Eyetracker_connection_calib % see that 



% 
% % Send Trigger 
% port_out = 5067;
% % only the first time to open the socket
% sock = pnet('udpsocket',port_out);
% pnet(sock,'udpconnect','10.0.0.111',port_out);

SITE = 'N';     % T = TCD, C = City College, E = EGI in City College
port=0;
par.CD_eyeO = 20;
par.CD_eyeC = 30;




%% send the actual trigger #2
% pnet(sock,'write',num2str(num2str(2)))
% pnet(sock,'writepacket')
eyetr_sendtrigger(90,sock)
WaitSecs(2)
eyetr_sendtrigger(20,sock)

%% STOP recording
% Make sure Firewall is off on the eye tracker PC

%sock = pnet('udpsocket',port_out)
%pnet(sock,'udpconnect','10.0.0.111',port_out)
pnet(sock,'write','end');
pnet(sock,'writepacket');
sca

% pnet(sock,'close')
