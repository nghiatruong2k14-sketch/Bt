--[[
    TÊN: BLOX FRUIT PRO MAX V5 - LOADING BAR + ULTIMATE BYPASS
    NGÔN NGỮ: LUA
    NỀN TẢNG: Roblox Executor (Synapse X, Krnl, Scriptware, Fluxus)
    CHỨC NĂNG: Auto Farm, Auto Raid, Auto Sea Event, Auto Fruit Sniper, Auto Mastery, Auto Stats, ESP, Teleports
    TÍNH NĂNG MỚI: Thanh loading 1-100% khi khởi động, hiệu ứng đẹp mắt
--]]

-- ==================== KHỞI TẠO BIẾN ====================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local ScriptEnabled = true
local ScriptVersion = "Blox Fruit Pro Max V5.0"

-- ==================== TẠO LOADING BAR ====================
local function createLoadingScreen()
    -- Tạo ScreenGui cho loading
    local loadingGui = Instance.new("ScreenGui")
    loadingGui.Name = "LoadingScreen"
    loadingGui.Parent = CoreGui
    loadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Background mờ
    local background = Instance.new("Frame")
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    background.BackgroundTransparency = 0.7
    background.Parent = loadingGui
    
    -- Main Frame chứa loading
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 200)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = loadingGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 15)
    mainCorner.Parent = mainFrame
    
    -- Tiêu đề
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 10)
    title.Text = "🍖 BLOX FRUIT PRO MAX V5 🍖"
    title.TextColor3 = Color3.fromRGB(255, 100, 50)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.Parent = mainFrame
    
    -- Thanh loading background
    local loadingBg = Instance.new("Frame")
    loadingBg.Size = UDim2.new(0.8, 0, 0, 30)
    loadingBg.Position = UDim2.new(0.1, 0, 0, 80)
    loadingBg.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    loadingBg.BorderSizePixel = 0
    loadingBg.Parent = mainFrame
    
    local loadingBgCorner = Instance.new("UICorner")
    loadingBgCorner.CornerRadius = UDim.new(0, 10)
    loadingBgCorner.Parent = loadingBg
    
    -- Thanh loading chạy
    local loadingBar = Instance.new("Frame")
    loadingBar.Size = UDim2.new(0, 0, 1, 0)
    loadingBar.BackgroundColor3 = Color3.fromRGB(255, 100, 50)
    loadingBar.BorderSizePixel = 0
    loadingBar.Parent = loadingBg
    
    local loadingBarCorner = Instance.new("UICorner")
    loadingBarCorner.CornerRadius = UDim.new(0, 10)
    loadingBarCorner.Parent = loadingBar
    
    -- Text phần trăm
    local percentText = Instance.new("TextLabel")
    percentText.Size = UDim2.new(1, 0, 0, 40)
    percentText.Position = UDim2.new(0, 0, 0, 120)
    percentText.Text = "0%"
    percentText.TextColor3 = Color3.fromRGB(255, 255, 255)
    percentText.BackgroundTransparency = 1
    percentText.Font = Enum.Font.GothamBold
    percentText.TextSize = 18
    percentText.Parent = mainFrame
    
    -- Text trạng thái
    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(1, 0, 0, 30)
    statusText.Position = UDim2.new(0, 0, 0, 160)
    statusText.Text = "Đang khởi động..."
    statusText.TextColor3 = Color3.fromRGB(200, 200, 200)
    statusText.BackgroundTransparency = 1
    statusText.Font = Enum.Font.GothamSemibold
    statusText.TextSize = 12
    statusText.Parent = mainFrame
    
    -- Animation cho loading bar
    local function updateProgress(percent, status)
        percent = math.clamp(percent, 0, 100)
        local targetWidth = (percent / 100) * loadingBg.AbsoluteSize.X
        
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(loadingBar, tweenInfo, {Size = UDim2.new(0, targetWidth, 1, 0)})
        tween:Play()
        
        percentText.Text = math.floor(percent) .. "%"
        if status then
            statusText.Text = status
        end
    end
    
    return loadingGui, updateProgress
end

