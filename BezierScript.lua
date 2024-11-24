

local Bezier = require(game:GetService("ReplicatedStorage").Bezier)
local vectorArray = {}
local ran = false
local ServerStorage = game:GetService("ServerStorage")
local poopy = false
local markerNumber = 0
local p0 = workspace.Bezier.P0.Position
local p1 = workspace.Bezier.P1.Position
local p2 = workspace.Bezier.P2.Position
local p3 = workspace.Bezier.P3.Position

local j0 = workspace.Bezier.J0.Position
local j1 = workspace.Bezier.J1.Position
local j2 = workspace.Bezier.J2.Position
local j3 = workspace.Bezier.J3.Position

local k0 = workspace.Bezier.K0.Position
local k1 = workspace.Bezier.K1.Position
local k2 = workspace.Bezier.K2.Position
local k3 = workspace.Bezier.K3.Position


local x0 = workspace.Bezier.X0.Position
local x1 = workspace.Bezier.X1.Position
local x2 = workspace.Bezier.X2.Position
local x3 = workspace.Bezier.X3.Position


local marketTemp = game:GetService("ServerStorage").Marker
local difference = x3 - x0
local smalldifference = x3 - x2
local smalldifference2 = x2 - x1
local smallerdifference = x1 - x0

--print(smalldifference)
--print(smalldifference2)
--print(smallerdifference)
local line1 = Bezier.new(100,k0,k1,k2,k3)
local curve1 = Bezier.new(100,p0,p1,p2,p3)
local curve2 = Bezier.new(100,j0,j1,j2,j3)
local line2 = Bezier.new(100,x0,x1,x2,x3)

local line3 = Bezier.new(100,x0 + difference  ,x1 + difference,x2 + difference,x3 + difference)


local line4 = Bezier.new(100,x0 +difference*2,x1 + difference*2, x2 + difference*2, x3 + difference* 2)


local line5 = Bezier.new(100,x0 + difference*3,difference*3 + x1,difference*3 + x2,x3 + difference* 3)

local line6 = Bezier.new(100,x0 + difference*4,difference*4 + x1,difference*4 + x2,x3 + difference* 4)
--[[
for t = 0, 1,0.1 do 
	local marker = marketTemp:Clone() 
	marker.Position = curve:Calc(t)
	marker.Parent = workspace
end

for t = 0, 1,0.2 do 
	local marker = marketTemp:Clone() 
	marker.Position = line1:Calc(t)
	marker.Parent = workspace
end
]]--
--[[
for t = 0, 1,0.2 do 
	local marker = marketTemp:Clone() 
	marker.Position = line2:Calc(t)
	marker.Parent = workspace
end
]]--

if ran == false then
	
	
	for t = 0, 4, 0.017 do
		markerNumber = markerNumber + 1
	--local vector3 = Instance.new('Vector3Value')
	local marker = marketTemp:Clone() 
	if t < 1 then
				marker.Position = line1:Calc(t)
				--vector3.Value = line1:Calc(t)
			vectorArray[#vectorArray+1] = Vector3.new(0,(line1:Calc(t)- k0).Y, (line1:Calc(t)-k0).Z)
			--print("Vector3.new(" ..  tostring(line1:Calc(t) - k0) .. "),")
			print("Vector3.new(" ..  tostring(Vector3.new(0,(line1:Calc(t)- k0).Y, (line1:Calc(t)-k0).Z)) .. "),")
	elseif t < 2 then
		marker.Position = curve1:Calc(t- 1)
		--vector3.Value = curve:Calc(t-1)
			vectorArray[#vectorArray+1] =  Vector3.new(0,(curve1:Calc(t-1)- k0).Y, (curve1:Calc(t-1)-k0).Z)
			--print("Vector3.new(" ..  tostring(curve1:Calc(t-1) - k0) .. "),")
			print("Vector3.new(" ..  tostring(Vector3.new(0,(curve1:Calc(t-1)- k0).Y, (curve1:Calc(t-1)-k0).Z)) .. "),")
	elseif t < 3 then
			marker.Position = curve2:Calc(t- 2)
			--vector3.Value = curve:Calc(t-1)
			vectorArray[#vectorArray+1] = curve2:Calc(t-2) - k0
			--print("Vector3.new(" ..  tostring(curve2:Calc(t-2) - k0) .. "),")
			print("Vector3.new(" ..  tostring(Vector3.new(0,(curve2:Calc(t-2) - k0).Y, (curve2:Calc(t-2) - k0).Z)) .. "),")
	elseif t <= 4 then
		--marker.Position = line2:Calc(t-3)
		--vector3.Value = line2:Calc(t-2)
			--vectorArray[#vectorArray+1] = line2:Calc(t-3) - k0
			--print("Vector3.new(" .. tostring(line2:Calc(t-3) - k0) .. "),")
			--print("Vector3.new(" ..  tostring(Vector3.new(0,(line2:Calc(t-3) - k0).Y, (line2:Calc(t-3) - k0).Z)) .. "),")
			--print("Vector3.new(" ..  tostring(Vector3.new(0,-16,0)) .. "),")
	end
	marker.Parent = workspace.doodoomarkers
	--vector3.Parent = ServerStorage.blueFairyVectors
	marker.Name = markerNumber
	end
	
	--[[
	for t = 0, 4, 0.017	 do
		markerNumber = markerNumber + 1
		local marker = marketTemp:Clone() 
		if t < 1 then
			marker.Position = line3:Calc(t)
			
			--marker.Position = line1:Calc(t)
			--vector3.Value = line1:Calc(t)
			--vectorArray[#vectorArray+1] = line1:Calc(t) - k0
			print("Vector3.new(" ..  tostring(Vector3.new(0,(line3:Calc(t)- k0).Y, (line3:Calc(t)-k0).Z)) .. "),")
		elseif t < 2 then
			
			marker.Position = line4:Calc(t-1)
			--marker.Position = curve1:Calc(t- 1)
			--vector3.Value = curve:Calc(t-1)
			--vectorArray[#vectorArray+1] = curve1:Calc(t-1) - k0
			--print("Vector3.new(" ..  tostring(line4:Calc(t-1) - k0) .. "),")

			print("Vector3.new(" ..  tostring(Vector3.new(0,(line4:Calc(t-1)- k0).Y, (line4:Calc(t-1)-k0).Z)) .. "),")
		elseif t < 3 then
			
			marker.Position = line5:Calc(t-2)
			--marker.Position = curve2:Calc(t- 2)
			--vector3.Value = curve:Calc(t-1)
			--vectorArray[#vectorArray+1] = curve2:Calc(t-2) - k0
			--print("Vector3.new(" ..  tostring(line5:Calc(t-2) - k0) .. "),")
			print("Vector3.new(" ..  tostring(Vector3.new(0,(line5:Calc(t-2) - k0).Y, (line5:Calc(t-2) - k0).Z)) .. "),")
		elseif t < 4 then
			
			marker.Position = line6:Calc(t-3)
			--marker.Position = curve2:Calc(t- 2)
			--vector3.Value = curve:Calc(t-1)
			--vectorArray[#vectorArray+1] = curve2:Calc(t-2) - k0
			--print("Vector3.new(" ..  tostring(line5:Calc(t-2) - k0) .. "),")
			print("Vector3.new(" ..  tostring(Vector3.new(0,(line6:Calc(t-3) - k0).Y, (line6:Calc(t-3) - k0).Z)) .. "),")
		end 
		
		marker.Parent = workspace.doodoomarkers
		--vector3.Parent = ServerStorage.blueFairyVectors
		marker.Name = markerNumber
	end
	]]--
ran = true	
--print(vectorArray)	
end



