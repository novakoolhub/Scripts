local WindowClass = {}

local TabClass = {}

local ButtonClass = {}

local ToggleClass = {}

local InputClass = {}

local SliderClass = {}

local DropdownClass = {}


-- Services

local PlayerService = game:GetService("Players")

local InputService = game:GetService("UserInputService")

local GuiService = game:GetService("GuiService")

local TweenService = game:GetService("TweenService")

local MarketService = game:GetService("MarketplaceService")

local ContentService = game:GetService("ContentProvider")


-- Locals

local User = PlayerService.LocalPlayer


-- Lists

local AvatarColors = {
	BrickColor.new("Bright red").Color;
	BrickColor.new("Bright blue").Color;
	BrickColor.new("Earth green").Color;
	BrickColor.new("Bright violet").Color;
	BrickColor.new("Bright orange").Color;
	BrickColor.new("Bright yellow").Color;
	BrickColor.new("Light reddish violet").Color;
	BrickColor.new("Brick yellow").Color;
}


-- FE Functions

local Clipboard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)


-- UI Functions

local UI = {}

function UI:Corner(Object:GuiObject, Radius)
	local NewCorner = Instance.new("UICorner")
	NewCorner.Parent = Object
	NewCorner.CornerRadius = UDim.new(0, Radius)
	
	return NewCorner
end

function UI:Border(Object:GuiObject, Thickness, Color, Transparency)
	local NewStroke = Instance.new("UIStroke")
	NewStroke.Parent = Object
	NewStroke.Thickness = Thickness or 1
	NewStroke.Color = Color or Color3.new(1, 1, 1)
	NewStroke.Transparency = Transparency or 0
	NewStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	
	return NewStroke
end

function UI:Gradient(Object:GuiObject, Color, Transparency, Rotation)
	local NewGradient = Instance.new("UIGradient")
	NewGradient.Parent = Object
	NewGradient.Color = Color or ColorSequence.new(Color3.new(1, 1, 1))
	NewGradient.Transparency = Transparency or NumberSequence.new(0)
	NewGradient.Rotation = Rotation or 0
	
	return NewGradient
end


-- Effects Functions

local Effects = {}

function Effects:Underline(Object:GuiObject, Offset, Color, Transparency)
	local NewLine = Instance.new("Frame")
	NewLine.Parent = Object
	NewLine.Position = UDim2.new(0.5, 0, 1, Offset)
	NewLine.Size = UDim2.new(1.1, 0, 0, 1)
	NewLine.AnchorPoint = Vector2.new(0.5, 0)
	NewLine.BackgroundColor3 = Color or Color3.new(1, 1, 1)
	NewLine.BackgroundTransparency = Transparency or 0
	NewLine.BorderSizePixel = 0

	Object.MouseEnter:Connect(function()
		TweenService:Create(NewLine, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
			Size = UDim2.new(1.15, 0, 0, 1);
		}):Play()
	end)

	Object.MouseLeave:Connect(function()
		TweenService:Create(NewLine, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
			Size = UDim2.new(1.1, 0, 0, 1);
		}):Play()
	end)
end


-- Animation Functions

local Animations = {}

function Animations:SlideUp(Object:GuiObject, Delay, Reverse, AnimateInfo)
	local OriginalPosition = Object.Position
	local DownPosition = UDim2.new(OriginalPosition.X.Scale, OriginalPosition.X.Offset, 1 + Object.Size.Y.Scale, 1 + Object.Size.Y.Offset)

	if Reverse then
		task.spawn(function()
			if Delay then
				task.wait(Delay)
			end

			TweenService:Create(Object, AnimateInfo or TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Position = DownPosition;
			}):Play()
		end)
	else
		Object.Position = DownPosition

		task.spawn(function()
			if Delay then
				task.wait(Delay)
			end

			TweenService:Create(Object, AnimateInfo or TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Position = OriginalPosition;
			}):Play()
		end)
	end
end

function Animations:SlideDown(Object:GuiObject, Delay, Reverse, AnimateInfo)
	local OriginalPosition = Object.Position
	local UpPosition = UDim2.new(OriginalPosition.X.Scale, OriginalPosition.X.Offset, -Object.Size.Y.Scale * 1.5, -Object.Size.Y.Offset * 1.5)
	
	if Reverse then
		task.spawn(function()
			if Delay then
				task.wait(Delay)
			end

			TweenService:Create(Object, AnimateInfo or TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Position = UpPosition;
			}):Play()
		end)
	else
		Object.Position = UpPosition

		task.spawn(function()
			if Delay then
				task.wait(Delay)
			end

			TweenService:Create(Object, AnimateInfo or TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Position = OriginalPosition;
			}):Play()
		end)
	end
end

function Animations:SlideRight(Object:GuiObject, Delay, Reverse, AnimateInfo)
	local OriginalPosition = Object.Position
	local LeftPosition = UDim2.new(-Object.Size.X.Scale * 1.5, -Object.Size.X.Offset * 1.5, OriginalPosition.Y.Scale, OriginalPosition.Y.Offset)

	if Reverse then
		task.spawn(function()
			if Delay then
				task.wait(Delay)
			end

			TweenService:Create(Object, AnimateInfo or TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Position = LeftPosition;
			}):Play()
		end)
	else
		Object.Position = LeftPosition

		task.spawn(function()
			if Delay then
				task.wait(Delay)
			end

			TweenService:Create(Object, AnimateInfo or TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Position = OriginalPosition;
			}):Play()
		end)
	end
end

function Animations:SlideLeft(Object:GuiObject, Delay, Reverse, AnimateInfo)
	local OriginalPosition = Object.Position
	local RightPosition = UDim2.new(1 + Object.Size.X.Scale, Object.Size.X.Offset, OriginalPosition.Y.Scale, OriginalPosition.Y.Offset)

	if Reverse then
		task.spawn(function()
			if Delay then
				task.wait(Delay)
			end

			TweenService:Create(Object, AnimateInfo or TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Position = RightPosition;
			}):Play()
		end)
	else
		Object.Position = RightPosition

		task.spawn(function()
			if Delay then
				task.wait(Delay)
			end

			TweenService:Create(Object, AnimateInfo or TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Position = OriginalPosition;
			}):Play()
		end)
	end
end


-- Window Class

WindowClass.__index = WindowClass

