IntroVideo = {};
logoImgFile = Graphics.loadImage("app0:/Sprites/SuicidalRobotGameLogo.png");
function IntroVideo:new()
  
  introVideo = {}
  setmetatable(introVideo, self);
  self.__index = self;
  introVideo.audioClip = Sound.openMp3("app0:/Music/Intro.mp3");
  
  introVideo.waitTime = 0;
  introVideo.audioClipPlayer = Sound.play(introVideo.audioClip,NO_LOOP) 
  
  return introVideo;
end


function IntroVideo:Draw()
  
 self.imageToDraw = Graphics.drawPartialImage(0,0, 0, 0, 960, 544,logoImgFile);
  
end

function IntroVideo:Update()
  
  self.waitTime = self.waitTime + 1;
 
    self:Draw()
 

if(self.waitTime >= 300) then
  
 -- Sound.close(self.audioClip);
  --Graphics.freeImage(self.imgFile)
  RemoveIntroVideo()
  
end


  
  
end
