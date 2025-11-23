-- Fling things and people - Onion UI版 (Part 1/3) - 完全修正版
-- 神関数使用：AssemblyLinearVelocity で確実に動作

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Onion UI用変数
_G.Onion = _G.Onion or {
    Enabled = true,
    Debug = true,
    Version = "3.0",
    FlingPower = 100, -- これが投げる強さ（距離）
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
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = player.PlayerGui
    
    -- モバイル用サイズ調整
    local uiWidth = isMobile and 320 or 400
    local uiHeight = isMobile and 480 or 550
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, uiWidth, 0, uiHeight)
    mainFrame.Position = UDim2.new(0.5, -uiWidth/2, 0, 60)
    mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.ClipsDescendants = false
    mainFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame
    
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Position = UDim2.new(0, -10, 0, -10)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.7
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.ZIndex = 0
    shadow.Parent = mainFrame
    
    -- タイトルバー
    local title = Instance.new("Frame")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    title.BorderSizePixel = 0
    title.Active = true
    title.Parent = mainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = title
    
    -- タイトル下部を隠すフレーム
    local titleBottom = Instance.new("Frame")
    titleBottom.Size = UDim2.new(1, 0, 0, 12)
    titleBottom.Position = UDim2.new(0, 0, 1, -12)
    titleBottom.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    titleBottom.BorderSizePixel = 0
    titleBottom.Parent = title
    
    -- タイトルテキスト
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, -110, 1, 0)
    titleLabel.Position = UDim2.new(0, 15, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 120, 255)
    titleLabel.Text = "🎪 Onion Fling Toys"
    titleLabel.TextSize = 20
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = title
    
    -- バージョン表示
    local versionLabel = Instance.new("TextLabel")
    versionLabel.Size = UDim2.new(0, 50, 0, 20)
    versionLabel.Position = UDim2.new(1, -160, 0, 15)
    versionLabel.BackgroundTransparency = 1
    versionLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
    versionLabel.Text = "v3.0"
    versionLabel.TextSize = 12
    versionLabel.Font = Enum.Font.Gotham
    versionLabel.Parent = title
    
    -- 閉じるボタン
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseBtn"
    closeBtn.Size = UDim2.new(0, 40, 0, 40)
    closeBtn.Position = UDim2.new(1, -50, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Text = "×"
    closeBtn.TextSize = 24
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.BorderSizePixel = 0
    closeBtn.AutoButtonColor = false
    closeBtn.Parent = title
    
    local closeBtnCorner = Instance.new("UICorner")
    closeBtnCorner.CornerRadius = UDim.new(0, 8)
    closeBtnCorner.Parent = closeBtn
    
    -- 最小化ボタン
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Name = "MinimizeBtn"
    minimizeBtn.Size = UDim2.new(0, 40, 0, 40)
    minimizeBtn.Position = UDim2.new(1, -95, 0, 5)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeBtn.Text = "−"
    minimizeBtn.TextSize = 24
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.BorderSizePixel = 0
    minimizeBtn.AutoButtonColor = false
    minimizeBtn.Parent = title
    
    local minBtnCorner = Instance.new("UICorner")
    minBtnCorner.CornerRadius = UDim.new(0, 8)
    minBtnCorner.Parent = minimizeBtn
    
    return screenGui, mainFrame, title, titleLabel, minimizeBtn, closeBtn, uiWidth, uiHeight
end

-- グローバル関数として保存
_G.CreateOnionUI = CreateOnionUI

print("✅ Part 1/3 読み込み完了")
print("📦 UI基礎コンポーネント準備完了")
-- Fling things and people - Onion UI版 (Part 2/3) - 完全修正版
-- コントロールパネルと神関数Fling機能

-- コントロールパネル作成関数
local function CreateControlPanel(mainFrame)
    local controlPanel = Instance.new("Frame")
    controlPanel.Name = "ControlPanel"
    controlPanel.Size = UDim2.new(1, -20, 0, 90)
    controlPanel.Position = UDim2.new(0, 10, 0, 60)
    controlPanel.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    controlPanel.BorderSizePixel = 0
    controlPanel.Parent = mainFrame
    
    local controlCorner = Instance.new("UICorner")
    controlCorner.CornerRadius = UDim.new(0, 10)
    controlCorner.Parent = controlPanel
    
    -- パワースライダーラベル
    local powerLabel = Instance.new("TextLabel")
    powerLabel.Name = "PowerLabel"
    powerLabel.Size = UDim2.new(1, -20, 0, 25)
    powerLabel.Position = UDim2.new(0, 10, 0, 10)
    powerLabel.BackgroundTransparency = 1
    powerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    powerLabel.Text = "投げる強さ: 100"
    powerLabel.TextSize = 16
    powerLabel.Font = Enum.Font.GothamBold
    powerLabel.TextXAlignment = Enum.TextXAlignment.Left
    powerLabel.Parent = controlPanel
    
    -- パワー説明
    local powerDesc = Instance.new("TextLabel")
    powerDesc.Size = UDim2.new(1, -20, 0, 15)
    powerDesc.Position = UDim2.new(0, 10, 0, 32)
    powerDesc.BackgroundTransparency = 1
    powerDesc.TextColor3 = Color3.fromRGB(150, 150, 160)
    powerDesc.Text = "スライダーで飛ぶ距離を調整"
    powerDesc.TextSize = 12
    powerDesc.Font = Enum.Font.Gotham
    powerDesc.TextXAlignment = Enum.TextXAlignment.Left
    powerDesc.Parent = controlPanel
    
    -- パワースライダー背景
    local powerSlider = Instance.new("Frame")
    powerSlider.Name = "PowerSlider"
    powerSlider.Size = UDim2.new(1, -20, 0, 35)
    powerSlider.Position = UDim2.new(0, 10, 0, 50)
    powerSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    powerSlider.BorderSizePixel = 0
    powerSlider.Parent = controlPanel
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 8)
    sliderCorner.Parent = powerSlider
    
    -- スライダーフィル
    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "SliderFill"
    sliderFill.Size = UDim2.new(0.166, 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(255, 100, 255)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = powerSlider
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 8)
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

