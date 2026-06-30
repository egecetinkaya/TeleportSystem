local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MapTemplate = ReplicatedStorage:WaitForChild("MapTemplate")
local RemoteService = ReplicatedStorage:WaitForChild("RemoteEvents")
local DataStoreService = game:GetService("DataStoreService")

local myDataStore = DataStoreService:GetDataStore("TeleportData")

local Zones = workspace:WaitForChild("Zones")
local TeleportPoints = workspace:WaitForChild("TeleportPoints")

game.Players.PlayerAdded:Connect(function(player)
	local playerGui = player:WaitForChild("PlayerGui")
	local ScrollingFrame = playerGui:WaitForChild("Teleport"):WaitForChild("TeleportMenu"):WaitForChild("ScrollingFrame")
	
	local OpenedZones = Instance.new("Folder")
	OpenedZones.Name = "OpenedZones"
	OpenedZones.Parent = player
	
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player
	
	local Gold = Instance.new("IntValue")
	Gold.Name = "Gold"
	Gold.Value = 100000
	Gold.Parent = leaderstats
	
	local Data
	local success, err = pcall(function()
		Data = myDataStore:GetAsync(player.UserId)
	end)
	
	if success and Data then
		Gold.Value = Data.Gold
	else
		Gold.Value = 100000
	end
	
	for _, zone in pairs(Zones:GetChildren()) do
		local ZonesBool = Instance.new("BoolValue")
		ZonesBool.Name = zone.Name
		
		if Data and Data.OpenedZones and Data.OpenedZones[zone.Name] then
			ZonesBool.Value = Data.OpenedZones[zone.Name]
		elseif zone.Name == "Zone1"then
			ZonesBool.Value = true
		else
			ZonesBool.Value = false
		end
			
		ZonesBool.Parent = OpenedZones
		
		local clone = MapTemplate:Clone()
		clone.Name = zone.Name
		
		local zoneNumber = tonumber(string.match(zone.Name, "%d+"))
		
		if zoneNumber  then
			clone.LayoutOrder = zoneNumber
		end
		
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
		local Price = tonumber(zone:GetAttribute("Price")) or 0
		local realName = zone:GetAttribute("ZoneName") or zone.Name		
		local ProximityPrompt = Instance.new("ProximityPrompt")
		ProximityPrompt.ObjectText = zone:GetAttribute("ZoneName") or zone.Name
		ProximityPrompt.ActionText = "[E] Buy (" .. Price  .. "$)" 
		ProximityPrompt.Parent = zone
		ProximityPrompt.HoldDuration = 1.25
		ProximityPrompt.Triggered:Connect(function(player)
			local MoneyName = zone:GetAttribute("MoneyName") or "Gold"
			local PlayerMoney = player.leaderstats:WaitForChild(MoneyName)
			if PlayerMoney.Value >= Price then
				PlayerMoney.Value -= Price
				local ZonesBool = player.OpenedZones:WaitForChild(zone.Name)
				ZonesBool.Value = true
				RemoteService.UnlockZone:FireClient(player, zone.Name, realName)
			end
		end)
	end
end

RemoteService.TeleportRequest.OnServerEvent:Connect(function(player, buttonName)
	local ZonesBool = player.OpenedZones:WaitForChild(buttonName)
	if ZonesBool.Value == true then
		local TeleportPoint = TeleportPoints:WaitForChild(buttonName)
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			player.Character.HumanoidRootPart.CFrame = TeleportPoint.CFrame + Vector3.new(0, 5, 0)
		end
	else
		print("You can't teleport to this zone")
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	local dataToSave = {
		Gold = player.leaderstats.Gold.Value,
		OpenedZones = {}
	}
	for _, zoneBool in pairs(player.OpenedZones:GetChildren()) do
		dataToSave.OpenedZones[zoneBool.Name] = zoneBool.Value
	end
	
	local success, err = pcall(function()
		myDataStore:SetAsync(player.UserId, dataToSave)
	end)
	
	if success  then
		print("Data saved successfully for player: " .. player.Name)
	else
		warn("Failed to save data for player: " .. player.Name .. " Error: " .. err)
	end
end)

game:BindToClose(function()
	task.wait(3)
	print("The server is closing")
end)