function WindowClass:New(Config)
	local NewWindow = setmetatable({}, WindowClass)
	
	NewWindow.Config = Config or {}
	
	-- Main
	
	local WindowSize = NewWindow.Config.WindowSize or Vector2.new(550, 330)
	local WindowScale = NewWindow.Config.WindowScale or 1
	
	NewWindow.UI = Instance.new("ScreenGui")
	NewWindow.UI.Parent = User.PlayerGui
	NewWindow.UI.Name = (NewWindow.Config.Name or "New").." Window"
	NewWindow.UI.Enabled = false
	NewWindow.UI.DisplayOrder = 1000
	NewWindow.UI.IgnoreGuiInset = true
	NewWindow.UI.ResetOnSpawn = false
	NewWindow.UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	
	NewWindow.MainFrame = Instance.new("Frame")
	NewWindow.MainFrame.Parent = NewWindow.UI
	NewWindow.MainFrame.Name = "MainFrame"
	NewWindow.MainFrame.Position = UDim2.fromScale(0.5, 0.5)
	NewWindow.MainFrame.Size = UDim2.fromOffset(WindowSize.X * WindowScale, WindowSize.Y * WindowScale)
	NewWindow.MainFrame.AnchorPoint = Vector2.one * 0.5
	NewWindow.MainFrame.ClipsDescendants = true
	NewWindow.MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	UI:Border(NewWindow.MainFrame, 1, Color3.fromRGB(125, 125, 125))
	UI:Corner(NewWindow.MainFrame, 16)
	
	-- Mobile --
	
	NewWindow.MainButton = Instance.new("TextButton")
	NewWindow.MainButton.Parent = NewWindow.UI
	NewWindow.MainButton.Position = UDim2.new(0, 55, 0.5, 0)
	NewWindow.MainButton.Size = UDim2.fromOffset(50, 50)
	NewWindow.MainButton.AnchorPoint = Vector2.new(0, 0.5)
	NewWindow.MainButton.Visible = false
	NewWindow.MainButton.AutoButtonColor = false
	NewWindow.MainButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	NewWindow.MainButton.Text = "Novura"
	NewWindow.MainButton.TextSize = 12
	NewWindow.MainButton.TextColor3 = Color3.new(1, 1, 1)
	NewWindow.MainButton.FontFace = Font.new(NewWindow.Config.MainFont or "rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)

	local ButtonBorder = UI:Border(NewWindow.MainButton, 1, Color3.fromRGB(225, 225, 225))
	local BorderGradient = UI:Gradient(ButtonBorder, nil, NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.25);
		NumberSequenceKeypoint.new(1, 0.75);
	}), 90)
	
	UI:Corner(NewWindow.MainButton, 8)

	NewWindow.MainButton.Activated:Connect(function()
		NewWindow.MainFrame.Visible = not NewWindow.MainFrame.Visible

		if NewWindow.MainFrame.Visible == true then
			TweenService:Create(BorderGradient, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Rotation = 90;
			}):Play()
		else
			TweenService:Create(BorderGradient, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Rotation = 135;
			}):Play()
		end
	end)
	
	if InputService.MouseEnabled == false then
		NewWindow.MainButton.Visible = true
	end
	
	-- Drag --
	
	NewWindow.DragFrame = Instance.new("Frame")
	NewWindow.DragFrame.Parent = NewWindow.MainFrame
	NewWindow.DragFrame.Name = "DragFrame"
	NewWindow.DragFrame.Size = UDim2.new(1, 0, 0, 25)
	NewWindow.DragFrame.BackgroundTransparency = 1
	
	local DragHovering = false
	local DragHolding = false
	local DragHoldPosition

	NewWindow.DragFrame.MouseEnter:Connect(function()
		DragHovering = true
	end)

	NewWindow.DragFrame.MouseLeave:Connect(function()
		DragHovering = false
	end)

	InputService.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 and DragHovering then
			DragHoldPosition = (InputService:GetMouseLocation() - NewWindow.MainFrame.AbsolutePosition) - (NewWindow.MainFrame.AbsoluteSize * NewWindow.MainFrame.AnchorPoint)
			DragHolding = true
		end
	end)

	InputService.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			DragHolding = false
		end
	end)

	local DragUDim = NewWindow.MainFrame.Position

	NewWindow.DragThread = InputService.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseMovement and NewWindow.MainFrame then
			if DragHolding == true then
				local DragPosition = InputService:GetMouseLocation() - DragHoldPosition + GuiService:GetGuiInset()
				DragUDim = UDim2.fromOffset(DragPosition.X, DragPosition.Y)
			end

			NewWindow.MainFrame.Position = NewWindow.MainFrame.Position:Lerp(DragUDim, 0.25)
		end
	end)
	
	-- Sounds

	NewWindow.HoverSound = Instance.new("Sound")
	NewWindow.HoverSound.Parent = NewWindow.UI
	NewWindow.HoverSound.Name = "HoverSound"
	NewWindow.HoverSound.SoundId = (NewWindow.Config.SoundIDs or {}).Hover or "rbxassetid://17208339919"
	NewWindow.HoverSound.Volume = 0.15

	NewWindow.TypeSound = Instance.new("Sound")
	NewWindow.TypeSound.Parent = NewWindow.UI
	NewWindow.TypeSound.Name = "TypeSound"
	NewWindow.TypeSound.SoundId = (NewWindow.Config.SoundIDs or {}).Type or "rbxassetid://9113142220"
	
	-- Notifications
	
	local NotificationPopupImage = Instance.new("ImageLabel")
	local NotificationPopupText = Instance.new("TextLabel")
	
	NewWindow.NotificationPopupFrame = Instance.new("Frame")
	NewWindow.NotificationPopupFrame.Parent = NewWindow.MainFrame
	NewWindow.NotificationPopupFrame.Name = "PopupFrame"
	NewWindow.NotificationPopupFrame.Position = UDim2.fromScale(0.5, 1)
	NewWindow.NotificationPopupFrame.Size = UDim2.fromOffset(200, 25)
	NewWindow.NotificationPopupFrame.AnchorPoint = Vector2.new(0.5, 0)
	NewWindow.NotificationPopupFrame.ZIndex = 100
	NewWindow.NotificationPopupFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	UI:Corner(NewWindow.NotificationPopupFrame, 4)
	UI:Border(NewWindow.NotificationPopupFrame, nil, Color3.fromRGB(65, 65, 65))
	
	NotificationPopupImage.Parent = NewWindow.NotificationPopupFrame
	NotificationPopupImage.Name = "NotificationImage"
	NotificationPopupImage.Position = UDim2.fromScale(0.025, 0.5)
	NotificationPopupImage.Size = UDim2.fromOffset(15, 15)
	NotificationPopupImage.AnchorPoint = Vector2.new(0, 0.5)
	NotificationPopupImage.BackgroundTransparency = 1
	NotificationPopupImage.Image = "rbxassetid://127056344849281"
	
	NotificationPopupText.Parent = NewWindow.NotificationPopupFrame
	NotificationPopupText.Name = "NotificationText"
	NotificationPopupText.Position = UDim2.fromScale(0.125, 0.5)
	NotificationPopupText.Size = UDim2.fromScale(0.85, 0.45)
	NotificationPopupText.AnchorPoint = Vector2.new(0, 0.5)
	NotificationPopupText.BackgroundTransparency = 1
	NotificationPopupText.Text = "Notification"
	NotificationPopupText.TextSize = 10
	NotificationPopupText.RichText = true
	NotificationPopupText.TextColor3 = Color3.new(1, 1, 1)
	NotificationPopupText.FontFace = Font.new(NewWindow.Config.MainFont or "rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)
	NotificationPopupText.TextXAlignment = Enum.TextXAlignment.Left
	NotificationPopupText.TextTruncate = Enum.TextTruncate.AtEnd
	
	NewWindow.NotificationContainer = Instance.new("Frame")
	NewWindow.NotificationContainer.Parent = NewWindow.UI
	NewWindow.NotificationContainer.Name = "NotificationContainer"
	NewWindow.NotificationContainer.Position = UDim2.new(1, -210, 0.5, 0)
	NewWindow.NotificationContainer.Size = UDim2.new(0, 200, 0.95, 0)
	NewWindow.NotificationContainer.AnchorPoint = Vector2.new(0, 0.5)
	NewWindow.NotificationContainer.BackgroundTransparency = 1
	
	-- Home
	
	local WallpaperImage = Instance.new("ImageLabel")
	local TitleText = Instance.new("TextLabel")
	local ProfileIconImage = Instance.new("ImageLabel")
	local ProfileNameText = Instance.new("TextLabel")
	local DescriptionText = Instance.new("TextLabel")
	local KeyBox = Instance.new("TextBox")
	local CopyButton = Instance.new("ImageButton")
	local ContinueButton = Instance.new("TextButton")
	
	WallpaperImage.Parent = NewWindow.MainFrame
	WallpaperImage.Name = "WallpaperImage"
	WallpaperImage.Position = UDim2.fromScale(0, 0)
	WallpaperImage.Size = UDim2.fromScale(1, 0.65)
	WallpaperImage.BackgroundTransparency = 1
	WallpaperImage.Image = NewWindow.Config.WallpaperID or "rbxassetid://103934428356480"
	WallpaperImage.ImageRectSize = WallpaperImage.AbsoluteSize * 2
	WallpaperImage.ImageRectOffset = Vector2.new(0, 30)
	WallpaperImage.ScaleType = Enum.ScaleType.Crop
	WallpaperImage.ResampleMode = Enum.ResamplerMode.Pixelated
	UI:Gradient(WallpaperImage, ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1));
		ColorSequenceKeypoint.new(0.75, Color3.new(1, 1, 1));
		ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0));
	}), nil, 90)
	UI:Corner(WallpaperImage, 12)
	
	TitleText.Parent = NewWindow.MainFrame
	TitleText.Name = "TitleText"
	TitleText.Position = UDim2.fromScale(0.5, 0.02)
	TitleText.Size = UDim2.new(0.35, 0, 0, 15)
	TitleText.AnchorPoint = Vector2.new(0.5, 0)
	TitleText.ZIndex = 2
	TitleText.BackgroundTransparency = 1
	TitleText.Text = "Novura: "..(NewWindow.Config.Name or "UI")
	TitleText.TextScaled = true
	TitleText.FontFace = Font.new(NewWindow.Config.MainFont or "rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)
	TitleText.TextColor3 = Color3.new(1, 1, 1)
	TitleText.TextStrokeTransparency = 0.85
	Effects:Underline(TitleText, 5)
	
	ProfileIconImage.Parent = NewWindow.MainFrame
	ProfileIconImage.Name = "AvatarImage"
	ProfileIconImage.Position = UDim2.fromScale(0.5, 0.15)
	ProfileIconImage.Size = UDim2.fromOffset(75, 75)
	ProfileIconImage.AnchorPoint = Vector2.new(0.5, 0)
	ProfileIconImage.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	ProfileIconImage.Image = PlayerService:GetUserThumbnailAsync(User.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size180x180)
	ProfileIconImage.ResampleMode = Enum.ResamplerMode.Pixelated
	UI:Corner(ProfileIconImage, 75)
	UI:Border(ProfileIconImage, 1, Color3.fromRGB(50, 50, 50))
	
	ProfileNameText.Parent = NewWindow.MainFrame
	ProfileNameText.Name = "NameText"
	ProfileNameText.Position = UDim2.fromScale(0.5, 0.425)
	ProfileNameText.Size = UDim2.fromOffset(175, 17)
	ProfileNameText.AnchorPoint = Vector2.new(0.5, 0)
	ProfileNameText.BackgroundTransparency = 1
	ProfileNameText.TextScaled = true
	ProfileNameText.FontFace = Font.new(NewWindow.Config.MainFont or "rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)
	ProfileNameText.TextColor3 = Color3.new(1, 1, 1)
	
	if User.DisplayName == User.Name then
		ProfileNameText.Text = "@"..User.Name
	else
		ProfileNameText.Text = User.DisplayName.." | (@"..User.Name..")"
	end
	
	DescriptionText.Parent = NewWindow.MainFrame
	DescriptionText.Name = "DescriptionText"
	DescriptionText.Position = UDim2.fromScale(0.5, 0.5)
	DescriptionText.Size = UDim2.fromScale(0.75, 0.135)
	DescriptionText.AnchorPoint = Vector2.new(0.5, 0)
	DescriptionText.BackgroundTransparency = 1
	DescriptionText.Text = NewWindow.Config.Description or "Novura UI library made by novakool, join our discord server at: https://discord.gg/gucEWABwKC!"
	DescriptionText.TextSize = 13
	DescriptionText.TextWrapped = true
	DescriptionText.FontFace = Font.new(NewWindow.Config.MainFont or "rbxasset://fonts/families/Arimo.json")
	DescriptionText.TextColor3 = Color3.fromRGB(190, 190, 190)
	DescriptionText.TextYAlignment = Enum.TextYAlignment.Top
	Effects:Underline(DescriptionText, 8, Color3.new(1, 1, 1), 0.8)
	
	ContinueButton.Parent = NewWindow.MainFrame
	ContinueButton.Name = "ContinueButton"
	ContinueButton.Position = UDim2.fromScale(0.5, 0.85)
	ContinueButton.Size = UDim2.fromOffset(100, 25)
	ContinueButton.AnchorPoint = Vector2.new(0.5, 0)
	ContinueButton.BackgroundColor3 = Color3.new(1, 1, 1)
	ContinueButton.AutoButtonColor = false
	ContinueButton.Text = "Continue"
	ContinueButton.TextSize = 10
	ContinueButton.FontFace = Font.new(NewWindow.Config.MainFont or "rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)
	UI:Corner(ContinueButton, 25)
	
	ContinueButton.MouseEnter:Connect(function()
		TweenService:Create(ContinueButton, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
			Size = UDim2.fromOffset(105, 30);
		}):Play()

		NewWindow.HoverSound:Play()
	end)

	ContinueButton.MouseLeave:Connect(function()
		TweenService:Create(ContinueButton, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
			Size = UDim2.fromOffset(100, 25);
		}):Play()
	end)

	ContinueButton.Activated:Connect(function()
		ContinueButton.Position = UDim2.new(0.5, 0, 0.85, 1)

		task.wait(0.05)

		ContinueButton.Position = UDim2.fromScale(0.5, 0.85)
	end)
	
	-- Key System --
	
	KeyBox.Parent = NewWindow.MainFrame
	KeyBox.Name = "KeyBox"
	KeyBox.Position = UDim2.fromScale(0.5, 0.725)
	KeyBox.Size = UDim2.fromOffset(125, 25)
	KeyBox.AnchorPoint = Vector2.new(0.5, 0)
	KeyBox.Visible = false
	KeyBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	KeyBox.Text = ""
	KeyBox.TextSize = 10
	KeyBox.ClearTextOnFocus = false
	KeyBox.FontFace = Font.new(Config.MainFont or "rbxasset://fonts/families/Arimo.json")
	KeyBox.TextColor3 = Color3.new(1, 1, 1)
	KeyBox.TextTruncate = Enum.TextTruncate.AtEnd
	KeyBox.PlaceholderText = "Key"

	local BoxBorder = UI:Border(KeyBox, 1, Color3.fromRGB(65, 65, 65))
	local BorderGradient = UI:Gradient(BoxBorder, nil, NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0);
		NumberSequenceKeypoint.new(1, 0.5);
	}), 135)
	UI:Corner(KeyBox, 6)
	
	KeyBox.Focused:Connect(function()
		KeyBox.PlaceholderText = ""

		TweenService:Create(BorderGradient, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
			Rotation = 90;
		}):Play()
	end)

	KeyBox.FocusLost:Connect(function()
		if KeyBox.Text == "" then
			KeyBox.PlaceholderText = "Key"

			TweenService:Create(BorderGradient, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
				Rotation = 135;
			}):Play()
		end
	end)
	
	KeyBox:GetPropertyChangedSignal("Text"):Connect(function()
		if KeyBox.Text ~= "" then
			NewWindow.TypeSound:Play()
		end
	end)
	
	CopyButton.Parent = NewWindow.MainFrame
	CopyButton.Name = "CopyButton"
	CopyButton.Position = UDim2.fromScale(0.6375, 0.74)
	CopyButton.Size = UDim2.fromOffset(15, 15)
	CopyButton.Visible = false
	CopyButton.BackgroundTransparency = 1
	CopyButton.Image = "rbxassetid://77677390562904"

	CopyButton.Activated:Connect(function()
		if Clipboard then
			Clipboard(Config.KeySystem.Link)

			NewWindow:PopupNotify('Copied key link!', 2)
		else
			NewWindow:PopupNotify('<font color="rgb(255,75,75)">Failed</font> to copy key link.', 2)
		end
	end)
	
	if NewWindow.Config.KeySystem then
		KeyBox.Visible = true
		CopyButton.Visible = true
	end
	
	ContinueButton.Activated:Connect(function(Input, Count)
		if NewWindow.Config.KeySystem then
			if KeyBox.Text == NewWindow.Config.KeySystem.Key then
				NewWindow:PopupNotify('Key was <font color="rgb(75,255,75)">correct</font>!', 2)

				NewWindow.HomeLocked = false
			else
				NewWindow:PopupNotify('Key was <font color="rgb(255,75,75)">incorrect</font>!', 2)
			end
		else
			NewWindow.HomeLocked = false
		end
	end)
	
	-- Animations --
	
	Animations:SlideDown(TitleText)
	Animations:SlideDown(ProfileIconImage)
	Animations:SlideDown(ProfileNameText)
	Animations:SlideDown(DescriptionText)
	Animations:SlideLeft(KeyBox, 0.25)
	Animations:SlideLeft(CopyButton, 0.35)
	Animations:SlideRight(ContinueButton, 0.25)
	
	ContentService:PreloadAsync({NewWindow.Config.WallpaperID or "rbxassetid://103934428356480"})

	NewWindow.UI.Enabled = true
	
	repeat
		task.wait(0.1)
	until NewWindow.HomeLocked == false
	
	Animations:SlideDown(TitleText, nil, true)
	Animations:SlideDown(ProfileIconImage, nil, true)
	Animations:SlideDown(ProfileNameText, nil, true)
	Animations:SlideDown(DescriptionText, nil, true)
	Animations:SlideUp(KeyBox, nil, true)
	Animations:SlideUp(CopyButton, nil, true)
	Animations:SlideUp(ContinueButton, nil, true)
	
	TweenService:Create(WallpaperImage, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		ImageTransparency = 1;
		ImageRectOffset = Vector2.new(0, 50);
	}):Play()
	
	task.wait(0.25)
	
	
	
	-- Menu
	
	local DividerLine = Instance.new("Frame")
	local ProfileIconImage = Instance.new("ImageLabel")
	local ProfileNameText = Instance.new("TextLabel")
	local ProfileTagText = Instance.new("TextLabel")
	local ScriptIconImage = Instance.new("ImageLabel")
	local ScriptNameText = Instance.new("TextLabel")
	local ScriptCreatorText = Instance.new("TextLabel")
	
	NewWindow.MenuFrame = Instance.new("Frame")
	NewWindow.MenuFrame.Parent = NewWindow.MainFrame
	NewWindow.MenuFrame.Name = "MenuFrame"
	NewWindow.MenuFrame.Position = UDim2.new(0, 7, 0.5, 0)
	NewWindow.MenuFrame.Size = UDim2.fromScale(0.25, 0.95)
	NewWindow.MenuFrame.AnchorPoint = Vector2.new(0, 0.5)
	NewWindow.MenuFrame.Visible = false
	NewWindow.MenuFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	
	local FrameBorder = UI:Border(NewWindow.MenuFrame, 1, Color3.fromRGB(45, 45, 45))
	UI:Gradient(FrameBorder, nil, NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0);
		NumberSequenceKeypoint.new(1, 0.5);
	}), 135)
	UI:Corner(NewWindow.MenuFrame, 16)
	
	DividerLine.Parent = NewWindow.MenuFrame
	DividerLine.Name = "DividerLine"
	DividerLine.Position = UDim2.new(0.5, 0, 1, -45)
	DividerLine.Size = UDim2.new(0.9, 0, 0, 1)
	DividerLine.AnchorPoint = Vector2.new(0.5, 0)
	DividerLine.BackgroundColor3 = Color3.new(1, 1, 1)
	DividerLine.BackgroundTransparency = 0.9
	
	local H, S, V = AvatarColors[(User.UserId * 6523) % 5 + 1]:ToHSV()
	
	ProfileIconImage.Parent = NewWindow.MenuFrame
	ProfileIconImage.Name = "ProfileIconImage"
	ProfileIconImage.Position = UDim2.new(0, 7, 1, -37)
	ProfileIconImage.Size = UDim2.fromOffset(30, 30)
	ProfileIconImage.BackgroundColor3 = Color3.fromHSV(H, S, V + 0.75)
	ProfileIconImage.Image = PlayerService:GetUserThumbnailAsync(User.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size60x60)
	ProfileIconImage.ResampleMode = Enum.ResamplerMode.Pixelated
	UI:Corner(ProfileIconImage, 4)
	
	ProfileNameText.Parent = NewWindow.MenuFrame
	ProfileNameText.Name = "ProfileNameText"
	ProfileNameText.Position = UDim2.new(0, 42, 1, -32)
	ProfileNameText.Size = UDim2.new(0.6, 0, 0, 12)
	ProfileNameText.BackgroundTransparency = 1
	ProfileNameText.Text = User.DisplayName
	ProfileNameText.TextSize = 12
	ProfileNameText.TextColor3 = Color3.new(1, 1, 1)
	ProfileNameText.FontFace = Font.new(NewWindow.Config.MainFont or "rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)
	ProfileNameText.TextXAlignment = Enum.TextXAlignment.Left
	ProfileNameText.TextTruncate = Enum.TextTruncate.AtEnd
	
	ProfileTagText.Parent = NewWindow.MenuFrame
	ProfileTagText.Name = "ProfileTagText"
	ProfileTagText.Position = UDim2.new(0, 42, 1, -20)
	ProfileTagText.Size = UDim2.new(0.6, 0, 0, 10)
	ProfileTagText.BackgroundTransparency = 1
	ProfileTagText.Text = "@"..User.Name
	ProfileTagText.TextSize = 10
	ProfileTagText.FontFace = Font.new(NewWindow.Config.MainFont or "rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)
	ProfileTagText.TextColor3 = Color3.fromRGB(190, 190, 190)
	ProfileTagText.TextXAlignment = Enum.TextXAlignment.Left
	ProfileTagText.TextTruncate = Enum.TextTruncate.AtEnd
	
	local ScriptIcon = NewWindow.Config.Icon

	if ScriptIcon == nil then
		pcall(function()
			ScriptIcon = "rbxassetid://"..MarketService:GetProductInfo(NewWindow.Config.GameID or game.PlaceId).IconImageAssetId
		end)
	end
	
	ScriptIconImage.Parent = NewWindow.MenuFrame
	ScriptIconImage.Name = "ScriptIconImage"
	ScriptIconImage.Position = UDim2.fromOffset(10, 10)
	ScriptIconImage.Size = UDim2.fromOffset(30, 30)
	ScriptIconImage.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	ScriptIconImage.ResampleMode = Enum.ResamplerMode.Pixelated
	UI:Corner(ScriptIconImage, 4)
	
	if ScriptIcon then
		ScriptIconImage.Image = ScriptIcon
	end
	
	ScriptNameText.Parent = NewWindow.MenuFrame
	ScriptNameText.Name = "ScriptNameText"
	ScriptNameText.Position = UDim2.fromOffset(45, 17)
	ScriptNameText.Size = UDim2.new(0.55, 0, 0, 11)
	ScriptNameText.BackgroundTransparency = 1
	ScriptNameText.Text = NewWindow.Config.Name or "Novura"
	ScriptNameText.TextSize = 11
	ScriptNameText.FontFace = Font.new(NewWindow.Config.MainFont or "rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)
	ScriptNameText.TextColor3 = Color3.new(1, 1, 1)
	ScriptNameText.TextXAlignment = Enum.TextXAlignment.Left
	
	ScriptCreatorText.Parent = NewWindow.MenuFrame
	ScriptCreatorText.Name = "ScriptCreatorText"
	ScriptCreatorText.Position = UDim2.fromOffset(45, 27)
	ScriptCreatorText.Size = UDim2.new(0.55, 0, 0, 10)
	ScriptCreatorText.BackgroundTransparency = 1
	ScriptCreatorText.Text = "By "..(NewWindow.Config.Creator or "novakool")
	ScriptCreatorText.TextSize = 9
	ScriptCreatorText.FontFace = Font.new(NewWindow.Config.MainFont or "rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)
	ScriptCreatorText.TextColor3 = Color3.fromRGB(190, 190, 190)
	ScriptCreatorText.TextXAlignment = Enum.TextXAlignment.Left
	ScriptCreatorText.TextTruncate = Enum.TextTruncate.AtEnd
	
	NewWindow.MenuFrame.Visible = true
	
	-- Tabs
	
	NewWindow.Tabs = {}
	
	NewWindow.TabTitleText = Instance.new("TextLabel")
	NewWindow.TabTitleText.Parent = NewWindow.MainFrame
	NewWindow.TabTitleText.Name = "TabText"
	NewWindow.TabTitleText.Position = UDim2.fromScale(0.53, 0.02)
	NewWindow.TabTitleText.Size = UDim2.fromOffset(100, 12)
	NewWindow.TabTitleText.BackgroundTransparency = 1
	NewWindow.TabTitleText.Text = "Tab"
	NewWindow.TabTitleText.TextScaled = true
	NewWindow.TabTitleText.TextColor3 = Color3.new(1, 1, 1)
	NewWindow.TabTitleText.FontFace = Font.new(NewWindow.Config.MainFont or "rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)
	Effects:Underline(NewWindow.TabTitleText, 5, Color3.fromRGB(75, 75, 75))
	
	local TabList = Instance.new("UIListLayout")
	NewWindow.TabContainer = Instance.new("ScrollingFrame")
	NewWindow.TabContainer.Parent = NewWindow.MenuFrame
	NewWindow.TabContainer.Name = "TabContainer"
	NewWindow.TabContainer.Position = UDim2.new(0, 10, 0, 50)
	NewWindow.TabContainer.Size = UDim2.fromScale(0.85, 0.665)
	NewWindow.TabContainer.BackgroundTransparency = 1
	NewWindow.TabContainer.BorderSizePixel = 0
	NewWindow.TabContainer.CanvasSize = UDim2.fromOffset(0, 20)
	NewWindow.TabContainer.ScrollBarThickness = 2
	NewWindow.TabContainer.ScrollBarImageTransparency = 0.85
	NewWindow.TabContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
	
	TabList.Parent = NewWindow.TabContainer
	TabList.Padding = UDim.new(0, 5)
	TabList.VerticalAlignment = Enum.VerticalAlignment.Top
	TabList.HorizontalAlignment = Enum.HorizontalAlignment.Left
	TabList.SortOrder = Enum.SortOrder.LayoutOrder
	
	NewWindow.PageContainer = Instance.new("Frame")
	NewWindow.PageContainer.Parent = NewWindow.MainFrame
	NewWindow.PageContainer.Name = "PageContainer"
	NewWindow.PageContainer.Position = UDim2.fromScale(0.285, 0.11)
	NewWindow.PageContainer.Size = UDim2.fromScale(0.69, 0.85)
	NewWindow.PageContainer.BackgroundTransparency = 1
	
	-- Animations --
	
	Animations:SlideRight(NewWindow.MenuFrame)
	Animations:SlideLeft(NewWindow.PageContainer)
	Animations:SlideDown(NewWindow.TabTitleText)
	
	return NewWindow
end

function WindowClass:NewTab(Config)
	local NewTab = setmetatable({}, TabClass)
	
	NewTab.WindowConfig = self.Config
	NewTab.Config = Config or {}
	NewTab.HoverSound = self.HoverSound
	NewTab.TypeSound = self.TypeSound
	
	NewTab.Name = NewTab.Config.Name or "Tab"
	NewTab.Selected = false
	NewTab.Actions = {}
	NewTab.Text = {}
	
	-- Tab
	
	local TabIconImage = Instance.new("ImageLabel")
	local TabNameText = Instance.new("TextLabel")

	NewTab.TabButton = Instance.new("TextButton")
	NewTab.TabButton.Parent = self.TabContainer
	NewTab.TabButton.Name = (NewTab.Config.Name or "Tab").."Button"
	NewTab.TabButton.Size = UDim2.new(0.95, 0, 0, 25)
	NewTab.TabButton.AutoButtonColor = false
	NewTab.TabButton.Text = ""
	NewTab.TabButton.BackgroundColor3 = Color3.new(1, 1, 1)
	NewTab.TabButton.BackgroundTransparency = 1
	UI:Corner(NewTab.TabButton, 4)
	
	TabIconImage.Parent = NewTab.TabButton
	TabIconImage.Name = "TabImage"
	TabIconImage.Position = UDim2.new(0, 5, 0.5, 0)
	TabIconImage.Size = UDim2.new(0, 13, 0, 13)
	TabIconImage.AnchorPoint = Vector2.new(0, 0.5)
	TabIconImage.Image = NewTab.Config.Icon or "rbxassetid://18132434045"
	TabIconImage.BackgroundTransparency = 1

	TabNameText.Parent = NewTab.TabButton
	TabNameText.Name = "NameText"
	TabNameText.Position = UDim2.fromOffset(25, 0)
	TabNameText.Size = UDim2.new(1, -25, 1, 0)
	TabNameText.BackgroundTransparency = 1
	TabNameText.Text = NewTab.Config.Name or "Tab"
	TabNameText.FontFace = Font.new(NewTab.WindowConfig.MainFont or "rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)
	TabNameText.TextSize = 12
	TabNameText.TextColor3 = Color3.new(1, 1, 1)
	TabNameText.TextXAlignment = Enum.TextXAlignment.Left
	
	
	-- Page
	
	local ActionList = Instance.new("UIListLayout")
	NewTab.PageFrame = Instance.new("ScrollingFrame")
	NewTab.PageFrame.Parent = self.PageContainer
	NewTab.PageFrame.Name = (NewTab.Config.Name or "Tab").."Frame"
	NewTab.PageFrame.Size = UDim2.fromScale(1, 1)
	NewTab.PageFrame.Visible = false
	NewTab.PageFrame.BackgroundTransparency = 1
	NewTab.PageFrame.BorderSizePixel = 0
	NewTab.PageFrame.ScrollBarThickness = 6
	NewTab.PageFrame.ScrollBarImageTransparency = 0.8
	NewTab.PageFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

	ActionList.Parent = NewTab.PageFrame
	ActionList.Padding = UDim.new(0, 5)
	ActionList.VerticalAlignment = Enum.VerticalAlignment.Top
	ActionList.HorizontalAlignment = Enum.HorizontalAlignment.Center
	ActionList.SortOrder = Enum.SortOrder.LayoutOrder
	
	NewTab.TabButton.MouseEnter:Connect(function()
		if NewTab.Selected == false then
			TweenService:Create(NewTab.TabButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
				BackgroundTransparency = 0.9;
			}):Play()
		else
			TweenService:Create(NewTab.TabButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
				BackgroundTransparency = 0.75;
			}):Play()
		end
	end)
	
	NewTab.TabButton.MouseLeave:Connect(function()
		if NewTab.Selected == false then
			TweenService:Create(NewTab.TabButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
				BackgroundTransparency = 1;
			}):Play()
		else
			TweenService:Create(NewTab.TabButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
				BackgroundTransparency = 0.8;
			}):Play()
		end
	end)
	
	NewTab.TabButton.Activated:Connect(function()
		self:ChangeTab(NewTab)
	end)
	
	if #self.Tabs == 0 then
		self:ChangeTab(NewTab)
	end
	
	table.insert(self.Tabs, NewTab)
	
	return NewTab
end

function WindowClass:ChangeTab(NewTab)
	for TabI, Tab in pairs(self.Tabs) do
		TweenService:Create(Tab.TabButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
			BackgroundTransparency = 1;
		}):Play()
		
		Tab.Selected = false
		Tab.PageFrame.Visible = false
	end
	
	self.TabTitleText.Text = NewTab.Name
	NewTab.Selected = true
	NewTab.PageFrame.Visible = true
	
	TweenService:Create(NewTab.TabButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
		BackgroundTransparency = 0.8;
	}):Play()
