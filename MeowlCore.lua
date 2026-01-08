--[[
    BOOTLOADER: Meowl System
    Связывает Core и Actions
]]

-- В будущем здесь будет загрузка через game:HttpGet
-- А пока создаем главную таблицу
local MeowlHub = {}

-- Подключаем наши части (имитация загрузки)
local Core = loadstring(game:HttpGet("ССЫЛКА_НА_CORE"))() 
local Actions = loadstring(game:HttpGet("ССЫЛКА_НА_ACTIONS"))()

-- Собираем всё в один объект
MeowlHub.Core = Core
MeowlHub.Actions = Actions

-- Приветствие при запуске
MeowlHub.Core.Notify("Meowl System", "Библиотека успешно собрана!")
MeowlHub.Core.Log("Система готова. Создатель: Meowl_2026")

return MeowlHub
