local Class = {}

-- Services

local WorkService = game:GetService("Workspace")


-- Functions

function RoundDecimal(Number:number, Decimals)
	local Multiplier = 10 ^ Decimals
	local NewNumber = math.round(Number * Multiplier) / Multiplier
	
	return NewNumber
end


-- Path Class

Class.__index = Class

function Class:New(Config)
	local NewPath = setmetatable({}, Class)
	NewPath.PartCells = {}
	NewPath.RCells = {}
	NewPath.GCells = {}
	NewPath.EndCell = nil
	NewPath.Start = nil
	NewPath.End = nil
	NewPath.Type = (Config or {}).Type or "3D"
	NewPath.Limit = (Config or {}).Limit or 2500
	NewPath.CellRadius = (Config or {}).CellRadius or 1
	NewPath.FinishRadius = (Config or {}).FinishRadius or 0
	NewPath.Visualize = (Config or {}).Visualize or false
	NewPath.Delay = (Config or {}).Delay or -1
	
	return NewPath
end

function Class:Reset()
	for CellPosition, Cell in pairs(self.PartCells) do
		Cell:Destroy()
	end

	self.PartCells = {}
	self.GCells = {}
	self.RCells = {}
end

function Class:ComputePath(Start, End)
	-- Reset --
	
	self:Reset()
	self.Start = Start
	self.End = End
	
	-- Compute --
	
	local LastCell = nil
	local LastPositions = {}
	local FoundEnd = false
	
	self:ComputeCell({
		G = 0;
		H = 0;
		F = 0;
	}, self.Start)
	
	for I = 1, self.Limit, 1 do
		local LowestCost, LowestCells = math.huge, {}
		local BestCellPosition, BestCell = nil, nil
		
		local Debug = 0
		
		for CellPosition, Cell in pairs(self.GCells) do
			if Cell.F < LowestCost then
				LowestCost = Cell.F
			end
		end
		
		for CellPosition, Cell in pairs(self.GCells) do
			if Cell.F == LowestCost then
				LowestCells[CellPosition] = Cell
				
				Debug += 1
			end
		end
		
		for CellPosition, Cell in pairs(LowestCells) do
			if BestCell == nil then
				BestCellPosition = CellPosition
				BestCell = Cell
			elseif Cell.H < BestCell.H then
				BestCellPosition = CellPosition
				BestCell = Cell
			end
		end
		
		self.GCells[BestCellPosition] = nil
		self.RCells[BestCellPosition] = BestCell
		LastCell = BestCell

		if self.Delay >= 0 then
			task.wait(self.Delay)
		end

		if self.Visualize == true then
			self.PartCells[BestCellPosition].Color = Color3.new(1, 0, 0)
		end

		self:ComputeCell(BestCell, BestCellPosition)
		
		if LastCell.H < self.CellRadius + self.FinishRadius then
			FoundEnd = true

			break
		end
	end
	
	if FoundEnd == false then
		error("PathModule: No path was found during the limit.")
	end
	
	self.EndCell = LastCell
end