end

function WindowClass:Notify(Title, Description, Time, Options)
	local NotificationFrame = Instance.new("Frame")
	local TitleText = Instance.new("TextLabel")
	local DividerLine = Instance.new("Frame")
	local ProgressLine = Instance.new("Frame")
	local DescriptionText = Instance.new("TextLabel")
	local OptionContainer = Instance.new("Frame")
	
	NotificationFrame.Parent = self.NotificationContainer
	NotificationFrame.Name = "NotificationFrame"
	NotificationFrame.Position = UDim2.new(0, 0, 1, -125)
	NotificationFrame.Size = UDim2.new(1, 0, 0, 125)
	NotificationFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	NotificationFrame.ClipsDescendants = true
	NotificationFrame:SetAttribute("TweenPosition", UDim2.new(0, 0, 1, -125))
	
	local FrameBorder = UI:Border(NotificationFrame, 1, Color3.fromRGB(125, 125, 125))
	UI:Gradient(FrameBorder, nil, NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0);
		NumberSequenceKeypoint.new(1, 0.5);
	}), 135)
	UI:Corner(NotificationFrame, 6)
	
	TitleText.Parent = NotificationFrame
	TitleText.Name = "TitleText"
	TitleText.Position = UDim2.fromOffset(0, 6)
	TitleText.Size = UDim2.new(1, 0, 0, 15)
	TitleText.BackgroundTransparency = 1
	TitleText.Text = Title or "Title"
	TitleText.FontFace = Font.new(self.Config.MainFont or "rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)
	TitleText.TextSize = 12
	TitleText.TextColor3 = Color3.new(1, 1, 1)
	
	DividerLine.Parent = TitleText
	DividerLine.Name = "DividerLine"
	DividerLine.Position = UDim2.new(0, 0, 1, 5)
	DividerLine.Size = UDim2.new(1, 0, 0, 1)
	DividerLine.BackgroundTransparency = 0.75
	
	ProgressLine.Parent = DividerLine
	ProgressLine.Name = "ProgressLine"
	ProgressLine.Size = UDim2.fromScale(1, 1)
	ProgressLine.BackgroundTransparency = 0.75
	
	DescriptionText.Parent = NotificationFrame
	DescriptionText.Name = "DescriptionText"
	DescriptionText.Position = UDim2.new(0.5, 0, 0, 32)
	DescriptionText.Size = UDim2.new(1, -10, 1, -55)
	DescriptionText.AnchorPoint = Vector2.new(0.5, 0)
	DescriptionText.BackgroundTransparency = 1
	DescriptionText.Text = Description or "Description"
	DescriptionText.TextWrapped = true
	DescriptionText.FontFace = Font.new(self.Config.MainFont or "rbxasset://fonts/families/Arimo.json")
	DescriptionText.TextSize = 13
	DescriptionText.TextColor3 = Color3.fromRGB(200, 200, 200)
	DescriptionText.TextYAlignment = Enum.TextYAlignment.Top
	
	local UIList = Instance.new("UIListLayout")
	OptionContainer.Parent = NotificationFrame
	OptionContainer.Name = "OptionContainer"
	OptionContainer.Position = UDim2.new(0, 0, 1, -20)
	OptionContainer.Size = UDim2.new(1, 0, 0, 20)
	OptionContainer.BackgroundTransparency = 1
	
	UIList.Parent = OptionContainer
	UIList.FillDirection = Enum.FillDirection.Horizontal
	
	-- Options --
	
	if Options then
		local OptionCount = 0

		for OptionName, OptionAction in pairs(Options) do
			OptionCount = OptionCount + 1
		end

		for OptionName, OptionAction in pairs(Options) do
			local NewOptionButton = Instance.new("TextButton")
			local DividerLine = Instance.new("Frame")

			NewOptionButton.Parent = OptionContainer
			NewOptionButton.Name = "OptionButton"
			NewOptionButton.Size = UDim2.fromScale(1 / OptionCount, 1)
			NewOptionButton.BackgroundTransparency = 1
			NewOptionButton.Text = OptionName
			NewOptionButton.TextSize = 12
			NewOptionButton.FontFace = Font.new(self.Config.MainFont or "rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)
			NewOptionButton.TextColor3 = Color3.new(1, 1, 1)

			NewOptionButton.Activated:Connect(function()
				NewOptionButton.Active = false

				OptionAction()

				Animations:SlideLeft(NotificationFrame, nil, true, TweenInfo.new(0.25, Enum.EasingStyle.Quad))

				task.wait(0.25)

				NotificationFrame:Destroy()

				for NotificationI, Notification in pairs(self.NotificationContainer:GetChildren()) do
					if Notification:IsA("Frame") and Notification ~= NotificationFrame and Notification.AbsolutePosition.Y < NotificationFrame.AbsolutePosition.Y then
						local TweenPosition = Notification:GetAttribute("TweenPosition")
						Notification:SetAttribute("TweenPosition", UDim2.new(0, 0, TweenPosition.Y.Scale, TweenPosition.Y.Offset + 135))

						TweenService:Create(Notification, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
							Position = UDim2.new(0, 0, TweenPosition.Y.Scale, TweenPosition.Y.Offset + 135);
						}):Play()
					end
				end
			end)

			DividerLine.Parent = NewOptionButton
			DividerLine.Name = "DividerLine"
			DividerLine.Position = UDim2.fromScale(1, 0.5)
			DividerLine.Size = UDim2.new(0, 1, 0.5, 0)
			DividerLine.AnchorPoint = Vector2.new(0, 0.5)
			DividerLine.BackgroundTransparency = 0.75
			DividerLine.BorderSizePixel = 0
		end
	end
	
	-- Animations --
	
	for NotificationI, Notification in pairs(self.NotificationContainer:GetChildren()) do
		if Notification:IsA("Frame") and Notification ~= NotificationFrame then
			local TweenPosition = Notification:GetAttribute("TweenPosition")
			Notification:SetAttribute("TweenPosition", UDim2.new(0, 0, TweenPosition.Y.Scale, TweenPosition.Y.Offset - 135))
			
			TweenService:Create(Notification, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Position = UDim2.new(0, 0, TweenPosition.Y.Scale, TweenPosition.Y.Offset - 135);
			}):Play()
		end
	end
	
	Animations:SlideLeft(NotificationFrame, nil, nil, TweenInfo.new(0.4, Enum.EasingStyle.Quad))
	
	task.spawn(function()
		TweenService:Create(ProgressLine, TweenInfo.new(Time or 3, Enum.EasingStyle.Linear), {
			Size = UDim2.fromScale(0, 1);
		}):Play()
		
		task.wait(Time or 3)
		
		Animations:SlideLeft(NotificationFrame, nil, true, TweenInfo.new(0.4, Enum.EasingStyle.Quad))
		
		task.wait(0.25)
		
		NotificationFrame:Destroy()
	end)
