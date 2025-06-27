Controller = {};

leftIsPressed = false;
downIsPressed = false;
upIsPressed = false;
rightIsPressed = false;

startIsPressed = false;
 startCanBePressed = false; 

xIsPressed = false;
xCanBePressed = false;



function Controller.ListenForControls()
  
  pad = Controls.read();
  cx, cy = Controls.readLeftAnalog();
  
  if (Controls.check(pad, SCE_CTRL_START)) then
  
  startIsPressed = true;
  
  else
  
  startIsPressed = false;
  
  end
  
  
  if (Controls.check(pad, SCE_CTRL_UP) or cy < 64 ) then
   
      upIsPressed = true;

   
 else
   upIsPressed = false;
  end
  
  if (Controls.check(pad, SCE_CTRL_DOWN) or cy > 180) then
   
   downIsPressed = true;
 else
   downIsPressed = false;
   
  end
  
  if (Controls.check(pad, SCE_CTRL_LEFT) or cx < 64) then
   
   leftIsPressed = true;
 else
   
   leftIsPressed = false;
   
  end
  
  if (Controls.check(pad, SCE_CTRL_RIGHT) or cx > 180) then
   
   rightIsPressed = true;
 else
   rightIsPressed = false;
   
  end
  
  if (Controls.check(pad, SCE_CTRL_CROSS)) then
    
    xIsPressed = true
  else
    
   xIsPressed = false 
  end
  
  
  
end


 function Controller.CheckButtonPresses()
  
  if(startIsPressed == true) then
     startCanBePressed = false; 
    
  end
  
  if(startIsPressed == false) then
    
  startCanBePressed = true;  
  end
  
  
  
  if(xIsPressed == false ) then
    
  xCanBePressed = true;  
  end
  
  
  if(xIsPressed == true ) then
    
  xCanBePressed = false;  
  end
  
  end


function Controller.Update()
  
  Controller.ListenForControls();
  
end