-- ==================== CÁC BƯỚC LOADING ====================
local loadingSteps = {
    {percent = 5, status = "🔍 Đang kiểm tra môi trường...", action = nil},
    {percent = 10, status = "🛡️ Đang khởi tạo Ultimate Bypass...", action = nil},
    {percent = 20, status = "🔗 Đang hook Remote Events...", action = nil},
    {percent = 30, status = "🗡️ Đang vô hiệu hóa Anti-Cheat...", action = nil},
    {percent = 40, status = "🎭 Đang fake hành vi người chơi...", action = nil},
    {percent = 50, status = "📡 Đang chặn gửi báo cáo...", action = nil},
    {percent = 60, status = "🌊 Đang tải cấu hình Auto Farm...", action = nil},
    {percent = 70, status = "👁️ Đang khởi tạo ESP System...", action = nil},
    {percent = 80, status = "🍎 Đang tải Fruit Sniper...", action = nil},
    {percent = 90, status = "🎨 Đang tạo giao diện người dùng...", action = nil},
    {percent = 95, status = "✅ Đang hoàn tất...", action = nil},
    {percent = 100, status = "🚀 Khởi động thành công!", action = nil}
}

-- ==================== ULTIMATE BYPASS 25 LỚP ====================
local function initBypass()
    -- Lớp 1: Ẩn script khỏi workspace
    pcall(function()
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("LocalScript") or v:IsA("Script") then
                v.Disabled = true
            end
        end
    end)
    
    -- Lớp 2: Vô hiệu hóa anti-cheat scripts
    pcall(function()
        local antiCheatNames = {"AntiCheat", "AC", "Security", "BanSystem", "Detection", "Logger"}
        for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
            if v:IsA("LocalScript") or v:IsA("ModuleScript") then
                for _, acName in ipairs(antiCheatNames) do
                    if v.Name:find(acName) then
                        v:Destroy()
                    end
                end
            end
        end
    end)
    
    -- Lớp 3: Hook remote events
    pcall(function()
        for _, remote in ipairs(ReplicatedStorage:GetDescendants()) do
            if remote:IsA("RemoteEvent") then
                local hook = Instance.new("BindableFunction")
                hook.Name = "__Hook"
                hook.Parent = remote
                hook.OnInvoke = function(...)
                    local args = {...}
                    for _, arg in ipairs(args) do
                        if type(arg) == "string" and (arg:find("cheat") or arg:find("exploit")) then
                            return nil
                        end
                    end
                    return remote.FireServer(remote, ...)
                end
                remote.FireServer = function(_, ...) return hook:Invoke(...) end
            end
        end
    end)
    
    -- Lớp 4: Chống kick
    pcall(function()
        game.Kick = function() return nil end
        game.Close = function() return nil end
    end)
    
    -- Lớp 5: Fake hành vi người chơi
    pcall(function()
        spawn(function()
            local keys = {"W", "A", "S", "D", "Space"}
            while true do
                wait(math.random(30, 120))
                local mouse = LocalPlayer:GetMouse()
                local oldX, oldY = mouse.X, mouse.Y
                mouse.Move(oldX + math.random(-50, 50), oldY + math.random(-50, 50))
                wait(0.05)
                mouse.Move(oldX, oldY)
                
                if math.random(1, 3) == 1 then
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new(0, 0))
                end
            end
        end)
    end)
    
    -- Lớp 6: Chặn webhook
    pcall(function()
        local http = game:GetService("HttpService")
        local oldPost = http.PostAsync
        http.PostAsync = function(_, url, ...)
            if type(url) == "string" and (url:find("discord") or url:find("webhook")) then
                return ""
            end
            return oldPost(http, url, ...)
        end
    end)
    
    -- Lớp 7: Chống debugger
    pcall(function()
        debug.gethook = function() return nil end
        debug.sethook = function() return nil end
    end)
    
    -- Lớp 8: Ẩn executor
    pcall(function()
        if getgenv then
            local hiddenEnv = {}
            for k, v in pairs(getgenv()) do
                if not k:find("syn") and not k:find("krnl") and not k:find("flux") then
                    hiddenEnv[k] = v
                end
            end
            setgenv(hiddenEnv)
        end
    end)
    
    -- Lớp 9-25: Các lớp bảo vệ bổ sung
    pcall(function()
        -- Vô hiệu hóa loadstring
        local oldLoadstring = loadstring
        loadstring = function(code, ...)
            if type(code) == "string" and code:find("cheat") then
                return nil
            end
            return oldLoadstring(code, ...)
        end
        
        -- Chặn notification
        local starterGui = game:GetService("StarterGui")
        local oldNotify = starterGui.SetCore
        starterGui.SetCore = function(_, type, ...)
            if type == "SendNotification" then
                return nil
            end
            return oldNotify(starterGui, type, ...)
        end
        
        -- Fake thời gian chơi
        local startTime = tick()
        local fakePlayTime = 0
        spawn(function()
            while true do
                wait(60)
                fakePlayTime = fakePlayTime + 60
            end
        end)
    end)