end

function WindowClass:PopupNotify(Text, Time)
	TweenService:Create(self.NotificationPopupFrame, TweenInfo.new(0.5, Enum.EasingStyle.Cubic), {
		Position = UDim2.new(0.5, 0, 1, -35);
	}):Play()
	
	if self.QuickNotifyThread then
		task.cancel(self.QuickNotifyThread)
	end
	
	self.QuickNotifyThread = task.spawn(function()
		self.NotificationPopupFrame.Position = UDim2.fromScale(0.5, 1);
		self.NotificationPopupFrame.NotificationText.Text = Text
		
		task.wait(0.5 + (Time or 3))

		TweenService:Create(self.NotificationPopupFrame, TweenInfo.new(0.35, Enum.EasingStyle.Cubic), {
			Position = UDim2.fromScale(0.5, 1);
		}):Play()
	end)
end

function WindowClass:Destroy()
	self.DragThread:Disconnect()
	self.UI:Destroy()
end


-- Tab Class

TabClass.__index = TabClass

function TabClass:NewButton(Config)
	local NewButton = setmetatable({}, ButtonClass)
	
	NewButton.Config = Config or {}
	NewButton.Type = "Button"
	NewButton.Action = NewButton.Config.Action
	NewButton.Hovering = false
	NewButton.OriginalColor = Color3.fromRGB(40, 40, 40)
	
	-- Button
	
	local ActionText = Instance.new("TextLabel")
	local ActionImage = Instance.new("ImageLabel")
	
	NewButton.ActionButton = Instance.new("TextButton")
	NewButton.ActionButton.Parent = self.PageFrame
	NewButton.ActionButton.Name = "ActionButton"
	NewButton.ActionButton.Size = UDim2.new(0.9, 0, 0, 35)
	NewButton.ActionButton.BackgroundColor3 = NewButton.OriginalColor
	NewButton.ActionButton.AutoButtonColor = false
	NewButton.ActionButton.Text = ""
	UI:Corner(NewButton.ActionButton, 4)
	
	NewButton.ActionButton.MouseEnter:Connect(function()
		local H, S, V = NewButton.OriginalColor:ToHSV()
		
		NewButton.Hovering = true
		
		TweenService:Create(NewButton.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
			BackgroundColor3 = Color3.fromHSV(H, S, V - 0.02)
		}):Play()
	end)
	
	NewButton.ActionButton.MouseLeave:Connect(function()
		NewButton.Hovering = false
		
		TweenService:Create(NewButton.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
			BackgroundColor3 = NewButton.OriginalColor;
		}):Play()
	end)
	
	NewButton.ActionButton.Activated:Connect(function(Input, Count)
		local H, S, V = NewButton.OriginalColor:ToHSV()
		
		TweenService:Create(NewButton.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
			BackgroundColor3 = Color3.fromHSV(H, S, V - 0.04)
		}):Play()
		
		if NewButton.Action then
			task.spawn(function()
				NewButton.Action(Count)
			end)
		end
		
		task.wait(0.25)
		
		if NewButton.Hovering == true then
			TweenService:Create(NewButton.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
				BackgroundColor3 = Color3.fromHSV(H, S, V - 0.02)
			}):Play()
		else
			TweenService:Create(NewButton.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
				BackgroundColor3 = NewButton.OriginalColor;
			}):Play()
		end
	end)
	
	ActionText.Parent = NewButton.ActionButton
	ActionText.Name = "ActionText"
	ActionText.Position = UDim2.new(0, 10, 0.5, 0)
	ActionText.Size = UDim2.new(1, -50, 0.5, 0)
	ActionText.AnchorPoint = Vector2.new(0, 0.5)
	ActionText.BackgroundTransparency = 1
	ActionText.Text = NewButton.Config.Name or "Action"
	ActionText.TextSize = 14
	ActionText.FontFace = Font.new(self.WindowConfig.MainFont or "rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)
	ActionText.TextColor3 = Color3.new(1, 1, 1)
	ActionText.TextXAlignment = Enum.TextXAlignment.Left
	ActionText.TextTruncate = Enum.TextTruncate.AtEnd

	ActionImage.Parent = NewButton.ActionButton
	ActionImage.Name = "ActionImage"
	ActionImage.Position = UDim2.new(1, -30, 0.5, 0)
	ActionImage.Size = UDim2.fromOffset(20, 20)
	ActionImage.AnchorPoint = Vector2.new(0, 0.5)
	ActionImage.BackgroundTransparency = 1
	ActionImage.Image = "rbxassetid://116127579017115"
	ActionImage.ImageTransparency = 0.9
	
	table.insert(self.Actions, NewButton)
	
	return NewButton
end

function TabClass:NewToggle(Config)
	local NewToggle = setmetatable({}, ToggleClass)
	
	NewToggle.Config = Config or {}
	NewToggle.Type = "Toggle"
	NewToggle.Action = NewToggle.Config.Action
	NewToggle.Value = NewToggle.Config.Value or false
	NewToggle.Hovering = false
	NewToggle.OriginalColor = Color3.fromRGB(40, 40, 40)
	
	-- Toggle
	
	local ActionText = Instance.new("TextLabel")
	
	NewToggle.ActionButton = Instance.new("TextButton")
	NewToggle.ActionButton.Parent = self.PageFrame
	NewToggle.ActionButton.Name = "ActionToggle"
	NewToggle.ActionButton.Size = UDim2.new(0.9, 0, 0, 35)
	NewToggle.ActionButton.BackgroundColor3 = NewToggle.OriginalColor
	NewToggle.ActionButton.AutoButtonColor = false
	NewToggle.ActionButton.Text = ""
	UI:Corner(NewToggle.ActionButton, 4)
	
	NewToggle.ActionButton.MouseEnter:Connect(function()
		local H, S, V = NewToggle.OriginalColor:ToHSV()

		NewToggle.Hovering = true

		TweenService:Create(NewToggle.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
			BackgroundColor3 = Color3.fromHSV(H, S, V - 0.02)
		}):Play()
	end)

	NewToggle.ActionButton.MouseLeave:Connect(function()
		NewToggle.Hovering = false

		TweenService:Create(NewToggle.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
			BackgroundColor3 = NewToggle.OriginalColor;
		}):Play()
	end)
	
	ActionText.Parent = NewToggle.ActionButton
	ActionText.Name = "ActionText"
	ActionText.Position = UDim2.new(0, 10, 0.5, 0)
	ActionText.Size = UDim2.new(1, -50, 0.5, 0)
	ActionText.AnchorPoint = Vector2.new(0, 0.5)
	ActionText.BackgroundTransparency = 1
	ActionText.Text = NewToggle.Config.Name or "Action"
	ActionText.TextSize = 14
	ActionText.FontFace = Font.new(self.WindowConfig.MainFont or "rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)
	ActionText.TextColor3 = Color3.new(1, 1, 1)
	ActionText.TextXAlignment = Enum.TextXAlignment.Left
	ActionText.TextTruncate = Enum.TextTruncate.AtEnd
	
	NewToggle.ToggleButton = Instance.new("TextButton")
	NewToggle.ToggleButton.Parent = NewToggle.ActionButton
	NewToggle.ToggleButton.Name = "ToggleButton"
	NewToggle.ToggleButton.Position = UDim2.new(1, -30, 0.5, 0)
	NewToggle.ToggleButton.Size = UDim2.fromOffset(18, 18)
	NewToggle.ToggleButton.AnchorPoint = Vector2.new(0, 0.5)
	NewToggle.ToggleButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	NewToggle.ToggleButton.AutoButtonColor = false
	NewToggle.ToggleButton.Text = ""
	
	NewToggle.ToggleMarkIcon = Instance.new("ImageLabel")
	NewToggle.ToggleMarkIcon.Parent = NewToggle.ToggleButton
	NewToggle.ToggleMarkIcon.Name = "MarkIcon"
	NewToggle.ToggleMarkIcon.Position = UDim2.fromScale(0.5, 0.5)
	NewToggle.ToggleMarkIcon.Size = UDim2.fromScale(0.65, 0.7)
	NewToggle.ToggleMarkIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	NewToggle.ToggleMarkIcon.BackgroundTransparency = 1
	NewToggle.ToggleMarkIcon.Image = "rbxassetid://117895213982708"
	NewToggle.ToggleMarkIcon.ImageTransparency = 1
	
	if NewToggle.Value == true then
		NewToggle.ToggleMarkIcon.ImageTransparency = 0
	end
	
	local BoxBorder = UI:Border(NewToggle.ToggleButton, 1, Color3.fromRGB(65, 65, 65))
	UI:Gradient(BoxBorder, nil, NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0);
		NumberSequenceKeypoint.new(1, 0.75);
	}), 135)
	UI:Corner(NewToggle.ToggleButton, 4)
	
	NewToggle.ActionButton.Activated:Connect(function(Input, Count)
		local OppositeState = not NewToggle.Value
		local H, S, V = NewToggle.OriginalColor:ToHSV()

		TweenService:Create(NewToggle.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
			BackgroundColor3 = Color3.fromHSV(H, S, V - 0.04)
		}):Play()
		
		NewToggle:Set(OppositeState)
		
		if NewToggle.Action then
			task.spawn(function()
				NewToggle.Action(OppositeState, Count)
			end)
		end

		task.wait(0.25)

		if NewToggle.Hovering == true then
			TweenService:Create(NewToggle.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
				BackgroundColor3 = Color3.fromHSV(H, S, V - 0.02)
			}):Play()
		else
			TweenService:Create(NewToggle.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
				BackgroundColor3 = NewToggle.OriginalColor;
			}):Play()
		end
	end)
	
	NewToggle.ToggleButton.Activated:Connect(function(Input, Count)
		local OppositeState = not NewToggle.Value

		NewToggle:Set(OppositeState)

		if NewToggle.Action then
			task.spawn(function()
				NewToggle.Action(OppositeState, Count)
			end)
		end
	end)
	
	table.insert(self.Actions, NewToggle)
	
	return NewToggle
