local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteService = ReplicatedStorage:WaitForChild("RemoteEvents")

local player = game.Players.LocalPlayer

RemoteService.UnlockZone.OnClientEvent:Connect(function(zoneName, realName)
	local playerGui = player:WaitForChild("PlayerGui")
	local ScrollingFrame = playerGui:WaitForChild("Teleport"):WaitForChild("TeleportMenu"):WaitForChild("ScrollingFrame")
	
	local Button = ScrollingFrame:WaitForChild(zoneName)
	Button.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
	Button.UIStroke.Color = Color3.fromRGB(56, 56, 56)
	Button.TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	Button.TextButton.Text = realName
end)