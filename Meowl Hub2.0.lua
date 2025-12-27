local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Meowl Scripter Hub",
    Icon = "", -- lucide icon. optional
    Author = "by .ftgs and .ftgs", -- optional

OpenButton = {
    Title = "Meowl Hub",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
}

)}
local Tab = Window:Tab({
    Title = "Main",
    Icon = "bird", -- optional
    Locked = false,
})

Tab:Select() -- Select Tab
