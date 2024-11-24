local markerTemp = game:GetService("ServerStorage").Marker
local RunService = game:GetService('RunService')
local fairyBasicPosition = Vector3.new( 224, 232, -16 )
local ran = false
local marker = markerTemp:Clone()
local ServerStorage = game:GetService("ServerStorage")
local Bezier = require(game:GetService("ReplicatedStorage").Bezier)

local p0 = workspace.Bezier.P0.Position
local p1 = workspace.Bezier.P1.Position
local p2 = workspace.Bezier.P2.Position
local p3 = workspace.Bezier.P3.Position

local marketTemp = game:GetService("ServerStorage").Marker

local curve = Bezier.new(100,p0,p1,p2,p3)

local t = 0



--[[
			local marker = markerTemp:Clone()
			marker.Position = blueFairyCalc(t)
			marker.Parent = workspace 
]]--
--[[
function createMarker(step)
	if ran == false then
		for t = 0, 7, 0.003 do 
			
			marker.Position = blueFairyCalc(t)
			marker.Parent = workspace 
			
		end
		ran = true
	end
end

]]--
function createMarker(step)
	if ran == false then  
		
	marker.Position = blueFairyCalc(t)
	marker.Parent = workspace 
	local vector3 = Instance.new("Vector3Value")
	vector3.Value = blueFairyCalc(t)
	vector3.Name = t
	vector3.Parent = ServerStorage.blueFairyVectors
	
	t = t + 0.003
	if t >= 7 then
		ran = true
	end
		
	end
		
end
	
function blueFairyCalc(t)
	if t < 1 then
		return Vector3.new(0,0 + (-15 * t),0)
	elseif t < 2 then
		return curve:Calc(t - 1) - Vector3.new( 224, 232, -16 )
	elseif t <= 7  then
		return Vector3.new(0,0 + (-9 * t) ,0 + (30))
	end
		
	
end




RunService.Heartbeat:Connect(createMarker)