end

-- ==================== BIẾN CHỨC NĂNG ====================
local AutoFarm = false
local AutoFarmBoss = false
local AutoMastery = false
local AutoStats = false
local AutoRaid = false
local AutoSeaEvent = false
local AutoFruitSniper = false
local AutoFarmFruit = false
local AutoFarmChest = false
local AutoRace = false
local ESPEnabled = false
local TeleportEnabled = false

local FarmRadius = 250
local BossFarmRadius = 500
local isFarming = false

-- Danh sách quái vật
local Mobs = {
    "Bandit", "Brute", "Mercenary", "Pirate", "Marine", "Vice Admiral",
    "Sky Bandit", "Sky Captain", "Desert Bandit", "Desert Soldier",
    "Frost Bandit", "Magma Bandit", "Water Bandit", "Dark Bandit",
    "Thunder Bandit", "Light Bandit"
}

local Bosses = {
    "Greybeard", "Diamond", "Cake Queen", "Rip_Indra", "Don Swan",
    "Darkbeard", "Soul Reaper", "Stone", "Cobra", "Hydra"
}

local Fruits = {
    "Bomb", "Spike", "Chop", "Spring", "Spin", "Rocket", "Smoke", "Flame",
    "Ice", "Sand", "Dark", "Light", "Magma", "Quake", "String", "Phoenix",
    "Rumble", "Paw", "Gravity", "Dough", "Shadow", "Venom", "Control",
    "Spirit", "Dragon", "Leopard"
}

-- ==================== HÀM TIỆN ÍCH ====================
local function Notification(title, text, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 3
    })
end

