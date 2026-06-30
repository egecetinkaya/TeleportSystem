local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteService = ReplicatedStorage:WaitForChild("RemoteEvents")

local player = game.Players.LocalPlayer

local OpenedZones = player:WaitForChild("OpenedZones")
local Zones = workspace:WaitForChild("Zones")

local playerGui = player:WaitForChild("PlayerGui")
local ScrollingFrame = playerGui:WaitForChild("Teleport"):WaitForChild("TeleportMenu"):WaitForChild("ScrollingFrame")

OpenedZones:WaitForChild("Zone1")

for _, zone in pairs(Zones:GetChildren()) do
	for _, OpenZones in pairs(OpenedZones:GetChildren()) do
		if zone.Name == OpenZones.Name then
			if OpenZones.Value == true then
				zone:Destroy()
			end
		end
	end
end

RemoteService.UnlockZone.OnClientEvent:Connect(function(zoneName, realName)

	local Button = ScrollingFrame:WaitForChild(zoneName)

	Button.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
	Button.UIStroke.Color = Color3.fromRGB(56, 56, 56)
	Button.TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	Button.TextButton.Text = realName
	
	local DestroyZone = Zones:WaitForChild(zoneName)
	DestroyZone:Destroy()
end)

for _, button in pairs(ScrollingFrame:GetChildren()) do
	if button:IsA("Frame") then
		button.TextButton.MouseButton1Click:Connect(function()
			RemoteService.TeleportRequest:FireServer(button.Name)
		end)
	end
end
