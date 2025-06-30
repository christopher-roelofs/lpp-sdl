-- UI Library for LPP-SDL with Resolution Independence
-- Supports automatic scaling and flexible layouts

local UI = {}

-- Default reference resolution (can be changed)
UI.referenceWidth = 1920
UI.referenceHeight = 1080

-- Current screen resolution
UI.screenWidth = 960
UI.screenHeight = 544

-- Calculate scale factors
UI.scaleX = UI.screenWidth / UI.referenceWidth
UI.scaleY = UI.screenHeight / UI.referenceHeight
UI.scale = math.min(UI.scaleX, UI.scaleY) -- Uniform scale to maintain aspect ratio

-- Update scale factors when screen size changes
function UI.setScreenSize(width, height)
    UI.screenWidth = width
    UI.screenHeight = height
    UI.scaleX = UI.screenWidth / UI.referenceWidth
    UI.scaleY = UI.screenHeight / UI.referenceHeight
    UI.scale = math.min(UI.scaleX, UI.scaleY)
end

-- Set reference resolution for design
function UI.setReferenceResolution(width, height)
    UI.referenceWidth = width
    UI.referenceHeight = height
    UI.scaleX = UI.screenWidth / UI.referenceWidth
    UI.scaleY = UI.screenHeight / UI.referenceHeight
    UI.scale = math.min(UI.scaleX, UI.scaleY)
end

-- Layout types
UI.Layout = {
    ABSOLUTE = "absolute",
    RELATIVE = "relative",
    FLEX = "flex"
}

-- Anchor types for relative positioning
UI.Anchor = {
    TOP_LEFT = {0, 0},
    TOP_CENTER = {0.5, 0},
    TOP_RIGHT = {1, 0},
    CENTER_LEFT = {0, 0.5},
    CENTER = {0.5, 0.5},
    CENTER_RIGHT = {1, 0.5},
    BOTTOM_LEFT = {0, 1},
    BOTTOM_CENTER = {0.5, 1},
    BOTTOM_RIGHT = {1, 1}
}

-- Base Component class
local Component = {}
Component.__index = Component

function Component:new(options)
    options = options or {}
    local instance = setmetatable({}, self)
    
    -- Position and size (in reference resolution units)
    instance.x = options.x or 0
    instance.y = options.y or 0
    instance.width = options.width or 100
    instance.height = options.height or 50
    
    -- Layout properties
    instance.layout = options.layout or UI.Layout.ABSOLUTE
    instance.anchor = options.anchor or UI.Anchor.TOP_LEFT
    instance.margin = options.margin or {top = 0, right = 0, bottom = 0, left = 0}
    instance.padding = options.padding or {top = 0, right = 0, bottom = 0, left = 0}
    
    -- Relative sizing (0-1 as percentage of parent)
    instance.relativeWidth = options.relativeWidth
    instance.relativeHeight = options.relativeHeight
    instance.relativeX = options.relativeX
    instance.relativeY = options.relativeY
    
    -- Flex properties
    instance.flex = options.flex or 0
    instance.flexDirection = options.flexDirection or "row" -- row, column
    instance.justifyContent = options.justifyContent or "start" -- start, center, end, space-between, space-around
    instance.alignItems = options.alignItems or "start" -- start, center, end, stretch
    instance.gap = options.gap or 0
    
    -- State
    instance.visible = true
    instance.enabled = true
    instance.children = {}
    instance.parent = nil
    
    -- Cached computed values
    instance._computedX = 0
    instance._computedY = 0
    instance._computedWidth = 0
    instance._computedHeight = 0
    instance._needsLayout = true
    
    return instance
end

function Component:addChild(child)
    table.insert(self.children, child)
    child.parent = self
    self:invalidateLayout()
    return child
end

function Component:removeChild(child)
    for i, c in ipairs(self.children) do
        if c == child then
            table.remove(self.children, i)
            child.parent = nil
            self:invalidateLayout()
            break
        end
    end
end

function Component:invalidateLayout()
    self._needsLayout = true
    if self.parent then
        self.parent:invalidateLayout()
    end
end