end

function TabClass:NewInput(Config)
	local NewInput = setmetatable({}, InputClass)
	
	NewInput.Config = Config or {}
	NewInput.Type = "Input"
	NewInput.Action = NewInput.Config.Action
	NewInput.Value = NewInput.Config.Value or ""
	NewInput.Hovering = false
	NewInput.OriginalColor = Color3.fromRGB(40, 40, 40)
	
	-- Input
	
	local ActionText = Instance.new("TextLabel")

	NewInput.ActionButton = Instance.new("TextButton")
	NewInput.ActionButton.Parent = self.PageFrame
	NewInput.ActionButton.Name = "ActionInput"
	NewInput.ActionButton.Size = UDim2.new(0.9, 0, 0, 35)
	NewInput.ActionButton.BackgroundColor3 = NewInput.OriginalColor
	NewInput.ActionButton.AutoButtonColor = false
	NewInput.ActionButton.Text = ""
	UI:Corner(NewInput.ActionButton, 4)

	NewInput.ActionButton.MouseEnter:Connect(function()
		local H, S, V = NewInput.OriginalColor:ToHSV()

		NewInput.Hovering = true

		TweenService:Create(NewInput.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
			BackgroundColor3 = Color3.fromHSV(H, S, V - 0.02)
		}):Play()
	end)

	NewInput.ActionButton.MouseLeave:Connect(function()
		NewInput.Hovering = false

		TweenService:Create(NewInput.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
			BackgroundColor3 = NewInput.OriginalColor;
		}):Play()
	end)
	
	NewInput.ActionButton.Activated:Connect(function(Input, Count)
		local H, S, V = NewInput.OriginalColor:ToHSV()

		TweenService:Create(NewInput.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
			BackgroundColor3 = Color3.fromHSV(H, S, V - 0.04)
		}):Play()

		if NewInput.Action then
			task.spawn(function()
				NewInput.Action(NewInput.InputBox.Text, true, Count)
			end)
		end

		task.wait(0.25)

		if NewInput.Hovering == true then
			TweenService:Create(NewInput.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
				BackgroundColor3 = Color3.fromHSV(H, S, V - 0.02)
			}):Play()
		else
			TweenService:Create(NewInput.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
				BackgroundColor3 = NewInput.OriginalColor;
			}):Play()
		end
	end)
	
	ActionText.Parent = NewInput.ActionButton
	ActionText.Name = "ActionText"
	ActionText.Position = UDim2.new(0, 10, 0.5, 0)
	ActionText.Size = UDim2.new(1, -100, 0.5, 0)
	ActionText.AnchorPoint = Vector2.new(0, 0.5)
	ActionText.BackgroundTransparency = 1
	ActionText.Text = NewInput.Config.Name or "Action"
	ActionText.TextSize = 14
	ActionText.FontFace = Font.new(self.WindowConfig.MainFont or "rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)
	ActionText.TextColor3 = Color3.new(1, 1, 1)
	ActionText.TextXAlignment = Enum.TextXAlignment.Left
	ActionText.TextTruncate = Enum.TextTruncate.AtEnd
	
	NewInput.InputBox = Instance.new("TextBox")
	NewInput.InputBox.Parent = NewInput.ActionButton
	NewInput.InputBox.Name = "InputBox"
	NewInput.InputBox.Position = UDim2.new(1, -80, 0.5, 0)
	NewInput.InputBox.Size = UDim2.fromOffset(70, 18)
	NewInput.InputBox.AnchorPoint = Vector2.new(0, 0.5)
	NewInput.InputBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	NewInput.InputBox.Text = NewInput.Value
	NewInput.InputBox.TextSize = 10
	NewInput.InputBox.FontFace = Font.new(self.WindowConfig.MainFont or "rbxasset://fonts/families/Arimo.json")
	NewInput.InputBox.TextColor3 = Color3.new(1, 1, 1)
	NewInput.InputBox.ClearTextOnFocus = NewInput.Config.ClearOnFocus or false
	NewInput.InputBox.TextTruncate = Enum.TextTruncate.AtEnd
	NewInput.InputBox.PlaceholderText = "Input"
	
	local BoxBorder = UI:Border(NewInput.InputBox, 1, Color3.fromRGB(65, 65, 65))
	local BorderGradient = UI:Gradient(BoxBorder, nil, NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0);
		NumberSequenceKeypoint.new(1, 0.75);
	}), 135)
	UI:Corner(NewInput.InputBox, 4)
	
	if NewInput.InputBox.Text ~= "" then
		BorderGradient.Rotation = 90
	end
	
	NewInput.InputBox.Focused:Connect(function()
		TweenService:Create(BorderGradient, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
			Rotation = 90;
		}):Play()
	end)
	
	NewInput.InputBox.FocusLost:Connect(function(Enter)
		if NewInput.InputBox.Text == "" then
			TweenService:Create(BorderGradient, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
				Rotation = 135;
			}):Play()
		end
		
		if NewInput.Action then
			task.spawn(function()
				NewInput.Action(NewInput.InputBox.Text, Enter)
			end)
		end
	end)
	
	NewInput.InputBox:GetPropertyChangedSignal("Text"):Connect(function()
		if NewInput.InputBox.Text ~= "" then
			self.TypeSound:Play()
		end
		
		NewInput.Value = NewInput.InputBox.Text
	end)
	
	table.insert(self.Actions, NewInput)
	
	return NewInput
