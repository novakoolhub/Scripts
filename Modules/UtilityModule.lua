local Module = {
	Align = {};
	UIObject = {};
	Color = {};
}

-- Services

local RunService = game:GetService("RunService")

local InputService = game:GetService("UserInputService")


-- Align Functions

function Module.Align:CenterAnchor(GuiObject:GuiButton) -- Uses AnchorPoint to make the GuiObject stay in the middle.
	GuiObject.Position = UDim2.fromScale(0.5, 0.5)
	GuiObject.AnchorPoint = Vector2.one / 2
end

function Module.Align:Top(GuiObject:GuiObject)
	GuiObject.Position = UDim2.fromScale(0, GuiObject.Size.Y.Scale)
end

function Module.Align:TopRight(GuiObject:GuiObject)
	GuiObject.Position = UDim2.new(1 - GuiObject.Size.X.Scale, -GuiObject.Size.X.Offset, 0, 0)
end

function Module.Align:TopLeft(GuiObject:GuiObject)
	GuiObject.Position = UDim2.new(0, 0, 0, 0)
end

function Module.Align:Bottom(GuiObject:GuiObject)
	GuiObject.Position = UDim2.new(GuiObject.Size.X.Scale, 0, 1 - GuiObject.Size.Y.Scale, -GuiObject.Size.Y.Offset)
end

function Module.Align:BottomRight(GuiObject:GuiObject)
	GuiObject.Position = UDim2.new(1 - GuiObject.Size.X.Scale, -GuiObject.Size.X.Offset, 1 - GuiObject.Size.Y.Scale, -GuiObject.Size.Y.Offset)
end

function Module.Align:BottomLeft(GuiObject:GuiObject)
	GuiObject.Position = UDim2.new(0, 0, 1 - GuiObject.Size.Y.Scale, -GuiObject.Size.Y.Offset)
end

function Module.Align:FullScreen(GuiObject:GuiObject)
	GuiObject.Position = UDim2.new(0, 0, 0, 0)
	GuiObject.Size = UDim2.fromScale(1, 1)
end

function Module.Align:Draggable(GuiObject:GuiObject, DragObject:GuiObject, Smoothness:number)
	-- Arguments

	DragObject = DragObject or GuiObject
	
	Smoothness = Smoothness or 0.9
	Smoothness = math.clamp(Smoothness, 0, 90)
	Smoothness = Smoothness / 100

	-- Function

	local Hovering = false
	local Holding = false
	local HoldPosition

	DragObject.MouseEnter:Connect(function()
		Hovering = true
	end)

	DragObject.MouseLeave:Connect(function()
		Hovering = false
	end)

	InputService.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 and Hovering then
			HoldPosition = (InputService:GetMouseLocation() - GuiObject.AbsolutePosition) - (GuiObject.AbsoluteSize * GuiObject.AnchorPoint)
			Holding = true
		end
	end)

	InputService.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			Holding = false
		end
	end)
	
	local DragUDim = GuiObject.Position

	local DragLoop = RunService.RenderStepped:Connect(function()
		if Holding == true then
			local DragPosition = InputService:GetMouseLocation() - HoldPosition + Vector2.new(0, 58)
			DragUDim = UDim2.fromOffset(DragPosition.X, DragPosition.Y)
		end
			
		GuiObject.Position = GuiObject.Position:Lerp(DragUDim, 1 - Smoothness)
	end)

	return DragLoop
end

-- UIObj Functions

function Module.UIObject:Stroke(GuiObject:GuiObject, Thickness:number, Color:Color3)
	local NewStroke = Instance.new("UIStroke", GuiObject)
	
	NewStroke.Thickness = Thickness
	NewStroke.Color = Color
	
	return NewStroke
end

function Module.UIObject:Scale(GuiObject:GuiObject, Scale:number)
	local NewScale = Instance.new("UIScale", GuiObject)
	
	NewScale.Scale = Scale
	
	return NewScale
end

function Module.UIObject:Raito(GuiObject:GuiObject, Ratio:number)
	local NewRatio = Instance.new("UIAspectRatioConstraint", GuiObject)

	NewRatio.AspectRatio = Ratio

	return NewRatio
end

function Module.UIObject:ClampTextSize(GuiObject:GuiObject, Min:number, Max:number)
	local NewTextClamp = Instance.new("UITextSizeConstraint", GuiObject)
	
	NewTextClamp.MinTextSize = Min
	NewTextClamp.MaxTextSize = Max
	
	return NewTextClamp
end

