local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MapTemplate = ReplicatedStorage:WaitForChild("MapTemplate")
local RemoteService = ReplicatedStorage:WaitForChild("RemoteEvents")

local Zones = workspace:WaitForChild("Zones")
local TeleportPoints = workspace:WaitForChild("TeleportPoints")

game.Players.PlayerAdded:Connect(function(player)
	local playerGui = player:WaitForChild("PlayerGui")
	local ScrollingFrame = playerGui:WaitForChild("Teleport"):WaitForChild("TeleportMenu"):WaitForChild("ScrollingFrame")
	
	local OpenedZones = Instance.new("Folder")
	OpenedZones.Name = "OpenedZones"
	OpenedZones.Parent = player
	
	for _, zone in pairs(Zones:GetChildren()) do
		local ZonesBool = Instance.new("BoolValue")
		ZonesBool.Name = zone.Name
		if zone.Name == "Zone1" then
			ZonesBool.Value = true
		else
			ZonesBool.Value = false
		end
		ZonesBool.Parent = OpenedZones
		
		local clone = MapTemplate:Clone()
		clone.Name = zone.Name
		if ZonesBool.Value == true then
			local realName = zone:GetAttribute("ZoneName") or zone.Name
			clone.TextButton.Text = realName
		else
			clone.TextButton.Text = "???"
			clone.TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			clone.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			clone.UIStroke.Color = Color3.fromRGB(255, 255, 255)
		end
		clone.Visible = true
		clone.Parent = ScrollingFrame
	end
end)

for _, zone in pairs(Zones:GetChildren()) do
	if zone.Name == "Zone1" then

	else 
		local Price = zone:GetAttribute("Price") or "0"
		local realName = zone:GetAttribute("ZoneName") or zone.Name		
		local ProximityPrompt = Instance.new("ProximityPrompt")
		ProximityPrompt.ObjectText = zone:GetAttribute("ZoneName") or zone.Name
		ProximityPrompt.ActionText = "[E] Buy (" .. Price  .. "$)" 
		ProximityPrompt.Parent = zone
		ProximityPrompt.Triggered:Connect(function(player)
			local MoneyName = zone:GetAttribute("MoneyName") or "Gold"
			local PlayerMoney = player.leaderstats:WaitForChild(MoneyName)
			if PlayerMoney.Value >= Price then
				PlayerMoney.Value -= Price
				local ZonesBool = player.OpenedZones:WaitForChild(zone.Name)
				ZonesBool.Value = true
				RemoteService.UnlockZone:FireClient(player, zone.Name, realName)
				zone:Destroy()
			end
		end)
	end
end

