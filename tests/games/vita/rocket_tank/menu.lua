Menu = {}
function Menu:render()
  Graphics.drawImage(0,0,overlay)
  Graphics.drawImage(0,0,overlay)
  Graphics.debugPrint(5, 5, "(Soon to be beautiful and fully functional Main Menu)", white)
  Graphics.debugPrint(300, 200, "Press O to start single player", white)
  Graphics.debugPrint(300, 250, "Press X to start two player", white)
  Graphics.debugPrint(5, 300, "TODO:", white)
  Graphics.debugPrint(20, 320, "Make menu", white)
  Graphics.debugPrint(20, 340, "Figure out why sound lags to death", white)
  Graphics.debugPrint(20, 340+20, "Make Win/Lose screens", white)
  Graphics.debugPrint(20, 360+20, "I say not bad for two days", white)
  Graphics.debugPrint(20, 380+20, "Make actual AI (The learning kind c:<)", white)
  Graphics.debugPrint(20, 400+20, "Add Camera for larger world (Singleplayer)", white)
  Graphics.debugPrint(20, 420+20, "Please someone help me get unity for vita", white)
  Graphics.debugPrint(20, 440+20, "Interactable Objects", white)
  Graphics.debugPrint(20, 460+20, "EXPLOSIONS", white)

  if Controls.check(Controls.read(), SCE_CTRL_CROSS) then
    screen = 2
  end
  if Controls.check(Controls.read(), SCE_CTRL_CIRCLE) then
    screen = 1
  end
end
