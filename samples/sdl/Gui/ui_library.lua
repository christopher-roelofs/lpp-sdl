-- UI Library for LPP-SDL
-- A simple, reusable UI component system

local UI = {}

-- Base Component class
local Component = {}
Component.__index = Component

function Component:new(x, y, width, height)
    local instance = setmetatable({}, self)
    instance.x = x or 0
    instance.y = y or 0
    instance.width = width or 100
    instance.height = height or 50
    instance.visible = true
    instance.enabled = true
    instance.children = {}
    instance.parent = nil
    return instance
end

function Component:addChild(child)
    table.insert(self.children, child)
    child.parent = self
    return child
end

function Component:removeChild(child)
    for i, c in ipairs(self.children) do
        if c == child then
            table.remove(self.children, i)
            child.parent = nil
            break
        end
    end
end

function Component:getAbsolutePosition()
    local x, y = self.x, self.y
    if self.parent then
        local px, py = self.parent:getAbsolutePosition()
        x = x + px
        y = y + py
    end
    return x, y
end

function Component:isPointInside(x, y)
    local ax, ay = self:getAbsolutePosition()
    return x >= ax and x <= ax + self.width and
           y >= ay and y <= ay + self.height
end

function Component:draw()
    if not self.visible then return end
    
    -- Draw children
    for _, child in ipairs(self.children) do
        child:draw()
    end
end

function Component:update(dt)
    if not self.enabled then return end
    
    -- Update children
    for _, child in ipairs(self.children) do
        child:update(dt)
    end
end

function Component:handleTouch(x, y, pressed)
    if not self.enabled or not self.visible then return false end
    
    -- Check children first (top to bottom)
    for i = #self.children, 1, -1 do
        if self.children[i]:handleTouch(x, y, pressed) then
            return true
        end
    end
    
    return false
end

-- Button Component
local Button = setmetatable({}, {__index = Component})
Button.__index = Button

function Button:new(x, y, width, height, text, font)
    local instance = Component.new(self, x, y, width, height)
    instance.text = text or "Button"
    instance.font = font
    instance.backgroundColor = Color.new(64, 64, 64)
    instance.hoverColor = Color.new(96, 96, 96)
    instance.pressedColor = Color.new(32, 32, 32)
    instance.textColor = Color.new(255, 255, 255)
    instance.borderColor = Color.new(128, 128, 128)
    instance.borderWidth = 2
    instance.isHovered = false
    instance.isPressed = false
    instance.onClick = nil
    return instance
end

function Button:draw()
    if not self.visible then return end
    
    local ax, ay = self:getAbsolutePosition()
    
    -- Choose background color based on state
    local bgColor = self.backgroundColor
    if self.isPressed then
        bgColor = self.pressedColor
    elseif self.isHovered then
        bgColor = self.hoverColor
    end
    
    -- Draw background
    Graphics.fillRect(ax, ax + self.width, ay, ay + self.height, bgColor)
    
    -- Draw border
    if self.borderWidth > 0 then
        for i = 0, self.borderWidth - 1 do
            Graphics.drawRect(ax + i, ax + self.width - i, ay + i, ay + self.height - i, self.borderColor)
        end
    end
    
    -- Draw text
    if self.font then
        -- Calculate text position (centered)
        local textX = ax + self.width / 2 - (string.len(self.text) * 8) / 2
        local textY = ay + self.height / 2 - 8
        Font.print(self.font, textX, textY, self.text, self.textColor)
    else
        -- Use debug print if no font provided
        local textX = ax + self.width / 2 - (string.len(self.text) * 8) / 2
        local textY = ay + self.height / 2 - 8
        Graphics.debugPrint(textX, textY, self.text, self.textColor)
    end
    
    -- Draw children
    Component.draw(self)
end

function Button:handleTouch(x, y, pressed)
    if not self.enabled or not self.visible then return false end
    
    -- Check children first
    if Component.handleTouch(self, x, y, pressed) then
        return true
    end
    
    -- Check if touch is inside button
    if self:isPointInside(x, y) then
        if pressed then
            if not self.isPressed then
                self.isPressed = true
            end
        else
            if self.isPressed then
                self.isPressed = false
                if self.onClick then
                    self.onClick(self)
                end
            end
        end
        self.isHovered = true
        return true
    else
        self.isHovered = false
        self.isPressed = false
    end
    
    return false
end

-- Panel Component (Container)
local Panel = setmetatable({}, {__index = Component})
Panel.__index = Panel

function Panel:new(x, y, width, height)
    local instance = Component.new(self, x, y, width, height)
    instance.backgroundColor = Color.new(48, 48, 48)
    instance.borderColor = Color.new(96, 96, 96)
    instance.borderWidth = 1
    return instance
end

