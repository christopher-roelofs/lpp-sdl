print("=== Testing dofile pattern ===")

-- Simulate the exact pattern used in hangman
white = Color.new(255,255,255)
red = Color.new(255,0,0)

-- Load one image to test
stat1 = Graphics.loadImage("Assets/Graphics/STATE1.png")
print("Image loaded in main script")

-- Simulate the game flow
go = 0
pad = Controls.read()
oldpad = Controls.read()

print("Starting main loop for 3 iterations...")

for i = 1, 3 do
    print("Main loop iteration", i)
    Graphics.initBlend()
    Screen.clear()
    
    -- Simulate pressing X to start game (this would normally trigger dofile)
    if i == 2 then
        print("=== WOULD CALL dofile('game.lua') HERE ===")
        print("In real game, this would load game.lua which has its own while loop")
        print("And game.lua would eventually call dofile('index.lua') to restart")
        print("This creates: index.lua -> game.lua -> index.lua (nested)")
    end
    
    Graphics.termBlend()
    Screen.flip()
    Screen.waitVblankStart()
end

print("Test completed - no dofile recursion occurred")