end

function TabClass:NewSlider(Config)
	local NewSlider = setmetatable({}, SliderClass)
	
	NewSlider.Config = Config or {}
	NewSlider.Type = "Slider"
	NewSlider.Action = NewSlider.Config.Action
	NewSlider.Value = NewSlider.Config.Value or NewSlider.Config.Min or 0
	NewSlider.OldValue = NewSlider.Config.Value or NewSlider.Config.Min or 0
	NewSlider.Steps = NewSlider.Config.Steps or 10
	NewSlider.Min = NewSlider.Config.Min or 0
	NewSlider.Max = NewSlider.Config.Max or 100
	NewSlider.Sliding = false
	NewSlider.Hovering = false
	NewSlider.OriginalColor = Color3.fromRGB(40, 40, 40)
	
	-- Slider
	
	local ActionText = Instance.new("TextLabel")

	NewSlider.ActionButton = Instance.new("TextButton")
	NewSlider.ActionButton.Parent = self.PageFrame
	NewSlider.ActionButton.Name = "ActionSlider"
	NewSlider.ActionButton.Size = UDim2.new(0.9, 0, 0, 40)
	NewSlider.ActionButton.BackgroundColor3 = NewSlider.OriginalColor
	NewSlider.ActionButton.AutoButtonColor = false
	NewSlider.ActionButton.Text = ""
	UI:Corner(NewSlider.ActionButton, 4)
	
	NewSlider.ActionButton.MouseEnter:Connect(function()
		local H, S, V = NewSlider.OriginalColor:ToHSV()

		NewSlider.Hovering = true

		TweenService:Create(NewSlider.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
			BackgroundColor3 = Color3.fromHSV(H, S, V - 0.02)
		}):Play()
	end)

	NewSlider.ActionButton.MouseLeave:Connect(function()
		NewSlider.Hovering = false

		TweenService:Create(NewSlider.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
			BackgroundColor3 = NewSlider.OriginalColor;
		}):Play()
	end)
	
	NewSlider.ActionButton.Activated:Connect(function(Input, Count)
		local H, S, V = NewSlider.OriginalColor:ToHSV()

		TweenService:Create(NewSlider.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
			BackgroundColor3 = Color3.fromHSV(H, S, V - 0.04)
		}):Play()

		if NewSlider.Action then
			task.spawn(function()
				NewSlider.Action(NewSlider.Value, Count)
			end)
		end

		task.wait(0.25)

		if NewSlider.Hovering == true then
			TweenService:Create(NewSlider.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
				BackgroundColor3 = Color3.fromHSV(H, S, V - 0.02)
			}):Play()
		else
			TweenService:Create(NewSlider.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
				BackgroundColor3 = NewSlider.OriginalColor;
			}):Play()
		end
	end)
	
	ActionText.Parent = NewSlider.ActionButton
	ActionText.Name = "ActionText"
	ActionText.Position = UDim2.new(0, 10, 0, 5)
	ActionText.Size = UDim2.new(1, -70, 0, 18)
	ActionText.BackgroundTransparency = 1
	ActionText.Text = (NewSlider.Config.Name or "Action")
	ActionText.TextSize = 14
	ActionText.FontFace = Font.new(self.WindowConfig.MainFont or "rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)
	ActionText.TextColor3 = Color3.new(1, 1, 1)
	ActionText.TextXAlignment = Enum.TextXAlignment.Left
	ActionText.TextTruncate = Enum.TextTruncate.AtEnd
	
	NewSlider.ValueBox = Instance.new("TextBox")
	NewSlider.ValueBox.Parent = NewSlider.ActionButton
	NewSlider.ValueBox.Name = "ValueBox"
	NewSlider.ValueBox.Position = UDim2.new(1, -50, 0, 5)
	NewSlider.ValueBox.Size = UDim2.fromOffset(40, 18)
	NewSlider.ValueBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	NewSlider.ValueBox.Text = NewSlider.Value
	NewSlider.ValueBox.TextSize = 10
	NewSlider.ValueBox.TextEditable = true
	NewSlider.ValueBox.FontFace = Font.new(self.WindowConfig.MainFont or "rbxasset://fonts/families/Arimo.json")
	NewSlider.ValueBox.TextColor3 = Color3.new(1, 1, 1)
	NewSlider.ValueBox.ClearTextOnFocus = NewSlider.Config.ClearOnFocus or false
	NewSlider.ValueBox.TextTruncate = Enum.TextTruncate.AtEnd
	NewSlider.ValueBox.PlaceholderText = "Value"
	
	NewSlider.ValueBox.FocusLost:Connect(function(Enter)
		local Numbers = NewSlider.ValueBox.Text:gsub("%a%w+", "")
		local Value = tonumber(Numbers) or NewSlider.Value
		Value = math.clamp(Value, NewSlider.Min, NewSlider.Max)
		
		NewSlider.ValueBox.Text = Value
		NewSlider:Set(Value)
	end)
	
	NewSlider.ValueBox:GetPropertyChangedSignal("Text"):Connect(function()
		if NewSlider.ValueBox.Text ~= "" then
			self.TypeSound:Play()
		end
	end)
	
	if NewSlider.Config.ValueEditable == false then
		NewSlider.ValueBox.TextEditable = false
	end
	
	local BoxBorder = UI:Border(NewSlider.ValueBox, 1, Color3.fromRGB(65, 65, 65))
	UI:Gradient(BoxBorder, nil, NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0);
		NumberSequenceKeypoint.new(1, 0.75);
	}), 90)
	UI:Corner(NewSlider.ValueBox, 4)
	
	NewSlider.SliderFrame = Instance.new("Frame")
	NewSlider.SliderFrame.Parent = NewSlider.ActionButton
	NewSlider.SliderFrame.Name = "SliderFrame"
	NewSlider.SliderFrame.Position = UDim2.new(0.5, 0, 1, -12)
	NewSlider.SliderFrame.Size = UDim2.new(1, -20, 0, 7)
	NewSlider.SliderFrame.AnchorPoint = Vector2.new(0.5, 0)
	NewSlider.SliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	UI:Corner(NewSlider.SliderFrame, 2)
	UI:Border(NewSlider.SliderFrame, 1, Color3.fromRGB(45, 45, 45))
	
	NewSlider.PickerFrame = Instance.new("Frame")
	NewSlider.PickerFrame.Parent = NewSlider.SliderFrame
	NewSlider.PickerFrame.Name = "PickerFrame"
	NewSlider.PickerFrame.Position = UDim2.fromScale(0, 0.5)
	NewSlider.PickerFrame.Size = UDim2.fromOffset(7, 7)
	NewSlider.PickerFrame.AnchorPoint = Vector2.new(0, 0.5)
	NewSlider.PickerFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	UI:Corner(NewSlider.PickerFrame, 2)
	UI:Border(NewSlider.PickerFrame, 1, Color3.fromRGB(65, 65, 65))
	
	if NewSlider.Value ~= NewSlider.Min then
		local Precentage = (NewSlider.Value - NewSlider.Min) / (NewSlider.Max - NewSlider.Min)
		
		NewSlider.PickerFrame.Position = UDim2.fromScale(Precentage, 0.5)
	end
	
	local SliderHovering = false
	
	NewSlider.SliderFrame.MouseEnter:Connect(function()
		SliderHovering = true
	end)
	
	NewSlider.SliderFrame.MouseLeave:Connect(function()
		SliderHovering = false
	end)
	
	InputService.InputBegan:Connect(function(Input)
		if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) and SliderHovering == true then
			NewSlider.Sliding = true
			
			if NewSlider.Steps <= 0 then
				local PickerX = InputService:GetMouseLocation().X - NewSlider.SliderFrame.AbsolutePosition.X
				local Precentage = PickerX / NewSlider.SliderFrame.AbsoluteSize.X
				Precentage = math.clamp(Precentage, 0, 1)

				NewSlider:Set(NewSlider.Min + (Precentage * (NewSlider.Max - NewSlider.Min)))
			else
				local PickerX = InputService:GetMouseLocation().X - NewSlider.SliderFrame.AbsolutePosition.X
				local Precentage = PickerX / NewSlider.SliderFrame.AbsoluteSize.X
				local Step = 1 / (NewSlider.Steps - 1)
				Precentage = math.floor(Precentage / Step + 0.5) * Step
				Precentage = math.clamp(Precentage, 0, 1)

				NewSlider:Set(NewSlider.Min + (Precentage * (NewSlider.Max - NewSlider.Min)))
			end

			if NewSlider.Action and NewSlider.Value ~= NewSlider.OldValue then
				NewSlider.Action(NewSlider.Value)
			end

			NewSlider.OldValue = NewSlider.Value
		end
	end)
	
	InputService.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			NewSlider.Sliding = false
		end
	end)
	
	InputService.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseMovement and NewSlider.Sliding == true then
			if NewSlider.Steps <= 0 then
				local PickerX = InputService:GetMouseLocation().X - NewSlider.SliderFrame.AbsolutePosition.X
				local Precentage = PickerX / NewSlider.SliderFrame.AbsoluteSize.X
				Precentage = math.clamp(Precentage, 0, 1)
				
				NewSlider:Set(NewSlider.Min + (Precentage * (NewSlider.Max - NewSlider.Min)))
			else
				local PickerX = InputService:GetMouseLocation().X - NewSlider.SliderFrame.AbsolutePosition.X
				local Precentage = PickerX / NewSlider.SliderFrame.AbsoluteSize.X
				local Step = 1 / (NewSlider.Steps - 1)
				Precentage = math.floor(Precentage / Step + 0.5) * Step
				Precentage = math.clamp(Precentage, 0, 1)

				NewSlider:Set(NewSlider.Min + (Precentage * (NewSlider.Max - NewSlider.Min)))
			end
			
			if NewSlider.Action and NewSlider.Value ~= NewSlider.OldValue then
				NewSlider.Action(NewSlider.Value)
			end
			
			NewSlider.OldValue = NewSlider.Value
		end
	end)
	
	table.insert(self.Actions, NewSlider)
	
	return NewSlider