-- 神関数を使った確実に動作するFling機能
_G.Flings = {}

-- 1. 自分を空中に浮かせる
function _G.Flings.FloatSelf()
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    -- 神関数使用
    humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, _G.Onion.FlingPower, 0)
    
    if _G.Onion.Debug then
        print("🎈 自分を浮かせました - パワー: " .. _G.Onion.FlingPower)
    end
end

-- 2. 最も近いプレイヤーを前方に飛ばす
function _G.Flings.FlingForward()
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
            -- 神関数で確実に飛ばす
            targetRoot.AssemblyLinearVelocity = direction * _G.Onion.FlingPower + Vector3.new(0, _G.Onion.FlingPower * 0.5, 0)
            
            if _G.Onion.Debug then
                print("🚀 " .. nearestPlayer.Name .. "を飛ばしました - パワー: " .. _G.Onion.FlingPower)
            end
        end
    else
        if _G.Onion.Debug then
            print("❌ 近くにプレイヤーがいません")
        end
    end
end

-- 3. 周囲の他のプレイヤー全員を浮かせる
function _G.Flings.FloatNearby()
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
                    -- 神関数使用
                    otherRoot.AssemblyLinearVelocity = Vector3.new(0, _G.Onion.FlingPower, 0)
                    count = count + 1
                end
            end
        end
    end
    
    if _G.Onion.Debug then
        print("👥 " .. count .. "人を浮かせました - パワー: " .. _G.Onion.FlingPower)
    end
end

-- 4. マウス位置のオブジェクトを飛ばす
function _G.Flings.FlingTarget()
    local target = mouse.Target
    if target and not target.Anchored and target.Parent then
        -- 神関数使用
        target.AssemblyLinearVelocity = Vector3.new(
            math.random(-_G.Onion.FlingPower, _G.Onion.FlingPower) * 0.5,
            _G.Onion.FlingPower,
            math.random(-_G.Onion.FlingPower, _G.Onion.FlingPower) * 0.5
        )
        
        if _G.Onion.Debug then
            print("🎯 " .. target.Name .. "を飛ばしました - パワー: " .. _G.Onion.FlingPower)
        end
    else
        if _G.Onion.Debug then
            print("❌ 対象が見つからないか固定されています")
        end
    end
end

-- 5. 最も近いプレイヤーをランダム方向に飛ばす
function _G.Flings.RandomFling()
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
            -- 神関数でランダム方向に飛ばす
            targetRoot.AssemblyLinearVelocity = Vector3.new(
                math.random(-_G.Onion.FlingPower, _G.Onion.FlingPower),
                math.random(_G.Onion.FlingPower * 0.5, _G.Onion.FlingPower),
                math.random(-_G.Onion.FlingPower, _G.Onion.FlingPower)
            )
            
            if _G.Onion.Debug then
                print("🎲 " .. nearestPlayer.Name .. "をランダムに飛ばしました - パワー: " .. _G.Onion.FlingPower)
            end
        end
    else
        if _G.Onion.Debug then
            print("❌ 近くにプレイヤーがいません")
        end
    end
end

