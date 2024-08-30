--[[
	Library by Mystery_Mux (novakool on discord).
	
	Version: 0.6
]]

local MainModule = script

local WindowClass = {}

local TabClass = {}

local DropdownClass = {}

WindowClass.__index = WindowClass

TabClass.__index = TabClass

DropdownClass.__index = DropdownClass


-- Services

local PlayerService = game:GetService("Players")

local RunService = game:GetService("RunService")

local TweenService = game:GetService("TweenService")

local InputService = game:GetService("UserInputService")


-- Locals

local User = PlayerService.LocalPlayer


-- Settings

local DefaultCustom = {
	Theme = Color3.fromRGB(50, 50, 50);
	Font = "rbxasset://fonts/families/Montserrat.json";
	DragSmoothness = 50;
	DefaultTabIconID = 18132434045;
}

local AnimateInfos = {
	MenuFrameToggle = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
	MenuButtonLineClick = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.InOut);
	MenuScrollLineSpeed = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
	ActionSelect = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
	PageCoverFrame = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
	PageBlackFrame = TweenInfo.new(0.25, Enum.EasingStyle.Linear);
	Notifcation = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
	SliderChange = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
	DropdownContainer = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
}


-- Modules

local UtilityModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/novakoolhub/Scripts/main/Modules/UtilityModule.lua"))()


-- Window Class