end

function TabClass:NewDropdown(Config)
	local NewDropdown = setmetatable({}, DropdownClass)
	
	NewDropdown.WindowConfig = self.WindowConfig
	NewDropdown.Config = Config or {}
	NewDropdown.Type = "Dropdown"
	NewDropdown.Action = NewDropdown.Config.Action
	NewDropdown.Value = NewDropdown.Config.DefaultItem or "None"
	NewDropdown.Items = NewDropdown.Config.Items or {}
	NewDropdown.Open = false
	NewDropdown.Hovering = false
	NewDropdown.OriginalColor = Color3.fromRGB(40, 40, 40)
	
	-- Dropdown
	
	local ActionText = Instance.new("TextLabel")
	
	NewDropdown.ActionButton = Instance.new("TextButton")
	NewDropdown.ActionButton.Parent = self.PageFrame
	NewDropdown.ActionButton.Name = "ActionDropdown"
	NewDropdown.ActionButton.Size = UDim2.new(0.9, 0, 0, 35)
	NewDropdown.ActionButton.ZIndex = 2
	NewDropdown.ActionButton.BackgroundColor3 = NewDropdown.OriginalColor
	NewDropdown.ActionButton.AutoButtonColor = false
	NewDropdown.ActionButton.Text = ""
	UI:Corner(NewDropdown.ActionButton, 4)
	
	NewDropdown.ActionButton.MouseEnter:Connect(function()
		local H, S, V = NewDropdown.OriginalColor:ToHSV()

		NewDropdown.Hovering = true

		TweenService:Create(NewDropdown.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
			BackgroundColor3 = Color3.fromHSV(H, S, V - 0.02)
		}):Play()
	end)

	NewDropdown.ActionButton.MouseLeave:Connect(function()
		NewDropdown.Hovering = false

		TweenService:Create(NewDropdown.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
			BackgroundColor3 = NewDropdown.OriginalColor;
		}):Play()
	end)

	NewDropdown.ActionButton.Activated:Connect(function(Input, Count)
		local H, S, V = NewDropdown.OriginalColor:ToHSV()

		TweenService:Create(NewDropdown.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
			BackgroundColor3 = Color3.fromHSV(H, S, V - 0.04)
		}):Play()

		if NewDropdown.Action then
			task.spawn(function()
				NewDropdown.Action(NewDropdown.Value, Count)
			end)
		end
		
		task.wait(0.25)

		if NewDropdown.Hovering == true then
			TweenService:Create(NewDropdown.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
				BackgroundColor3 = Color3.fromHSV(H, S, V - 0.02)
			}):Play()
		else
			TweenService:Create(NewDropdown.ActionButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
				BackgroundColor3 = NewDropdown.OriginalColor;
			}):Play()
		end
	end)

	ActionText.Parent = NewDropdown.ActionButton
	ActionText.Name = "ActionText"
	ActionText.Position = UDim2.new(0, 10, 0.5, 0)
	ActionText.Size = UDim2.new(1, -50, 0.5, 0)
	ActionText.AnchorPoint = Vector2.new(0, 0.5)
	ActionText.BackgroundTransparency = 1
	ActionText.Text = NewDropdown.Config.Name or "Action"
	ActionText.TextSize = 14
	ActionText.FontFace = Font.new(self.WindowConfig.MainFont or "rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)
	ActionText.TextColor3 = Color3.new(1, 1, 1)
	ActionText.TextXAlignment = Enum.TextXAlignment.Left
	ActionText.TextTruncate = Enum.TextTruncate.AtEnd
	
	NewDropdown.DropdownButton = Instance.new("TextButton")
	NewDropdown.DropdownButton.Parent = NewDropdown.ActionButton
	NewDropdown.DropdownButton.Name = "DropdownButton"
	NewDropdown.DropdownButton.Position = UDim2.new(1, -100, 0.5, 0)
	NewDropdown.DropdownButton.Size = UDim2.fromOffset(90, 18)
	NewDropdown.DropdownButton.AnchorPoint = Vector2.new(0, 0.5)
	NewDropdown.DropdownButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	NewDropdown.DropdownButton.AutoButtonColor = false
	NewDropdown.DropdownButton.Text = ""
	
	local BoxBorder = UI:Border(NewDropdown.DropdownButton, 1, Color3.fromRGB(65, 65, 65))
	local BorderGradient = UI:Gradient(BoxBorder, nil, NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0);
		NumberSequenceKeypoint.new(1, 0.75);
	}), 135)
	UI:Corner(NewDropdown.DropdownButton, 4)
	
	NewDropdown.DropdownSelectedText = Instance.new("TextLabel")
	NewDropdown.DropdownSelectedText.Parent = NewDropdown.DropdownButton
	NewDropdown.DropdownSelectedText.Position = UDim2.new(0, 5, 0.5, 0)
	NewDropdown.DropdownSelectedText.Size = UDim2.new(1, -24, 1, 0)
	NewDropdown.DropdownSelectedText.AnchorPoint = Vector2.new(0, 0.5)
	NewDropdown.DropdownSelectedText.BackgroundTransparency = 1
	NewDropdown.DropdownSelectedText.Text = NewDropdown.Value
	NewDropdown.DropdownSelectedText.TextSize = 11
	NewDropdown.DropdownSelectedText.FontFace = Font.new(self.WindowConfig.MainFont or "rbxasset://fonts/families/Arimo.json")
	NewDropdown.DropdownSelectedText.TextColor3 = Color3.new(1, 1, 1)
	NewDropdown.DropdownSelectedText.TextXAlignment = Enum.TextXAlignment.Left
	NewDropdown.DropdownSelectedText.TextTruncate = Enum.TextTruncate.AtEnd
	
	NewDropdown.DropdownIcon = Instance.new("ImageLabel")
	NewDropdown.DropdownIcon.Parent = NewDropdown.DropdownButton
	NewDropdown.DropdownIcon.Name = "DropdownIcon"
	NewDropdown.DropdownIcon.Position = UDim2.new(1, -17, 0.5, 0)
	NewDropdown.DropdownIcon.Size = UDim2.fromOffset(12, 12)
	NewDropdown.DropdownIcon.AnchorPoint = Vector2.new(0, 0.5)
	NewDropdown.DropdownIcon.BackgroundTransparency = 1
	NewDropdown.DropdownIcon.Image = "rbxassetid://116390486500841"
	
	local ItemList = Instance.new("UIListLayout")
	NewDropdown.DropdownContainer = Instance.new("Frame")
	NewDropdown.DropdownContainer.Parent = NewDropdown.DropdownButton
	NewDropdown.DropdownContainer.Name = "DropdownContainer"
	NewDropdown.DropdownContainer.Position = UDim2.fromScale(0, 0.85)
	NewDropdown.DropdownContainer.Size = UDim2.fromScale(1, 0)
	NewDropdown.DropdownContainer.ClipsDescendants = true
	NewDropdown.DropdownContainer.BorderSizePixel = 0
	NewDropdown.DropdownContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	
	local BoxBorder = UI:Border(NewDropdown.DropdownContainer, 1, Color3.fromRGB(65, 65, 65))
	BoxBorder.Transparency = 1
	UI:Gradient(BoxBorder, nil, NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0);
		NumberSequenceKeypoint.new(0.65, 0);
		NumberSequenceKeypoint.new(1, 1);
	}), -90)
	UI:Corner(NewDropdown.DropdownContainer, 4)
	
	ItemList.Parent = NewDropdown.DropdownContainer
	ItemList.Padding = UDim.new(0, 2)
	ItemList.VerticalAlignment = Enum.VerticalAlignment.Top
	ItemList.HorizontalAlignment = Enum.HorizontalAlignment.Center
	ItemList.SortOrder = Enum.SortOrder.LayoutOrder
	
	if NewDropdown.Config.Sort == true then
		ItemList.SortOrder = Enum.SortOrder.Name
	end
	
	for Item, ItemName in pairs(NewDropdown.Items) do
		local NewItemButton = Instance.new("TextButton")
		NewItemButton.Parent = NewDropdown.DropdownContainer
		NewItemButton.Name = Item
		NewItemButton.Size = UDim2.new(1, 0, 0, 12)
		NewItemButton.BackgroundTransparency = 1
		NewItemButton.Text = ItemName
		NewItemButton.TextScaled = true
		NewItemButton.TextColor3 = Color3.new(1, 1, 1)
		NewItemButton.FontFace = Font.new(self.WindowConfig.MainFont or "rbxasset://fonts/families/Arimo.json")
		
		NewItemButton.Activated:Connect(function()
			NewDropdown:Set(Item)
			
			if NewDropdown.Action then
				task.spawn(function()
					NewDropdown.Action(Item)
				end)
			end
			
			TweenService:Create(NewDropdown.DropdownContainer, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Size = UDim2.fromScale(1, 0)
			}):Play()

			TweenService:Create(NewDropdown.DropdownIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Rotation = 0;
			}):Play()
			
			TweenService:Create(BoxBorder, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Transparency = 1;
			}):Play()
			
			NewDropdown.ActionButton.ZIndex = 2
			
			NewDropdown.Open = false
		end)
	end
	
	NewDropdown.DropdownButton.Activated:Connect(function()
		if NewDropdown.Open == false then
			local YSize = (#NewDropdown.DropdownContainer:GetChildren() - 3) * 14

			TweenService:Create(NewDropdown.DropdownContainer, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Size = UDim2.new(1, 0, 0, YSize)
			}):Play()
			
			TweenService:Create(NewDropdown.DropdownIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Rotation = 180;
			}):Play()
			
			TweenService:Create(BoxBorder, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Transparency = 0;
			}):Play()
			
			NewDropdown.ActionButton.ZIndex = 3
			
			NewDropdown.Open = true
		else
			TweenService:Create(NewDropdown.DropdownContainer, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Size = UDim2.fromScale(1, 0)
			}):Play()
			
			TweenService:Create(NewDropdown.DropdownIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Rotation = 0;
			}):Play()
			
			TweenService:Create(BoxBorder, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Transparency = 1;
			}):Play()
			
			NewDropdown.ActionButton.ZIndex = 2
			
			NewDropdown.Open = false
		end
	end)
	
	table.insert(self.Actions, NewDropdown)
	
	return NewDropdown
