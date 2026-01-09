local MeowlCore = {}

MeowlCore.Data = {
    Creator = "Meowl_2026",
    Info = "Meowl_2705",
    Version = "1.0"
}

-- Функция уведомления через саму WindUI (мы передадим её позже)
function MeowlCore.Notify(library, title, content)
    library:Notify({
        Title = title,
        Content = content,
        Duration = 5
    })
end

return MeowlCore