function Component:computeLayout()
    if not self._needsLayout then return end
    
    -- Compute own position and size
    if self.parent then
        local parentX = self.parent._computedX + self.parent.padding.left
        local parentY = self.parent._computedY + self.parent.padding.top
        local parentWidth = self.parent._computedWidth - self.parent.padding.left - self.parent.padding.right
        local parentHeight = self.parent._computedHeight - self.parent.padding.top - self.parent.padding.bottom
        
        -- Calculate size
        if self.relativeWidth then
            self._computedWidth = parentWidth * self.relativeWidth
        else
            self._computedWidth = self.width * UI.scale
        end
        
        if self.relativeHeight then
            self._computedHeight = parentHeight * self.relativeHeight
        else
            self._computedHeight = self.height * UI.scale
        end
        
        -- Calculate position based on anchor
        local anchorX, anchorY = self.anchor[1], self.anchor[2]
        
        if self.relativeX then
            self._computedX = parentX + parentWidth * self.relativeX
        else
            self._computedX = parentX + (self.x * UI.scale)
        end
        
        if self.relativeY then
            self._computedY = parentY + parentHeight * self.relativeY
        else
            self._computedY = parentY + (self.y * UI.scale)
        end
        
        -- Apply anchor offset
        self._computedX = self._computedX + (parentWidth - self._computedWidth) * anchorX
        self._computedY = self._computedY + (parentHeight - self._computedHeight) * anchorY
        
        -- Apply margins
        self._computedX = self._computedX + self.margin.left * UI.scale
        self._computedY = self._computedY + self.margin.top * UI.scale
    else
        -- Root component
        self._computedX = self.x * UI.scale
        self._computedY = self.y * UI.scale
        self._computedWidth = self.width * UI.scale
        self._computedHeight = self.height * UI.scale
    end
    
    -- Layout children based on layout type
    if self.layout == UI.Layout.FLEX then
        self:computeFlexLayout()
    else
        -- For absolute/relative layout, just compute children
        for _, child in ipairs(self.children) do
            child:computeLayout()
        end
    end
    
    self._needsLayout = false
end