end

function TabClass:AddGap(Gap)
	local GapFrame = Instance.new("Frame")

	GapFrame.Parent = self.PageFrame
	GapFrame.Size = UDim2.new(1, 0, 0, Gap or 15)
	GapFrame.BackgroundTransparency = 1
	
	return GapFrame
end

function TabClass:AddSection(Name)
	local SectionText = Instance.new("TextLabel")
	SectionText.Parent = self.PageFrame
	SectionText.Name = "SectionText"
	SectionText.Size = UDim2.new(0.9, 0, 0, 15)
	SectionText.BackgroundTransparency = 1
	SectionText.Text = "-- "..(Name or "Section")
	SectionText.TextScaled = true
	SectionText.FontFace = Font.new(self.WindowConfig.MainFont or "rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)
	SectionText.TextColor3 = Color3.fromRGB(100, 100, 100)
	SectionText.TextXAlignment = Enum.TextXAlignment.Left

	table.insert(self.Text, SectionText)
	
	return SectionText
end

function TabClass:AddTitle(Text)
	local TitleText = Instance.new("TextLabel")
	TitleText.Parent = self.PageFrame
	TitleText.Name = "TitleText"
	TitleText.Size = UDim2.new(0.9, 0, 0, 13)
	TitleText.BackgroundTransparency = 1
	TitleText.Text = Text or "Title"
	TitleText.TextScaled = true
	TitleText.FontFace = Font.new(self.WindowConfig.MainFont or "rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)
	TitleText.TextColor3 = Color3.fromRGB(225, 225, 225)
	TitleText.TextXAlignment = Enum.TextXAlignment.Left

	table.insert(self.Text, TitleText)

	return TitleText
end

function TabClass:AddParagraph(Text)
	local ParagraphText = Instance.new("TextLabel")
	local ParagraphFrame = Instance.new("Frame")

	ParagraphFrame.Parent = self.PageFrame
	ParagraphFrame.Size = UDim2.new(0.9, 0, 0, 0)
	ParagraphFrame.AutomaticSize = Enum.AutomaticSize.Y
	ParagraphFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	local BoxBorder = UI:Border(ParagraphFrame, 1, Color3.fromRGB(65, 65, 65))
	UI:Gradient(BoxBorder, nil, NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0);
		NumberSequenceKeypoint.new(1, 0.75);
	}), 135)
	UI:Corner(ParagraphFrame, 4)

	ParagraphText.Parent = ParagraphFrame
	ParagraphText.Position = UDim2.fromScale(0.5, 0)
	ParagraphText.Size = UDim2.new(1, -15, 1, 15)
	ParagraphText.AnchorPoint = Vector2.new(0.5, 0)
	ParagraphText.AutomaticSize = Enum.AutomaticSize.Y
	ParagraphText.BackgroundTransparency = 1
	ParagraphText.Text = (Text or "Paragraph")
	ParagraphText.TextWrapped = true
	ParagraphText.RichText = true
	ParagraphText.TextSize = 12
	ParagraphText.FontFace = Font.new(self.WindowConfig.MainFont or "rbxasset://fonts/families/Arimo.json")
	ParagraphText.TextColor3 = Color3.fromRGB(225, 225, 225)
	ParagraphText.TextXAlignment = Enum.TextXAlignment.Left

	table.insert(self.Text, ParagraphFrame)

	return ParagraphFrame
end

function TabClass:Destroy()
	self.TabButton:Destroy()
	self.PageFrame:Destroy()
	self.TabButton = nil
	self.PageFrame = nil
	self.HoverSound = nil
	self.TypeSound = nil

	for ActionI, Action in pairs(self.Actions) do
		if Action.ActionButton then
			Action:Destroy()
		end
	end

	self.WindowConfig = nil
	self.Config = nil
	self.Name = nil
	self.Selected = nil

	self = nil
end


-- Button Class

ButtonClass.__index = ButtonClass

function ButtonClass:Destroy()
	self.ActionButton:Destroy()
end


-- Toggle Class

ToggleClass.__index = ToggleClass

function ToggleClass:Set(NewValue)
	self.Value = NewValue
	
	if NewValue == true then
		TweenService:Create(self.ToggleMarkIcon, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
			ImageTransparency = 0;
		}):Play()
		
		TweenService:Create(self.ToggleButton.UIStroke.UIGradient, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
			Rotation = 90;
		}):Play()
	else
		TweenService:Create(self.ToggleMarkIcon, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
			ImageTransparency = 1;
		}):Play()
		
		TweenService:Create(self.ToggleButton.UIStroke.UIGradient, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
			Rotation = 135;
		}):Play()
	end
end

function ToggleClass:Destroy()
	self.ActionButton:Destroy()
end


-- Input Class

InputClass.__index = InputClass

function InputClass:Set(NewValue)
	self.Value = NewValue
	self.InputBox.Text = NewValue
	
	if NewValue == "" then
		TweenService:Create(self.InputBox.UIStroke.UIGradient, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
			Rotation = 135;
		}):Play()
	else
		TweenService:Create(self.InputBox.UIStroke.UIGradient, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
			Rotation = 90;
		}):Play()
	end
end

function InputClass:Destroy()
	self.ActionButton:Destroy()
end


-- Slider Class

SliderClass.__index = SliderClass

function SliderClass:Set(NewValue)
	local Precentage = (NewValue - self.Min) / (self.Max - self.Min)
	
	self.Value = NewValue
	self.ValueBox.Text = math.floor(NewValue * 10) / 10
	
	TweenService:Create(self.PickerFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
		Position = UDim2.fromScale(Precentage, 0.5);
	}):Play()
end

function SliderClass:Destroy()
	self.ActionButton:Destroy()
end


-- Dropdown Class

DropdownClass.__index = DropdownClass

function DropdownClass:Set(NewValue)
	local Name = self.Items[NewValue]
	
	self.Value = NewValue
	self.DropdownSelectedText.Text = Name
end

function DropdownClass:Change(NewItems)
	self.Items = NewItems
	
	for ItemI, Item in pairs(self.DropdownContainer:GetChildren()) do
		if Item:IsA("TextButton") then
			Item:Destroy()
		end
	end
	
	for Item, ItemName in pairs(NewItems) do
		local NewItemButton = Instance.new("TextButton")
		NewItemButton.Parent = self.DropdownContainer
		NewItemButton.Name = Item
		NewItemButton.Size = UDim2.new(1, 0, 0, 12)
		NewItemButton.BackgroundTransparency = 1
		NewItemButton.Text = ItemName
		NewItemButton.TextScaled = true
		NewItemButton.TextColor3 = Color3.new(1, 1, 1)
		NewItemButton.FontFace = Font.new(self.WindowConfig.MainFont or "rbxasset://fonts/families/Arimo.json")

		NewItemButton.Activated:Connect(function()
			self:Set(Item)

			if self.Action then
				task.spawn(function()
					self.Action(Item)
				end)
			end

			TweenService:Create(self.DropdownContainer, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Size = UDim2.fromScale(1, 0)
			}):Play()

			TweenService:Create(self.DropdownIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Rotation = 0;
			}):Play()

			self.Open = false
		end)
	end
end

function DropdownClass:Add(Item, ItemName)
	local NewItemButton = Instance.new("TextButton")
	NewItemButton.Parent = self.DropdownContainer
	NewItemButton.Name = Item
	NewItemButton.Size = UDim2.new(1, 0, 0, 12)
	NewItemButton.BackgroundTransparency = 1
	NewItemButton.Text = ItemName
	NewItemButton.TextScaled = true
	NewItemButton.TextColor3 = Color3.new(1, 1, 1)
	NewItemButton.FontFace = Font.new(self.WindowConfig.MainFont or "rbxasset://fonts/families/Arimo.json")
	
	NewItemButton.Activated:Connect(function()
		self:Set(Item)

		if self.Action then
			task.spawn(function()
				self.Action(Item)
			end)
		end

		TweenService:Create(self.DropdownContainer, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			Size = UDim2.fromScale(1, 0)
		}):Play()

		TweenService:Create(self.DropdownIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			Rotation = 0;
		}):Play()

		self.Open = false
	end)
	
	if self.Open == true then
		local YSize = (#self.DropdownContainer:GetChildren() - 3) * 14

		TweenService:Create(self.DropdownContainer, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			Size = UDim2.new(1, 0, 0, YSize)
		}):Play()
	end
	
	self.Items[Item] = ItemName
end

function DropdownClass:Remove(Item)
	for ItemButtonI, ItemButton in pairs(self.DropdownContainer:GetChildren()) do
		if ItemButton.Name == Item then
			ItemButton:Destroy()

			break
		end
	end

	self.Items[Item] = nil
	
	if self.Open == true then
		local YSize = (#self.DropdownContainer:GetChildren() - 3) * 14

		TweenService:Create(self.DropdownContainer, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			Size = UDim2.new(1, 0, 0, YSize)
		}):Play()
	end
end

function DropdownClass:Destroy()
	self.ActionButton:Destroy()
end


return WindowClass
