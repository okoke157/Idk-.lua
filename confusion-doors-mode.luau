local function safeCaption(text)
    pcall(function()
        local mainGame = game.Players.LocalPlayer.PlayerGui:WaitForChild("MainUI"):WaitForChild("Initiator"):WaitForChild("Main_Game")
        require(mainGame).caption(text, true)
    end)
end

safeCaption("Bạn đã chạy Confusion Mode v0.1")
task.wait(2)
safeCaption("Ý tưởng: UnknownUser2450, xin cảm ơn cho các nhà sản xuất thực thể")
task.wait(2)
safeCaption("Cái mode này có thể bị lỗi")
task.wait(2)
safeCaption("p°/•£€~♤•>~£`□□^_")
task.wait(2)
safeCaption("£••££~*•£•££><^^♤&&")
task.wait(2)
safeCaption("Việt hóa bởi viet09544 và zombir_man")

pcall(function()
    local playerGui = game.Players.LocalPlayer.PlayerGui
    local mainFrame = playerGui:WaitForChild("MainUI"):WaitForChild("MainFrame")
    local shut = mainFrame:WaitForChild("IntroText")
    
    local intro = shut:Clone()
    intro.Parent = playerGui.MainUI
    intro.Name = "Confusion Mode Intro"
    intro.Visible = true
    intro.Text = "Khách Sạn Confused"
    intro.TextTransparency = 0
    
    local underline = intro:FindFirstChild("Underline")
    if underline then
        local targetSize1 = UDim2.new(1.1, 0, 0.015, 6)
        game.TweenService:Create(underline, TweenInfo.new(3), {Size = targetSize1}):Play()
        task.wait(7)
        
        local targetSize2 = UDim2.new(0.95, 0, 0.015, 6)
        game.TweenService:Create(underline, TweenInfo.new(1.3), {Size = targetSize2}):Play()
        task.wait(1)
        
        game.TweenService:Create(underline, TweenInfo.new(2), {ImageTransparency = 1}):Play()
    end
    
    game.TweenService:Create(intro, TweenInfo.new(2), {TextTransparency = 1}):Play()
    
    if underline then
        game.TweenService:Create(underline, TweenInfo.new(7), {Size = UDim2.new(0, 0, 0.015, 6)}):Play()
    end
    
    task.wait(2.3)
    intro.Visible = false
    task.wait(4)
    intro:Destroy()
end)

coroutine.wrap(function()
    while true do
        task.wait(25)
        pcall(function()
            local latestRoom = game.ReplicatedStorage:WaitForChild("GameData"):WaitForChild("LatestRoom")
            latestRoom.Changed:Wait()
            local success, res = pcall(function()
                return game:HttpGet("https://raw.githubusercontent.com/Francisco1692qzd/RevivedOldHardcore/refs/heads/main/oldShocker.lua")
            end)
            if success and res then
                loadstring(res)()
            end
        end)
    end
end)() 

coroutine.wrap(function()
    while true do
        task.wait(75)
        pcall(function()
            local latestRoom = game.ReplicatedStorage:WaitForChild("GameData"):WaitForChild("LatestRoom")
            latestRoom.Changed:Wait()
            local success, res = pcall(function()
                return game:HttpGet("https://raw.githubusercontent.com/PurpleHatsoOfficial/OMG-HC-REMAKE-RETAKE/refs/heads/main/Cease%20v1.txt")
            end)
            if success and res then
                loadstring(res)()
            end
        end)
    end
end)()

coroutine.wrap(function()
    while true do
        task.wait(250)
        pcall(function()
            local latestRoom = game.ReplicatedStorage:WaitForChild("GameData"):WaitForChild("LatestRoom")
            latestRoom.Changed:Wait()
            local success, res = pcall(function()
                return game:HttpGet("https://pastebin.com/raw/2SAwkPLt")
            end)
            if success and res then
                loadstring(res)()
            end
        end)
    end
end)()

coroutine.wrap(function()
    while true do
        task.wait(math.random(300, 510))
        pcall(function()
            local spawnerFunc = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))
            if spawnerFunc then
                local spawner = spawnerFunc()
                local e = spawner.Create({
                    Entity = {Name = "Depth", Asset = "https://github.com/sofianmohamedovich-cmyk/tes/blob/main/DEPTHNEWREMAKE.rbxm?raw=true", HeightOffset = 0},
                    Lights = {Flicker = {Enabled = true, Duration = 5}, Shatter = true, Repair = false},
                    Earthquake = {Enabled = false},
                    CameraShake = {Enabled = true, Range = 100, Values = {1.5, 20, 0.1, 1}},
                    Movement = {Speed = 150, Delay = 1, Reversed = false},
                    Rebounding = {Enabled = true, Type = "Ambush", Min = 3, Max = 3, Delay = 1},
                    Damage = {Enabled = true, Range = 40, Amount = 100},
                    Crucifixion = {Enabled = true, Range = 40, Resist = false, Break = true},
                    Death = {Type = "Guiding", Hints = {"Bạn chết bởi depth(độ sâu)..", "Khi đèn chớp, Trốn!", "Dùng kiến thức bạn đã học được từ Ambush.", "Bạn có thể làm được!"}, Cause = "Depth(Độ sâu)"}
                })
                e:Run()
            end
        end)
    end
