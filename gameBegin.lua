local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvent = ReplicatedStorage:WaitForChild("gameBegin")
local serverTime = ReplicatedStorage:WaitForChild("timeSinceStart")
local RunService = game:GetService("RunService");
local physicsService = game:GetService("PhysicsService")
workspace.Gravity = 0
local begunTime = nil

remoteEvent.OnServerEvent:Connect(function()
	if begunTime == nil then 
		begunTime = os.clock()
		local pname = "player"
		local ename = "enemies"
		local bname = "bullets"	
		local iname = "ignore"
		local gname = "goodBullet"
		physicsService:RegisterCollisionGroup(iname)
		physicsService:RegisterCollisionGroup(bname)
		physicsService:RegisterCollisionGroup(ename)
		physicsService:RegisterCollisionGroup(pname)
		physicsService:RegisterCollisionGroup(gname)
		physicsService:CollisionGroupSetCollidable(gname, pname, false)
		physicsService:CollisionGroupSetCollidable(ename, gname, false)
		physicsService:CollisionGroupSetCollidable(gname, bname, false)
		physicsService:CollisionGroupSetCollidable(gname, iname, false)
		physicsService:CollisionGroupSetCollidable(iname, bname, false)
		physicsService:CollisionGroupSetCollidable(iname, pname, false)
		physicsService:CollisionGroupSetCollidable(iname, iname, false)
		physicsService:CollisionGroupSetCollidable(iname, ename, false)
		physicsService:CollisionGroupSetCollidable(bname, bname, false)
		physicsService:CollisionGroupSetCollidable(bname, pname, false)
		physicsService:CollisionGroupSetCollidable(ename, pname, false)
		physicsService:CollisionGroupSetCollidable(bname, ename, false)		
		
	end
end)

local function timeCalculator()
	if begunTime ~= nil then
		serverTime.Value = os.clock() - begunTime
	end
end

RunService.Stepped:Connect(timeCalculator)
