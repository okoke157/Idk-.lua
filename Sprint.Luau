local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Xóa giao diện Sprint cũ nếu có để tránh bị trùng
if playerGui:FindFirstChild("MobileSprintGui") then
	playerGui.MobileSprintGui:Destroy()
end

-- ==========================================
-- 1. TẠO GIAO DIỆN SPRINT (GÓC PHẢI)
-- ==========================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MobileSprintGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Nút bấm Sprint
local sprintButton = Instance.new("TextButton")
sprintButton.Name = "SprintButton"
sprintButton.Size = UDim2.new(0, 100, 0, 100)
sprintButton.Position = UDim2.new(1, -140, 0.55, -50)
sprintButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
sprintButton.BackgroundTransparency = 0.4
sprintButton.TextColor3 = Color3.fromRGB(255, 255, 255)
sprintButton.TextSize = 18
sprintButton.Font = Enum.Font.SourceSansBold
sprintButton.Text = "CHẠY"
sprintButton.Active = true
sprintButton.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = sprintButton

-- Thanh thể lực (Stamina Bar) nằm phía trên nút CHẠY
local barBackground = Instance.new("Frame")
barBackground.Name = "BarBackground"
barBackground.Size = UDim2.new(0, 120, 0, 10)
barBackground.Position = UDim2.new(1, -130, 0.48, -20)
barBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
barBackground.BorderSizePixel = 0
barBackground.Parent = screenGui

local bgCorner = Instance.new("UICorner")
bgCorner.CornerRadius = UDim.new(0.5, 0)
bgCorner.Parent = barBackground

local barFill = Instance.new("Frame")
barFill.Name = "BarFill"
barFill.Size = UDim2.new(1, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
barFill.BorderSizePixel = 0
barFill.Parent = barBackground

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(0.5, 0)
fillCorner.Parent = barFill

-- ==========================================
-- 2. LOGIC XỬ LÝ SPRINT & THỂ LỰC
-- ==========================================
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

player.CharacterAdded:Connect(function(newChar)
	character = newChar
	humanoid = character:WaitForChild("Humanoid")
end)

local normalSpeed = 16
local sprintSpeed = 22 -- Đặt mức 22 để chống giật lùi vị trí (Rubberbanding)
local maxStamina = 1000
local currentStamina = 1000
local drainRate = 25
local regenRate = 200

local shiftPressed = false
local mobilePressed = false

-- Chỉ hiện nút trên thiết bị cảm ứng
if UserInputService.TouchEnabled then
	sprintButton.Visible = true
else
	sprintButton.Visible = false
end

-- Bắt sự kiện chạm trên Mobile
sprintButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		mobilePressed = true
		sprintButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	end
end)

sprintButton.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		mobilePressed = false
		sprintButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	end
end)

-- Phím Shift trên PC (nếu dùng giả lập)
UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftShift then
		shiftPressed = true
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftShift then
		shiftPressed = false
	end
end)

-- Vòng lặp cập nhật tốc độ và thể lực
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
