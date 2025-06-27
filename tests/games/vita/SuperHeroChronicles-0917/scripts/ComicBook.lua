ComicBook = {};
comicImag1 = nil
comicImg1 = Graphics.loadImage("app0:/Sprites/Comic1.png");
comicImg2 = Graphics.loadImage("app0:/Sprites/Comic2.png");

function ComicBook:new(page)
  comicBook = {}
  setmetatable(comicBook, self);
  self.__index = self;
  comicBook.page = page;
  
  return comicBook;
end


function ComicBook:Draw()
  if(self.page == 1) then
  self.comicObj = Graphics.drawPartialImage(38, 0, 0,0,884,544, comicImg1);
end

if(self.page == 2) then
  self.comicObj = Graphics.drawPartialImage(38, 0, 0,0,884,544, comicImg2);
  end
end

function ComicBook:CheckForButtonPress()
  if (xIsPressed == true and xCanBePressed == true) then
   xCanBePressed = false;
   
   if(self.page == 1) then
   CreateLevel();
   end
   
   if(self.page == 2) then
   EndGame();
   end
    
    end
end


function ComicBook:Update()
  self:Draw()
  self:CheckForButtonPress()
end
