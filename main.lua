-- Fling things and people - Onion UI版 (Part 1/3)
-- オブジェクトとプレイヤーを空中に浮かせる/飛ばすスクリプト

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Onion UI用変数
local Onion = {
    Enabled = true,
    Debug = true,
    Version = "2.0",
    FlingPower = 100,
    FloatHeight = 50
}

-- メインUI作成関数
local function CreateOnionUI()
    -- 既存のUIを削除
    if player.PlayerGui:FindFirstChild("OnionFlingUI") then
        player.PlayerGui:FindFirstChild("OnionFlingUI"):Destroy()
    end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "OnionFlingUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = player.PlayerGui
    
    -- モバイル用サイズ調整
    local uiWidth = isMobile and 300 or 380
    local uiHeight = isMobile and 450 or 520
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, uiWidth, 0, uiHeight)
    mainFrame.Position = UDim2.new(0.5, -uiWidth/2, 0, 50)
    mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = false
    mainFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = mainFrame
    
    -- タイトルバー
    local title = Instance.new("Frame")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 45)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    title.BorderSizePixel = 0
    title.Active = true
    title.Parent = mainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 10)
    titleCorner.Parent = title
    
    -- タイトル下部を隠すフレーム
    local titleBottom = Instance.new("Frame")
    titleBottom.Size = UDim2.new(1, 0, 0, 10)
    titleBottom.Position = UDim2.new(0, 0, 1, -10)
    titleBottom.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    titleBottom.BorderSizePixel = 0
    titleBottom.Parent = title
    
    -- タイトルテキスト
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, -100, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 120, 255)
    titleLabel.Text = "🎪 Onion Fling Toys"
    titleLabel.TextSize = 18
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = title
    
    -- 最小化ボタン
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Name = "MinimizeBtn"
    minimizeBtn.Size = UDim2.new(0, 35, 0, 35)
    minimizeBtn.Position = UDim2.new(1, -45, 0, 5)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeBtn.Text = "−"
    minimizeBtn.TextSize = 20
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.BorderSizePixel = 0
    minimizeBtn.AutoButtonColor = false
    minimizeBtn.Parent = title
    
    local minBtnCorner = Instance.new("UICorner")
    minBtnCorner.CornerRadius = UDim.new(0, 6)
    minBtnCorner.Parent = minimizeBtn
    
    return screenGui, mainFrame, title, titleLabel, minimizeBtn, uiWidth, uiHeight
end
-- Fling things and people - Onion UI版 (Part 2/3)
-- コントロールパネルとFling機能

-- Part 1からの続き...

-- コントロールパネル作成関数
local function CreateControlPanel(mainFrame)
    local controlPanel = Instance.new("Frame")
    controlPanel.Name = "ControlPanel"
    controlPanel.Size = UDim2.new(1, -20, 0, 80)
    controlPanel.Position = UDim2.new(0, 10, 0, 55)
    controlPanel.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    controlPanel.BorderSizePixel = 0
    controlPanel.Parent = mainFrame
    
    local controlCorner = Instance.new("UICorner")
    controlCorner.CornerRadius = UDim.new(0, 8)
    controlCorner.Parent = controlPanel
    
    -- パワースライダーラベル
    local powerLabel = Instance.new("TextLabel")
    powerLabel.Name = "PowerLabel"
    powerLabel.Size = UDim2.new(1, -20, 0, 30)
    powerLabel.Position = UDim2.new(0, 10, 0, 10)
    powerLabel.BackgroundTransparency = 1
    powerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    powerLabel.Text = "パワー: 100"
    powerLabel.TextSize = 14
    powerLabel.Font = Enum.Font.Gotham
    powerLabel.TextXAlignment = Enum.TextXAlignment.Left
    powerLabel.Parent = controlPanel
    
    -- パワースライダー背景
    local powerSlider = Instance.new("Frame")
    powerSlider.Name = "PowerSlider"
    powerSlider.Size = UDim2.new(1, -20, 0, 30)
    powerSlider.Position = UDim2.new(0, 10, 0, 45)
    powerSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    powerSlider.BorderSizePixel = 0
    powerSlider.Parent = controlPanel
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 6)
    sliderCorner.Parent = powerSlider
    
    -- スライダーフィル
    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "SliderFill"
    sliderFill.Size = UDim2.new(0.2, 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(255, 100, 255)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = powerSlider
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 6)
    fillCorner.Parent = sliderFill
    
    -- スライダーボタン（透明で全体をカバー）
    local sliderButton = Instance.new("TextButton")
    sliderButton.Name = "SliderButton"
    sliderButton.Size = UDim2.new(1, 0, 1, 0)
    sliderButton.BackgroundTransparency = 1
    sliderButton.Text = ""
    sliderButton.Parent = powerSlider
    
    return controlPanel, powerLabel, sliderFill, sliderButton
