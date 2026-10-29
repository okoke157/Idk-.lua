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
local sprintSpeed = 30
local maxStamina = 100000
local currentStamina = 100000
local drainRate = 250
local regenRate = 20000

local shiftPressed = false
local mobilePressed = false

local gui = script.Parent
local sprintButton = gui:WaitForChild("SprintButton")
local barBackground = gui:WaitForChild("BarBackground")
local barFill = barBackground:WaitForChild("BarFill")

-- Bật hiển thị nút trên thiết bị di động
if UserInputService.TouchEnabled then
	sprintButton.Visible = true
else
	sprintButton.Visible = false
end

-- === TỐI ƯU RIÊNG CHO MOBILE EXECUTOR ===
-- Dùng kết hợp nhiều sự kiện chạm để đảm bảo Delta X nhận diện được thao tác của bạn
sprintButton.MouseButton1Down:Connect(function()
	mobilePressed = true
end)

sprintButton.MouseButton1Up:Connect(function()
	mobilePressed = false
end)

sprintButton.TouchTap:Connect(function()
	-- Hỗ trợ thêm cú chạm nhanh trên màn hình điện thoại
	mobilePressed = not mobilePressed
end)

sprintButton.MouseLeave:Connect(function()
	mobilePressed = false
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
