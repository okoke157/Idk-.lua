local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Xóa giao diện cũ nếu có để tránh bị trùng lặp
if playerGui:FindFirstChild("MobileSprintGui") then
	playerGui.MobileSprintGui:Destroy()
end

-- 1. TẠO GIAO DIỆN ẢO TRỰC TIẾP BẰNG SCRIPT
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MobileSprintGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Nút bấm Sprint (Nằm ở góc phải)
local sprintButton = Instance.new("TextButton")
sprintButton.Name = "SprintButton"
sprintButton.Size = UDim2.new(0, 100, 0, 100)
sprintButton.Position = UDim2.new(1, -140, 0.55, -50)
sprintButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
sprintButton.BackgroundTransparency = 0.4
sprintButton.TextColor3 = Color3.fromRGB(255, 255, 255)
sprintButton.TextSize = 18
sprintButton.Font = Enum.Font.SourceSansBold
sprintButton.Text = "Sprint"
sprintButton.Active = true
sprintButton.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = sprintButton

-- Thanh thể lực (Stamina Bar) đã được dịch chuyển xuống góc phải, nằm ngay trên nút CHẠY
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

-- 2. LOGIC XỬ LÝ CHẠY VÀ THỂ LỰC
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

player.CharacterAdded:Connect(function(newChar)
	character = newChar
	humanoid = character:WaitForChild("Humanoid")
end)

local normalSpeed = 16
local sprintSpeed = 30
local maxStamina = 100000
local currentStamina = 100000
local drainRate = 250
local regenRate = 20000

local shiftPressed = false
local mobilePressed = false

-- Chỉ hiện nút trên thiết bị cảm ứng điện thoại
if UserInputService.TouchEnabled then
	sprintButton.Visible = true
else
	sprintButton.Visible = false
end

-- Bắt sự kiện chạm trên Mobile Executor
sprintButton.MouseButton1Down:Connect(function()
	mobilePressed = true
	sprintButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
end)

sprintButton.MouseButton1Up:Connect(function()
	mobilePressed = false
	sprintButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)

sprintButton.TouchLeave:Connect(function()
	mobilePressed = false
	sprintButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)

-- Xử lý phím Shift trên PC (nếu chơi giả lập/bàn phím)
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