end

-- Fling機能関数
local Flings = {}

-- 1. 自分を空中に浮かせる
function Flings.FloatSelf()
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, Onion.FlingPower, 0)
    bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
    bodyVelocity.Parent = humanoidRootPart
    
    game:GetService("Debris"):AddItem(bodyVelocity, 2)
    
    if Onion.Debug then
        print("🎈 自分を浮かせました")
    end
end

-- 2. 最も近いプレイヤーを前方に飛ばす
function Flings.FlingForward()
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local nearestPlayer = nil
    local nearestDistance = 50
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local otherRoot = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            if otherRoot then
                local distance = (humanoidRootPart.Position - otherRoot.Position).Magnitude
                if distance < nearestDistance then
                    nearestPlayer = otherPlayer
                    nearestDistance = distance
                end
            end
        end
    end
    
    if nearestPlayer and nearestPlayer.Character then
        local targetRoot = nearestPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetRoot then
            local direction = humanoidRootPart.CFrame.LookVector
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = direction * Onion.FlingPower + Vector3.new(0, 50, 0)
            bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bodyVelocity.Parent = targetRoot
            
            game:GetService("Debris"):AddItem(bodyVelocity, 1.5)
            
            if Onion.Debug then
                print("🚀 " .. nearestPlayer.Name .. "を飛ばしました")
            end
        end
    end
end

-- 3. 周囲の他のプレイヤー全員を浮かせる
function Flings.FloatNearby()
    local character = player.Character
    if not character then return end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    local count = 0
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local otherRoot = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            if otherRoot then
                local distance = (rootPart.Position - otherRoot.Position).Magnitude
                if distance < 30 then
                    local bodyVelocity = Instance.new("BodyVelocity")
                    bodyVelocity.Velocity = Vector3.new(0, Onion.FlingPower, 0)
                    bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
                    bodyVelocity.Parent = otherRoot
                    
                    game:GetService("Debris"):AddItem(bodyVelocity, 2)
                    count = count + 1
                end
            end
        end
    end
    
    if Onion.Debug then
        print("👥 " .. count .. "人を浮かせました")
    end
end

-- 4. マウス位置のオブジェクトを飛ばす
function Flings.FlingTarget()
    local target = mouse.Target
    if target and not target.Anchored and target.Parent then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(
            math.random(-Onion.FlingPower, Onion.FlingPower),
            Onion.FlingPower,
            math.random(-Onion.FlingPower, Onion.FlingPower)
        )
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Parent = target
        
        game:GetService("Debris"):AddItem(bodyVelocity, 1.5)
        
        if Onion.Debug then
            print("🎯 " .. target.Name .. "を飛ばしました")
        end
    else
        if Onion.Debug then
            print("❌ 対象が見つかりません")
        end
    end
end

-- 5. 最も近いプレイヤーをランダム方向に飛ばす
function Flings.RandomFling()
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local nearestPlayer = nil
    local nearestDistance = 50
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local otherRoot = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            if otherRoot then
                local distance = (humanoidRootPart.Position - otherRoot.Position).Magnitude
                if distance < nearestDistance then
                    nearestPlayer = otherPlayer
                    nearestDistance = distance
                end
            end
        end
    end
    
    if nearestPlayer and nearestPlayer.Character then
        local targetRoot = nearestPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetRoot then
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(
                math.random(-Onion.FlingPower, Onion.FlingPower),
                math.random(50, Onion.FlingPower),
                math.random(-Onion.FlingPower, Onion.FlingPower)
            )
            bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bodyVelocity.Parent = targetRoot
            
            game:GetService("Debris"):AddItem(bodyVelocity, 1.5)
            
            if Onion.Debug then
                print("🎲 " .. nearestPlayer.Name .. "をランダムに飛ばしました")
            end
        end
    end
end
-- Fling things and people - Onion UI版 (Part 3/3 - 完成版)
-- 残りのFling機能、UIボタン、ドラッグ機能、初期化

-- Part 2からの続き...