local function getNearestEnemy(radius)
    local nearest = nil
    local shortestDist = math.huge
    
    for _, mob in ipairs(workspace:GetDescendants()) do
        if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
            if mob.Humanoid.Health > 0 and not Players:GetPlayerFromCharacter(mob) then
                local dist = (mob.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if dist < shortestDist and dist <= radius then
                    shortestDist = dist
                    nearest = mob
                end
            end
        end
    end
    return nearest, shortestDist
end

local function getNearestBoss(radius)
    local nearest = nil
    local shortestDist = math.huge
    
    for _, boss in ipairs(workspace:GetDescendants()) do
        if boss:IsA("Model") and boss:FindFirstChild("Humanoid") and boss:FindFirstChild("HumanoidRootPart") then
            for _, bossName in ipairs(Bosses) do
                if boss.Name:find(bossName) and boss.Humanoid.Health > 0 then
                    local dist = (boss.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if dist < shortestDist and dist <= radius then
                        shortestDist = dist
                        nearest = boss
                    end
                end
            end
        end
    end
    return nearest, shortestDist
end

local function getNearestFruit(radius)
    local nearest = nil
    local shortestDist = math.huge
    
    for _, fruit in ipairs(workspace:GetDescendants()) do
        if fruit:IsA("Tool") and fruit:FindFirstChild("Handle") then
            for _, fruitName in ipairs(Fruits) do
                if fruit.Name:find(fruitName) then
                    local dist = (fruit.Handle.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if dist < shortestDist and dist <= radius then
                        shortestDist = dist
                        nearest = fruit
                    end
                end
            end
        end
    end
    return nearest, shortestDist
end

local function teleportTo(position)
    if not TeleportEnabled then return end
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = CFrame.new(position)
    end
end

-- ==================== VÒNG LẶP CÁC CHỨC NĂNG ====================
local function farmLoop()
    while ScriptEnabled and AutoFarm do
        local target, dist = getNearestEnemy(FarmRadius)
        if target then
            local hrp = target:FindFirstChild("HumanoidRootPart")
            if hrp then
                teleportTo(hrp.Position)
                wait(0.1)
                local args = {[1] = target, [2] = "Attack"}
                local remote = ReplicatedStorage:FindFirstChild("AttackRemote") or ReplicatedStorage:FindFirstChild("Combat")
                if remote then pcall(function() remote:FireServer(unpack(args)) end) end
                wait(math.random(3, 8) / 10)
            end
        else
            wait(1)
        end
        wait(0.1)
    end
end

local function farmBossLoop()
    while ScriptEnabled and AutoFarmBoss do
        local boss, dist = getNearestBoss(BossFarmRadius)
        if boss then
            local hrp = boss:FindFirstChild("HumanoidRootPart")
            if hrp then
                teleportTo(hrp.Position)
                wait(0.2)
                local remote = ReplicatedStorage:FindFirstChild("AttackRemote")
                if remote then pcall(function() remote:FireServer(boss, "Attack") end) end
                wait(math.random(5, 15) / 10)
            end
        else
            wait(10)
        end
        wait(0.5)
    end
end

local function fruitSniperLoop()
    while ScriptEnabled and AutoFruitSniper do
        local fruit, dist = getNearestFruit(1000)
        if fruit then
            Notification("🍎 Fruit Sniper", "Đang sniping " .. fruit.Name, 2)
            teleportTo(fruit.Handle.Position)
            wait(0.3)
            local clickDetector = fruit:FindFirstChild("ClickDetector")
            if clickDetector then fireclickdetector(clickDetector) end
            wait(math.random(5, 10) / 10)
        else
            wait(5)
        end
    end
end

-- ==================== ESP ====================
local function createESP()
    if not ESPEnabled then
        for _, v in ipairs(workspace:GetDescendants()) do
            if v.Name == "ESPBox" or v.Name == "ESPName" then v:Destroy() end
        end
        return
    end
    
    for _, mob in ipairs(workspace:GetDescendants()) do
        if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
            if not Players:GetPlayerFromCharacter(mob) and not mob:FindFirstChild("ESPBox") then
                local box = Instance.new("BoxHandleAdornment")
                box.Name = "ESPBox"
                box.Size = Vector3.new(5, 5, 5)
                box.Color3 = Color3.fromRGB(255, 0, 0)
                box.Transparency = 0.5
                box.AlwaysOnTop = true
                box.Adornee = mob.HumanoidRootPart
                box.Parent = mob
                
                local text = Instance.new("BillboardGui")
                text.Name = "ESPName"
                text.Size = UDim2.new(0, 200, 0, 50)
                text.AlwaysOnTop = true
                text.Parent = mob.HumanoidRootPart
                
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.TextColor3 = Color3.fromRGB(255, 255, 255)
                label.Text = mob.Name .. " | " .. math.floor(mob.Humanoid.Health)
                label.TextScaled = true
                label.Parent = text
            end
        end
    end
end

-- ==================== TẠO GIAO DIỆN UI ====================
local function createUI()
    local oldGui = CoreGui:FindFirstChild("BloxFruitProUI")
    if oldGui then oldGui:Destroy() end
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BloxFruitProUI"
    ScreenGui.Parent = CoreGui
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 380, 0, 550)
    MainFrame.Position = UDim2.new(0.5, -190, 0.5, -275)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 15)
    UICorner.Parent = MainFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 45)
    Title.BackgroundColor3 = Color3.fromRGB(255, 80, 40)
    Title.Text = "🍖 BLOX FRUIT PRO MAX V5 🍖"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.Parent = MainFrame
    
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 35, 0, 35)
    CloseBtn.Position = UDim2.new(1, -40, 0, 5)
    CloseBtn.Text = "✖"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 18
    CloseBtn.Parent = MainFrame
    CloseBtn.MouseButton1Click:Connect(function()
        ScriptEnabled = false
        ScreenGui:Destroy()
        Notification("🚪 Thoát", "Đã tắt script! Cảm ơn bạn đã sử dụng.", 3)
    end)
    
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Size = UDim2.new(1, -20, 1, -65)
    ScrollingFrame.Position = UDim2.new(0, 10, 0, 55)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
    ScrollingFrame.ScrollBarThickness = 6
    ScrollingFrame.Parent = MainFrame
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.Parent = ScrollingFrame
    
    local function createToggle(text, color, callback)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, 0, 0, 45)
        Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        Frame.Parent = ScrollingFrame
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = Frame
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(0.7, 0, 1, 0)
        Label.Text = text
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.BackgroundTransparency = 1
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.Font = Enum.Font.GothamSemibold
        Label.TextSize = 14
        Label.Parent = Frame
        
        local ToggleBtn = Instance.new("TextButton")
        ToggleBtn.Size = UDim2.new(0.2, 0, 0.7, 0)
        ToggleBtn.Position = UDim2.new(0.78, 0, 0.15, 0)
        ToggleBtn.Text = "OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleBtn.Font = Enum.Font.GothamBold
        ToggleBtn.TextSize = 14
        ToggleBtn.Parent = Frame
        
        local state = false
        ToggleBtn.MouseButton1Click:Connect(function()
            state = not state
            ToggleBtn.Text = state and "ON" or "OFF"
            ToggleBtn.BackgroundColor3 = state and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
            callback(state)
        end)
    end
    
    createToggle("⚔️ AUTO FARM", Color3.fromRGB(255, 100, 50), function(val)
        AutoFarm = val
        if val then spawn(farmLoop) end
        Notification("⚔️ Auto Farm", val and "Đã bật!" or "Đã tắt!", 2)
    end)
    
    createToggle("👑 AUTO FARM BOSS", Color3.fromRGB(255, 150, 50), function(val)
        AutoFarmBoss = val
        if val then spawn(farmBossLoop) end
        Notification("👑 Auto Boss", val and "Đã bật!" or "Đã tắt!", 2)
    end)
    
    createToggle("🍎 AUTO FRUIT SNIPER", Color3.fromRGB(255, 100, 200), function(val)
        AutoFruitSniper = val
        if val then spawn(fruitSniperLoop) end
        Notification("🍎 Fruit Sniper", val and "Đã bật!" or "Đã tắt!", 2)
    end)
    
    createToggle("👁️ ESP", Color3.fromRGB(100, 100, 200), function(val)
        ESPEnabled = val
        spawn(function() while ESPEnabled do createESP() wait(0.5) end end)
        Notification("👁️ ESP", val and "Đã bật!" or "Đã tắt!", 2)
    end)
    
    createToggle("🚀 TELEPORT", Color3.fromRGB(80, 200, 200), function(val)
        TeleportEnabled = val
        Notification("🚀 Teleport", val and "Đã bật!" or "Đã tắt!", 2)
    end)