function Module.UIObject:Corner(GuiObject:GuiObject, Radius:UDim, Removed:string) -- Removed table is all the corners that should stay sharp.
	-- Arguments

	Removed = Removed or ""
	Removed = string.split(Removed, "/")

	-- Function

	local NewCorner = Instance.new("UICorner")
	local TRRemoved = table.find(Removed, "TR")
	local TLRemoved = table.find(Removed, "TL")
	local BRRemoved = table.find(Removed, "BR")
	local BLRemoved = table.find(Removed, "BL")

	NewCorner.Parent = GuiObject
	NewCorner.CornerRadius = Radius

	if TRRemoved then
		local NewBlock = Instance.new("Frame")

		NewBlock.Parent = GuiObject
		NewBlock.Name = "TRCornerBlock"
		NewBlock.Size = UDim2.new(Radius.Scale, Radius.Offset, Radius.Scale, Radius.Offset)
		NewBlock.BackgroundColor3 = GuiObject.BackgroundColor3
		NewBlock.BorderSizePixel = 0
		Module.Align:TopRight(NewBlock)
	end

	if TLRemoved then
		local NewBlock = Instance.new("Frame")

		NewBlock.Parent = GuiObject
		NewBlock.Name = "TLCornerBlock"
		NewBlock.Size = UDim2.new(Radius.Scale, Radius.Offset, Radius.Scale, Radius.Offset)
		NewBlock.BackgroundColor3 = GuiObject.BackgroundColor3
		NewBlock.BorderSizePixel = 0
		Module.Align:TopLeft(NewBlock)
	end

	if BRRemoved then
		local NewBlock = Instance.new("Frame")

		NewBlock.Parent = GuiObject
		NewBlock.Name = "BRCornerBlock"
		NewBlock.Size = UDim2.new(Radius.Scale, Radius.Offset, Radius.Scale, Radius.Offset)
		NewBlock.BackgroundColor3 = GuiObject.BackgroundColor3
		NewBlock.BorderSizePixel = 0
		Module.Align:BottomRight(NewBlock)
	end

	if BLRemoved then
		local NewBlock = Instance.new("Frame")

		NewBlock.Parent = GuiObject
		NewBlock.Name = "BLCornerBlock"
		NewBlock.Size = UDim2.new(Radius.Scale, Radius.Offset, Radius.Scale, Radius.Offset)
		NewBlock.BackgroundColor3 = GuiObject.BackgroundColor3
		NewBlock.BorderSizePixel = 0
		Module.Align:BottomLeft(NewBlock)
	end

	return NewCorner
end

function Module.UIObject:FadeGradient(GuiObject:GuiObject, EndTransparency:number, Direction:string)
	-- Arguments
	
	EndTransparency = EndTransparency or 1
	Direction = Direction or "TOP"
	
	-- Function
	
	local NewGradient = Instance.new("UIGradient")
	
	NewGradient.Parent = GuiObject
	NewGradient.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0, 0);
		NumberSequenceKeypoint.new(1, EndTransparency, 0);
	})

	if Direction == "TOP" then
		NewGradient.Rotation = -90
	elseif Direction == "BOTTOM" then
		NewGradient.Rotation = 90
	elseif Direction == "RIGHT" then
		NewGradient.Rotation = 0
	elseif Direction == "LEFT" then
		NewGradient.Rotation = -180
	end

	return NewGradient
end

function Module.UIObject:ColorFadeGradient(GuiObject:GuiObject, Direction:string)
	-- Arguments

	Direction = Direction or "TOP"

	-- Function

	local NewGradient = Instance.new("UIGradient")

	NewGradient.Parent = GuiObject
	NewGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1));
		ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0));
	})

	if Direction == "TOP" then
		NewGradient.Rotation = -90
	elseif Direction == "BOTTOM" then
		NewGradient.Rotation = 90
	elseif Direction == "RIGHT" then
		NewGradient.Rotation = 0
	elseif Direction == "LEFT" then
		NewGradient.Rotation = -180
	end

	return NewGradient
end

function Module.UIObject:List(GuiObject:GuiObject, Padding:UDim, FillDirection:Enum.FillDirection, AlignDirection:string)
	-- Arguments

	Padding = Padding or UDim.new(0, 0)
	FillDirection = FillDirection or Enum.FillDirection.Vertical
	AlignDirection = AlignDirection or "CC"

	-- Function

	local VerticalDirection = AlignDirection:sub(1, 1)
	local HorizontalDirection = AlignDirection:sub(2, 2)
	local NewList = Instance.new("UIListLayout")

	NewList.Parent = GuiObject
	NewList.Padding = Padding
	NewList.FillDirection = FillDirection
	NewList.SortOrder = Enum.SortOrder.LayoutOrder

	if VerticalDirection == "C" then
		NewList.VerticalAlignment = Enum.VerticalAlignment.Center
	elseif VerticalDirection == "T" then
		NewList.VerticalAlignment = Enum.VerticalAlignment.Top
	elseif VerticalDirection == "B" then
		NewList.VerticalAlignment = Enum.VerticalAlignment.Bottom
	end

	if HorizontalDirection == "C" then
		NewList.HorizontalAlignment = Enum.HorizontalAlignment.Center
	elseif HorizontalDirection == "R" then
		NewList.HorizontalAlignment = Enum.HorizontalAlignment.Right
	elseif HorizontalDirection == "L" then
		NewList.HorizontalAlignment = Enum.HorizontalAlignment.Left
	end

	return NewList
end

function Module.UIObject:TextSizeClamp(GuiObject:GuiObject, Min:number, Max:number)
	-- Arguments

	Min = Min or 0
	Max = Max or 0

	-- Function

	local NewTextClamp = Instance.new("UITextSizeConstraint")

	NewTextClamp.Parent = GuiObject
	NewTextClamp.MinTextSize = Min
	NewTextClamp.MaxTextSize = Max
end

-- Color Functions

function Module.Color:Add(ColorA, ColorB)
	local R1, G1, B1 = ColorA.R * 255, ColorA.G * 255, ColorA.B * 255
	local R2, G2, B2 = ColorB.R * 255, ColorB.G * 255, ColorB.B * 255
	local R, G, B = math.max(R1 + R2, 0), math.max(G1 + G2, 0), math.max(B1 + B2, 0)
	
	return Color3.fromRGB(R, G, B)
end

-- Deprecated functions



return Module
