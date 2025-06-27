furthestBackground = {};
backgroundCityImage = Graphics.loadImage("app0:/Sprites/FurthestBackground.png");

function furthestBackground.new (xPos,yPos)


furthestBackground.xPos = xPos;
furthestBackground.yPos = yPos;

end

function furthestBackground.Draw()
  furBackSprite = Graphics.drawPartialImage( furthestBackground.xPos, furthestBackground.yPos, 0, 0, 256, 391, backgroundCityImage )
  furBackSprite1 = Graphics.drawPartialImage( furthestBackground.xPos + 256, furthestBackground.yPos, 0, 0, 256, 391, backgroundCityImage )
  furBackSprite2 = Graphics.drawPartialImage( furthestBackground.xPos + (256 * 2), furthestBackground.yPos, 0, 0, 256, 391, backgroundCityImage )
  furBackSprite3 = Graphics.drawPartialImage( furthestBackground.xPos + (256 * 3), furthestBackground.yPos, 0, 0, 256, 391, backgroundCityImage) 
  furBackSprite4 = Graphics.drawPartialImage( furthestBackground.xPos + (256 * 4), furthestBackground.yPos, 0, 0, 256, 391, backgroundCityImage )
  furBackSprite5 = Graphics.drawPartialImage( furthestBackground.xPos + (256 * 5), furthestBackground.yPos, 0, 0, 256, 391, backgroundCityImage )


end

function furthestBackground.Move()
  furthestBackground.xPos =furthestBackground.xPos - 1;
  if(furthestBackground.xPos <= -256) then
  furthestBackground.xPos = 0;
  end
  end

function furthestBackground.Update()
  
  furthestBackground.Move();
  furthestBackground.Draw();
  
  
  end