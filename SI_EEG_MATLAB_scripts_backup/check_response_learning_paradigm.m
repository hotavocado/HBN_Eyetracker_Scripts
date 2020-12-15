% Waits for the user to press a button before starting



Screen('TextSize', window, 16);
for j = 1:par.numtargets
   
    
if    whichButton == 1  && correction(r,c,1) == 0 ;
     
if c<9 && x(c) >= center(1,1)+pos(j,1)-r_resp && x(c) <= center(1,1)+pos(j,1)+r_resp && y(c)>=center(1,2)+pos(j,2)-r_resp && y(c) <= center(1,2)+pos(j,2)+r_resp
par.resp_click(r,c,1) = j; %par.resp_click(r,end+1,1) = j; 
Screen('FillRect',window, color_gray, [0.25*scresw 0.8*scresh 0.25*scresw+500 0.8*scresh+30]);  
      Screen('DrawText', window, [num2str(c)], center(1,1)+pos(j,1)+right_text_shift,center(1,2)+pos(j,2)-5,[255 0 0]); Screen(window, 'Flip',[],1);
elseif c>8 && x(c) >= center(1,1)+pos(j,1)-r_resp && x(c) <= center(1,1)+pos(j,1)+r_resp && y(c)>=center(1,2)+pos(j,2)-r_resp && y(c) <= center(1,2)+pos(j,2)+r_resp
par.resp_click(r,c,1) = j; 
Screen('FillRect',window, color_gray, [0.25*scresw 0.8*scresh 0.25*scresw+500 0.8*scresh+30]);  
 Screen('DrawText', window, [num2str(c)], center(1,1)+pos(j,1)-left_text_shift,center(1,2)+pos(j,2)-5,[255 0 0]); Screen(window, 'Flip',[],1);
end

% Answer for Correction
elseif    whichButton == 1 && correction(r,c,1) == 1 ;
     
if c<9 && x(c) >= center(1,1)+pos(j,1)-r_resp && x(c) <= center(1,1)+pos(j,1)+r_resp && y(c)>=center(1,2)+pos(j,2)-r_resp && y(c) <= center(1,2)+pos(j,2)+r_resp
par.resp_click(r,c,1) = j; %par.resp_click(r,end+1,1) = j; 
Screen('FillRect',window, color_gray, [0.25*scresw 0.8*scresh 0.25*scresw+500 0.8*scresh+30]);
         Screen('DrawText', window, [num2str(c)], center(1,1)+pos(j,1)+right_text_shift,center(1,2)+pos(j,2)-5,[255 0 0]); Screen(window, 'Flip',[],1);
%Screen('DrawText', window, [num2str(c)], center(1,1)+pos(par.resp_click(r,c,1),1)+right_text_shift,center(1,2)+pos(par.resp_click(r,c,1),2)-5,[124 252 0]); Screen(window, 'Flip',[],1);
correction(r,c,1) = 0;
elseif c>8 && x(c) >= center(1,1)+pos(j,1)-r_resp && x(c) <= center(1,1)+pos(j,1)+r_resp && y(c)>=center(1,2)+pos(j,2)-r_resp && y(c) <= center(1,2)+pos(j,2)+r_resp
par.resp_click(r,c,1) = j; 
Screen('FillRect',window, color_gray, [0.25*scresw 0.8*scresh 0.25*scresw+500 0.8*scresh+30]);
 Screen('DrawText', window, [num2str(c)], center(1,1)+pos(j,1)-left_text_shift,center(1,2)+pos(j,2)-5,[255 0 0]); Screen(window, 'Flip',[],1);
 %Screen('DrawText', window, [num2str(c)], center(1,1)+pos(par.resp_click(r,c,1),1)-left_text_shift,center(1,2)+pos(par.resp_click(r,c,1),2)-5,[124 252 0]); Screen(window, 'Flip',[],1);
correction(r,c,1) = 0;
end

end

end


if  whichButton == 1 && par.resp_click(r,c,1) == 0
    
     Screen('TextSize', window, 15);
Screen('DrawText', window, 'No Response recognized: Try Again', 0.25*scresw, 0.8*scresh, [255 0 0]);
Screen('Flip', window,[],1); %WaitSecs(2);
 [clicks,x(c),y(c),whichButton] = GetClicks(whichScreen,0);
 
if  whichButton == 3
 Screen('DrawText', window, 'Select a new choice with the left mouse', 0.25*scresw, 0.9*scresh, [255 0 0]);
Screen('Flip', window,[],1); %WaitSecs(2);
  [clicks,x(c),y(c),whichButton] = GetClicks(whichScreen,0);
  
  if  whichButton == 3
 Screen('DrawText', window, 'Select a new choice with the left mouse', 0.25*scresw, 0.9*scresh, [255 0 0]);
Screen('Flip', window,[],1); %WaitSecs(2);
  [clicks,x(c),y(c),whichButton] = GetClicks(whichScreen,0);
  else check_response_learning_paradigm
  end

else check_response_learning_paradigm
end
end



   