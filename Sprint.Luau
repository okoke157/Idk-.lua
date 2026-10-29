local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

player.CharacterAdded:Connect(function(newChar)
	character = newChar
	humanoid = character:WaitForChild("Humanoid")
end)

local normalSpeed = 16
local sprintSpeed = 26
local maxStamina = 100
local currentStamina = 100
local drainRate = 35
local regenRate = 25

local shiftPressed = false
local mobilePressed = false

local gui = script.Parent
local sprintButton = gui:WaitForChild("SprintButton")
local barBackground = gui:WaitForChild("BarBackground")
local barFill = barBackground:WaitForChild("BarFill")

-- === KIỂM TRA LOẠI THIẾT BỊ ===
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

if isMobile then
	-- Nếu là Điện thoại: Hiển thị nút bấm ảo trên màn hình
	sprintButton.Visible = true
else
	-- Nếu là Máy tính (PC): Ẩn nút bấm ảo đi vì người chơi dùng phím Shift
	sprintButton.Visible = false
end

-- Xử lý nút bấm trên Điện thoại
sprintButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		mobilePressed = true
	end
end)

sprintButton.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		mobilePressed = false
	end
end)

-- Xử lý bàn phím Máy tính (Left Shift)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.LeftShift then
		shiftPressed = true
	end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.LeftShift then
		shiftPressed = false
	end
end)

-- Vòng lặp cập nhật thể lực và tốc độ
RunService.RenderStepped:Connect(function(dt)
	if not humanoid or humanoid.Health <= 0 then return end

	local isMoving = humanoid.MoveDirection.Magnitude > 0
	local wantsToSprint = (shiftPressed or mobilePressed) and isMoving

	if wantsToSprint and currentStamina > 0 then
		currentStamina = math.clamp(currentStamina - drainRate * dt, 0, maxStamina)
		humanoid.WalkSpeed = sprintSpeed
		
		if currentStamina <= 0 then
			humanoid.WalkSpeed = normalSpeed
		end
	else
		humanoid.WalkSpeed = normalSpeed
		currentStamina = math.clamp(currentStamina + regenRate * dt, 0, maxStamina)
	end

	barFill.Size = UDim2.new(currentStamina / maxStamina, 0, 1, 0)
end)
