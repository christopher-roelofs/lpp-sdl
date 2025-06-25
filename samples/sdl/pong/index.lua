-- Pong for lpp-sdl (Truly Resolution Independent)

-- Get screen dimensions from the engine. This works in both default and vitacompat modes.
local screen_width = Screen.getWidth()
local screen_height = Screen.getHeight()

-- Colors
local white = Color.new(255, 255, 255)

-- Game object dimensions and speeds are now relative to the screen size.
local paddle_width = screen_width * 0.015
local paddle_height = screen_height * 0.15
local ball_size = screen_width * 0.012
local paddle_speed = screen_height * 0.013
local base_ball_speed_x = screen_width * 0.005
local base_ball_speed_y = screen_height * 0.009

-- Use a consistent margin for positioning.
local margin = screen_width * 0.04

-- Game objects
local ball = {
  x = screen_width / 2 - ball_size / 2,
  y = screen_height / 2 - ball_size / 2,
  width = ball_size,
  height = ball_size,
  dx = base_ball_speed_x,
  dy = base_ball_speed_y
}

local player1 = {
  x = margin,
  y = screen_height / 2 - paddle_height / 2,
  width = paddle_width,
  height = paddle_height,
  speed = paddle_speed
}

local player2 = {
  x = screen_width - paddle_width - margin,
  y = screen_height / 2 - paddle_height / 2,
  width = paddle_width,
  height = paddle_height,
  speed = paddle_speed
}

-- Score
local score1 = 0
local score2 = 0

-- Function to draw a filled rectangle
function draw_filled_rect(x, y, w, h, color)
  Graphics.fillRect(x, x + w, y, y + h, color)
end

-- Function to reset the ball's position and speed
function reset_ball()
    ball.x = screen_width / 2 - ball_size / 2
    ball.y = screen_height / 2 - ball_size / 2
    
    -- Reverse direction and reset speed
    if ball.dx > 0 then
        ball.dx = -base_ball_speed_x
    else
        ball.dx = base_ball_speed_x
    end
end

-- Main loop
while true do
  -- Clear the screen
  Screen.clear()

  -- Read controls
  local pad = Controls.read()

  -- Player 1 movement
  if Controls.check(pad, SDLK_UP) then
    player1.y = player1.y - player1.speed
  end
  if Controls.check(pad, SDLK_DOWN) then
    player1.y = player1.y + player1.speed
  end

  -- Player 2 movement (simple AI)
  if ball.y + ball.height / 2 > player2.y + player2.height / 2 then
      player2.y = player2.y + player2.speed * 0.8
  elseif ball.y + ball.height / 2 < player2.y + player2.height / 2 then
      player2.y = player2.y - player2.speed * 0.8
  end

  -- Keep paddles on screen
  if player1.y < 0 then player1.y = 0 end
  if player1.y + player1.height > screen_height then player1.y = screen_height - player1.height end
  if player2.y < 0 then player2.y = 0 end
  if player2.y + player2.height > screen_height then player2.y = screen_height - player2.height end

  -- Move the ball
  ball.x = ball.x + ball.dx
  ball.y = ball.y + ball.dy

  -- Ball collision with top and bottom walls
  if ball.y <= 0 or (ball.y + ball.height >= screen_height) then
    ball.dy = -ball.dy
  end

  -- Ball collision with paddles
  if (ball.x < player1.x + player1.width and ball.x + ball.width > player1.x and
      ball.y < player1.y + player1.height and ball.y + ball.height > player1.y) then
    ball.dx = -ball.dx
    ball.dx = ball.dx * 1.05 -- Increase speed slightly on hit
  end

  if (ball.x < player2.x + player2.width and ball.x + ball.width > player2.x and
      ball.y < player2.y + player2.height and ball.y + ball.height > player2.y) then
    ball.dx = -ball.dx
    ball.dx = ball.dx * 1.05
  end

  -- Ball out of bounds (scoring)
  if ball.x < 0 then
    score2 = score2 + 1
    reset_ball()
  end

  if ball.x + ball.width > screen_width then
    score1 = score1 + 1
    reset_ball()
  end

  -- Draw everything
  Graphics.initBlend()
  
  draw_filled_rect(ball.x, ball.y, ball.width, ball.height, white)
  draw_filled_rect(player1.x, player1.y, player1.width, player1.height, white)
  draw_filled_rect(player2.x, player2.y, player2.width, player2.height, white)

  -- Draw score
  Graphics.debugPrint(screen_width * 0.25, 20, tostring(score1), white)
  Graphics.debugPrint(screen_width * 0.75, 20, tostring(score2), white)
  
  -- Draw centered exit text
  local exit_text = "Press TRIANGLE to exit"
  -- Estimate width of text (char_count * pixels_per_char) and center it.
  local exit_text_x = screen_width / 2 - (string.len(exit_text) * 4)
  local exit_text_y = screen_height - 30
  Graphics.debugPrint(exit_text_x, exit_text_y, exit_text, white)
  
  -- Draw center line
  local center_line_segment_height = screen_height * 0.02
  local center_line_gap = screen_height * 0.02
  local center_line_y = 0
  while center_line_y < screen_height do
    draw_filled_rect(screen_width/2 - 1, center_line_y, 2, center_line_segment_height, white)
    center_line_y = center_line_y + center_line_segment_height + center_line_gap
  end

  Graphics.termBlend()

  -- Update screen
  Screen.flip()

  -- Exit condition
  if Controls.check(Controls.read(), SCE_CTRL_TRIANGLE) then
    break
  end
end