-- グローバル関数として保存
_G.CreateControlPanel = CreateControlPanel

print("✅ Part 2/3 読み込み完了")
print("⚡ 神関数Fling機能準備完了（1-5）")
-- Fling things and people - Onion UI版 (Part 3/3) - 完全修正版
-- 残りのFling機能、ドラッグ、最小化、初期化

-- 6. 最も近いプレイヤーを回転させながら浮かせる
function _G.Flings.SpinFloat()
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
            -- 神関数で浮かせる + 回転
            targetRoot.AssemblyLinearVelocity = Vector3.new(0, _G.Onion.FlingPower * 0.8, 0)
            targetRoot.AssemblyAngularVelocity = Vector3.new(0, 50, 0)
            
            if _G.Onion.Debug then
                print("🌀 " .. nearestPlayer.Name .. "を回転させました - パワー: " .. _G.Onion.FlingPower)
            end
        end
    end
end

-- 7. 月面ジャンプ（低重力）
function _G.Flings.MoonJump()
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        -- 神関数でジャンプ力アップ
        humanoid.JumpPower = _G.Onion.FlingPower * 2
        humanoid.JumpHeight = _G.Onion.FlingPower / 5
        
        if _G.Onion.Debug then
            print("🌙 月面ジャンプを有効にしました - パワー: " .. _G.Onion.FlingPower)
        end
        
        -- 10秒後に元に戻す
        task.delay(10, function()
            if humanoid then
                humanoid.JumpPower = 50
                humanoid.JumpHeight = 7.2
                print("🌙 月面ジャンプを解除しました")
            end
        end)
    end
end

-- 8. 周囲のプレイヤー全員を爆発で飛ばす
function _G.Flings.ExplosiveFling()
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
                    -- 外向きに飛ばす
                    local direction = (otherRoot.Position - humanoidRootPart.Position).Unit
                    otherRoot.AssemblyLinearVelocity = direction * _G.Onion.FlingPower + Vector3.new(0, _G.Onion.FlingPower * 0.5, 0)
                    count = count + 1
                end
            end
        end
    end
    
    if _G.Onion.Debug then
        print("💥 " .. count .. "人を爆発で飛ばしました - パワー: " .. _G.Onion.FlingPower)
    end
end

-- 9. 最も近いプレイヤーを天井まで飛ばす
function _G.Flings.SkyRocket()
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
            -- 神関数で超高速上昇
            targetRoot.AssemblyLinearVelocity = Vector3.new(0, _G.Onion.FlingPower * 2, 0)
            
            if _G.Onion.Debug then
                print("☁️ " .. nearestPlayer.Name .. "をロケットで飛ばしました - パワー: " .. _G.Onion.FlingPower)
            end
        end
    end
end

-- 10. 最も近いプレイヤーを宙返りさせる
function _G.Flings.Backflip()
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
            -- 神関数で宙返り
            targetRoot.AssemblyLinearVelocity = Vector3.new(0, _G.Onion.FlingPower * 0.7, 0)
            targetRoot.AssemblyAngularVelocity = targetRoot.CFrame.RightVector * -20
            
            if _G.Onion.Debug then
                print("🤸 " .. nearestPlayer.Name .. "を宙返りさせました - パワー: " .. _G.Onion.FlingPower)
            end
        end
    end
end

-- Flingリスト
local flingList = {
    {"🎈 自分を浮かせる", _G.Flings.FloatSelf, Color3.fromRGB(100, 200, 255)},
    {"🚀 近くの人を飛ばす", _G.Flings.FlingForward, Color3.fromRGB(255, 150, 100)},
    {"👥 周囲全員浮かせる", _G.Flings.FloatNearby, Color3.fromRGB(150, 255, 150)},
    {"🎯 対象を飛ばす", _G.Flings.FlingTarget, Color3.fromRGB(255, 100, 150)},
    {"🎲 近くの人ランダム", _G.Flings.RandomFling, Color3.fromRGB(200, 100, 255)},
    {"🌀 近くの人回転", _G.Flings.SpinFloat, Color3.fromRGB(100, 255, 255)},
    {"🌙 月面ジャンプ", _G.Flings.MoonJump, Color3.fromRGB(200, 200, 255)},
    {"💥 周囲全員爆発", _G.Flings.ExplosiveFling, Color3.fromRGB(255, 100, 100)},
    {"☁️ 近くの人ロケット", _G.Flings.SkyRocket, Color3.fromRGB(150, 200, 255)},
    {"🤸 近くの人宙返り", _G.Flings.Backflip, Color3.fromRGB(255, 200, 100)},
}