-- 6. 最も近いプレイヤーを回転させながら浮かせる
function Flings.SpinFloat()
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local nearestPlayer = nil
    local nearestDistance = 50
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local otherRoot = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            if otherRoot then
                local distance = (humanoidRootPart.Position - otherRoot.Position).Magnitude
                if distance < nearestDistance then
                    nearestPlayer = otherPlayer
                    nearestDistance = distance
                end
            end
        end
    end
    
    if nearestPlayer and nearestPlayer.Character then
        local targetRoot = nearestPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetRoot then
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, Onion.FlingPower * 0.8, 0)
            bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
            bodyVelocity.Parent = targetRoot
            
            local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
            bodyAngularVelocity.AngularVelocity = Vector3.new(0, 50, 0)
            bodyAngularVelocity.MaxTorque = Vector3.new(0, math.huge, 0)
            bodyAngularVelocity.Parent = targetRoot
            
            game:GetService("Debris"):AddItem(bodyVelocity, 3)
            game:GetService("Debris"):AddItem(bodyAngularVelocity, 3)
            
            if Onion.Debug then
                print("🌀 " .. nearestPlayer.Name .. "を回転させました")
            end
        end
    end
end

-- 7. 月面ジャンプ（低重力）
function Flings.MoonJump()
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local bodyForce = Instance.new("BodyForce")
    bodyForce.Force = Vector3.new(0, humanoidRootPart:GetMass() * workspace.Gravity * 0.9, 0)
    bodyForce.Parent = humanoidRootPart
    
    game:GetService("Debris"):AddItem(bodyForce, 10)
    
    if Onion.Debug then
        print("🌙 月面ジャンプを有効にしました")
    end
end

-- 8. 周囲のプレイヤー全員を爆発で飛ばす
function Flings.ExplosiveFling()
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local count = 0
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local otherRoot = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            if otherRoot then
                local distance = (humanoidRootPart.Position - otherRoot.Position).Magnitude
                if distance < 40 then
                    local explosion = Instance.new("Explosion")
                    explosion.Position = otherRoot.Position
                    explosion.BlastPressure = Onion.FlingPower * 1000
                    explosion.BlastRadius = 10
                    explosion.Parent = workspace
                    count = count + 1
                end
            end
        end
    end
    
    if Onion.Debug then
        print("💥 " .. count .. "人を爆発で飛ばしました")
    end
end

-- 9. 最も近いプレイヤーを天井まで飛ばす
function Flings.SkyRocket()
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local nearestPlayer = nil
    local nearestDistance = 50
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local otherRoot = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            if otherRoot then
                local distance = (humanoidRootPart.Position - otherRoot.Position).Magnitude
                if distance < nearestDistance then
                    nearestPlayer = otherPlayer
                    nearestDistance = distance
                end
            end
        end
    end
    
    if nearestPlayer and nearestPlayer.Character then
        local targetRoot = nearestPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetRoot then
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, Onion.FlingPower * 2, 0)
            bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
            bodyVelocity.Parent = targetRoot
            
            game:GetService("Debris"):AddItem(bodyVelocity, 5)
            
            if Onion.Debug then
                print("☁️ " .. nearestPlayer.Name .. "をロケットで飛ばしました")
            end
        end
    end
end

-- 10. 最も近いプレイヤーを宙返りさせる
function Flings.Backflip()
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local nearestPlayer = nil
    local nearestDistance = 50
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local otherRoot = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            if otherRoot then
                local distance = (humanoidRootPart.Position - otherRoot.Position).Magnitude
                if distance < nearestDistance then
                    nearestPlayer = otherPlayer
                    nearestDistance = distance
                end
            end
        end
    end
    
    if nearestPlayer and nearestPlayer.Character then
        local targetRoot = nearestPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetRoot then
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, Onion.FlingPower * 0.7, 0)
            bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
            bodyVelocity.Parent = targetRoot
            
            local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
            bodyAngularVelocity.AngularVelocity = targetRoot.CFrame.RightVector * -20
            bodyAngularVelocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bodyAngularVelocity.Parent = targetRoot
            
            game:GetService("Debris"):AddItem(bodyVelocity, 2)
            game:GetService("Debris"):AddItem(bodyAngularVelocity, 2)
            
            if Onion.Debug then
                print("🤸 " .. nearestPlayer.Name .. "を宙返りさせました")
            end
        end
    end
end

-- Flingリスト
local flingList = {
    {"🎈 自分を浮かせる", Flings.FloatSelf, Color3.fromRGB(100, 200, 255)},
    {"🚀 近くの人を飛ばす", Flings.FlingForward, Color3.fromRGB(255, 150, 100)},
    {"👥 周囲全員浮かせる", Flings.FloatNearby, Color3.fromRGB(150, 255, 150)},
    {"🎯 対象を飛ばす", Flings.FlingTarget, Color3.fromRGB(255, 100, 150)},
    {"🎲 近くの人ランダム", Flings.RandomFling, Color3.fromRGB(200, 100, 255)},
    {"🌀 近くの人回転", Flings.SpinFloat, Color3.fromRGB(100, 255, 255)},
    {"🌙 月面ジャンプ", Flings.MoonJump, Color3.fromRGB(200, 200, 255)},
    {"💥 周囲全員爆発", Flings.ExplosiveFling, Color3.fromRGB(255, 100, 100)},
    {"☁️ 近くの人ロケット", Flings.SkyRocket, Color3.fromRGB(150, 200, 255)},
    {"🤸 近くの人宙返り", Flings.Backflip, Color3.fromRGB(255, 200, 100)},
}

