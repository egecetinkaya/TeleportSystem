local TweenService = game:GetService("TweenService")

local teleport = script.Parent
local teleportIcon = teleport:WaitForChild("TeleportIcon")
local teleportMenu = teleport:WaitForChild("TeleportMenu")
local button = teleportIcon:WaitForChild("TeleportButton")
local CloseButton = teleportMenu:WaitForChild("CloseButton"):WaitForChild("ShopToggle")

local MenuSize = teleportMenu.Size

teleportMenu.Size = UDim2.new(0,0,0,0)
teleportMenu.AnchorPoint = Vector2.new(0.5,0.5)
teleportMenu.Visible = false

local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

local function OpenMenu()
	if teleportMenu.Visible == false then
		teleportMenu.Visible = true
		TweenService:Create(teleportMenu , tweenInfo, { Size = MenuSize }):Play()
	end
end

local function CloseMenu()
	if teleportMenu.Visible == true then
		local tween = TweenService:Create(teleportMenu , tweenInfo, { Size = UDim2.new(0,0,0,0) })
		tween:Play()
		
		tween.Completed:Connect(function()
			teleportMenu.Visible = false
		end)
	end
end
button.MouseButton1Click:Connect(function()
	if teleportMenu.Visible == false then
		OpenMenu()
	else
		CloseMenu()
	end
end)

CloseButton.MouseButton1Click:Connect(function()
	CloseMenu()
end)
