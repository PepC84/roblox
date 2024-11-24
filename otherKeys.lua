local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local movingPart = workspace.player.playerHitbox;
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local bindables = ReplicatedStorage.LocalBindables
local shiftPressed = bindables.shiftPressed
local shiftReleased = bindables.shiftReleased
local backspacePressed = bindables.backspacePressed
local backspaceReleased = bindables.backspaceReleased
local spacePressed = bindables.spacePressed
local spaceReleased = bindables.spaceReleased
local xPressed = bindables.xPressed
local xReleased = bindables.xReleased
local keyCodeToIsPressedMap = {
	[Enum.KeyCode.LeftShift] = false,
	[Enum.KeyCode.Space] = false,
	[Enum.KeyCode.X] = false,
	[Enum.KeyCode.Tab] = false,
	[Enum.KeyCode.RightShift] = false,
};


local function isRelevantInput(input)
	return (
		input.KeyCode == Enum.KeyCode.LeftShift
			or input.KeyCode == Enum.KeyCode.RightShift
			or input.KeyCode == Enum.KeyCode.Space
			or input.KeyCode == Enum.KeyCode.X
			or input.KeyCode == Enum.KeyCode.Backspace
	);
end


local function registerKeyPressed(input, gameProcessedEvent)
	if gameProcessedEvent or not isRelevantInput(input) then
		return;
	end
	if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then 
		--_G.shiftMultiplier = 0.5
		shiftPressed:Fire()
	end
	if input.KeyCode == Enum.KeyCode.Space then
		spacePressed:Fire()
	end
	if input.KeyCode == Enum.KeyCode.X then
		xPressed:Fire()
	end
	if input.KeyCode == Enum.KeyCode.Backspace then
		backspacePressed:Fire()
	end
	keyCodeToIsPressedMap[input.KeyCode] = true;
end

local function unregisterKeyPressed(input, gameProcessedEvent)
	if gameProcessedEvent or not isRelevantInput(input) then
		return;
	end
	if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then 
		--_G.shiftMultiplier = 1
		shiftReleased:Fire()
	end
	if input.KeyCode == Enum.KeyCode.Space then
		spaceReleased:Fire()
	end
	if input.KeyCode == Enum.KeyCode.X then
		xReleased:Fire()
	end
	if input.KeyCode == Enum.KeyCode.Backspace then
		backspaceReleased:Fire()
	end
	
	keyCodeToIsPressedMap[input.KeyCode] = false;
end


UserInputService.InputBegan:Connect(registerKeyPressed);
UserInputService.InputEnded:Connect(unregisterKeyPressed);
