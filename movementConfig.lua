 
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UserInputService = game:GetService("UserInputService");
local movingPart = workspace.player.playerHitbox;
local leftBall = movingPart.leftBall
local rightBall = movingPart.rightBall
local shiftPressed = ReplicatedStorage.LocalBindables:WaitForChild('shiftPressed')
local shiftReleased = ReplicatedStorage.LocalBindables:WaitForChild('shiftReleased')
local shiftPressedBoolean = false
local shiftMultiplier = 1
--game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.player.playerHitbox




local remoteEvent = ReplicatedStorage:WaitForChild('SendPos2Server')
-- Measured in studs per second.
local targetVelocity = 24;
local diagonalFix = 1;
local hitboxSize = 1;
local scene = workspace.scene;
local borderDownCap = scene.borderDown.Position.Y
local borderUpCap = scene.borderUp.Position.Y
local borderLeftCap = scene.borderLeft.Position.Z
local borderRightCap = scene.borderRight.Position.Z
local imAtTheEdge = false;
local TweenService = game:GetService("TweenService")
local vectorOffsetLeft = Vector3.new(0,0,3)
local desiredVectorOffset = Vector3.new(0,3,1)
local tweenValue = workspace.player.playerHitbox.tweenValue
local tweenInfo = TweenInfo.new(.10,Enum.EasingStyle.Linear)
local lastFrameTween = Vector3.new(0,0,0)
local tweenForward = TweenService:Create(tweenValue,tweenInfo, { Value = desiredVectorOffset })
local tweenBack = TweenService:Create(tweenValue,tweenInfo, {Value = vectorOffsetLeft})
local last = os.clock()


function shiftTween()
	if shiftPressedBoolean == true  then
		tweenForward:Play()
	else 
		tweenBack:Play()
	end
end
shiftPressed.Event:Connect(function()
	shiftPressedBoolean = true
	shiftMultiplier = .5

end)
shiftReleased.Event:Connect(function()
	shiftPressedBoolean = false 
	shiftMultiplier = 1
	lastFrameTween = tweenValue.Value
end)


local keyCodeToDirectionMap = {
	[Enum.KeyCode.W] = Vector3.new(0, 1, 0),
	[Enum.KeyCode.A] = Vector3.new(0, 0, -1),
	[Enum.KeyCode.S] = Vector3.new(0, -1, 0),
	[Enum.KeyCode.D] = Vector3.new(0, 0, 1),
};


local keyCodeToIsPressedMap = {
	[Enum.KeyCode.W] = false,
	[Enum.KeyCode.A] = false,
	[Enum.KeyCode.S] = false,
	[Enum.KeyCode.D] = false,
};


local function isRelevantInput(input)
	return (
		input.KeyCode == Enum.KeyCode.W
			or input.KeyCode == Enum.KeyCode.A
			or input.KeyCode == Enum.KeyCode.S
			or input.KeyCode == Enum.KeyCode.D
	);
end

local function getDirectionsToProcess()
	local directions = {};

	for keyCode, isPressed in pairs(keyCodeToIsPressedMap) do
		if isPressed then
			local direction = keyCodeToDirectionMap[keyCode];
			table.insert(directions, direction);
			
			local diagonalChecker = Vector3.new(0,0,0);

			for i,value in pairs(directions) do
				diagonalChecker = diagonalChecker + value
			end
			if diagonalChecker.Magnitude > 1.1 and imAtTheEdge == false then
				diagonalFix = 0.707
			else 
				diagonalFix = 1
			end
		end
	end

	return directions;
end

local function registerKeyPressed(input, gameProcessedEvent)
	if gameProcessedEvent or not isRelevantInput(input) then
		return;
	end

	keyCodeToIsPressedMap[input.KeyCode] = true;
end

local function unregisterKeyPressed(input, gameProcessedEvent)
	if gameProcessedEvent or not isRelevantInput(input) then
		return;
	end

	keyCodeToIsPressedMap[input.KeyCode] = false;
end


local function managePartMovement(step)
	local directions = getDirectionsToProcess();
	local targetPosition = movingPart.Position;

	for _, direction in ipairs(directions) do
		
		local offset = (targetVelocity * shiftMultiplier * diagonalFix * step) * direction;
		targetPosition = targetPosition + offset;
	end
	movingPart.Position = Vector3.new(targetPosition.X,math.clamp(targetPosition.Y,borderDownCap+hitboxSize,borderUpCap-hitboxSize),math.clamp(targetPosition.Z,borderLeftCap+hitboxSize,borderRightCap-hitboxSize))
	leftBall.Position = movingPart.Position + tweenValue.Value
	rightBall.Position = movingPart.Position + Vector3.new(0,tweenValue.Value.Y,-tweenValue.Value.Z)
	movingPart.body.Position = movingPart.Position
	--print(movingPart.Position)
	if targetPosition.Magnitude ~= movingPart.Position.Magnitude then 
		imAtTheEdge = true else
		imAtTheEdge = false
	end
	
	--remoteEvent:FireServer(movingPart.Position)
end

UserInputService.InputBegan:Connect(registerKeyPressed);
UserInputService.InputEnded:Connect(unregisterKeyPressed);
RunService.Heartbeat:Connect(managePartMovement); 
RunService.Heartbeat:Connect(shiftTween); 