function WindowClass:NewWindow(Name:string, Version:string, Scale, Custom)
	local NewWindow = setmetatable({}, WindowClass)
	NewWindow.Name = Name
	NewWindow.UI = Instance.new("ScreenGui")
	NewWindow.MainFrame = Instance.new("Frame")
	NewWindow.NotificationContainer = Instance.new("Frame")
	NewWindow.PageContainer = Instance.new("Frame")
	NewWindow.TopBar = Instance.new("Frame")
	NewWindow.MenuFrame = Instance.new("Frame")

	-- UI --

	NewWindow.Config = Custom or {}
	NewWindow.Config.Theme = NewWindow.Config.Theme or DefaultCustom.Theme
	NewWindow.Config.Font = NewWindow.Config.Font or DefaultCustom.Font
	NewWindow.Config.DragSmoothness = NewWindow.Config.DragSmoothness or DefaultCustom.DragSmoothness
	NewWindow.Config.DefaultTabIconID = NewWindow.Config.DefaultTabIconID or DefaultCustom.DefaultTabIconID

	NewWindow.UI.Parent = User.PlayerGui
	NewWindow.UI.Name = Name.." Window"
	NewWindow.UI.IgnoreGuiInset = true
	NewWindow.UI.ResetOnSpawn = false
	NewWindow.UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	NewWindow.UI.DisplayOrder = 10

	-- Main Frame --

	NewWindow.MainFrame.Parent = NewWindow.UI
	NewWindow.MainFrame.Name = "MainFrame"
	NewWindow.MainFrame.Size = UDim2.fromOffset(350, 200)
	NewWindow.MainFrame.ZIndex = 2
	NewWindow.MainFrame.ClipsDescendants = true
	NewWindow.MainFrame.BackgroundColor3 = UtilityModule.Color:Add(NewWindow.Config.Theme, Color3.fromRGB(-25, -25, -25))
	NewWindow.MainFrame.BorderSizePixel = 0

	UtilityModule.Align:CenterAnchor(NewWindow.MainFrame)
	UtilityModule.UIObject:Scale(NewWindow.MainFrame, Scale or 1)
	UtilityModule.UIObject:Corner(NewWindow.MainFrame, UDim.new(0, 6))

	-- Notification Container --

	NewWindow.NotificationContainer.Parent = NewWindow.UI
	NewWindow.NotificationContainer.Name = "NotificationContainer"
	NewWindow.NotificationContainer.Position = UDim2.fromScale(0.8, 0.5)
	NewWindow.NotificationContainer.Size = UDim2.fromScale(0.175, 0.9)
	NewWindow.NotificationContainer.AnchorPoint = Vector2.new(0, 0.5)
	NewWindow.NotificationContainer.BackgroundTransparency = 1
	NewWindow.NotificationContainer.BorderSizePixel = 0
	NewWindow.NotificationContainer:SetAttribute("Moveable", true)

	-- Page Container --

	local BlackFrame = Instance.new("Frame")
	local CoverFrame = Instance.new("Frame")

	NewWindow.PageContainer.Parent = NewWindow.MainFrame
	NewWindow.PageContainer.Name = "PageContainer"
	NewWindow.PageContainer.Position = UDim2.fromScale(0, 0.125)
	NewWindow.PageContainer.Size = UDim2.fromScale(1, 0.875)
	NewWindow.PageContainer.ClipsDescendants = true
	NewWindow.PageContainer.BackgroundTransparency = 1

	BlackFrame.Parent = NewWindow.PageContainer
	BlackFrame.Name = "BlackFrame"
	BlackFrame.Size = UDim2.fromScale(1, 1)
	BlackFrame.ZIndex = 5
	BlackFrame.BackgroundColor3 = Color3.new(0, 0, 0)
	BlackFrame.BackgroundTransparency = 1

	CoverFrame.Parent = NewWindow.PageContainer
	CoverFrame.Name = "CoverFrame"
	CoverFrame.Position = UDim2.fromScale(-1, 0)
	CoverFrame.Size = UDim2.fromScale(1, 1)
	CoverFrame.ZIndex = 2
	CoverFrame.BackgroundColor3 = UtilityModule.Color:Add(NewWindow.Config.Theme, Color3.fromRGB(-45, -45, -45))

	UtilityModule.UIObject:Corner(BlackFrame, UDim.new(0, 6))
	UtilityModule.UIObject:Corner(CoverFrame, UDim.new(0, 6), "TR/TL/BR")

	-- Top Bar --

	local MenuOpen = false

	local DragFrame = Instance.new("Frame")
	local TitleText = Instance.new("TextLabel")
	local VersionText = Instance.new("TextLabel")
	local MenuButton = Instance.new("TextButton")

	NewWindow.TopBar.Parent = NewWindow.MainFrame
	NewWindow.TopBar.Name = "TopBar"
	NewWindow.TopBar.Size = UDim2.fromScale(1, 0.125)
	NewWindow.TopBar.BackgroundColor3 = NewWindow.Config.Theme
	NewWindow.TopBar.BorderSizePixel = 0

	TitleText.Parent = NewWindow.TopBar
	TitleText.Name = "TitleText"
	TitleText.Position = UDim2.fromScale(0.025, 0.5)
	TitleText.Size = UDim2.fromScale(0.25, 0.75)
	TitleText.AnchorPoint = Vector2.new(0, 0.5)
	TitleText.BorderSizePixel = 0
	TitleText.BackgroundTransparency = 1
	TitleText.Text = Name
	TitleText.TextScaled = true
	TitleText.TextColor3 = Color3.new(1, 1, 1)
	TitleText.FontFace = Font.new(NewWindow.Config.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	TitleText.TextXAlignment = Enum.TextXAlignment.Left

	VersionText.Parent = NewWindow.TopBar
	VersionText.Name = "VersionText"
	VersionText.Position = UDim2.fromScale(0.82, 0.5)
	VersionText.Size = UDim2.fromScale(0.1, 0.5)
	VersionText.AnchorPoint = Vector2.new(0, 0.5)
	VersionText.BackgroundTransparency = 1
	VersionText.BorderSizePixel = 0
	VersionText.Text = "V"..(Version or "")
	VersionText.TextColor3 = Color3.new(1, 1, 1)
	VersionText.TextXAlignment = Enum.TextXAlignment.Right

	if Version == nil then
		VersionText.Visible = false
	end

	MenuButton.Parent = NewWindow.TopBar
	MenuButton.Name = "MenuButton"
	MenuButton.Size = UDim2.fromScale(0.075, 1)
	MenuButton.BorderSizePixel = 0
	MenuButton.BackgroundTransparency = 1
	MenuButton.Text = ""

	local TopLine = Instance.new("Frame")
	local CenterLine = Instance.new("Frame")
	local BottomLine = Instance.new("Frame")

	TopLine.Parent = MenuButton
	TopLine.Name = "Line"
	TopLine.Position = UDim2.fromScale(0.5, 0.3)
	TopLine.AnchorPoint = Vector2.new(0.5, 0)
	TopLine.Size = UDim2.new(0.5, 0, 0, 1)
	TopLine.BackgroundColor3 = Color3.new(1, 1, 1)
	TopLine.BorderSizePixel = 0
	CenterLine.Parent = MenuButton
	CenterLine.Name = "Line"
	CenterLine.AnchorPoint = Vector2.new(0.5, 0.5)
	CenterLine.Position = UDim2.fromScale(0.5, 0.5)
	CenterLine.Size = UDim2.new(0.5, 0, 0, 1)
	CenterLine.BackgroundColor3 = Color3.new(1, 1, 1)
	CenterLine.BorderSizePixel = 0
	BottomLine.Parent = MenuButton
	BottomLine.Name = "Line"
	BottomLine.Position = UDim2.fromScale(0.5, 0.65)
	BottomLine.AnchorPoint = Vector2.new(0.5, 0)
	BottomLine.Size = UDim2.new(0.5, 0, 0, 1)
	BottomLine.BackgroundColor3 = Color3.new(1, 1, 1)
	BottomLine.BorderSizePixel = 0

	DragFrame.Parent = NewWindow.TopBar
	DragFrame.Name = "DragFrame"
	DragFrame.Size = UDim2.fromScale(0.925, 1)
	DragFrame.BackgroundTransparency = 1

	MenuButton.Activated:Connect(function()
		if MenuOpen == false then
			MenuOpen = true

			TweenService:Create(NewWindow.MenuFrame, AnimateInfos.ActionSelect, {
				Position = UDim2.fromScale(0.75, 0.125)
			}):Play()

			TweenService:Create(BlackFrame, AnimateInfos.PageBlackFrame, {
				BackgroundTransparency = 0.5;
			}):Play()
		else
			MenuOpen = false

			TweenService:Create(NewWindow.MenuFrame, AnimateInfos.ActionSelect, {
				Position = UDim2.fromScale(1, 0.125)
			}):Play()

			TweenService:Create(BlackFrame, AnimateInfos.PageBlackFrame, {
				BackgroundTransparency = 1;
			}):Play()
		end

		task.spawn(function()
			-- Close --

			TweenService:Create(TopLine, AnimateInfos.ActionSelect, {
				Size = UDim2.new(0.3, 0, 0, 1);
			}):Play()

			task.wait(0.1)

			TweenService:Create(CenterLine, AnimateInfos.ActionSelect, {
				Size = UDim2.new(0.3, 0, 0, 1);
			}):Play()

			task.wait(0.1)

			TweenService:Create(BottomLine, AnimateInfos.ActionSelect, {
				Size = UDim2.new(0.3, 0, 0, 1);
			}):Play()

			-- Open --

			task.wait(0.1)

			TweenService:Create(TopLine, AnimateInfos.ActionSelect, {
				Size = UDim2.new(0.5, 0, 0, 1);
			}):Play()

			task.wait(0.1)

			TweenService:Create(CenterLine, AnimateInfos.ActionSelect, {
				Size = UDim2.new(0.5, 0, 0, 1);
			}):Play()

			task.wait(0.1)

			TweenService:Create(BottomLine, AnimateInfos.ActionSelect, {
				Size = UDim2.new(0.5, 0, 0, 1);
			}):Play()
		end)
	end)

	UtilityModule.Align:Draggable(NewWindow.MainFrame, DragFrame, NewWindow.Config.DragSmoothness)
	UtilityModule.Align:TopRight(MenuButton)
	UtilityModule.UIObject:Corner(NewWindow.TopBar, UDim.new(0, 6), "BR/BL")

	-- Menu Frame --

	local TabContainer = Instance.new("ScrollingFrame")
	local ScrollLine = Instance.new("Frame")

	NewWindow.MenuFrame.Parent = NewWindow.MainFrame
	NewWindow.MenuFrame.Name = "MenuFrame"
	NewWindow.MenuFrame.Position = UDim2.fromScale(1, 0.125)
	NewWindow.MenuFrame.Size = UDim2.fromScale(0.25, 0.875)
	NewWindow.MenuFrame.BackgroundColor3 = NewWindow.Config.Theme
	NewWindow.MenuFrame.BorderSizePixel = 0

	TabContainer.Parent = NewWindow.MenuFrame
	TabContainer.Name = "TabContainer"
	TabContainer.Position = UDim2.fromScale(0.5, 0.5)
	TabContainer.Size = UDim2.fromScale(0.85, 0.9)
	TabContainer.AnchorPoint = Vector2.one / 2
	TabContainer.BackgroundTransparency = 1
	TabContainer.BorderSizePixel = 0
	TabContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
	TabContainer.ScrollBarThickness = 4
	TabContainer.ScrollBarImageTransparency = 0.75

	ScrollLine.Parent = NewWindow.MenuFrame
	ScrollLine.Name = "Line"
	ScrollLine.Position = UDim2.fromScale(0.825, 0.5)
	ScrollLine.Size = UDim2.new(0, 1, 0.65, 0)
	ScrollLine.AnchorPoint = Vector2.new(0, 0.5)
	ScrollLine.ZIndex = 2
	ScrollLine.BackgroundColor3 = Color3.new(1, 1, 1)
	ScrollLine.BackgroundTransparency = 0.95
	ScrollLine.BorderSizePixel = 0

	local OldScrollLevel = TabContainer.CanvasPosition.Y

	RunService.Heartbeat:Connect(function()
		local ScrollLevel = TabContainer.CanvasPosition.Y
		local LevelDelta = math.abs(ScrollLevel - OldScrollLevel)

		ScrollLine.Size = UDim2.new(0, 1, 0.65 + (LevelDelta / 250), 0)

		OldScrollLevel = ScrollLevel
	end)

	UtilityModule.UIObject:List(TabContainer, UDim.new(0, 5), Enum.FillDirection.Vertical, "TL")
	UtilityModule.UIObject:Corner(NewWindow.MenuFrame, UDim.new(0, 6), "TR/TL/BL", 2)

	return NewWindow
end

function WindowClass:NewTab(Name:string, IconID:number)
	local NewTab = setmetatable({}, TabClass)
	NewTab.TabButton = Instance.new("TextButton")
	NewTab.TabPage = Instance.new("Frame")
	NewTab.Config = self.Config

	-- Tab Button --

	local TabText = Instance.new("TextLabel")
	local TabIcon = Instance.new("ImageLabel")

	NewTab.TabButton.Parent = self.MenuFrame.TabContainer
	NewTab.TabButton.Name = Name.." Tab"
	NewTab.TabButton.Size = UDim2.fromScale(0.85, 0.15)
	NewTab.TabButton.ZIndex = 2
	NewTab.TabButton.BackgroundColor3 = Color3.new(1, 1, 1)
	NewTab.TabButton.BackgroundTransparency = 1
	NewTab.TabButton.BorderSizePixel = 0
	NewTab.TabButton.AutoButtonColor = false
	NewTab.TabButton.Text = ""

	TabText.Parent = NewTab.TabButton
	TabText.Name = "TitleText"
	TabText.Position = UDim2.fromScale(0.35, 0)
	TabText.Size = UDim2.fromScale(0.6, 1)
	TabText.BackgroundTransparency = 1
	TabText.BorderSizePixel = 0
	TabText.Text = Name
	TabText.TextScaled = true
	TabText.TextColor3 = Color3.new(1, 1, 1)
	TabText.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal)

	TabIcon.Parent = NewTab.TabButton
	TabIcon.Name = "TabIcon"
	TabIcon.Position = UDim2.fromScale(0.1, 0.5)
	TabIcon.Size = UDim2.fromScale(0.2, 0.55)
	TabIcon.AnchorPoint = Vector2.new(0, 0.5)
	TabIcon.BackgroundTransparency = 1
	TabIcon.BorderSizePixel = 0
	TabIcon.Image = "rbxassetid://"..(IconID or self.Config.DefaultTabIconID)
	TabIcon.ScaleType = Enum.ScaleType.Fit

	NewTab.TabButton.MouseEnter:Connect(function()
		local Selected = NewTab.TabButton:GetAttribute("Selected")

		if Selected == true then
			TweenService:Create(NewTab.TabButton, AnimateInfos.ActionSelect, {
				BackgroundTransparency = 0.8;
			}):Play()
		else
			TweenService:Create(NewTab.TabButton, AnimateInfos.ActionSelect, {
				BackgroundTransparency = 0.9;
			}):Play()
		end
	end)

	NewTab.TabButton.MouseLeave:Connect(function()
		local Selected = NewTab.TabButton:GetAttribute("Selected")

		if Selected == true then
			TweenService:Create(NewTab.TabButton, AnimateInfos.ActionSelect, {
				BackgroundTransparency = 0.85;
			}):Play()
		else
			TweenService:Create(NewTab.TabButton, AnimateInfos.ActionSelect, {
				BackgroundTransparency = 1;
			}):Play()
		end
	end)

	NewTab.TabButton.Activated:Connect(function()
		TweenService:Create(self.PageContainer.CoverFrame, AnimateInfos.PageCoverFrame, {
			Position = UDim2.fromScale(0, 0);
		}):Play()

		task.wait(AnimateInfos.PageCoverFrame.Time)

		for PageI, Page:Frame in pairs(self.PageContainer:GetChildren()) do
			if Page:IsA("Frame") and Page.Name ~= "CoverFrame" and Page.Name ~= "BlackFrame" then
				Page.Visible = false
			end
		end

		NewTab.TabPage.Visible = true

		for TabI, Tab:TextButton in pairs(self.MenuFrame.TabContainer:GetChildren()) do
			if Tab:IsA("TextButton") then
				Tab:SetAttribute("Selected", false)

				TweenService:Create(Tab, AnimateInfos.ActionSelect, {
					BackgroundTransparency = 1;
				}):Play()
			end
		end

		NewTab.TabButton:SetAttribute("Selected", true)

		TweenService:Create(NewTab.TabButton, AnimateInfos.ActionSelect, {
			BackgroundTransparency = 0.8;
		}):Play()

		task.wait(AnimateInfos.PageCoverFrame.Time)

		TweenService:Create(self.PageContainer.CoverFrame, AnimateInfos.PageCoverFrame, {
			Position = UDim2.fromScale(-1, 0);
		}):Play()
	end)

	UtilityModule.UIObject:Corner(NewTab.TabButton, UDim.new(0, 4))

	-- TabPage --

	local ActionContainer = Instance.new("ScrollingFrame")
	local TitleText = Instance.new("TextLabel")
	local ScrollLine = Instance.new("Frame")

	NewTab.TabPage.Parent = self.PageContainer
	NewTab.TabPage.Name = Name.." Page"
	NewTab.TabPage.Size = UDim2.fromScale(1, 1)
	NewTab.TabPage.BackgroundTransparency = 1

	ActionContainer.Parent = NewTab.TabPage
	ActionContainer.Name = "ActionContainer"
	ActionContainer.Position = UDim2.fromScale(0.5, 0.55)
	ActionContainer.Size = UDim2.fromScale(0.95, 0.8)
	ActionContainer.AnchorPoint = Vector2.one / 2
	ActionContainer.BackgroundTransparency = 1
	ActionContainer.ScrollBarThickness = 4
	ActionContainer.ScrollBarImageTransparency = 0.75
	ActionContainer.BorderSizePixel = 0
	ActionContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y

	ScrollLine.Parent = NewTab.TabPage
	ScrollLine.Name = "Line"
	ScrollLine.Position = UDim2.fromScale(0.945, 0.5)
	ScrollLine.Size = UDim2.new(0, 1, 0.65, 0)
	ScrollLine.AnchorPoint = Vector2.new(0, 0.5)
	ScrollLine.BorderSizePixel = 0
	ScrollLine.BackgroundColor3 = Color3.new(1, 1, 1)
	ScrollLine.BackgroundTransparency = 0.95

	local OldScrollLevel = ActionContainer.CanvasPosition.Y

	RunService.Heartbeat:Connect(function()
		local ScrollLevel = ActionContainer.CanvasPosition.Y
		local LevelDelta = math.abs(ScrollLevel - OldScrollLevel)

		ScrollLine.Size = UDim2.new(0, 1, 0.65 + (LevelDelta / 250), 0);

		OldScrollLevel = ScrollLevel
	end)

	if #self.PageContainer:GetChildren() == 3 then
		NewTab.TabButton:SetAttribute("Selected", true)

		TweenService:Create(NewTab.TabButton, AnimateInfos.ActionSelect, {
			BackgroundTransparency = 0.8;
		}):Play()
	else
		NewTab.TabPage.Visible = false
	end

	TitleText.Parent = NewTab.TabPage
	TitleText.Name = "TitleText"
	TitleText.Position = UDim2.fromScale(0.0125, 0.025)
	TitleText.Size = UDim2.fromScale(1, 0.075)
	TitleText.BackgroundTransparency = 1
	TitleText.TextScaled = true
	TitleText.TextColor3 = Color3.new(1, 1, 1)
	TitleText.Text = Name
	TitleText.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal)

	UtilityModule.UIObject:List(ActionContainer, UDim.new(0, 5), Enum.FillDirection.Vertical, "TL")

	return NewTab