-- スクロールフレームとボタン作成
local function CreateScrollAndButtons(mainFrame)
    local scroll = Instance.new("ScrollingFrame")
    scroll.Name = "Scroll"
    scroll.Size = UDim2.new(1, -20, 1, -170)
    scroll.Position = UDim2.new(0, 10, 0, 160)
    scroll.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 8
    scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 255)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.Parent = mainFrame
    
    local scrollCorner = Instance.new("UICorner")
    scrollCorner.CornerRadius = UDim.new(0, 10)
    scrollCorner.Parent = scroll
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent = scroll
    
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 10)
    padding.PaddingBottom = UDim.new(0, 10)
    padding.Parent = scroll
    
    -- Flingボタンを作成
    for _, fling in ipairs(flingList) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -20, 0, 50)
        button.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Text = fling[1]
        button.Font = Enum.Font.GothamBold
        button.TextSize = 17
        button.BorderSizePixel = 0
        button.AutoButtonColor = false
        button.Parent = scroll
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = button
        
        local accent = Instance.new("Frame")
        accent.Size = UDim2.new(0, 5, 1, -12)
        accent.Position = UDim2.new(0, 6, 0, 6)
        accent.BackgroundColor3 = fling[3]
        accent.BorderSizePixel = 0
        accent.Parent = button
        
        local accentCorner = Instance.new("UICorner")
        accentCorner.CornerRadius = UDim.new(1, 0)
        accentCorner.Parent = accent
        
        button.MouseButton1Click:Connect(function()
            if _G.Onion.Enabled then
                button.BackgroundColor3 = fling[3]
                fling[2]()
                
                TweenService:Create(button, TweenInfo.new(0.3), {
                    BackgroundColor3 = Color3.fromRGB(55, 55, 65)
                }):Play()
            end
        end)
        
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(70, 70, 80)
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

-- メイン初期化関数（全Part統合）
local function Initialize()
    local screenGui, mainFrame, title, titleLabel, minimizeBtn, closeBtn, uiWidth, uiHeight = _G.CreateOnionUI()
    local controlPanel, powerLabel, sliderFill, sliderButton = _G.CreateControlPanel(mainFrame)
    local scroll = CreateScrollAndButtons(mainFrame)
    
    -- 閉じるボタン機能
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        print("👋 Onion Fling Toys を閉じました")
    end)
    
    closeBtn.MouseEnter:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 70, 70)}):Play()
    end)
    
    closeBtn.MouseLeave:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(220, 50, 50)}):Play()
    end)
    
    -- スライダー機能（PC・スマホ両対応）
    local draggingSlider = false
    
    sliderButton.MouseButton1Down:Connect(function()
        draggingSlider = true
    end)
    
    sliderButton.TouchTap:Connect(function(touchPositions, gameProcessedEvent)
        draggingSlider = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = false
        end
    end)
    
    RunService.RenderStepped:Connect(function()
        if draggingSlider then
            local mousePos = UserInputService:GetMouseLocation()
            local relativeX = math.clamp((mousePos.X - sliderButton.AbsolutePosition.X) / sliderButton.AbsoluteSize.X, 0, 1)
            sliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
            _G.Onion.FlingPower = math.floor(relativeX * 250 + 50)
            powerLabel.Text = "投げる強さ: " .. _G.Onion.FlingPower
        end
    end)
    
    -- 最小化機能
    local isMinimized = false
    local originalSize = mainFrame.Size
    
    minimizeBtn.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        
        if isMinimized then
            TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = UDim2.new(0, uiWidth, 0, 50)
            }):Play()
            minimizeBtn.Text = "+"
            controlPanel.Visible = false
            scroll.Visible = false
        else
            TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = originalSize
            }):Play()
            minimizeBtn.Text = "−"
            task.wait(0.15)
            controlPanel.Visible = true
            scroll.Visible = true
        end
    end)
    
    minimizeBtn.MouseEnter:Connect(function()
        TweenService:Create(minimizeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 120, 255)}):Play()
    end)
    
    minimizeBtn.MouseLeave:Connect(function()
        TweenService:Create(minimizeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 60)}):Play()
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
    
    print("━━━━━━━━━━━━━━━━━━━━━━━━")
    print("🎪 Onion Fling Toys v3.0")
    print("✅ 完全動作版 読み込み完了!")
    print("━━━━━━━━━━━━━━━━━━━━━━━━")
    print("⚡ AssemblyLinearVelocity使用")
    print("🎯 パワーで投げる強さ調整可能")
    print("📱 PC・スマホ両対応")
    print("🖱️ タイトルをドラッグで移動")
    print("━━━━━━━━━━━━━━━━━━━━━━━━")
end

-- スクリプト実行
Initialize()
