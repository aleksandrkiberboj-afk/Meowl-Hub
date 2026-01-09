local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()
local Window = WindUI:CreateWindow({
    Title = "Meowl Hub | Grandma's Favorite",
    Icon = "rbxassetid://10734950309",
    Author = "Meowl_2026"
})

local Core = loadstring(game:HttpGet("https://raw.githubusercontent.com/aleksandrkiberboj-afk/Meowl-Hub/main/MeowlCore.lua"))()
local Actions = loadstring(game:HttpGet("https://raw.githubusercontent.com/aleksandrkiberboj-afk/Meowl-Hub/main/MeowlActions.lua"))()

local MainTab = Window:Tab({ Title = "Main", Icon = "house" })
MainTab:Section({ Title = "Параметры игрока" })

MainTab:Slider({
    Title = "Скорость",
    Step = 1, Min = 16, Max = 250, Default = 16,
    Callback = function(v) Actions.SetStat("WalkSpeed", v) end
})

MainTab:Slider({
    Title = "Прыжок",
    Step = 1, Min = 50, Max = 500, Default = 50,
    Callback = function(v) Actions.SetStat("JumpPower", v) end
})

Core.Notify(WindUI, "Meowl Hub", "Добро пожаловать, " .. Core.Data.Creator)