end

function WindowClass:Notify(Title:string, Description:string, Time:number, Options:string)
	local NotificationFrame = Instance.new("Frame")
	local TopBar = Instance.new("Frame")
	local TitleText = Instance.new("TextLabel")
	local DescriptionText = Instance.new("TextLabel")
	local ProgressLine = Instance.new("Frame")

	NotificationFrame.Parent = self.NotificationContainer
	NotificationFrame.Name = "Notification"
	NotificationFrame.Position = UDim2.fromScale(1.75, 0.8)
	NotificationFrame.Size = UDim2.fromScale(1, 0.2)
	NotificationFrame.AnchorPoint = Vector2.new(0.5, 0)
	NotificationFrame.BackgroundColor3 = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(-25, -25, -25))

	TopBar.Parent = NotificationFrame
	TopBar.Name = "TopBar"
	TopBar.Size = UDim2.fromScale(1, 0.2)
	TopBar.BackgroundColor3 = self.Config.Theme
	TopBar.BorderSizePixel = 0

	TitleText.Parent = TopBar
	TitleText.Name = "TitleText"
	TitleText.Position = UDim2.fromScale(0.5, 0.5)
	TitleText.Size = UDim2.fromScale(0.9, 0.75)
	TitleText.AnchorPoint = Vector2.new(0.5, 0.5)
	TitleText.BackgroundTransparency = 1
	TitleText.BorderSizePixel = 0
	TitleText.TextScaled = true
	TitleText.TextColor3 = Color3.new(1, 1, 1)
	TitleText.Text = self.Name..": "..Title
	TitleText.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal)

	DescriptionText.Parent = NotificationFrame
	DescriptionText.Name = "DescriptionText"
	DescriptionText.Position = UDim2.fromScale(0.5, 0.3)
	DescriptionText.Size = UDim2.fromScale(0.9, 0.45)
	DescriptionText.AnchorPoint = Vector2.new(0.5, 0)
	DescriptionText.BackgroundTransparency = 1
	DescriptionText.BorderSizePixel = 0
	DescriptionText.TextScaled = true
	DescriptionText.RichText = true
	DescriptionText.TextColor3 = Color3.new(1, 1, 1)
	DescriptionText.Text = Description
	DescriptionText.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	DescriptionText.TextYAlignment = Enum.TextYAlignment.Top

	ProgressLine.Parent = TopBar
	ProgressLine.Name = "Line"
	ProgressLine.Position = UDim2.new(0, 0, 1, -1)
	ProgressLine.Size = UDim2.new(1, 0, 0, 1)
	ProgressLine.BackgroundColor3 = Color3.new(1, 1, 1)
	ProgressLine.BackgroundTransparency = 0.9
	ProgressLine.BorderSizePixel = 0
	ProgressLine.ZIndex = 2

	repeat
		task.wait()
	until self.NotificationContainer:GetAttribute("Moveable") == true

	task.spawn(function()
		NotificationFrame:SetAttribute("Moveable", true)
		self.NotificationContainer:SetAttribute("Moveable", false)

		for NotificationI, Notification in pairs(self.NotificationContainer:GetChildren()) do
			if Notification:IsA("Frame") and Notification ~= NotificationFrame and Notification:GetAttribute("Moveable") == true then
				TweenService:Create(Notification, AnimateInfos.Notifcation, {
					Position = UDim2.fromScale(Notification.Position.X.Scale, Notification.Position.Y.Scale - 0.25);
				}):Play()
			end
		end

		task.wait(AnimateInfos.Notifcation.Time / 2)

		TweenService:Create(NotificationFrame, AnimateInfos.Notifcation, {
			Position = UDim2.fromScale(0.5, 0.8);
		}):Play()

		task.wait(AnimateInfos.Notifcation.Time)

		self.NotificationContainer:SetAttribute("Moveable", true)

		TweenService:Create(ProgressLine, TweenInfo.new(Time or 3, Enum.EasingStyle.Linear), {
			Size = UDim2.new(0, 0, 0, 1);
		}):Play()

		task.wait(Time or 3)

		NotificationFrame:SetAttribute("Moveable", false)

		TweenService:Create(NotificationFrame, AnimateInfos.Notifcation, {
			Position = UDim2.fromScale(1.75, NotificationFrame.Position.Y.Scale);
		}):Play()

		task.wait(AnimateInfos.Notifcation.Time)

		NotificationFrame:Destroy()
	end)

	UtilityModule.UIObject:TextSizeClamp(DescriptionText, 1, 12)
	UtilityModule.UIObject:Corner(TopBar, UDim.new(0, 6), "BR/BL")
	UtilityModule.UIObject:Corner(NotificationFrame, UDim.new(0, 6))
end

function WindowClass:Destroy()
	self.UI:Destroy()

	self = nil
end

-- Tab Class

