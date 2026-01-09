-- Загружаем WindUI
local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()
local Window = WindUI:CreateWindow({
    Title = "Meowl Hub",
    Icon = "rbxassetid://10734950309", -- Можно сменить иконку
    Author = "Meowl_2026",
    Folder = "MeowlHubConfig"
})

-- Загружаем твои модули
local Core = loadstring(game:HttpGet("https://raw.githubusercontent.com/aleksandrkiberboj-afk/Meowl-Hub/main/MeowlCore.lua"))()
local Actions = loadstring(game:HttpGet("https://raw.githubusercontent.com/aleksandrkiberboj-afk/Meowl-Hub/main/MeowlActions.lua"))()

-- Создаем вкладку Main
local MainTab = Window:Tab({
    Title = "Main",
    Icon = "house"
})

-- Секция персонажа
MainTab:Section({ Title = "Параметры игрока" })

MainTab:Slider({
    Title = "Скорость бега",
    Step = 1,
    Min = 16,
    Max = 250,
    Default = 16,
    Callback = function(v)
        Actions.SetSpeed(v)
    end
})

MainTab:Slider({
    Title = "Сила прыжка",
    Step = 1,
    Min = 50,
    Max = 500,
    Default = 50,
    Callback = function(v)
        Actions.SetJump(v)
    end
})

-- Уведомление о загрузке
Core.Notify(WindUI, "Meowl Hub", "Система успешно запущена!")