end)()

coroutine.wrap(function()
    while true do
        task.wait(math.random(80, 155))
        pcall(function()
            local spawnerFunc = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))
            if spawnerFunc then
                local spawner = spawnerFunc()
                local e = spawner.Create({
                    Entity = {Name = "Smiley", Asset = "https://github.com/sofianmohamedovich-cmyk/tes/blob/main/smiley.rbxm?raw=true", HeightOffset = 0},
                    Lights = {Flicker = {Enabled = true, Duration = 20}, Shatter = true, Repair = false},
                    Earthquake = {Enabled = false},
                    CameraShake = {Enabled = true, Range = 100, Values = {1.0, 10, 0.1, 1}},
                    Movement = {Speed = 100, Delay = 2, Reversed = false},
                    Rebounding = {Enabled = false, Type = "Ambush", Min = 5, Max = 8, Delay = 2},
                    Damage = {Enabled = true, Range = 40, Amount = 100},
                    Crucifixion = {Enabled = true, Range = 40, Resist = false, Break = true},
                    Death = {Type = "Guiding", Hints = {"Bạn chết bởi smiley..", "Khi đèn chớp, Trốn!", "Dùng kiến thức bạn đã học Rush, nó chỉ hơi chậm.", "Bạn có thể làm được!"}, Cause = "Smiley(Mặt cười)"}
                })
                e:Run()
            end
        end)
    end
end)()

coroutine.wrap(function()
    while true do
        task.wait(math.random(1000, 5000))
        pcall(function()
            local spawnerFunc = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))
            if spawnerFunc then
                local spawner = spawnerFunc()
                local e = spawner.Create({
                    Entity = {Name = "A-60", Asset = "https://github.com/sofianmohamedovich-cmyk/tes/blob/main/A60.rbxm?raw=true", HeightOffset = 0},
                    Lights = {Flicker = {Enabled = true, Duration = 30}, Shatter = false, Repair = false},
                    Earthquake = {Enabled = false},
                    CameraShake = {Enabled = false, Range = 100, Values = {1.0, 10, 0.1, 1}},
                    Movement = {Speed = 300, Delay = 2, Reversed = false},
                    Rebounding = {Enabled = true, Type = "Ambush", Min = 20, Max = 30, Delay = 3},
                    Damage = {Enabled = true, Range = 40, Amount = 100},
                    Crucifixion = {Enabled = true, Range = 40, Resist = false, Break = true},
                    Death = {Type = "Guiding", Hints = {"Bạn đã chết vì...", "Tôi.. không biết ..?", "Tôi.. Not sure how to help không chắc làm thế nào để giúp bạn được, Tôi thực sự xin lỗi..", "Cẩn thẩn lần sau."}, Cause = "A-??"}
                })
                e:Run()
            end
        end)
    end
end)()

coroutine.wrap(function()
    while true do
        task.wait(math.random(200, 355))
        pcall(function()
            local spawnerFunc = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))
            if spawnerFunc then
                local spawner = spawnerFunc()
                local e = spawner.Create({
                    Entity = {Name = "A-200", Asset = "https://github.com/sofianmohamedovich-cmyk/tes/blob/main/A200.rbxm?raw=true", HeightOffset = 0},
                    Lights = {Flicker = {Enabled = true, Duration = 10}, Shatter = false, Repair = false},
                    Earthquake = {Enabled = false},
                    CameraShake = {Enabled = false, Range = 100, Values = {1.0, 10, 0.1, 1}},
                    Movement = {Speed = 30, Delay = 5, Reversed = true},
                    Rebounding = {Enabled = false, Type = "Ambush", Min = 20, Max = 30, Delay=3},
                    Damage = {Enabled = true, Range = 20, Amount = 100},
                    Crucifixion = {Enabled = true, Range = 40, Resist = self and true or false, Break = true}, -- Đã tối ưu logic
                    Death = {Type = "Guiding", Hints = {"Bạn đã chết vì.....", "Tôi.. không biết ..?", "Tôi.. không chắc làm thế nào để giúp được, Tôi vô cùng xin lỗi...", "Lần sau hãy cẩn thận hơn nhé..", "Hình nó tên là A-.."}, Cause = "A-???"}
                })
                e:Run()
            end
        end)
    end
end)()