function TabClass:NewButton(Name:string, Action)
	local ActionButton = Instance.new("TextButton")
	local IconImage = Instance.new("ImageLabel")
	local TitleText = Instance.new("TextLabel")

	local DefaultColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(15, 15, 15))
	local HoverColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(25, 25, 25))
	local ActivateColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(35, 35, 35))

	ActionButton.Parent = self.TabPage.ActionContainer
	ActionButton.Name = "ButtonAction"
	ActionButton.Size = UDim2.fromScale(0.95, 0.18)
	ActionButton.BackgroundColor3 = DefaultColor
	ActionButton.BorderSizePixel = 0
	ActionButton.AutoButtonColor = false
	ActionButton.Text = ""

	IconImage.Parent = ActionButton
	IconImage.Name = "ActionIcon"
	IconImage.Position = UDim2.fromScale(0.02, 0.5)
	IconImage.Size = UDim2.fromScale(0.05, 0.65)
	IconImage.AnchorPoint = Vector2.new(0, 0.5)
	IconImage.BackgroundTransparency = 1
	IconImage.BorderSizePixel = 0
	IconImage.Image = "rbxassetid://18136385143"
	IconImage.ScaleType = Enum.ScaleType.Fit
	IconImage.ResampleMode = Enum.ResamplerMode.Pixelated

	TitleText.Parent = ActionButton
	TitleText.Name = "TitleText"
	TitleText.Position = UDim2.fromScale(0.1, 0.5)
	TitleText.Size = UDim2.fromScale(0.875, 0.55)
	TitleText.AnchorPoint = Vector2.new(0, 0.5)
	TitleText.BackgroundTransparency = 1
	TitleText.BorderSizePixel = 0
	TitleText.TextScaled = true
	TitleText.TextColor3 = Color3.new(1, 1, 1)
	TitleText.Text = Name
	TitleText.TextXAlignment = Enum.TextXAlignment.Left
	TitleText.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal)

	local Hovering = false

	ActionButton.MouseEnter:Connect(function()
		Hovering = true

		TweenService:Create(ActionButton, AnimateInfos.ActionSelect, {
			BackgroundColor3 = HoverColor;
		}):Play()
	end)

	ActionButton.MouseLeave:Connect(function()
		Hovering = false

		TweenService:Create(ActionButton, AnimateInfos.ActionSelect, {
			BackgroundColor3 = DefaultColor;
		}):Play()
	end)

	ActionButton.Activated:Connect(function()
		Action()

		TweenService:Create(ActionButton, AnimateInfos.ActionSelect, {
			BackgroundColor3 = ActivateColor;
		}):Play()

		task.wait(AnimateInfos.ActionSelect.Time)

		if Hovering == true then
			TweenService:Create(ActionButton, AnimateInfos.ActionSelect, {
				BackgroundColor3 = HoverColor;
			}):Play()
		else
			TweenService:Create(ActionButton, AnimateInfos.ActionSelect, {
				BackgroundColor3 = DefaultColor;
			}):Play()
		end
	end)

	UtilityModule.UIObject:Corner(ActionButton, UDim.new(0, 6))
end

function TabClass:NewToggle(Name:string, DefaultValue:boolean, Action)
	local ActionButton = Instance.new("TextButton")
	local IconImage = Instance.new("ImageLabel")
	local TitleText = Instance.new("TextLabel")
	local ToggleButton = Instance.new("TextButton")
	local ToggleIcon = Instance.new("ImageLabel")

	local DefaultColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(15, 15, 15))
	local HoverColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(25, 25, 25))

	ActionButton.Parent = self.TabPage.ActionContainer
	ActionButton.Name = "ToggleAction"
	ActionButton.Size = UDim2.fromScale(0.95, 0.18)
	ActionButton.BackgroundColor3 = DefaultColor
	ActionButton.BorderSizePixel = 0
	ActionButton.AutoButtonColor = false
	ActionButton.Text = ""

	IconImage.Parent = ActionButton
	IconImage.Name = "ActionIcon"
	IconImage.Position = UDim2.fromScale(0.02, 0.5)
	IconImage.Size = UDim2.fromScale(0.05, 0.65)
	IconImage.AnchorPoint = Vector2.new(0, 0.5)
	IconImage.BackgroundTransparency = 1
	IconImage.BorderSizePixel = 0
	IconImage.Image = "rbxassetid://18138630295"
	IconImage.ScaleType = Enum.ScaleType.Fit

	TitleText.Parent = ActionButton
	TitleText.Name = "TitleText"
	TitleText.Position = UDim2.fromScale(0.1, 0.5)
	TitleText.Size = UDim2.fromScale(0.75, 0.55)
	TitleText.AnchorPoint = Vector2.new(0, 0.5)
	TitleText.BackgroundTransparency = 1
	TitleText.BorderSizePixel = 0
	TitleText.TextScaled = true
	TitleText.TextColor3 = Color3.new(1, 1, 1)
	TitleText.Text = Name
	TitleText.TextXAlignment = Enum.TextXAlignment.Left
	TitleText.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal)

	local ButtonDefaultColor = self.Config.Theme
	local ButtonHoverColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(15, 15, 15))

	ToggleButton.Parent = ActionButton
	ToggleButton.Name = "ToggleButton"
	ToggleButton.Position = UDim2.fromScale(0.9, 0.5)
	ToggleButton.Size = UDim2.fromScale(0.05, 0.65)
	ToggleButton.AnchorPoint = Vector2.new(0, 0.5)
	ToggleButton.BackgroundColor3 = self.Config.Theme
	ToggleButton.BorderSizePixel = 0
	ToggleButton.AutoButtonColor = false
	ToggleButton.Text = ""

	ToggleIcon.Parent = ToggleButton
	ToggleIcon.Name = "CheckIcon"
	ToggleIcon.Position = UDim2.fromScale(0.5, 0.5)
	ToggleIcon.Size = UDim2.fromScale(0.75, 0.75)
	ToggleIcon.AnchorPoint = Vector2.one / 2
	ToggleIcon.BackgroundTransparency = 1
	ToggleIcon.BorderSizePixel = 0
	ToggleIcon.Image = "rbxassetid://18138714473"
	ToggleIcon.ImageTransparency = if DefaultValue == false then 1 else 0

	ActionButton.MouseEnter:Connect(function()
		TweenService:Create(ActionButton, AnimateInfos.ActionSelect, {
			BackgroundColor3 = HoverColor;
		}):Play()
	end)

	ActionButton.MouseLeave:Connect(function()
		TweenService:Create(ActionButton, AnimateInfos.ActionSelect, {
			BackgroundColor3 = DefaultColor;
		}):Play()
	end)

	ToggleButton.MouseEnter:Connect(function()
		TweenService:Create(ToggleButton, AnimateInfos.ActionSelect, {
			BackgroundColor3 = ButtonHoverColor;
		}):Play()
	end)

	ToggleButton.MouseLeave:Connect(function()
		TweenService:Create(ToggleButton, AnimateInfos.ActionSelect, {
			BackgroundColor3 = ButtonDefaultColor;
		}):Play()
	end)

	local Enabled = DefaultValue

	ToggleButton.Activated:Connect(function()
		if Enabled == false then
			Enabled = true

			TweenService:Create(ToggleIcon, AnimateInfos.ActionSelect, {
				ImageTransparency = 0;
			}):Play()

			Action(Enabled)
		else
			Enabled = false

			TweenService:Create(ToggleIcon, AnimateInfos.ActionSelect, {
				ImageTransparency = 1;
			}):Play()

			Action(Enabled)
		end
	end)

	ActionButton.Activated:Connect(function()
		if Enabled == false then
			Enabled = true

			TweenService:Create(ToggleIcon, AnimateInfos.ActionSelect, {
				ImageTransparency = 0;
			}):Play()

			Action(Enabled)
		else
			Enabled = false

			TweenService:Create(ToggleIcon, AnimateInfos.ActionSelect, {
				ImageTransparency = 1;
			}):Play()

			Action(Enabled)
		end
	end)

	UtilityModule.UIObject:Corner(ToggleButton, UDim.new(0, 4))
	UtilityModule.UIObject:Corner(ActionButton, UDim.new(0, 6))
end

function TabClass:NewInput(Name:string, Long:boolean, Action:string)
	local ActionFrame = Instance.new("Frame")
	local IconImage = Instance.new("ImageLabel")
	local TitleText = Instance.new("TextLabel")
	local InputText = Instance.new("TextBox")

	local DefaultColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(15, 15, 15))
	local HoverColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(25, 25, 25))

	ActionFrame.Parent = self.TabPage.ActionContainer
	ActionFrame.Name = "InputAction"
	ActionFrame.Size = UDim2.fromScale(0.95, 0.18)
	ActionFrame.BackgroundColor3 = DefaultColor
	ActionFrame.BorderSizePixel = 0

	IconImage.Parent = ActionFrame
	IconImage.Name = "ActionIcon"
	IconImage.Position = UDim2.fromScale(0.02, 0.5)
	IconImage.Size = UDim2.fromScale(0.05, 0.65)
	IconImage.AnchorPoint = Vector2.new(0, 0.5)
	IconImage.BackgroundTransparency = 1
	IconImage.BorderSizePixel = 0
	IconImage.Image = "rbxassetid://18139219099"
	IconImage.ScaleType = Enum.ScaleType.Fit

	TitleText.Parent = ActionFrame
	TitleText.Name = "TitleText"
	TitleText.Position = UDim2.fromScale(0.1, 0.5)
	TitleText.Size = UDim2.fromScale(0.75, 0.55)
	TitleText.AnchorPoint = Vector2.new(0, 0.5)
	TitleText.BackgroundTransparency = 1
	TitleText.BorderSizePixel = 0
	TitleText.TextScaled = true
	TitleText.TextColor3 = Color3.new(1, 1, 1)
	TitleText.Text = Name
	TitleText.TextXAlignment = Enum.TextXAlignment.Left
	TitleText.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal)

	local InputDefaultColor = self.Config.Theme
	local InputHoverColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(15, 15, 15))

	InputText.Parent = ActionFrame
	InputText.Name = "InputTextBox"
	InputText.Position = UDim2.fromScale(0.8, 0.5)
	InputText.Size = UDim2.fromScale(0.15, 0.65)
	InputText.AnchorPoint = Vector2.new(0, 0.5)
	InputText.BackgroundColor3 = self.Config.Theme
	InputText.BorderSizePixel = 0
	InputText.PlaceholderText = "Input"
	InputText.TextSize = 10
	InputText.PlaceholderColor3 = Color3.new(0.5, 0.5, 0.5)
	InputText.TextColor3 = Color3.new(1, 1, 1)
	InputText.Text = ""
	InputText.TextTruncate = Enum.TextTruncate.AtEnd
	InputText.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal)

	if Long == true then
		TitleText.Size = UDim2.fromScale(0.55, 0.55)
		InputText.Size = UDim2.fromScale(0.25, 0.65)
		InputText.Position = UDim2.fromScale(0.7, 0.5)

		InputText.ClearTextOnFocus = false
	end

	ActionFrame.MouseEnter:Connect(function()
		TweenService:Create(ActionFrame, AnimateInfos.ActionSelect, {
			BackgroundColor3 = HoverColor;
		}):Play()
	end)

	ActionFrame.MouseLeave:Connect(function()
		TweenService:Create(ActionFrame, AnimateInfos.ActionSelect, {
			BackgroundColor3 = DefaultColor;
		}):Play()
	end)

	InputText.MouseEnter:Connect(function()
		TweenService:Create(InputText, AnimateInfos.ActionSelect, {
			BackgroundColor3 = InputHoverColor;
		}):Play()
	end)

	InputText.MouseLeave:Connect(function()
		TweenService:Create(InputText, AnimateInfos.ActionSelect, {
			BackgroundColor3 = InputDefaultColor;
		}):Play()
	end)

	InputText.FocusLost:Connect(function(Enter)
		Action(InputText.Text, Enter)
	end)

	UtilityModule.UIObject:Corner(InputText, UDim.new(0, 4))
	UtilityModule.UIObject:Corner(ActionFrame, UDim.new(0, 6))
