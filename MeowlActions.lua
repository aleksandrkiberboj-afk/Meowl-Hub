local Actions = {}
function Actions.SetStat(stat, value)
    local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum[stat] = value
    end
end
return Actions
