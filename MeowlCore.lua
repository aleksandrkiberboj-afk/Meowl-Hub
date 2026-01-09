local MeowlCore = {}
MeowlCore.Data = {
    Creator = "Meowl_2026",
    Info = "Meowl_2705"
}
function MeowlCore.Notify(lib, title, text)
    lib:Notify({
        Title = title,
        Content = text,
        Duration = 5
    })
end
return MeowlCore