end

function TabClass:NewSlider(Name:string, Min:number, Max:number, Steps:number, Action)
	local ActionFrame = Instance.new("Frame")
	local IconImage = Instance.new("ImageLabel")
	local TitleText = Instance.new("TextLabel")
	local ValueText = Instance.new("TextLabel")

	local SliderLine = Instance.new("Frame")
	local Slider = Instance.new("ImageLabel")

	local DefaultColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(15, 15, 15))
	local HoverColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(25, 25, 25))

	ActionFrame.Parent = self.TabPage.ActionContainer
	ActionFrame.Name = "SliderAction"
	ActionFrame.Size = UDim2.fromScale(0.95, 0.25)
	ActionFrame.BackgroundColor3 = DefaultColor
	ActionFrame.BorderSizePixel = 0

	TitleText.Parent = ActionFrame
	TitleText.Name = "TitleText"
	TitleText.Position = UDim2.fromScale(0.085, 0.1)
	TitleText.Size = UDim2.fromScale(0.8, 0.375)
	TitleText.BackgroundTransparency = 1
	TitleText.BorderSizePixel = 0
	TitleText.TextScaled = true
	TitleText.TextColor3 = Color3.new(1, 1, 1)
	TitleText.Text = Name
	TitleText.TextXAlignment = Enum.TextXAlignment.Left
	TitleText.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal)

	ValueText.Parent = ActionFrame
	ValueText.Name = "ValueText"
	ValueText.Position = UDim2.fromScale(0.885, 0.1)
	ValueText.Size = UDim2.fromScale(0.075, 0.375)
	ValueText.BackgroundTransparency = 1
	ValueText.BorderSizePixel = 0
	ValueText.TextScaled = true
	ValueText.TextColor3 = Color3.new(1, 1, 1)
	ValueText.Text = Min
	ValueText.TextXAlignment = Enum.TextXAlignment.Right
	ValueText.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal)

	IconImage.Parent = ActionFrame
	IconImage.Name = "ActionIcon"
	IconImage.Position = UDim2.fromScale(0.02, 0.1)
	IconImage.Size = UDim2.fromScale(0.05, 0.375)
	IconImage.BackgroundTransparency = 1
	IconImage.BorderSizePixel = 0
	IconImage.Image = "rbxassetid://18137656810"
	IconImage.ScaleType = Enum.ScaleType.Fit

	SliderLine.Parent = ActionFrame
	SliderLine.Name = "Line"
	SliderLine.Position = UDim2.fromScale(0.5, 0.75)
	SliderLine.Size = UDim2.fromScale(0.9, 0.05)
	SliderLine.AnchorPoint = Vector2.new(0.5, 0)
	SliderLine.BackgroundColor3 = Color3.new(1, 1, 1)
	SliderLine.BackgroundTransparency = 0.65
	SliderLine.BorderSizePixel = 0

	Slider.Parent = SliderLine
	Slider.Name = "Slider"
	Slider.Size = UDim2.fromScale(0.035, 6)
	Slider.AnchorPoint = Vector2.one / 2
	Slider.ZIndex = 2
	Slider.BackgroundTransparency = 1
	Slider.Image = "rbxassetid://9208578430"
	Slider.ImageColor3 = Color3.fromRGB(100, 200, 255) --UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(45, 45, 45))
	Slider.BorderSizePixel = 0

	if Steps ~= math.huge then
		local StepLevels = {}

		for I = 0, Steps - 1, 1 do
			local NewStopLine = Instance.new("Frame")
			local StopLevel = (1 / (Steps - 1)) * I

			NewStopLine.Parent = SliderLine
			NewStopLine.Name = "StopLine"
			NewStopLine.Position = UDim2.fromScale(StopLevel, 0)
			NewStopLine.Size = UDim2.new(0, 4, 5, 0)
			NewStopLine.AnchorPoint = Vector2.one / 2
			NewStopLine.BackgroundColor3 = Color3.new(1, 1, 1)
			NewStopLine.BackgroundTransparency = 0.65
			NewStopLine.BorderSizePixel = 0

			table.insert(StepLevels, StopLevel)
		end

		local Hovering = false
		local Holding = false

		ActionFrame.MouseEnter:Connect(function()
			Hovering = true

			TweenService:Create(ActionFrame, AnimateInfos.ActionSelect, {
				BackgroundColor3 = HoverColor;
			}):Play()
		end)

		ActionFrame.MouseLeave:Connect(function()
			Hovering = false

			TweenService:Create(ActionFrame, AnimateInfos.ActionSelect, {
				BackgroundColor3 = DefaultColor;
			}):Play()
		end)

		InputService.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 and Hovering == true then
				Holding = true
			end
		end)

		InputService.InputEnded:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then
				Holding = false
			end
		end)

		local OldValue = Min

		RunService.Heartbeat:Connect(function()
			if Holding == true then
				local MouseOffsetLevel = InputService:GetMouseLocation().X
				local SliderOffsetLevel = MouseOffsetLevel - SliderLine.AbsolutePosition.X
				local SliderLevel = SliderOffsetLevel / SliderLine.AbsoluteSize.X

				local ClosestStepDistance = 999
				local ClosestStep = 0

				for LevelI, Level in pairs(StepLevels) do
					local Distance = math.abs(SliderLevel - Level)

					if Distance < ClosestStepDistance then
						ClosestStepDistance = Distance
						ClosestStep = Level
					end
				end

				local Value = Min + (Max - Min) * ClosestStep

				ValueText.Text = math.round(Value)

				if Value ~= OldValue then
					TweenService:Create(Slider, AnimateInfos.SliderChange, {
						Position = UDim2.new(ClosestStep, 0, 0, 0);
					}):Play()

					Action(Value)
				end

				OldValue = Value
			end
		end)
	else
		local Hovering = false
		local Holding = false

		ActionFrame.MouseEnter:Connect(function()
			Hovering = true

			TweenService:Create(ActionFrame, AnimateInfos.ActionSelect, {
				BackgroundColor3 = HoverColor;
			}):Play()
		end)

		ActionFrame.MouseLeave:Connect(function()
			Hovering = false

			TweenService:Create(ActionFrame, AnimateInfos.ActionSelect, {
				BackgroundColor3 = DefaultColor;
			}):Play()
		end)

		InputService.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 and Hovering == true then
				Holding = true
			end
		end)

		InputService.InputEnded:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then
				Holding = false
			end
		end)

		local OldValue = Min

		RunService.Heartbeat:Connect(function()
			if Holding == true then
				local MouseOffsetLevel = InputService:GetMouseLocation().X
				local SliderOffsetLevel = MouseOffsetLevel - SliderLine.AbsolutePosition.X
				local SliderLevel = math.clamp(SliderOffsetLevel / SliderLine.AbsoluteSize.X, 0, 1)

				local Value = Min + (Max - Min) * SliderLevel

				ValueText.Text = math.ceil(Value)

				if Value ~= OldValue then
					TweenService:Create(Slider, AnimateInfos.SliderChange, {
						Position = UDim2.new(SliderLevel, 0, 0, 0);
					}):Play()

					Action(Value)
				end

				OldValue = Value
			end
		end)
	end

	UtilityModule.UIObject:Corner(ActionFrame, UDim.new(0, 6))
end