function Panel:draw()
    if not self.visible then return end
    
    local ax, ay = self:getAbsolutePosition()
    
    -- Draw background
    Graphics.fillRect(ax, ax + self.width, ay, ay + self.height, self.backgroundColor)
    
    -- Draw border
    if self.borderWidth > 0 then
        for i = 0, self.borderWidth - 1 do
            Graphics.drawRect(ax + i, ax + self.width - i, ay + i, ay + self.height - i, self.borderColor)
        end
    end
    
    -- Draw children
    Component.draw(self)
end

-- Label Component
local Label = setmetatable({}, {__index = Component})
Label.__index = Label

function Label:new(x, y, text, font)
    local instance = Component.new(self, x, y, 0, 20)
    instance.text = text or ""
    instance.font = font
    instance.textColor = Color.new(255, 255, 255)
    instance.alignment = "left" -- left, center, right
    return instance
end

function Label:draw()
    if not self.visible then return end
    
    local ax, ay = self:getAbsolutePosition()
    
    -- Calculate text position based on alignment
    local textX = ax
    if self.alignment == "center" then
        textX = ax + self.width / 2 - (string.len(self.text) * 8) / 2
    elseif self.alignment == "right" then
        textX = ax + self.width - string.len(self.text) * 8
    end
    
    -- Draw text
    if self.font then
        Font.print(self.font, textX, ay, self.text, self.textColor)
    else
        Graphics.debugPrint(textX, ay, self.text, self.textColor)
    end
    
    -- Draw children
    Component.draw(self)
end

-- TextField Component
local TextField = setmetatable({}, {__index = Component})
TextField.__index = TextField

function TextField:new(x, y, width, height, font)
    local instance = Component.new(self, x, y, width, height)
    instance.text = ""
    instance.font = font
    instance.backgroundColor = Color.new(32, 32, 32)
    instance.borderColor = Color.new(128, 128, 128)
    instance.borderColorFocused = Color.new(64, 128, 255)
    instance.textColor = Color.new(255, 255, 255)
    instance.borderWidth = 2
    instance.isFocused = false
    instance.padding = 5
    instance.onChange = nil
    return instance
end

function TextField:draw()
    if not self.visible then return end
    
    local ax, ay = self:getAbsolutePosition()
    
    -- Draw background
    Graphics.fillRect(ax, ax + self.width, ay, ay + self.height, self.backgroundColor)
    
    -- Draw border
    local borderColor = self.isFocused and self.borderColorFocused or self.borderColor
    for i = 0, self.borderWidth - 1 do
        Graphics.drawRect(ax + i, ax + self.width - i, ay + i, ay + self.height - i, borderColor)
    end
    
    -- Draw text
    local textX = ax + self.padding
    local textY = ay + self.height / 2 - 8
    
    local displayText = self.text
    if self.isFocused then
        displayText = displayText .. "_"
    end
    
    if self.font then
        Font.print(self.font, textX, textY, displayText, self.textColor)
    else
        Graphics.debugPrint(textX, textY, displayText, self.textColor)
    end
    
    -- Draw children
    Component.draw(self)
end

function TextField:handleTouch(x, y, pressed)
    if not self.enabled or not self.visible then return false end
    
    -- Check children first
    if Component.handleTouch(self, x, y, pressed) then
        return true
    end
    
    -- Check if touch is inside field
    if pressed and self:isPointInside(x, y) then
        self.isFocused = true
        return true
    elseif pressed then
        self.isFocused = false
    end
    
    return false
end

function TextField:handleKey(key)
    if not self.isFocused then return false end
    
    -- Handle backspace
    if key == "backspace" and string.len(self.text) > 0 then
        self.text = string.sub(self.text, 1, -2)
        if self.onChange then
            self.onChange(self, self.text)
        end
        return true
    end
    
    -- Add character
    if string.len(key) == 1 then
        self.text = self.text .. key
        if self.onChange then
            self.onChange(self, self.text)
        end
        return true
    end
    
    return false
end

-- UI Manager
local UIManager = {}
UIManager.__index = UIManager

function UIManager:new()
    local instance = setmetatable({}, self)
    instance.root = Component:new(0, 0, 960, 544) -- Vita screen size by default
    instance.touchPressed = false
    return instance
end

function UIManager:add(component)
    self.root:addChild(component)
    return component
end

function UIManager:remove(component)
    self.root:removeChild(component)
end

function UIManager:draw()
    self.root:draw()
end

function UIManager:update(dt)
    self.root:update(dt)
    
    -- Handle touch input
    local x, y = Controls.readTouch()
    if x and y then
        if not self.touchPressed then
            self.touchPressed = true
            self.root:handleTouch(x, y, true)
        else
            self.root:handleTouch(x, y, false)
        end
    else
        if self.touchPressed then
            self.touchPressed = false
            self.root:handleTouch(-1, -1, false)
        end
    end
end

-- Export UI components
UI.Component = Component
UI.Button = Button
UI.Panel = Panel
UI.Label = Label
UI.TextField = TextField
UI.Manager = UIManager

return UI