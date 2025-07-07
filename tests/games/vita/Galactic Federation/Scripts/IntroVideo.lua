IntroVideo = {};
logoImgFile = Graphics.loadImage("app0:/Sprites/Screens/SuicidalRobotGameLogo.png");
gekiImgFile = Graphics.loadImage("app0:/Sprites/Screens/gekihen.png");
function IntroVideo:New()
  
  introVideo = {}
  setmetatable(introVideo, self);
  self.__index = self;
  introVideo.audioClip = Sound.openMp3("app0:/Music/Intro.mp3");
  
  introVideo.waitTime = 0;
  
  
  return introVideo;
end


function IntroVideo:Draw()
  
  if(self.waitTime <= 200) then
    self.imageToDraw = Graphics.drawPartialImage(0,0, 0, 0, 960, 544,gekiImgFile);
  end
  
  
  if(self.waitTime > 200) then
 self.imageToDraw = Graphics.drawPartialImage(0,0, 0, 0, 960, 544,logoImgFile);
 end
  
end

function IntroVideo:SkipScreen()
for i, value in ipairs(controllerObj) do
if(controllerObj[i].startIsPressed == true and controllerObj[i].startCanBePressed == true) then
self.waitTime = 500  
end

end
end


function IntroVideo:Update()
  
  self.waitTime = self.waitTime + 1;
  
  if(self.waitTime == 201) then
introVideo.audioClipPlayer = Sound.play(introVideo.audioClip,NO_LOOP)   
end
self:SkipScreen()
 
   
 

if(self.waitTime >= 500) then
  
 -- Sound.close(self.audioClip);
  Graphics.freeImage(gekiImgFile)
   Graphics.freeImage(logoImgFile)
  RemoveIntroVideo()
  
end


  
  
end
