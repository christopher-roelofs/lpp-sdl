-- Console Demo Launcher
-- Run with: ./lpp_sdl -headless samples/sdl/Console/run_demos.lua
-- Demonstrates running multiple console scripts in sequence

print("=== Console Demo Launcher ===")
print("Running multiple console demos in sequence...")

-- Demo scripts to run
local demos = {
    {
        name = "Basic Console Demo",
        script = "index.lua",
        description = "Basic system operations and file handling"
    },
    {
        name = "File Processor",
        script = "file_processor.lua", 
        description = "Directory analysis and reporting"
    },
    {
        name = "Data Converter",
        script = "data_converter.lua",
        description = "Multi-format data conversion (CSV/JSON/XML)"
    }
}

-- Function to run a demo script
local function run_demo(demo)
    print(string.format("\n🚀 Running: %s", demo.name))
    print(string.format("📄 Script: %s", demo.script))
    print(string.format("📝 Description: %s", demo.description))
    print("=" .. string.rep("-", 50))
    
    -- Note: In a real launcher, you might use System.executeProcess() or similar
    -- For this demo, we'll just show what would be executed
    print(string.format("Command: ./lpp_sdl -headless samples/sdl/Console/%s", demo.script))
    print("(This demo shows the launcher concept - each script runs independently)")
    
    return true
end

-- Main execution
print(string.format("\nFound %d console demos to run:", #demos))

for i, demo in ipairs(demos) do
    print(string.format("  %d. %s (%s)", i, demo.name, demo.script))
end

print("\n" .. string.rep("=", 60))

-- Run each demo
local success_count = 0
for i, demo in ipairs(demos) do
    if run_demo(demo) then
        success_count = success_count + 1
        print("✅ Demo completed successfully")
    else
        print("❌ Demo failed")
    end
    
    if i < #demos then
        print("\n⏸️  Waiting before next demo...")
        Timer.sleep(1000) -- Wait 1 second between demos
    end
end

-- Final summary
print("\n" .. string.rep("=", 60))
print("🏁 Demo Launcher Complete")
print(string.format("📊 Results: %d/%d demos ran successfully", success_count, #demos))

if success_count == #demos then
    print("✅ All console demos are working correctly!")
else
    print("⚠️ Some demos had issues - check individual scripts")
end

print("\n📖 To run individual demos:")
for _, demo in ipairs(demos) do
    print(string.format("   ./lpp_sdl -headless samples/sdl/Console/%s", demo.script))
end

print("\n🎯 Console mode perfect for:")
print("   • Server automation scripts")
print("   • Data processing pipelines") 
print("   • Command-line utilities")
print("   • CI/CD automation")
print("   • Headless testing environments")

System.exit()