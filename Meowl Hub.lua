-- Meowl Scripter | 99 Nights
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/User/Repo/main/WindUI.lua"))()

local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")
local camera = workspace.CurrentCamera

local flags = {
    autoCampfire = false,
    campRadius = 50,
    autoChop = false,
    chopRadius = 50,
    chopDelay = 1,
    walkSpeed = 16,
    jumpPower = 50,
    flyEnabled = false,
    flySpeed = 20,
    noclip = false,
    exploreSpeed = 1,
    playerESP = false
}

local hub = WindUI:Create("Window", {Title = "Meowl Scripter | 99 Nights", Draggable = true})

local mainTab = hub:CreateTab("Main")
local farmTab = hub:CreateTab("Farm")
local moveTab = hub:CreateTab("Move")
local espTab = hub:CreateTab("ESP")

-- Main Tab
mainTab:CreateToggle("Auto Campfire Feed", function(state)
    flags.autoCampfire = state
end):SetValue(false)

mainTab:CreateSlider("Camp Radius", 10, 100, function(value)
    flags.campRadius = value
end):SetValue(50)

-- Farm Tab
farmTab:CreateToggle("Auto Chop", function(state)
    flags.autoChop = state
end):SetValue(false)

farmTab:CreateSlider("Chop Radius", 10, 100, function(value)
    flags.chopRadius = value
end):SetValue(50)

farmTab:CreateSlider("Chop Delay", 0.1, 3, function(value)
    flags.chopDelay = value
end):SetValue(1)

-- Move Tab
moveTab:CreateSlider("WalkSpeed", 16, 50, function(value)
    flags.walkSpeed = value
end):SetValue(16)

moveTab:CreateSlider("JumpPower", 50, 100, function(value)
    flags.jumpPower = value
end):SetValue(50)

moveTab:CreateToggle("Fly", function(state)
    flags.flyEnabled = state
end):SetValue(false)

moveTab:CreateSlider("Fly Speed", 10, 50, function(value)
    flags.flySpeed = value
end):SetValue(20)

moveTab:CreateToggle("Noclip", function(state)
    flags.noclip = state
end):SetValue(false)

moveTab:CreateSlider("Explore Speed", 1, 10, function(value)
    flags.exploreSpeed = value
end):SetValue(1)

-- ESP Tab
espTab:CreateToggle("Player ESP", function(state)
    flags.playerESP = state
end):SetValue(false)

local function getClosestPlayer()
    local closestPlayer = nil
    local minDist = math.huge
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (plr.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
            if dist < minDist then
                minDist = dist
                closestPlayer = plr
            end
        end
    end
    return closestPlayer, minDist
end

local espBoxes = {}

runService.RenderStepped:Connect(function()
    if flags.playerESP then
        local plr, dist = getClosestPlayer()
        for p, box in pairs(espBoxes) do
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                box.Visible = true
                local hrpPos, onScreen = camera:WorldToScreenPoint(p.Character.HumanoidRootPart.Position)
                box.Position = UDim2.new(0, hrpPos.X - 50, 0, hrpPos.Y - 10)
                box.Size = UDim2.new(0, 100, 0, 20)
                box.Text = p.Name .. " | " .. math.floor(dist) .. "m"
            else
                box.Visible = false
            end
        end
    else
        for _, box in pairs(espBoxes) do
            if box then box.Visible = false end
        end
    end
end)

-- Setup ESP labels
game:GetService("RunService").Heartbeat:Connect(function()
    if flags.playerESP then
        local plr, _ = getClosestPlayer()
        if plr and not espBoxes[plr] then
            local label = Instance.new("TextLabel")
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(0, 200, 0, 20)
            label.Parent = game.CoreGui
            espBoxes[plr] = label
        end
    end
end)

-- Movement controls
local moving = {
    fly = false,
    noclip = false,
    exploreSpeed = 1
}

local function setupMove()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    runService.RenderStepped:Connect(function()
        if not player.Character then return end
        if player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character.Humanoid.WalkSpeed = flags.walkSpeed
            player.Character.Humanoid.JumpPower = flags.jumpPower
        end

        local moveDir = Vector3.new()
        if game:GetService("UserInputService):IsKeyDown(Enum.KeyCode.W) then
            moveDir += camera.CFrame.LookVector
        end
        if game:GetService("UserInputService):IsKeyDown(Enum.KeyCode.S) then
            moveDir -= camera.CFrame.LookVector
        end
        if game:GetService("UserInputService):IsKeyDown(Enum.KeyCode.A) then
            moveDir -= camera.CFrame.RightVector
        end
        if game:GetService("UserInputService):IsKeyDown(Enum.KeyCode.D) then
            moveDir += camera.CFrame.RightVector
        end
        moveDir = moveDir.Unit * flags.exploreSpeed

        if flags.flyEnabled then
            if not moving.fly then
                -- start flying
                hrp.Anchored = false
                moving.fly = true
            end
            hrp.Velocity = moveDir * flags.flySpeed
        else
            if moving.fly then
                hrp.Anchored = false
                moving.fly = false
            end
            hrp.Velocity = moveDir * flags.walkSpeed
        end

        if flags.noclip then
            hrp.CanCollide = false
        else
            hrp.CanCollide = true
        end
    end)
end

setupMove()

-- Auto Campfire Feeding
coroutine.wrap(function()
    while true do
        wait(1)
        if flags.autoCampfire then
            for _, obj in pairs(workspace:GetChildren()) do
                if obj.Name == "Campfire" and obj:FindFirstChild("Humanoid") then
                    if (obj.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude <= flags.campRadius then
                        local fires = workspace:GetChildren()
                        for _, fire in pairs(fires) do
                            if fire.Name == "Campfire" then
                                local firePart = fire:FindFirstChild("Fire")
                                if firePart and not firePart.Parent:FindFirstChild("Fire") then
                                    firePart.Parent.Fire:Emit(1)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)()

-- Auto Chop
coroutine.wrap(function()
    while true do
        wait(flags.chopDelay)
        if flags.autoChop then
            for _, obj in pairs(workspace:GetChildren()) do
                if obj.Name == "Tree" and obj:FindFirstChild("HumanoidRootPart") then
                    local dist = (obj.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
                    if dist <= flags.chopRadius then
                        local hammer = player.Character:FindFirstChild("Tool") -- assume tool is equipped
                        if hammer then
                            -- simulate chopping
                            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                            if humanoid then
                                humanoid:EquipTool(hammer)
                                -- simulate hit
                                local hitEvent = hammer:FindFirstChild("RemoteEvent")
                                if hitEvent then
                                    hitEvent:FireServer(obj)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)()					
