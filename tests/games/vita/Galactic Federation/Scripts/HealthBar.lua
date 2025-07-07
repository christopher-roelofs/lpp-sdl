HealthBar = {}
healthBarImg = Graphics.loadImage("app0:/Sprites/HealthBar.png")
energyBarImg = Graphics.loadImage("app0:/Sprites/EnergyBar.png")

function HealthBar:New()
  healthBar = {}
  setmetatable(healthBar, self)
  self.__index = self
  healthBar.currentHealth = 0
  healthBar.maxHealth = 0
  healthBar.currentEnergy = 0
  healthBar.maxEnergy = 0
  
  return healthBar
end

function HealthBar:Draw()
  healthPercent = self.currentHealth/self.maxHealth
  energyPercent = self.currentEnergy/self.maxEnergy
  Graphics.drawImageExtended(7, 469,0,0, 160,32,1,1, healthBarImg, Color.new(100,100,100))
  Graphics.drawImageExtended(7, 469,0,0, math.ceil(160 * healthPercent),32,1,1, healthBarImg)
  Graphics.drawImageExtended(7, 507,0,32,160,32,1,1,energyBarImg)
  Graphics.drawImageExtended(7, 507,0,0,math.ceil(160 *energyPercent),32,1,1,energyBarImg)
  Graphics.drawLine(7, 167, 469, 469, Color.new(0,0,0))
  Graphics.drawLine(7, 167, 501, 501, Color.new(0,0,0))
  Graphics.drawLine(7, 7, 469, 501, Color.new(0,0,0))
  Graphics.drawLine(167, 167, 469, 501, Color.new(0,0,0))
end

function HealthBar:UpdateValues(currentHealth, maxHealth, currentEnergy, maxEnergy)
  self.currentHealth = currentHealth
  self.maxHealth = maxHealth
  self.currentEnergy = currentEnergy
  self.maxEnergy = maxEnergy
end