function TabClass:NewDropdown(Name:string, Items, AutoSelected, Sort, Action)
	local NewDropdown = setmetatable({}, DropdownClass)

	NewDropdown.Config = self.Config

	NewDropdown.ActionButton = Instance.new("TextButton")
	NewDropdown.DropdownButton = Instance.new("TextButton")
	NewDropdown.ItemContainer = Instance.new("Frame")

	NewDropdown.Action = Action
	NewDropdown.Items = Items
	NewDropdown.Selected = AutoSelected or "None"
	NewDropdown.Open = false

	local DefaultColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(15, 15, 15))
	local HoverColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(25, 25, 25))
	local ActivateColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(35, 35, 35))

	local DropdownDefaultColor = self.Config.Theme
	local DropdownHoverColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(15, 15, 15))

	local IconImage = Instance.new("ImageLabel")
	local TitleText = Instance.new("TextLabel")

	NewDropdown.ActionButton.Parent = self.TabPage.ActionContainer
	NewDropdown.ActionButton.Name = "DropdownAction"
	NewDropdown.ActionButton.Size = UDim2.fromScale(0.95, 0.2)
	NewDropdown.ActionButton.ZIndex = 2
	NewDropdown.ActionButton.BackgroundColor3 = DefaultColor
	NewDropdown.ActionButton.BorderSizePixel = 0
	NewDropdown.ActionButton.AutoButtonColor = false
	NewDropdown.ActionButton.Text = ""

	IconImage.Parent = NewDropdown.ActionButton
	IconImage.Name = "ActionIcon"
	IconImage.Position = UDim2.fromScale(0.02, 0.5)
	IconImage.Size = UDim2.fromScale(0.05, 0.65)
	IconImage.AnchorPoint = Vector2.new(0, 0.5)
	IconImage.BackgroundTransparency = 1
	IconImage.BorderSizePixel = 0
	IconImage.Image = "rbxassetid://18203477286"
	IconImage.ScaleType = Enum.ScaleType.Fit
	IconImage.ResampleMode = Enum.ResamplerMode.Pixelated

	TitleText.Parent = NewDropdown.ActionButton
	TitleText.Name = "TitleText"
	TitleText.Position = UDim2.fromScale(0.1, 0.5)
	TitleText.Size = UDim2.fromScale(0.75, 0.55)
	TitleText.AnchorPoint = Vector2.new(0, 0.5)
	TitleText.BackgroundTransparency = 1
	TitleText.BorderSizePixel = 0
	TitleText.TextScaled = true
	TitleText.TextColor3 = Color3.new(1, 1, 1)
	TitleText.Text = Name
	TitleText.TextXAlignment = Enum.TextXAlignment.Left
	TitleText.FontFace = Font.new(NewDropdown.Config.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal)

	local DropdownText = Instance.new("TextLabel")
	local DropdownIcon = Instance.new("ImageLabel")

	NewDropdown.DropdownButton.Parent = NewDropdown.ActionButton
	NewDropdown.DropdownButton.Name = "DropdownButton"
	NewDropdown.DropdownButton.Position = UDim2.fromScale(0.675, 0.5)
	NewDropdown.DropdownButton.AnchorPoint = Vector2.new(0, 0.5)
	NewDropdown.DropdownButton.Size = UDim2.fromScale(0.3, 0.65)
	NewDropdown.DropdownButton.BackgroundColor3 = NewDropdown.Config.Theme
	NewDropdown.DropdownButton.BorderSizePixel = 0
	NewDropdown.DropdownButton.AutoButtonColor = false
	NewDropdown.DropdownButton.Text = ""

	DropdownText.Parent = NewDropdown.DropdownButton
	DropdownText.Name = "ItemText"
	DropdownText.Position = UDim2.fromScale(0.05, 0.5)
	DropdownText.AnchorPoint = Vector2.new(0, 0.5)
	DropdownText.Size = UDim2.fromScale(0.7, 0.75)
	DropdownText.BackgroundTransparency = 1
	DropdownText.TextScaled = true
	DropdownText.TextColor3 = Color3.new(1, 1, 1)
	DropdownText.Text = NewDropdown.Selected
	DropdownText.TextXAlignment = Enum.TextXAlignment.Left
	DropdownText.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal)

	DropdownIcon.Parent = NewDropdown.DropdownButton
	DropdownIcon.Name = "DropdownIcon"
	DropdownIcon.Position = UDim2.fromScale(0.85, 0.5)
	DropdownIcon.AnchorPoint = Vector2.new(0, 0.5)
	DropdownIcon.Size = UDim2.fromScale(0.125, 0.7)
	DropdownIcon.BackgroundTransparency = 1
	DropdownIcon.BorderSizePixel = 0
	DropdownIcon.Image = "rbxassetid://17352538452"

	NewDropdown.ItemContainer.Parent = NewDropdown.DropdownButton
	NewDropdown.ItemContainer.Name = "ItemContainer"
	NewDropdown.ItemContainer.Position = UDim2.fromScale(0, 0.85)
	NewDropdown.ItemContainer.Size = UDim2.fromScale(1, 0)
	NewDropdown.ItemContainer.ClipsDescendants = true
	NewDropdown.ItemContainer.BorderSizePixel = 0
	NewDropdown.ItemContainer.BackgroundColor3 = self.Config.Theme

	UtilityModule.UIObject:Corner(NewDropdown.ItemContainer, UDim.new(0, 4))
	UtilityModule.UIObject:List(NewDropdown.ItemContainer, UDim.new(0, 0), Enum.FillDirection.Vertical, "TC")

	for ItemI, Item in pairs(NewDropdown.Items) do
		local NewItemButton = Instance.new("TextButton")

		NewItemButton.Parent = NewDropdown.ItemContainer
		NewItemButton.Name = if Sort == true then Item.." Item" else "ItemButton"
		NewItemButton.Size = UDim2.new(0.95, 0, 0, 12)
		NewItemButton.BackgroundColor3 = Color3.new(1, 1, 1)
		NewItemButton.BackgroundTransparency = 1
		NewItemButton.BorderSizePixel = 0
		NewItemButton.AutoButtonColor = false
		NewItemButton.TextScaled = true
		NewItemButton.TextColor3 = Color3.new(1, 1, 1)
		NewItemButton.Text = Item
		NewItemButton.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Medium, Enum.FontStyle.Normal)

		NewItemButton.MouseEnter:Connect(function()
			TweenService:Create(NewItemButton, AnimateInfos.ActionSelect, {
				BackgroundTransparency = 0.9;
			}):Play()
		end)

		NewItemButton.MouseLeave:Connect(function()
			TweenService:Create(NewItemButton, AnimateInfos.ActionSelect, {
				BackgroundTransparency = 1;
			}):Play()
		end)

		NewItemButton.Activated:Connect(function()
			NewDropdown.Open = false

			NewDropdown.Action(Item, false)

			NewDropdown.Selected = Item
			DropdownText.Text = Item

			TweenService:Create(NewDropdown.ItemContainer, AnimateInfos.DropdownContainer, {
				Size = UDim2.fromScale(1, 0);
			}):Play()

			TweenService:Create(DropdownIcon, AnimateInfos.DropdownContainer, {
				Rotation = 0;
			}):Play()

			task.spawn(function()
				task.wait(AnimateInfos.DropdownContainer.Time)

				NewDropdown.ActionButton.ZIndex = 1
				NewDropdown.ItemContainer.ZIndex = 1
			end)
		end)
	end

	local Hovering = false

	NewDropdown.ActionButton.MouseEnter:Connect(function()
		Hovering = true

		TweenService:Create(NewDropdown.ActionButton, AnimateInfos.ActionSelect, {
			BackgroundColor3 = HoverColor;
		}):Play()
	end)

	NewDropdown.ActionButton.MouseLeave:Connect(function()
		Hovering = false

		TweenService:Create(NewDropdown.ActionButton, AnimateInfos.ActionSelect, {
			BackgroundColor3 = DefaultColor;
		}):Play()
	end)

	NewDropdown.ActionButton.Activated:Connect(function()
		NewDropdown.Action(NewDropdown.Selected, true)

		TweenService:Create(NewDropdown.ActionButton, AnimateInfos.ActionSelect, {
			BackgroundColor3 = ActivateColor;
		}):Play()

		task.wait(AnimateInfos.ActionSelect.Time)

		if Hovering == true then
			TweenService:Create(NewDropdown.ActionButton, AnimateInfos.ActionSelect, {
				BackgroundColor3 = HoverColor;
			}):Play()
		else
			TweenService:Create(NewDropdown.ActionButton, AnimateInfos.ActionSelect, {
				BackgroundColor3 = DefaultColor;
			}):Play()
		end
	end)

	NewDropdown.DropdownButton.MouseEnter:Connect(function()
		TweenService:Create(NewDropdown.DropdownButton, AnimateInfos.ActionSelect, {
			BackgroundColor3 = DropdownHoverColor;
		}):Play()

		TweenService:Create(NewDropdown.ItemContainer, AnimateInfos.ActionSelect, {
			BackgroundColor3 = DropdownHoverColor;
		}):Play()
	end)

	NewDropdown.DropdownButton.MouseLeave:Connect(function()
		TweenService:Create(NewDropdown.DropdownButton, AnimateInfos.ActionSelect, {
			BackgroundColor3 = DropdownDefaultColor;
		}):Play()

		TweenService:Create(NewDropdown.ItemContainer, AnimateInfos.ActionSelect, {
			BackgroundColor3 = DropdownDefaultColor;
		}):Play()
	end)

	NewDropdown.DropdownButton.Activated:Connect(function()
		if NewDropdown.Open == false then
			NewDropdown.Open = true

			NewDropdown.ActionButton.ZIndex = 10
			NewDropdown.ItemContainer.ZIndex = 10

			local OffsetY = (#NewDropdown.ItemContainer:GetChildren() - 2) * 12.25

			TweenService:Create(NewDropdown.ItemContainer, AnimateInfos.DropdownContainer, {
				Size = UDim2.new(1, 0, 0, OffsetY);
			}):Play()

			TweenService:Create(DropdownIcon, AnimateInfos.DropdownContainer, {
				Rotation = 180;
			}):Play()
		else
			NewDropdown.Open = false

			TweenService:Create(NewDropdown.ItemContainer, AnimateInfos.DropdownContainer, {
				Size = UDim2.fromScale(1, 0);
			}):Play()

			TweenService:Create(DropdownIcon, AnimateInfos.DropdownContainer, {
				Rotation = 0;
			}):Play()

			task.spawn(function()
				task.wait(AnimateInfos.DropdownContainer.Time)

				NewDropdown.ActionButton.ZIndex = 1
				NewDropdown.ItemContainer.ZIndex = 1
			end)
		end
	end)

	UtilityModule.UIObject:Corner(NewDropdown.DropdownButton, UDim.new(0, 4))
	UtilityModule.UIObject:Corner(NewDropdown.ActionButton, UDim.new(0, 6))

	return NewDropdown
end

function TabClass:NewColorWheel(Name:string, Action)
	local ActionButton = Instance.new("TextButton")
	local IconImage = Instance.new("ImageLabel")
	local TitleText = Instance.new("TextLabel")
	local ColorText = Instance.new("TextLabel")

	local WheelImage = Instance.new("ImageLabel")
	local WheelPicker = Instance.new("Frame")

	local ValueFrame = Instance.new("Frame")
	local ValuePicker = Instance.new("Frame")
	local ValueGradient = Instance.new("UIGradient")

	local DefaultColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(15, 15, 15))
	local HoverColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(25, 25, 25))
	local ActivateColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(35, 35, 35))

	ActionButton.Parent = self.TabPage.ActionContainer
	ActionButton.Name = "ColorAction"
	ActionButton.Size = UDim2.fromScale(0.95, 0.65)
	ActionButton.BackgroundColor3 = DefaultColor
	ActionButton.BorderSizePixel = 0
	ActionButton.AutoButtonColor = false
	ActionButton.Text = ""

	IconImage.Parent = ActionButton
	IconImage.Name = "ActionIcon"
	IconImage.Position = UDim2.fromScale(0.02, 0.05)
	IconImage.Size = UDim2.fromScale(0.05, 0.15)
	IconImage.BackgroundTransparency = 1
	IconImage.BorderSizePixel = 0
	IconImage.Image = "rbxassetid://18139650833"
	IconImage.ScaleType = Enum.ScaleType.Fit
	IconImage.ResampleMode = Enum.ResamplerMode.Pixelated

	TitleText.Parent = ActionButton
	TitleText.Name = "TitleText"
	TitleText.Position = UDim2.fromScale(0.1, 0.05)
	TitleText.Size = UDim2.fromScale(0.5, 0.35)
	TitleText.BackgroundTransparency = 1
	TitleText.BorderSizePixel = 0
	TitleText.TextScaled = true
	TitleText.TextColor3 = Color3.new(1, 1, 1)
	TitleText.Text = Name
	TitleText.TextXAlignment = Enum.TextXAlignment.Left
	TitleText.TextYAlignment = Enum.TextYAlignment.Top
	TitleText.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal)

	ColorText.Parent = ActionButton
	ColorText.Name = "ColorText"
	ColorText.Position = UDim2.fromScale(0.025, 0.8)
	ColorText.Size = UDim2.fromScale(0.5, 0.15)
	ColorText.BackgroundTransparency = 1
	ColorText.BorderSizePixel = 0
	ColorText.TextScaled = true
	ColorText.RichText = true
	ColorText.TextColor3 = Color3.new(1, 1, 1)
	ColorText.Text = "RGB: 255, 255, 255"
	ColorText.TextXAlignment = Enum.TextXAlignment.Left
	ColorText.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal)

	WheelImage.Parent = ActionButton
	WheelImage.Name = "WheelImage"
	WheelImage.Position = UDim2.fromScale(0.75, 0.5)
	WheelImage.Size = UDim2.fromScale(0.225, 0.78)
	WheelImage.AnchorPoint = Vector2.new(0, 0.5)
	WheelImage.BackgroundTransparency = 1
	WheelImage.BorderSizePixel = 0
	WheelImage.Image = "rbxassetid://2849458409"

	WheelPicker.Parent = WheelImage
	WheelPicker.Name = "Picker"
	WheelPicker.Position = UDim2.fromScale(0.5, 0.5)
	WheelPicker.Size = UDim2.fromScale(0.15, 0.15)
	WheelPicker.AnchorPoint = Vector2.one / 2
	WheelPicker.BackgroundColor3 = Color3.new(1, 1, 1)
	WheelPicker.BorderSizePixel = 0

	ValueFrame.Parent = ActionButton
	ValueFrame.Name = "ValueFrame"
	ValueFrame.Position = UDim2.fromScale(0.7, 0.5)
	ValueFrame.Size = UDim2.fromScale(0.025, 0.78)
	ValueFrame.AnchorPoint = Vector2.new(0, 0.5)
	ValueFrame.BackgroundColor3 = Color3.new(1, 1, 1)
	ValueFrame.BorderSizePixel = 0

	ValuePicker.Parent = ValueFrame
	ValuePicker.Name = "Picker"
	ValuePicker.Size = UDim2.fromScale(2, 0.05)
	ValuePicker.AnchorPoint = Vector2.new(0.25, 0.5)
	ValuePicker.BackgroundColor3 = Color3.new(1, 1, 1)
	ValuePicker.BorderSizePixel = 0

	ValueGradient.Parent = ValueFrame
	ValueGradient.Rotation = 90
	ValueGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1));
		ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0));
	})

	local WheelHovering = false
	local WheelHolding = false

	local ValueHovering = false
	local ValueHolding = false

	WheelImage.MouseEnter:Connect(function()
		WheelHovering = true
	end)

	WheelImage.MouseLeave:Connect(function()
		WheelHovering = false
	end)

	ValueFrame.MouseEnter:Connect(function()
		ValueHovering = true
	end)

	ValueFrame.MouseLeave:Connect(function()
		ValueHovering = false
	end)

	InputService.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			if WheelHovering == true then
				WheelHolding = true
			end

			if ValueHovering == true then
				ValueHolding = true
			end
		end
	end)

	InputService.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			WheelHolding = false
			ValueHolding = false
		end
	end)

	local WheelHalfSize = WheelImage.AbsoluteSize / 2
	local WheelColor = Color3.new(1, 1, 1)
	local ResultColor Color3.new(1, 1, 1)

	RunService.Heartbeat:Connect(function()
		local MousePosition = InputService:GetMouseLocation()
		local WheelPickerOffset = MousePosition - WheelImage.AbsolutePosition - Vector2.new(0, 58)
		local WheelPickerScale = WheelPickerOffset / WheelImage.AbsoluteSize

		if WheelHolding == true then
			local RelativeX = WheelPickerOffset.X - WheelHalfSize.X
			local RelativeY = WheelPickerOffset.Y - WheelHalfSize.Y

			local Angle = math.deg(math.atan2(RelativeY, RelativeX * -1))

			if Angle < 0 then
				Angle += 360
			end

			local Hue = Angle / 360
			local Saturation = (WheelPickerOffset - WheelHalfSize).Magnitude / WheelHalfSize.X
			local Value = 1

			if Saturation < 1 then
				WheelColor = Color3.fromHSV(Hue, Saturation, Value)

				WheelPicker.Position = UDim2.fromScale(WheelPickerScale.X, WheelPickerScale.Y)
			end
		end

		if ValueHolding == true then
			local ValueLevelOffset = MousePosition.Y - ValueFrame.AbsolutePosition.Y - 58
			local ValueLevelScale = ValueLevelOffset / ValueFrame.AbsoluteSize.Y
			local NewValueLevel = math.clamp(ValueLevelScale, 0, 1)

			ValuePicker.Position = UDim2.fromScale(0, NewValueLevel)
		end

		ValueGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, WheelColor);
			ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0));
		})

		ResultColor = WheelColor:Lerp(Color3.new(0, 0, 0), ValuePicker.Position.Y.Scale)

		local RgbText = math.round(ResultColor.R * 255)..", "..math.round(ResultColor.G * 255)..", "..math.round(ResultColor.B * 255)

		ColorText.Text = 'RGB: <font color="rgb('..RgbText..')">'..RgbText..'</font>'
		ValuePicker.BackgroundColor3 = WheelColor:Lerp(Color3.new(0, 0, 0), ValuePicker.Position.Y.Scale)
	end)


	local Hovering = false

	ActionButton.MouseEnter:Connect(function()
		Hovering = true

		TweenService:Create(ActionButton, AnimateInfos.ActionSelect, {
			BackgroundColor3 = HoverColor;
		}):Play()
	end)

	ActionButton.MouseLeave:Connect(function()
		Hovering = false

		TweenService:Create(ActionButton, AnimateInfos.ActionSelect, {
			BackgroundColor3 = DefaultColor;
		}):Play()
	end)

	ActionButton.Activated:Connect(function()
		if WheelHolding == false and ValueHolding == false then
			Action(ResultColor)
		end

		TweenService:Create(ActionButton, AnimateInfos.ActionSelect, {
			BackgroundColor3 = ActivateColor;
		}):Play()

		task.wait(AnimateInfos.ActionSelect.Time)

		if Hovering == true then
			TweenService:Create(ActionButton, AnimateInfos.ActionSelect, {
				BackgroundColor3 = HoverColor;
			}):Play()
		else
			TweenService:Create(ActionButton, AnimateInfos.ActionSelect, {
				BackgroundColor3 = DefaultColor;
			}):Play()
		end
	end)

	local StrokeColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(5, 5, 5))

	UtilityModule.UIObject:Stroke(ValuePicker, 1, StrokeColor)
	UtilityModule.UIObject:Stroke(WheelPicker, 1, StrokeColor)
	UtilityModule.UIObject:Corner(WheelPicker, UDim.new(1, 0))
	UtilityModule.UIObject:Corner(ActionButton, UDim.new(0, 6))
