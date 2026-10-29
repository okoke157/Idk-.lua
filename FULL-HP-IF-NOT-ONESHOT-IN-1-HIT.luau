local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Bảng trạng thái
local isGodMode = false
local godConnection = nil

-- Tạo Giao diện (UI) nút bấm
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GodModeGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "GodToggleButton"
toggleButton.Size = UDim2.new(0, 150, 0, 50)
toggleButton.Position = UDim2.new(0.05, 0, 0.4, 0) -- Vị trí bên trái màn hình
toggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Màu đỏ (Trạng thái OFF)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 16
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.Text = "God Mode: OFF (F5)"
toggleButton.Parent = screenGui

-- Bo góc cho nút bấm
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = toggleButton

-- Hàm chuyển đổi trạng thái God Mode
local function toggleGodMode()
	local character = player.Character
	if not character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	isGodMode = not isGodMode

	if isGodMode then
		-- Bật God Mode
		toggleButton.Text = "God Mode: ON (F5)"
		toggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50) -- Màu xanh (Trạng thái ON)
		
		-- Hồi máu liên tục khi bị mất máu
		godConnection = humanoid.HealthChanged:Connect(function(health)
			if isGodMode and health < humanoid.MaxHealth and health > 0 then
				humanoid.Health = humanoid.MaxHealth
			end
		end)
	else
		-- Tắt God Mode
		toggleButton.Text = "God Mode: OFF (F5)"
		toggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Màu đỏ
		
		-- Hủy kết nối
		if godConnection then
			godConnection:Disconnect()
			godConnection = nil
		end
	end
end

-- 1. Sự kiện khi click/chạm vào nút trên màn hình
toggleButton.MouseButton1Click:Connect(toggleGodMode)

-- 2. Sự kiện khi bấm phím F5 trên Máy tính (PC)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	-- Nếu người chơi không đang gõ chat hoặc nhập văn bản
	if not gameProcessed then
		if input.KeyCode == Enum.KeyCode.F5 then
			toggleGodMode()
		end
	end
end)

-- Cập nhật lại kết nối khi nhân vật hồi sinh (Re-spawn)
player.CharacterAdded:Connect(function(newChar)
	local humanoid = newChar:WaitForChild("Humanoid")
	
	if isGodMode then
		if godConnection then godConnection:Disconnect() end
		godConnection = humanoid.HealthChanged:Connect(function(health)
			if isGodMode and health < humanoid.MaxHealth and health > 0 then
				humanoid.Health = humanoid.MaxHealth
			end
		end)
	end
end)
