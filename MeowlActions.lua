local Actions = {}

function Actions.SetSpeed(value)
    local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = value end
end

function Actions.SetJump(value)
    local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = value end
end

return Actions