end

function TabClass:NewSection(Name:string)
	local ActionText = Instance.new("TextLabel")

	ActionText.Parent = self.TabPage.ActionContainer
	ActionText.Name = Name.." Section"
	ActionText.Size = UDim2.fromScale(1, 0.1)
	ActionText.BackgroundTransparency = 1
	ActionText.BorderSizePixel = 0
	ActionText.TextScaled = true
	ActionText.TextColor3 = Color3.new(1, 1, 1)
	ActionText.TextTransparency = 0.5
	ActionText.Text = "-- "..Name.." --"
	ActionText.TextXAlignment = Enum.TextXAlignment.Left
	ActionText.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal)
end

function TabClass:NewHint(Hint:string)
	local ActionText = Instance.new("TextLabel")

	ActionText.Parent = self.TabPage.ActionContainer
	ActionText.Name = "HintText"
	ActionText.Size = UDim2.fromScale(1, 0.1)
	ActionText.BackgroundTransparency = 1
	ActionText.BorderSizePixel = 0
	ActionText.TextScaled = true
	ActionText.TextColor3 = Color3.new(1, 1, 1)
	ActionText.TextTransparency = 0.25
	ActionText.Text = Hint
	ActionText.TextXAlignment = Enum.TextXAlignment.Left
	ActionText.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal)