function Component:computeFlexLayout()
    local availableWidth = self._computedWidth - self.padding.left - self.padding.right
    local availableHeight = self._computedHeight - self.padding.top - self.padding.bottom
    local isRow = self.flexDirection == "row"
    local mainSize = isRow and availableWidth or availableHeight
    local crossSize = isRow and availableHeight or availableWidth
    
    -- Calculate flex children and fixed size
    local totalFlex = 0
    local fixedSize = 0
    local visibleChildren = {}
    
    for _, child in ipairs(self.children) do
        if child.visible then
            table.insert(visibleChildren, child)
            if child.flex > 0 then
                totalFlex = totalFlex + child.flex
            else
                child:computeLayout()
                local childSize = isRow and child._computedWidth or child._computedHeight
                fixedSize = fixedSize + childSize
            end
        end
    end
    
    -- Add gaps
    local totalGaps = math.max(0, #visibleChildren - 1) * self.gap * UI.scale
    fixedSize = fixedSize + totalGaps
    
    -- Calculate flex unit size
    local remainingSize = math.max(0, mainSize - fixedSize)
    local flexUnit = totalFlex > 0 and remainingSize / totalFlex or 0
    
    -- Position children
    local currentPos = isRow and (self._computedX + self.padding.left) or (self._computedY + self.padding.top)
    
    -- Handle justifyContent for start position
    if self.justifyContent == "center" then
        currentPos = currentPos + (mainSize - fixedSize - (flexUnit * totalFlex)) / 2
    elseif self.justifyContent == "end" then
        currentPos = currentPos + (mainSize - fixedSize - (flexUnit * totalFlex))
    end
    
    for i, child in ipairs(visibleChildren) do
        -- Set position
        if isRow then
            child._computedX = currentPos
            child._computedY = self._computedY + self.padding.top
            
            -- Handle alignItems
            if self.alignItems == "center" then
                child._computedY = child._computedY + (crossSize - child._computedHeight) / 2
            elseif self.alignItems == "end" then
                child._computedY = child._computedY + (crossSize - child._computedHeight)
            elseif self.alignItems == "stretch" then
                child._computedHeight = crossSize
            end
        else
            child._computedX = self._computedX + self.padding.left
            child._computedY = currentPos
            
            -- Handle alignItems
            if self.alignItems == "center" then
                child._computedX = child._computedX + (crossSize - child._computedWidth) / 2
            elseif self.alignItems == "end" then
                child._computedX = child._computedX + (crossSize - child._computedWidth)
            elseif self.alignItems == "stretch" then
                child._computedWidth = crossSize
            end
        end
        
        -- Set size for flex children
        if child.flex > 0 then
            if isRow then
                child._computedWidth = flexUnit * child.flex
            else
                child._computedHeight = flexUnit * child.flex
            end
        end
        
        -- Update position for next child
        local childSize = isRow and child._computedWidth or child._computedHeight
        currentPos = currentPos + childSize
        
        -- Add gap
        if i < #visibleChildren then
            currentPos = currentPos + self.gap * UI.scale
        end
        
        -- Compute child's layout
        child:computeLayout()
    end
end

function Component:getScreenPosition()
    return self._computedX, self._computedY
end

function Component:getScreenSize()
    return self._computedWidth, self._computedHeight
end

function Component:isPointInside(x, y)
    return x >= self._computedX and x <= self._computedX + self._computedWidth and
           y >= self._computedY and y <= self._computedY + self._computedHeight
end

function Component:draw()
    if not self.visible then return end
    
    -- Ensure layout is computed
    if self._needsLayout then
        self:computeLayout()
    end
    
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

function Button:new(options)
    options = options or {}
    local instance = Component.new(self, options)
    instance.text = options.text or "Button"
    instance.font = options.font
    instance.fontSize = options.fontSize or 16
    instance.backgroundColor = options.backgroundColor or Color.new(64, 64, 64)
    instance.hoverColor = options.hoverColor or Color.new(96, 96, 96)
    instance.pressedColor = options.pressedColor or Color.new(32, 32, 32)
    instance.textColor = options.textColor or Color.new(255, 255, 255)
    instance.borderColor = options.borderColor or Color.new(128, 128, 128)
    instance.borderWidth = options.borderWidth or 2
    instance.borderRadius = options.borderRadius or 0
    instance.isHovered = false
    instance.isPressed = false
    instance.onClick = options.onClick
    return instance
end

function Button:draw()
    if not self.visible then return end
    
    -- Ensure layout is computed
    if self._needsLayout then
        self:computeLayout()
    end
    
    local x, y = self:getScreenPosition()
    local w, h = self:getScreenSize()
    
    -- Choose background color based on state
    local bgColor = self.backgroundColor
    if self.isPressed then
        bgColor = self.pressedColor
    elseif self.isHovered then
        bgColor = self.hoverColor
    end
    
    -- Draw background with optional rounded corners
    if self.borderRadius > 0 then
        -- Simple rounded rectangle approximation
        local r = self.borderRadius * UI.scale
        Graphics.fillRect(x + r, x + w - r, y, y + h, bgColor)
        Graphics.fillRect(x, x + w, y + r, y + h - r, bgColor)
        -- Draw corner circles
        Graphics.fillCircle(x + r, y + r, r, bgColor)
        Graphics.fillCircle(x + w - r, y + r, r, bgColor)
        Graphics.fillCircle(x + r, y + h - r, r, bgColor)
        Graphics.fillCircle(x + w - r, y + h - r, r, bgColor)
    else
        Graphics.fillRect(x, x + w, y, y + h, bgColor)
    end
    
    -- Draw border
    if self.borderWidth > 0 then
        local bw = self.borderWidth * UI.scale
        for i = 0, bw - 1 do
            if self.borderRadius > 0 then
                -- Rounded border (simplified)
                local r = self.borderRadius * UI.scale
                Graphics.drawRect(x + i + r, x + w - i - r, y + i, y + h - i, self.borderColor)
                Graphics.drawRect(x + i, x + w - i, y + i + r, y + h - i - r, self.borderColor)
            else
                Graphics.drawRect(x + i, x + w - i, y + i, y + h - i, self.borderColor)
            end
        end
    end
    
    -- Draw text (scaled)
    local scaledFontSize = self.fontSize * UI.scale
    local charWidth = 8 * (scaledFontSize / 16) -- Approximate character width
    local charHeight = scaledFontSize
    
    local textWidth = string.len(self.text) * charWidth
    local textX = x + (w - textWidth) / 2
    local textY = y + (h - charHeight) / 2
    
    if self.font then
        Font.print(self.font, textX, textY, self.text, self.textColor)
    else
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

function Panel:new(options)
    options = options or {}
    local instance = Component.new(self, options)
    instance.backgroundColor = options.backgroundColor or Color.new(48, 48, 48)
    instance.borderColor = options.borderColor or Color.new(96, 96, 96)
    instance.borderWidth = options.borderWidth or 1
    instance.borderRadius = options.borderRadius or 0
    return instance
end

function Panel:draw()
    if not self.visible then return end
    
    -- Ensure layout is computed
    if self._needsLayout then
        self:computeLayout()
    end
    
    local x, y = self:getScreenPosition()
    local w, h = self:getScreenSize()
    
    -- Draw background with optional rounded corners
    if self.borderRadius > 0 then
        local r = self.borderRadius * UI.scale
        Graphics.fillRect(x + r, x + w - r, y, y + h, self.backgroundColor)
        Graphics.fillRect(x, x + w, y + r, y + h - r, self.backgroundColor)
        Graphics.fillCircle(x + r, y + r, r, self.backgroundColor)
        Graphics.fillCircle(x + w - r, y + r, r, self.backgroundColor)
        Graphics.fillCircle(x + r, y + h - r, r, self.backgroundColor)
        Graphics.fillCircle(x + w - r, y + h - r, r, self.backgroundColor)
    else
        Graphics.fillRect(x, x + w, y, y + h, self.backgroundColor)
    end
    
    -- Draw border
    if self.borderWidth > 0 then
        local bw = self.borderWidth * UI.scale
        for i = 0, bw - 1 do
            if self.borderRadius > 0 then
                local r = self.borderRadius * UI.scale
                Graphics.drawRect(x + i + r, x + w - i - r, y + i, y + h - i, self.borderColor)
                Graphics.drawRect(x + i, x + w - i, y + i + r, y + h - i - r, self.borderColor)
            else
                Graphics.drawRect(x + i, x + w - i, y + i, y + h - i, self.borderColor)
            end
        end
    end
    
    -- Draw children
    Component.draw(self)
end

-- Label Component
local Label = setmetatable({}, {__index = Component})
Label.__index = Label

function Label:new(options)
    options = options or {}
    options.height = options.height or 30
    local instance = Component.new(self, options)
    instance.text = options.text or ""
    instance.font = options.font
    instance.fontSize = options.fontSize or 16
    instance.textColor = options.textColor or Color.new(255, 255, 255)
    instance.alignment = options.alignment or "left" -- left, center, right
    return instance
end

function Label:draw()
    if not self.visible then return end
    
    -- Ensure layout is computed
    if self._needsLayout then
        self:computeLayout()
    end
    
    local x, y = self:getScreenPosition()
    local w, h = self:getScreenSize()
    
    -- Calculate text position based on alignment
    local scaledFontSize = self.fontSize * UI.scale
    local charWidth = 8 * (scaledFontSize / 16)
    local textWidth = string.len(self.text) * charWidth
    
    local textX = x
    if self.alignment == "center" then
        textX = x + (w - textWidth) / 2
    elseif self.alignment == "right" then
        textX = x + w - textWidth
    end
    
    local textY = y + (h - scaledFontSize) / 2
    
    -- Draw text
    if self.font then
        Font.print(self.font, textX, textY, self.text, self.textColor)
    else
        Graphics.debugPrint(textX, textY, self.text, self.textColor)
    end
    
    -- Draw children
    Component.draw(self)
end

-- UI Manager
local UIManager = {}
UIManager.__index = UIManager

function UIManager:new(screenWidth, screenHeight)
    local instance = setmetatable({}, self)
    
    -- Set screen size
    if screenWidth and screenHeight then
        UI.setScreenSize(screenWidth, screenHeight)
    end
    
    -- Create root container that fills the screen
    instance.root = Component:new({
        x = 0,
        y = 0,
        width = UI.referenceWidth,
        height = UI.referenceHeight
    })
    
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

-- Export UI components and utilities
UI.Component = Component
UI.Button = Button
UI.Panel = Panel
UI.Label = Label
UI.Manager = UIManager

return UI