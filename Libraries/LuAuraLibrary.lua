--[[
	Library by Mystery_Mux (novakool on discord).
	
	Version: 0.6
]]

local MainModule = script

local WindowClass = {}

local TabClass = {}

WindowClass.__index = WindowClass

TabClass.__index = TabClass

-- Services

local PlayerService = game:GetService("Players")

local RunService = game:GetService("RunService")

local TweenService = game:GetService("TweenService")

local InputService = game:GetService("UserInputService")


-- Locals

local User = PlayerService.LocalPlayer


-- Settings

local DefaultCustom = {
	Theme = Color3.fromRGB(50, 50, 75);
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
}


-- Modules

local Modules = MainModule.Modules

local UtilityModule = require(Modules.UtilityModule)


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
	NewWindow.UI.Name = Name.." UI"
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
	UtilityModule.UIObject:Scale(NewWindow.MainFrame, Scale)
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

function TabClass:NewHint(Hint:string)
	local HintText = Instance.new("TextLabel")

	HintText.Parent = self.TabPage.ActionContainer
	HintText.Name = "HintText"
	HintText.Size = UDim2.fromScale(1, 0.1)
	HintText.BackgroundTransparency = 1
	HintText.BorderSizePixel = 0
	HintText.TextScaled = true
	HintText.TextColor3 = Color3.new(1, 1, 1)
	HintText.TextTransparency = 0.25
	HintText.Text = Hint
	HintText.TextXAlignment = Enum.TextXAlignment.Left
	HintText.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal)
end

function TabClass:NewSection(Name:string)
	local SectionText = Instance.new("TextLabel")
	
	SectionText.Parent = self.TabPage.ActionContainer
	SectionText.Name = Name.." Section"
	SectionText.Size = UDim2.fromScale(1, 0.1)
	SectionText.BackgroundTransparency = 1
	SectionText.BorderSizePixel = 0
	SectionText.TextScaled = true
	SectionText.TextColor3 = Color3.new(1, 1, 1)
	SectionText.TextTransparency = 0.5
	SectionText.Text = "-- "..Name.." --"
	SectionText.TextXAlignment = Enum.TextXAlignment.Left
	SectionText.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal)
end

function TabClass:NewButton(Name:string, Action)
	local Button = Instance.new("TextButton")
	local IconImage = Instance.new("ImageLabel")
	local TitleText = Instance.new("TextLabel")
	
	local DefaultColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(15, 15, 15))
	local HoverColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(25, 25, 25))
	local ActivateColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(35, 35, 35))
	
	Button.Parent = self.TabPage.ActionContainer
	Button.Name = "ButtonAction"
	Button.Size = UDim2.fromScale(0.95, 0.18)
	Button.BackgroundColor3 = DefaultColor
	Button.BorderSizePixel = 0
	Button.AutoButtonColor = false
	Button.Text = ""
	
	IconImage.Parent = Button
	IconImage.Name = "ActionIcon"
	IconImage.Position = UDim2.fromScale(0.02, 0.5)
	IconImage.Size = UDim2.fromScale(0.05, 0.65)
	IconImage.AnchorPoint = Vector2.new(0, 0.5)
	IconImage.BackgroundTransparency = 1
	IconImage.BorderSizePixel = 0
	IconImage.Image = "rbxassetid://18136385143"
	IconImage.ScaleType = Enum.ScaleType.Fit
	IconImage.ResampleMode = Enum.ResamplerMode.Pixelated
	
	TitleText.Parent = Button
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
	
	Button.MouseEnter:Connect(function()
		Hovering = true
		
		TweenService:Create(Button, AnimateInfos.ActionSelect, {
			BackgroundColor3 = HoverColor;
		}):Play()
	end)
	
	Button.MouseLeave:Connect(function()
		Hovering = false
		
		TweenService:Create(Button, AnimateInfos.ActionSelect, {
			BackgroundColor3 = DefaultColor;
		}):Play()
	end)
	
	Button.Activated:Connect(function()
		Action()
		
		TweenService:Create(Button, AnimateInfos.ActionSelect, {
			BackgroundColor3 = ActivateColor;
		}):Play()
		
		task.wait(AnimateInfos.ActionSelect.Time)
		
		if Hovering == true then
			TweenService:Create(Button, AnimateInfos.ActionSelect, {
				BackgroundColor3 = HoverColor;
			}):Play()
		else
			TweenService:Create(Button, AnimateInfos.ActionSelect, {
				BackgroundColor3 = DefaultColor;
			}):Play()
		end
	end)
	
	UtilityModule.UIObject:Corner(Button, UDim.new(0, 6))