function Class:ComputeCell(Cell, Position)
	local NearPositions
	
	if self.Type == "3D" then
		NearPositions = {
			Position + Vector3.new(0, 0, self.CellRadius);
			Position + Vector3.new(0, 0, -self.CellRadius);
			Position + Vector3.new(self.CellRadius, 0, 0);
			Position + Vector3.new(-self.CellRadius, 0, 0);

			Position + Vector3.new(self.CellRadius, 0, self.CellRadius);
			Position + Vector3.new(-self.CellRadius, 0, self.CellRadius);
			Position + Vector3.new(self.CellRadius, 0, -self.CellRadius);
			Position + Vector3.new(-self.CellRadius, 0, -self.CellRadius);

			Position + Vector3.new(0, self.CellRadius, self.CellRadius);
			Position + Vector3.new(0, self.CellRadius, -self.CellRadius);
			Position + Vector3.new(self.CellRadius, self.CellRadius, 0);
			Position + Vector3.new(-self.CellRadius, self.CellRadius, 0);

			Position + Vector3.new(self.CellRadius, self.CellRadius, self.CellRadius);
			Position + Vector3.new(-self.CellRadius, self.CellRadius, self.CellRadius);
			Position + Vector3.new(self.CellRadius, self.CellRadius, -self.CellRadius);
			Position + Vector3.new(-self.CellRadius, self.CellRadius, -self.CellRadius);


			Position + Vector3.new(0, -self.CellRadius, self.CellRadius);
			Position + Vector3.new(0, -self.CellRadius, -self.CellRadius);
			Position + Vector3.new(self.CellRadius, -self.CellRadius, 0);
			Position + Vector3.new(-self.CellRadius, -self.CellRadius, 0);

			Position + Vector3.new(self.CellRadius, -self.CellRadius, self.CellRadius);
			Position + Vector3.new(-self.CellRadius, -self.CellRadius, self.CellRadius);
			Position + Vector3.new(self.CellRadius, -self.CellRadius, -self.CellRadius);
			Position + Vector3.new(-self.CellRadius, -self.CellRadius, -self.CellRadius);
		}
	elseif self.Type == "2D" then
		NearPositions = {
			Position + Vector3.new(0, 0, self.CellRadius);
			Position + Vector3.new(0, 0, -self.CellRadius);
			Position + Vector3.new(self.CellRadius, 0, 0);
			Position + Vector3.new(-self.CellRadius, 0, 0);

			Position + Vector3.new(self.CellRadius, 0, self.CellRadius);
			Position + Vector3.new(-self.CellRadius, 0, self.CellRadius);
			Position + Vector3.new(self.CellRadius, 0, -self.CellRadius);
			Position + Vector3.new(-self.CellRadius, 0, -self.CellRadius);
		}
	end
	
	local CellSize = Vector3.one * self.CellRadius * 0.9
	
	
	for NearPositionI, NearPosition in pairs(NearPositions) do
		if self.RCells[NearPosition] == nil and #WorkService:GetPartBoundsInBox(CFrame.new(NearPosition), CellSize) == 0 then
			local GCost = Cell.G + (NearPosition - Position).Magnitude
			local HCost = (NearPosition - self.End).Magnitude
			
			if self.Type == "3D" and NearPosition.Y < Position.Y then
				GCost -= 1
			end

			if self.GCells[NearPosition] == nil then
				self.GCells[NearPosition] = {
					Parent = Position;
					G = GCost;
					H = HCost;
					F = GCost + HCost;
				}

				if self.Visualize == true then
					local NewCellPart = script.CellPart:Clone()
					local CostGui = NewCellPart.CostGui
					NewCellPart.Parent = WorkService
					NewCellPart.Position = NearPosition
					NewCellPart.Size = CellSize

					CostGui.GText.Text = "G: "..math.round(GCost)
					CostGui.HText.Text = "H: "..math.round(HCost)
					CostGui.FText.Text = "F: "..math.round(GCost + HCost)

					self.PartCells[NearPosition] = NewCellPart
				end
			elseif self.GCells[NearPosition].G > GCost then
				self.GCells[NearPosition] = {
					Parent = Position;
					G = GCost;
					H = HCost;
					F = GCost + HCost;
				}

				if self.Visualize == true then
					local CellPart = self.PartCells[NearPosition]
					local CostGui = CellPart.CostGui

					CostGui.GText.Text = "G: "..math.round(GCost)
					CostGui.HText.Text = "H: "..math.round(HCost)
					CostGui.FText.Text = "F: "..math.round(GCost + HCost)
				end
			end
		end
	end
end

function Class:GetPath()
	local Points = {self.End}
	local LastCell = self.EndCell
	
	repeat
		local ParentCell = self.RCells[LastCell.Parent]
		
		table.insert(Points, LastCell.Parent)

		if self.Visualize == true and self.PartCells[LastCell.Parent] then
			self.PartCells[LastCell.Parent].Color = Color3.new(0, 0, 1)
			self.PartCells[LastCell.Parent].Transparency = 0.5
		end
		
		if ParentCell == nil then
			break
		end
		
		LastCell = ParentCell
	until LastCell.G < 2
	
	for Index = 1, math.floor(#Points/2) do
		local Object = #Points - Index + 1
		Points[Index], Points[Object] = Points[Object], Points[Index]
	end
	
	return Points
end

return Class
