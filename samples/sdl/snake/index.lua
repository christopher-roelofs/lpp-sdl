-- Snake for lpp-sdl (Resolution Independent)

-- Get screen dimensions for dynamic scaling
local screen_width = Screen.getWidth()
local screen_height = Screen.getHeight()

-- Colors
local white = Color.new(255, 255, 255)
local green = Color.new(0, 200, 0)
local red = Color.new(200, 0, 0)
local gray = Color.new(100, 100, 100)

-- Game grid setup
-- We divide the screen into a grid to make positioning resolution-independent.
local grid_cell_size = math.floor(screen_width / 40) -- 40 cells across the width
local grid_width = math.floor(screen_width / grid_cell_size)
local grid_height = math.floor(screen_height / grid_cell_size)

-- Game state
local snake = {}
local food = {}
local direction = 'RIGHT'
local score = 0
local game_over = false
local game_speed = 0.1 -- seconds per move
local game_update_timer = Timer.new()

-- Function to draw a filled rectangle on the grid
function draw_grid_rect(x, y, color)
  local real_x = x * grid_cell_size
  local real_y = y * grid_cell_size
  Graphics.fillRect(real_x, real_x + grid_cell_size, real_y, real_y + grid_cell_size, color)
end

-- Function to place food at a random location
function place_food()
  food.x = math.random(0, grid_width - 1)
  food.y = math.random(0, grid_height - 1)
  -- Ensure food doesn't spawn on the snake
  for i, segment in ipairs(snake) do
    if food.x == segment.x and food.y == segment.y then
      place_food() -- Try again
      return
    end
  end
end

-- Function to initialize or reset the game
function reset_game()
  -- Initial snake position and body
  snake = {
    {x = 10, y = 10},
    {x = 9, y = 10},
    {x = 8, y = 10}
  }
  direction = 'RIGHT'
  score = 0
  game_over = false
  place_food()
  Timer.reset(game_update_timer)
end

-- Initialize the game for the first time
reset_game()

-- Main game loop
while true do
  -- Read controls
  local pad = Controls.read()

  -- Handle input
  if not game_over then
    if Controls.check(pad, SDLK_UP) and direction ~= 'DOWN' then
      direction = 'UP'
    elseif Controls.check(pad, SDLK_DOWN) and direction ~= 'UP' then
      direction = 'DOWN'
    elseif Controls.check(pad, SDLK_LEFT) and direction ~= 'RIGHT' then
      direction = 'LEFT'
    elseif Controls.check(pad, SDLK_RIGHT) and direction ~= 'LEFT' then
      direction = 'RIGHT'
    end
  else
    -- Restart game on key press
    if Controls.check(pad, SDLK_RETURN) or Controls.check(pad, SCE_CTRL_CROSS) then
      reset_game()
    end
  end

  -- Exit condition
  if Controls.check(pad, SCE_CTRL_TRIANGLE) then
    break
  end

  -- Update game state based on timer
  if Timer.getTime(game_update_timer) / 1000.0 > game_speed and not game_over then
    Timer.reset(game_update_timer)

    -- Calculate new head position
    local head = {x = snake[1].x, y = snake[1].y}
    if direction == 'UP' then head.y = head.y - 1 end
    if direction == 'DOWN' then head.y = head.y + 1 end
    if direction == 'LEFT' then head.x = head.x - 1 end
    if direction == 'RIGHT' then head.x = head.x + 1 end

    -- Check for wall collision
    if head.x < 0 or head.x >= grid_width or head.y < 0 or head.y >= grid_height then
      game_over = true
    else
      -- Insert new head
      table.insert(snake, 1, head)

      -- Check for food collision
      if head.x == food.x and head.y == food.y then
        score = score + 1
        place_food() -- Don't remove tail, snake grows
      else
        table.remove(snake) -- Remove tail
      end

      -- Check for self collision
      for i = 2, #snake do
        if head.x == snake[i].x and head.y == snake[i].y then
          game_over = true
          break
        end
      end
    end
  end

  -- Drawing
  Screen.clear()
  Graphics.initBlend()

  -- Draw snake
  for i, segment in ipairs(snake) do
    draw_grid_rect(segment.x, segment.y, green)
  end

  -- Draw food
  draw_grid_rect(food.x, food.y, red)

  -- Draw score
  Graphics.debugPrint(10, 10, "Score: " .. tostring(score), white)

  -- Draw game over message
  if game_over then
    local msg = "Game Over!"
    local msg2 = "Press ENTER or (X) to Restart"
    local msg_w = string.len(msg) * 8 -- Approximate width
    local msg2_w = string.len(msg2) * 8
    Graphics.debugPrint(screen_width / 2 - msg_w / 2, screen_height / 2 - 20, msg, white)
    Graphics.debugPrint(screen_width / 2 - msg2_w / 2, screen_height / 2, msg2, white)
  end

  Graphics.termBlend()
  Screen.flip()
end