end

function TabClass:NewToggle(Name:string, DefaultValue:boolean, Action)
	local ToggleFrame = Instance.new("Frame")
	local IconImage = Instance.new("ImageLabel")
	local TitleText = Instance.new("TextLabel")
	local ToggleButton = Instance.new("TextButton")
	local ToggleIcon = Instance.new("ImageLabel")
	
	local DefaultColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(15, 15, 15))
	local HoverColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(25, 25, 25))
	
	ToggleFrame.Parent = self.TabPage.ActionContainer
	ToggleFrame.Name = "ToggleAction"
	ToggleFrame.Size = UDim2.fromScale(0.95, 0.18)
	ToggleFrame.BackgroundColor3 = DefaultColor
	ToggleFrame.BorderSizePixel = 0
	
	IconImage.Parent = ToggleFrame
	IconImage.Name = "ActionIcon"
	IconImage.Position = UDim2.fromScale(0.02, 0.5)
	IconImage.Size = UDim2.fromScale(0.05, 0.65)
	IconImage.AnchorPoint = Vector2.new(0, 0.5)
	IconImage.BackgroundTransparency = 1
	IconImage.BorderSizePixel = 0
	IconImage.Image = "rbxassetid://18138630295"
	IconImage.ScaleType = Enum.ScaleType.Fit
	
	TitleText.Parent = ToggleFrame
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
	
	ToggleButton.Parent = ToggleFrame
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
	ToggleIcon.Visible = DefaultValue
	ToggleIcon.BackgroundTransparency = 1
	ToggleIcon.BorderSizePixel = 0
	ToggleIcon.Image = "rbxassetid://18138714473"
	
	ToggleFrame.MouseEnter:Connect(function()
		TweenService:Create(ToggleFrame, AnimateInfos.ActionSelect, {
			BackgroundColor3 = HoverColor;
		}):Play()
	end)

	ToggleFrame.MouseLeave:Connect(function()
		TweenService:Create(ToggleFrame, AnimateInfos.ActionSelect, {
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
			
			ToggleIcon.Visible = true
			
			Action(Enabled)
		else
			Enabled = false
			
			ToggleIcon.Visible = false
			
			Action(Enabled)
		end
	end)
	
	UtilityModule.UIObject:Corner(ToggleButton, UDim.new(0, 4))
	UtilityModule.UIObject:Corner(ToggleFrame, UDim.new(0, 6))
end

function TabClass:NewInput(Name:string, Long:boolean, Action:string)
	local InputFrame = Instance.new("Frame")
	local IconImage = Instance.new("ImageLabel")
	local TitleText = Instance.new("TextLabel")
	local InputText = Instance.new("TextBox")
	
	local DefaultColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(15, 15, 15))
	local HoverColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(25, 25, 25))
	
	InputFrame.Parent = self.TabPage.ActionContainer
	InputFrame.Name = "InputAction"
	InputFrame.Size = UDim2.fromScale(0.95, 0.18)
	InputFrame.BackgroundColor3 = DefaultColor
	InputFrame.BorderSizePixel = 0
	
	IconImage.Parent = InputFrame
	IconImage.Name = "ActionIcon"
	IconImage.Position = UDim2.fromScale(0.02, 0.5)
	IconImage.Size = UDim2.fromScale(0.05, 0.65)
	IconImage.AnchorPoint = Vector2.new(0, 0.5)
	IconImage.BackgroundTransparency = 1
	IconImage.BorderSizePixel = 0
	IconImage.Image = "rbxassetid://18139219099"
	IconImage.ScaleType = Enum.ScaleType.Fit
	
	TitleText.Parent = InputFrame
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
	
	InputText.Parent = InputFrame
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
	
	InputFrame.MouseEnter:Connect(function()
		TweenService:Create(InputFrame, AnimateInfos.ActionSelect, {
			BackgroundColor3 = HoverColor;
		}):Play()
	end)

	InputFrame.MouseLeave:Connect(function()
		TweenService:Create(InputFrame, AnimateInfos.ActionSelect, {
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
	UtilityModule.UIObject:Corner(InputFrame, UDim.new(0, 6))
end

function TabClass:NewSlider(Name:string, Min:number, Max:number, Steps:number, Action)
	local SliderFrame = Instance.new("Frame")
	local IconImage = Instance.new("ImageLabel")
	local TitleText = Instance.new("TextLabel")
	local ValueText = Instance.new("TextLabel")
	
	local SliderLine = Instance.new("Frame")
	local Slider = Instance.new("Frame")
	
	local DefaultColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(15, 15, 15))
	local HoverColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(25, 25, 25))
	
	SliderFrame.Parent = self.TabPage.ActionContainer
	SliderFrame.Name = "SliderAction"
	SliderFrame.Size = UDim2.fromScale(0.95, 0.25)
	SliderFrame.BackgroundColor3 = DefaultColor
	SliderFrame.BorderSizePixel = 0
	
	TitleText.Parent = SliderFrame
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
	
	ValueText.Parent = SliderFrame
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
	
	IconImage.Parent = SliderFrame
	IconImage.Name = "ActionIcon"
	IconImage.Position = UDim2.fromScale(0.02, 0.1)
	IconImage.Size = UDim2.fromScale(0.05, 0.375)
	IconImage.BackgroundTransparency = 1
	IconImage.BorderSizePixel = 0
	IconImage.Image = "rbxassetid://18137656810"
	IconImage.ScaleType = Enum.ScaleType.Fit

	SliderLine.Parent = SliderFrame
	SliderLine.Name = "Line"
	SliderLine.Position = UDim2.fromScale(0.5, 0.75)
	SliderLine.Size = UDim2.fromScale(0.9, 0.05)
	SliderLine.AnchorPoint = Vector2.new(0.5, 0)
	SliderLine.BackgroundColor3 = Color3.new(1, 1, 1)
	SliderLine.BackgroundTransparency = 0.65
	SliderLine.BorderSizePixel = 0

	Slider.Parent = SliderLine
	Slider.Name = "Slider"
	Slider.Size = UDim2.fromScale(0.025, 7)
	Slider.AnchorPoint = Vector2.one / 2
	Slider.ZIndex = 2
	Slider.BackgroundColor3 = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(45, 45, 45))
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

		SliderFrame.MouseEnter:Connect(function()
			Hovering = true

			TweenService:Create(SliderFrame, AnimateInfos.ActionSelect, {
				BackgroundColor3 = HoverColor;
			}):Play()
		end)

		SliderFrame.MouseLeave:Connect(function()
			Hovering = false

			TweenService:Create(SliderFrame, AnimateInfos.ActionSelect, {
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

		SliderFrame.MouseEnter:Connect(function()
			Hovering = true

			TweenService:Create(SliderFrame, AnimateInfos.ActionSelect, {
				BackgroundColor3 = HoverColor;
			}):Play()
		end)

		SliderFrame.MouseLeave:Connect(function()
			Hovering = false

			TweenService:Create(SliderFrame, AnimateInfos.ActionSelect, {
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
	
	UtilityModule.UIObject:Corner(Slider, UDim.new(1, 0))
	UtilityModule.UIObject:Corner(SliderFrame, UDim.new(0, 6))
end

function TabClass:NewColorPicker(Name:string, Action)
	local ColorButton = Instance.new("TextButton")
	local IconImage = Instance.new("ImageLabel")
	local TitleText = Instance.new("TextLabel")
	local ColorText = Instance.new("TextLabel")
	
	local WheelImage = Instance.new("ImageLabel")
	local ColorPicker = Instance.new("Frame")
	
	local ValueFrame = Instance.new("Frame")
	local ValuePicker = Instance.new("Frame")
	
	local DefaultColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(15, 15, 15))
	local HoverColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(25, 25, 25))
	local ActivateColor = UtilityModule.Color:Add(self.Config.Theme, Color3.fromRGB(35, 35, 35))
	
	ColorButton.Parent = self.TabPage.ActionContainer
	ColorButton.Name = "ColorPickerAction"
	ColorButton.Size = UDim2.fromScale(0.95, 0.5)
	ColorButton.BackgroundColor3 = DefaultColor
	ColorButton.BorderSizePixel = 0
	ColorButton.AutoButtonColor = false
	ColorButton.Text = ""
	
	IconImage.Parent = ColorButton
	IconImage.Name = "ActionIcon"
	IconImage.Position = UDim2.fromScale(0.02, 0.1)
	IconImage.Size = UDim2.fromScale(0.05, 0.25)
	IconImage.BackgroundTransparency = 1
	IconImage.BorderSizePixel = 0
	IconImage.Image = "rbxassetid://18139650833"
	IconImage.ScaleType = Enum.ScaleType.Fit
	
	TitleText.Parent = ColorButton
	TitleText.Name = "TitleText"
	TitleText.Position = UDim2.fromScale(0.1, 0.125)
	TitleText.Size = UDim2.fromScale(0.65, 0.2)
	TitleText.BackgroundTransparency = 1
	TitleText.BorderSizePixel = 0
	TitleText.TextScaled = true
	TitleText.TextColor3 = Color3.new(1, 1, 1)
	TitleText.Text = Name
	TitleText.TextXAlignment = Enum.TextXAlignment.Left
	TitleText.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	
	ColorText.Parent = ColorButton
	ColorText.Name = "ColorText"
	ColorText.Position = UDim2.fromScale(0.025, 0.7)
	ColorText.Size = UDim2.fromScale(0.65, 0.2)
	ColorText.BackgroundTransparency = 1
	ColorText.BorderSizePixel = 0
	ColorText.TextScaled = true
	ColorText.RichText = true
	ColorText.TextColor3 = Color3.new(1, 1, 1)
	ColorText.Text = 'RGB: <font color="rgb(255, 255, 255)">255, 255, 255</font>'
	ColorText.TextXAlignment = Enum.TextXAlignment.Left
	ColorText.FontFace = Font.new(self.Config.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	
	WheelImage.Parent = ColorButton
	WheelImage.Name = "ColorImage"
	WheelImage.Position = UDim2.fromScale(0.8, 0.15)
	WheelImage.Size = UDim2.fromScale(0.175, 0.75)
	WheelImage.BackgroundTransparency = 1
	WheelImage.Image = "rbxassetid://2849458409"
	WheelImage:SetAttribute("SelectedColor", Color3.new(1, 1, 1))
	
	ColorPicker.Parent = WheelImage
	ColorPicker.Name = "Picker"
	ColorPicker.Position = UDim2.fromOffset(WheelImage.AbsoluteSize.X / 2, WheelImage.AbsoluteSize.Y / 2)
	ColorPicker.Size = UDim2.fromScale(0.1, 0.1)
	ColorPicker.AnchorPoint = Vector2.one / 2
	ColorPicker.BackgroundColor3 = Color3.new(1, 1, 1)
	ColorPicker.BorderSizePixel = 0
	
	ValueFrame.Parent = ColorButton
	ValueFrame.Name = "ValueSliderFrame"
	ValueFrame.Position = UDim2.fromScale(0.775, 0.15)
	ValueFrame.Size = UDim2.fromScale(0.01, 0.75)
	ValueFrame.BackgroundColor3 = Color3.new(1, 1, 1)
	ValueFrame.BorderSizePixel = 0
	
	ValuePicker.Parent = ValueFrame
	ValuePicker.Name = "Picker"
	ValuePicker.Size = UDim2.fromScale(5, 0.05)
	ValuePicker.AnchorPoint = Vector2.new(0.4, 0.5)
	ValuePicker.BackgroundColor3 = Color3.new(1, 1, 1)
	ValuePicker.BorderSizePixel = 0
	
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
	
	local WheelCenterOffset = WheelImage.AbsoluteSize / 2
	local WheelCenter = WheelImage.AbsolutePosition + WheelImage.AbsoluteSize / 2
	
	local LastUpdatedColorPickerPosition = WheelCenterOffset
	
	RunService.Heartbeat:Connect(function()
		local MousePosition = InputService:GetMouseLocation()
		local PickerOffsetPosition = (MousePosition - WheelImage.AbsolutePosition) - Vector2.new(0, 58)
		local PickerScalePosition = PickerOffsetPosition / WheelImage.AbsoluteSize

		local RelativeX = PickerOffsetPosition.X - WheelCenterOffset.X
		local RelativeY = PickerOffsetPosition.Y - WheelCenterOffset.Y

		local Angle = math.deg(math.atan2(RelativeY, RelativeX * -1))
		
		if Angle < 0 then
			Angle += 360
		end
		
		local Hue = Angle / 360
		local Saturation = (PickerOffsetPosition - WheelCenterOffset).Magnitude / WheelCenterOffset.X
		local Value = (ValueFrame.AbsoluteSize.Y - ValuePicker.Position.Y.Offset) / ValueFrame.AbsoluteSize.Y
		
		local PickerColor = Color3.fromHSV(Hue, Saturation, Value)
		local RgbText = math.round(PickerColor.R * 255)..", "..math.round(PickerColor.G * 255)..", "..math.round(PickerColor.B * 255)
		
		if WheelHolding == true and Saturation < 1 then
			WheelImage:SetAttribute("SelectedColor", PickerColor)
			ColorText.Text = [[RGB: <font color="rgb(]]..RgbText..[[)">]]..RgbText..[[</font>]]
			
			LastUpdatedColorPickerPosition = PickerScalePosition
			ColorPicker.Position = UDim2.fromScale(PickerScalePosition.X, PickerScalePosition.Y)
		end
		
		if ValueHolding == true then
			local ValueLevel = math.clamp(MousePosition.Y - ValueFrame.AbsolutePosition.Y - 58, 0, ValueFrame.AbsoluteSize.Y)
			
			ValuePicker.Position = UDim2.fromOffset(0, ValueLevel)
		end
	end)
	
	local Hovering = false
	
	ColorButton.MouseEnter:Connect(function()
		Hovering = true
		
		TweenService:Create(ColorButton, AnimateInfos.ActionSelect, {
			BackgroundColor3 = HoverColor;
		}):Play()
	end)

	ColorButton.MouseLeave:Connect(function()
		Hovering = false
		
		TweenService:Create(ColorButton, AnimateInfos.ActionSelect, {
			BackgroundColor3 = DefaultColor;
		}):Play()
	end)
	
	ColorButton.Activated:Connect(function()
		if WheelHolding == false and ValueHolding == false then
			Action(WheelImage:GetAttribute("SelectedColor"))
		end

		TweenService:Create(ColorButton, AnimateInfos.ActionSelect, {
			BackgroundColor3 = ActivateColor;
		}):Play()

		task.wait(AnimateInfos.ActionSelect.Time)

		if Hovering == true then
			TweenService:Create(ColorButton, AnimateInfos.ActionSelect, {
				BackgroundColor3 = HoverColor;
			}):Play()
		else
			TweenService:Create(ColorButton, AnimateInfos.ActionSelect, {
				BackgroundColor3 = DefaultColor;
			}):Play()
		end
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
	
	UtilityModule.UIObject:ColorFadeGradient(ValueFrame, "BOTTOM")
	UtilityModule.UIObject:Stroke(ColorPicker, 1)
	UtilityModule.UIObject:Corner(ColorPicker, UDim.new(1, 0))
	UtilityModule.UIObject:Corner(ColorButton, UDim.new(0, 6))
	
	warn("LuAura: "..'"'..Name..'"'..": Color picker is still in beta, please expect bugs.")
end


return WindowClass