end

function TabClass:NewGap(Length)
	local ActionFrame = Instance.new("Frame")

	ActionFrame.Parent = self.TabPage.ActionContainer
	ActionFrame.Name = "GapFrame"
	ActionFrame.Size = UDim2.new(1, 0, 0, Length)
	ActionFrame.BackgroundTransparency = 1
	ActionFrame.BorderSizePixel = 0
end


-- Dropdown Class

function DropdownClass:ChangeItems(Items, Sort)
	for ItemButtonI, ItemButton in pairs(self.ItemContainer:GetChildren()) do
		if ItemButton:IsA("TextButton") then
			ItemButton:Destroy()
		end
	end

	for ItemI, Item in pairs(Items) do
		local NewItemButton = Instance.new("TextButton")

		NewItemButton.Parent = self.ItemContainer
		NewItemButton.Name = if Sort == true then Item.." Item" else "ItemButton"
		NewItemButton.Size = UDim2.new(0.95, 0, 0, 12)
		NewItemButton.BackgroundColor3 = Color3.new(1, 1, 1)
		NewItemButton.BackgroundTransparency = 1
		NewItemButton.BorderSizePixel = 0
		NewItemButton.AutoButtonColor = false
		NewItemButton.TextScaled = true
		NewItemButton.TextColor3 = Color3.new(1, 1, 1)
		NewItemButton.Text = Item
		NewItemButton.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Medium, Enum.FontStyle.Normal)

		NewItemButton.MouseEnter:Connect(function()
			TweenService:Create(NewItemButton, AnimateInfos.ActionSelect, {
				BackgroundTransparency = 0.9;
			}):Play()
		end)

		NewItemButton.MouseLeave:Connect(function()
			TweenService:Create(NewItemButton, AnimateInfos.ActionSelect, {
				BackgroundTransparency = 1;
			}):Play()
		end)

		NewItemButton.Activated:Connect(function()
			self.Open = false

			self.Action(Item, false)

			self.Selected = Item
			self.DropdownButton.ItemText.Text = Item

			TweenService:Create(self.ItemContainer, AnimateInfos.DropdownContainer, {
				Size = UDim2.fromScale(1, 0);
			}):Play()

			TweenService:Create(self.DropdownButton.DropdownIcon, AnimateInfos.DropdownContainer, {
				Rotation = 0;
			}):Play()

			task.spawn(function()
				task.wait(AnimateInfos.DropdownContainer.Time)

				self.ActionButton.ZIndex = 1
				self.ItemContainer.ZIndex = 1
			end)
		end)
	end

	self.Items = Items

	if self.Open == true then
		local OffsetY = (#self.ItemContainer:GetChildren() - 2) * 12.25

		TweenService:Create(self.ItemContainer, AnimateInfos.DropdownContainer, {
			Size = UDim2.new(1, 0, 0, OffsetY);
		}):Play()
	end
end

function DropdownClass:AddItem(Item:string, Sort)
	local NewItemButton = Instance.new("TextButton")

	NewItemButton.Parent = self.ItemContainer
	NewItemButton.Name = if Sort == true then Item.." Item" else "ItemButton"
	NewItemButton.Size = UDim2.new(0.95, 0, 0, 12)
	NewItemButton.BackgroundColor3 = Color3.new(1, 1, 1)
	NewItemButton.BackgroundTransparency = 1
	NewItemButton.BorderSizePixel = 0
	NewItemButton.AutoButtonColor = false
	NewItemButton.TextScaled = true
	NewItemButton.TextColor3 = Color3.new(1, 1, 1)
	NewItemButton.Text = Item
	NewItemButton.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Medium, Enum.FontStyle.Normal)

	NewItemButton.MouseEnter:Connect(function()
		TweenService:Create(NewItemButton, AnimateInfos.ActionSelect, {
			BackgroundTransparency = 0.9;
		}):Play()
	end)

	NewItemButton.MouseLeave:Connect(function()
		TweenService:Create(NewItemButton, AnimateInfos.ActionSelect, {
			BackgroundTransparency = 1;
		}):Play()
	end)

	NewItemButton.Activated:Connect(function()
		self.Open = false

		self.Action(Item, false)

		self.Selected = Item
		self.DropdownButton.ItemText.Text = Item

		TweenService:Create(self.ItemContainer, AnimateInfos.DropdownContainer, {
			Size = UDim2.fromScale(1, 0);
		}):Play()

		TweenService:Create(self.DropdownButton.DropdownIcon, AnimateInfos.DropdownContainer, {
			Rotation = 0;
		}):Play()

		task.spawn(function()
			task.wait(AnimateInfos.DropdownContainer.Time)

			self.ActionButton.ZIndex = 1
			self.ItemContainer.ZIndex = 1
		end)
	end)

	table.insert(self.Items, Item)

	if self.Open == true then
		local OffsetY = (#self.ItemContainer:GetChildren() - 2) * 12.25

		TweenService:Create(self.ItemContainer, AnimateInfos.DropdownContainer, {
			Size = UDim2.new(1, 0, 0, OffsetY);
		}):Play()
	end
end

function DropdownClass:RemoveItem(Item:string)
	local Index = tonumber(Item)

	if Index == nil then
		for ItemButtonI, ItemButton in pairs(self.ItemContainer:GetChildren()) do
			if ItemButton:IsA("TextButton") and ItemButton.Text == Item then
				table.remove(self.Items, table.find(self.Items, Item))

				ItemButton:Destroy()
			end
		end
	else
		table.remove(self.Items, Index)

		local Item = self.ItemContainer:GetChildren()[Index + 2]

		if Item then
			if Item:IsA("TextButton") then
				Item:Destroy()
			end
		end
	end	

	if self.Open == true then
		local OffsetY = (#self.ItemContainer:GetChildren() - 2) * 12.25

		TweenService:Create(self.ItemContainer, AnimateInfos.DropdownContainer, {
			Size = UDim2.new(1, 0, 0, OffsetY);
		}):Play()
	end
end


-- Deprecated methods

function TabClass:NewColorPicker(Name:string, Action)
	local WarnName = Name:gsub("%p", "")

	warn("LuAura: "..'"'..WarnName..'"'..": NewColorPicker method has been removed and is deprecated, please use another method.")
end


return WindowClass
