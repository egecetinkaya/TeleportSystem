local tweenservice = game:GetService("TweenService")
local TpIcon = script.Parent
local Iconsize = TpIcon.Size
local TweenInfo1 = TweenInfo.new(
	0.15,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.Out
)
local TweenInfo2 = TweenInfo.new(
	0.15,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.In
)

local goal1 = { Size = Iconsize + UDim2.new(0.03,0,0.008,0)
}
local goal2 = { Size = Iconsize
}

TpIcon.MouseEnter:Connect(function()
	tweenservice:Create(TpIcon, TweenInfo1, goal1):Play()
end)

TpIcon.MouseLeave:Connect(function()
	tweenservice:Create(TpIcon, TweenInfo2, goal2):Play()
end)