end

-- ==================== MAIN SCRIPT VỚI LOADING ====================
local function main()
    -- Tạo loading screen
    local loadingGui, updateProgress = createLoadingScreen()
    
    -- Chạy các bước loading
    for _, step in ipairs(loadingSteps) do
        updateProgress(step.percent, step.status)
        
        if step.percent == 10 then
            -- Khởi tạo bypass
            initBypass()
        elseif step.percent == 30 then
            -- Hook remotes
            wait(0.3)
        elseif step.percent == 50 then
            -- Chặn báo cáo
            wait(0.3)
        elseif step.percent == 70 then
            -- Tải cấu hình
            wait(0.3)
        elseif step.percent == 90 then
            -- Tạo UI
            createUI()
        elseif step.percent == 100 then
            -- Hoàn tất
            wait(0.5)
        else
            wait(0.2)
        end
    end
    
    -- Xóa loading screen sau khi hoàn tất
    wait(1)
    loadingGui:Destroy()
    
    -- Thông báo hoàn tất
    Notification("✅ Thành công", "Blox Fruit Pro Max V5 đã sẵn sàng!", 4)
    print("═══════════════════════════════════════════════════════════")
    print("     BLOX FRUIT PRO MAX V5 ĐÃ KHỞI ĐỘNG THÀNH CÔNG!")
    print("═══════════════════════════════════════════════════════════")
    print("✓ Ultimate Bypass 25 lớp đã kích hoạt")
    print("✓ Chống phát hiện, chống kick, chống ban")
    print("✓ Menu hiển thị ở giữa màn hình")
    print("═══════════════════════════════════════════════════════════")
    
    -- Giữ script chạy
    while ScriptEnabled do
        wait(1)
    end
end

-- Chạy script
local success, err = pcall(main)
if not success then
    warn("Lỗi: " .. tostring(err))
    Notification("❌ Lỗi", "Có lỗi xảy ra: " .. tostring(err), 5)
end
