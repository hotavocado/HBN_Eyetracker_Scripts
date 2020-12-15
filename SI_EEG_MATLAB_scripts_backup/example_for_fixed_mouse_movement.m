%1. create a callback that reads and prints (or stores) the coordinates 

% function timerCallback(timerObj,event,str_arg) 
% this function is executed every time the timer object triggers 

% read the coordinates 
coords = get(0,'PointerLocation'); 
% print the coordinates to screen 
fprintf('x: %4i y: %4i\n',coords) 

end % function 
coords_all =[]
%2. create a timer object 

% the timer object triggers every second. If you need it faster, decrease the value for Period 
%timerObj = timer('TimerFcn',@timerCallback,'Period',0.5)
timerObj = timer('TimerFcn',@timerCallback,'ExecutionMode','fixedRate','Period',0.001)
%3. start 
% this will run until you type stop(timerObj). You may want to have the stop callback implemented in a GUI button. 
start(timerObj);
coords_all(end+1,:) = coords