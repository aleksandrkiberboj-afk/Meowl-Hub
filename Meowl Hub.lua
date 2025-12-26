-- Meowl Scripter | 99 Nights
-- WindUI Client Hub

if game.PlaceId ~= 0 then end
if getgenv().MeowlLoaded then return end
getgenv().MeowlLoaded = true

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/source.lua"))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer

local Flags = {
	AutoChop=false, ChopRadius=20, ChopDelay=0.2,
	AutoFeed=false, CampRadius=20,
	Fly=false, FlySpeed=2,
	Noclip=false,
	WalkSpeed=16, JumpPower=50,
	ExploreSpeed=1,
	PlayerESP=false
}

local Window = WindUI:CreateWindow({
	Title="Meowl Scripter | 99 Nights",
	Subtitle="Client",
	Draggable=true
})

local Main = Window:CreateTab("Main")
local Farm = Window:CreateTab("Farm")
local Move = Window:CreateTab("Move")
local ESP = Window:CreateTab("ESP")

Main:CreateToggle("Auto Campfire Feed", false, function(v) Flags.AutoFeed=v end)
Main:CreateSlider("Camp Radius", 5, 50, 20, function(v) Flags.CampRadius=v end)

Farm:CreateToggle("Auto Chop", false, function(v) Flags.AutoChop=v end)
Farm:CreateSlider("Chop Radius", 5, 60, 20, function(v) Flags.ChopRadius=v end)
Farm:CreateSlider("Chop Delay", 0, 1, 0.2, function(v) Flags.ChopDelay=v end)

Move:CreateToggle("Fly", false, function(v) Flags.Fly=v end)
Move:CreateSlider("Fly Speed", 1, 10, 2, function(v) Flags.FlySpeed=v end)
Move:CreateToggle("Noclip", false, function(v) Flags.Noclip=v end)
Move:CreateSlider("WalkSpeed", 10, 60, 16, function(v)
	Flags.WalkSpeed=v
	if LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
		LP.Character:FindFirstChildOfClass("Humanoid").WalkSpeed=v
	end
end)
Move:CreateSlider("JumpPower", 20, 120, 50, function(v)
	Flags.JumpPower=v
	if LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
		LP.Character:FindFirstChildOfClass("Humanoid").JumpPower=v
	end
end)
Move:CreateSlider("Explore Speed x", 1, 10, 1, function(v) Flags.ExploreSpeed=v end)

ESP:CreateToggle("Player ESP", false, function(v) Flags.PlayerESP=v end)

local BodyGyro, BodyVel
RunService.RenderStepped:Connect(function()
	local char = LP.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	local hrp = char and char:FindFirstChild("HumanoidRootPart")

	if hum then
		hum.WalkSpeed = Flags.WalkSpeed * Flags.ExploreSpeed
		hum.JumpPower = Flags.JumpPower
	end

	if Flags.Noclip and char then
		for _,p in ipairs(char:GetDescendants()) do
			if p:IsA("BasePart") then p.CanCollide=false end
		end
	end

	if Flags.Fly and hrp then
		if not BodyGyro then
			BodyGyro = Instance.new("BodyGyro", hrp)
			BodyVel = Instance.new("BodyVelocity", hrp)
			BodyGyro.P = 9e4
			BodyGyro.MaxTorque = Vector3.new(9e9,9e9,9e9)
			BodyVel.MaxForce = Vector3.new(9e9,9e9,9e9)
		end
		local cam = workspace.CurrentCamera
		BodyGyro.CFrame = cam.CFrame
		BodyVel.Velocity = cam.CFrame.LookVector * (Flags.FlySpeed*50)
	else
		if BodyGyro then BodyGyro:Destroy(); BodyGyro=nil end
		if BodyVel then BodyVel:Destroy(); BodyVel=nil end
	end
end)

-- Client visuals only (ESP example)
local ESPFolder = Instance.new("Folder", workspace); ESPFolder.Name="MeowlESP"
RunService.RenderStepped:Connect(function()
	for _,plr in ipairs(Players:GetPlayers()) do
		if plr~=LP then
			local ch = plr.Character
			local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
			local tag = ESPFolder:FindFirstChild(plr.Name)
			if Flags.PlayerESP and hrp then
				if not tag then
					local b = Instance.new("BillboardGui", ESPFolder)
					b.Name=plr.Name
					b.Size=UDim2.fromScale(4,1)
					b.AlwaysOnTop=true
					b.Adornee=hrp
					local t = Instance.new("TextLabel", b)
					t.Size=UDim2.fromScale(1,1)
					t.BackgroundTransparency=1
					t.Text=plr.Name
					t.TextScaled=true
					t.TextColor3=Color3.new(1,0,0)
				end
			elseif tag then
				tag:Destroy()
			end
		end
	end
end)