-- スクロールフレームとボタン作成
local function CreateScrollAndButtons(mainFrame)
    local scroll = Instance.new("ScrollingFrame")
    scroll.Name = "Scroll"
    scroll.Size = UDim2.new(1, -20, 1, -155)
    scroll.Position = UDim2.new(0, 10, 0, 145)
    scroll.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 6
    scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 255)
    scroll.Parent = mainFrame
    
    local scrollCorner = Instance.new("UICorner")
    scrollCorner.CornerRadius = UDim.new(0, 8)
    scrollCorner.Parent = scroll
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent = scroll
    
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 10)
    padding.PaddingBottom = UDim.new(0, 10)
    padding.Parent = scroll
    
    -- Flingボタンを作成
    for _, fling in ipairs(flingList) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -20, 0, 45)
        button.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Text = fling[1]
        button.Font = Enum.Font.GothamSemibold
        button.TextSize = 16
        button.BorderSizePixel = 0
        button.AutoButtonColor = false
        button.Parent = scroll
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = button
        
        local accent = Instance.new("Frame")
        accent.Size = UDim2.new(0, 4, 1, -10)
        accent.Position = UDim2.new(0, 5, 0, 5)
        accent.BackgroundColor3 = fling[3]
        accent.BorderSizePixel = 0
        accent.Parent = button
        
        local accentCorner = Instance.new("UICorner")
        accentCorner.CornerRadius = UDim.new(1, 0)
        accentCorner.Parent = accent
        
        button.MouseButton1Click:Connect(function()
            if Onion.Enabled then
                button.BackgroundColor3 = fling[3]
                fling[2]()
                
                TweenService:Create(button, TweenInfo.new(0.3), {
                    BackgroundColor3 = Color3.fromRGB(55, 55, 65)
                }):Play()
            end
        end)
        
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(65, 65, 75)
            }):Play()
        end)
        
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(55, 55, 65)
            }):Play()
        end)
    end
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
    end)
    
    return scroll
end

-- メイン初期化関数（Part 1, 2, 3を全て統合）
local function Initialize()
    -- Part 1から
    local screenGui, mainFrame, title, titleLabel, minimizeBtn, uiWidth, uiHeight = CreateOnionUI()
    
    -- Part 2から
    local controlPanel, powerLabel, sliderFill, sliderButton = CreateControlPanel(mainFrame)
    
    -- Part 3から
    local scroll = CreateScrollAndButtons(mainFrame)
    
    -- スライダー機能
    local draggingSlider = false
    
    sliderButton.MouseButton1Down:Connect(function()
        draggingSlider = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local relativeX = math.clamp((input.Position.X - sliderButton.AbsolutePosition.X) / sliderButton.AbsoluteSize.X, 0, 1)
            sliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
            Onion.FlingPower = math.floor(relativeX * 250 + 50)
            powerLabel.Text = "パワー: " .. Onion.FlingPower
        end
    end)
    
    -- 最小化機能
    local isMinimized = false
    local originalSize = mainFrame.Size
    
    minimizeBtn.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        
        if isMinimized then
            TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = UDim2.new(0, uiWidth, 0, 45)
            }):Play()
            minimizeBtn.Text = "+"
            controlPanel.Visible = false
            scroll.Visible = false
        else
            TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = originalSize
            }):Play()
            minimizeBtn.Text = "−"
            task.wait(0.1)
            controlPanel.Visible = true
            scroll.Visible = true
        end
    end)
    
    minimizeBtn.MouseEnter:Connect(function()
        TweenService:Create(minimizeBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(255, 120, 255)
        }):Play()
    end)
    
    minimizeBtn.MouseLeave:Connect(function()
        TweenService:Create(minimizeBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        }):Play()
    end)
    
    -- ドラッグ機能（PC・スマホ両対応）
    local dragging = false
    local dragInput, dragStart, startPos
    
    title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    title.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X,
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    print("🎪 Onion Fling Toys UI 読み込み完了!")
    print("🎯 他のプレイヤーを飛ばす機能が利用可能です")
    print("💡 " .. (isMobile and "タイトルをタップしてドラッグ可能" or "タイトルバーをドラッグして移動、−ボタンで最小化"))
    print("⚡ パワースライダーで威力調整可能 (50-300)")
end

-- スクリプト実行
Initialize()
