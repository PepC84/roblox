


ReplicatedStorage = game:GetService('ReplicatedStorage')
RunService = game:GetService('RunService')
yLimit = 231.5
fairyVectorsTable = require(ReplicatedStorage.paths.firstStage.redFairy.downwaitUpright)
fairiesToClone = ReplicatedStorage.Assets.enemyAssets.firstRedFairies --fairies to clone from replicated storage to workplace so clients can see it
whereToClone = workspace.enemies.miniEnemies.redFairies

local tweenArray = {}
local initialPos = {}
local fairiesDone = {}
local directionArray = {}
local totalFairies = 0
local previousTime = 0
local negativeMultiplier = 0
local clockArray = {}
fairiesToClone:Clone().Parent = whereToClone
subfolder = whereToClone.firstRedFairies
for k,v in pairs(subfolder:GetChildren()) do
	v:SetAttribute('id', k)
	clockArray[k] = os.clock()
	totalFairies = totalFairies + 1 
end


function main() 
	for _,v in pairs(subfolder:GetChildren()) do

		if v.Position.Y <= 165 or v.Position.Z < -23 or v.Position.Z > 23 then 
			local i = v:GetAttribute('id')
			fairiesDone[i] = true
			v:Destroy()
			if #subfolder:GetChildren() < 1 then
				script:Destroy()
			end

			do continue end
		end

		if v.Position.Y >= 231.5 then
			if v:GetAttribute('step') == 0 then 
				v.Position = v.Position + (Vector3.new(0,-.1 * 60,0) * ( os.clock() - clockArray[v:GetAttribute('id')] ))
				clockArray[v:GetAttribute('id')] = os.clock()

				do continue end
			end

		end
		local i = v:GetAttribute('id')
		if initialPos[i] == nil then 
			initialPos[i] = v.Position
			negativeMultiplier = negativeMultiplier + 1
			directionArray[i] =	math.pow(-1, negativeMultiplier)
		end 


		local step = v:GetAttribute('step')
		if fairyVectorsTable[step + 1] == nil then
			v:Destroy()
			fairiesDone[i] = true
			do continue end
		end
		v.Position = initialPos[i] + Vector3.new(0,fairyVectorsTable[step + 1].Y, directionArray[i] * fairyVectorsTable[step + 1].Z) 
		v:SetAttribute('step',step + 1)
		clockArray[i] = os.clock()
	end

end

RunService.Heartbeat:Connect(main)
