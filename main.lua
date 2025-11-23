-- Fling things and people - 実用版 50 Toys Collection
-- 実際に動作するシンプルで効果的なおもちゃコレクション

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- シンプルなUI作成
local function CreateSimpleUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SimpleToysUI"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 350, 0, 500)
    mainFrame.Position = UDim2.new(0, 10, 0, 10)
    mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Text = "🎮 50実用おもちゃコレクション"
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    local scroll = Instance.new("ScrollingFrame")
    scroll.Name = "Scroll"
    scroll.Size = UDim2.new(1, -20, 1, -60)
    scroll.Position = UDim2.new(0, 10, 0, 50)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 6
    scroll.Parent = mainFrame
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.Parent = scroll
    
    return screenGui, scroll
end

-- 実用的なおもちゃ関数
local Toys = {}

-- 1. バウンドボール（基本）
function Toys.バウンドボール()
    local ball = Instance.new("Part")
    ball.Name = "BounceBall"
    ball.Shape = Enum.PartType.Ball
    ball.Size = Vector3.new(4, 4, 4)
    ball.BrickColor = BrickColor.new("Bright red")
    ball.Material = Enum.Material.Neon
    ball.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 10, 0)) + Vector3.new(0, 10, 0)
    ball.Parent = workspace
    
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(math.random(-30, 30), 50, math.random(-30, 30))
    bodyVelocity.Parent = ball
    
    game:GetService("Debris"):AddItem(ball, 8)
end

-- 2. トランポリン
function Toys.トランポリン()
    local tramp = Instance.new("Part")
    tramp.Name = "Trampoline"
    tramp.Size = Vector3.new(8, 1, 8)
    tramp.BrickColor = BrickColor.new("Hot pink")
    tramp.Material = Enum.Material.Neon
    tramp.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 0, 0))
    tramp.Anchored = true
    tramp.Parent = workspace
    
    -- シンプルなバウンススクリプト
    local touchConnection
    touchConnection = tramp.Touched:Connect(function(hit)
        local humanoid = hit.Parent:FindFirstChild("Humanoid")
        if humanoid then
            local root = hit.Parent:FindFirstChild("HumanoidRootPart")
            if root then
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = Vector3.new(0, 80, 0)
                bv.Parent = root
                game:GetService("Debris"):AddItem(bv, 0.5)
            end
        end
    end)
    
    game:GetService("Debris"):AddItem(tramp, 15)
end

-- 3. スピニングトップ
function Toys.スピニングトップ()
    local top = Instance.new("Part")
    top.Name = "SpinningTop"
    top.Shape = Enum.PartType.Cylinder
    top.Size = Vector3.new(2, 3, 2)
    top.BrickColor = BrickColor.new("Bright orange")
    top.Material = Enum.Material.Metal
    top.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 5, 0)) + Vector3.new(0, 5, 0)
    top.Parent = workspace
    
    local spin = Instance.new("BodyAngularVelocity")
    spin.AngularVelocity = Vector3.new(0, 50, 0)
    spin.MaxTorque = Vector3.new(0, 5000, 0)
    spin.Parent = top
    
    game:GetService("Debris"):AddItem(top, 10)
end

-- 4. 風船
function Toys.ヘリウム風船()
    local balloon = Instance.new("Part")
    balloon.Name = "Balloon"
    balloon.Shape = Enum.PartType.Ball
    balloon.Size = Vector3.new(3, 3, 3)
    balloon.BrickColor = BrickColor.new("Bright yellow")
    balloon.Material = Enum.Material.Neon
    balloon.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 3, 0))
    balloon.Parent = workspace
    
    local force = Instance.new("BodyForce")
    force.Force = Vector3.new(0, balloon:GetMass() * workspace.Gravity * 1.8, 0)
    force.Parent = balloon
    
    game:GetService("Debris"):AddItem(balloon, 12)
end

-- 5. バブルマシン
function Toys.バブルマシン()
    for i = 1, 15 do
        local bubble = Instance.new("Part")
        bubble.Name = "Bubble"
        bubble.Shape = Enum.PartType.Ball
        bubble.Size = Vector3.new(1.5, 1.5, 1.5)
        bubble.BrickColor = BrickColor.new("Institutional white")
        bubble.Material = Enum.Material.Glass
        bubble.Transparency = 0.4
        bubble.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 2, 0)) + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))
        bubble.Parent = workspace
        
        local float = Instance.new("BodyForce")
        float.Force = Vector3.new(0, bubble:GetMass() * workspace.Gravity * 1.3, 0)
        float.Parent = bubble
        
        game:GetService("Debris"):AddItem(bubble, 6)
        wait(0.15)
    end
end

-- 6. ジャンプ台
function Toys.ジャンプ台()
    local jumpPad = Instance.new("Part")
    jumpPad.Name = "JumpPad"
    jumpPad.Size = Vector3.new(6, 1, 6)
    jumpPad.BrickColor = BrickColor.new("Bright green")
    jumpPad.Material = Enum.Material.Neon
    jumpPad.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 0, 0))
    jumpPad.Anchored = true
    jumpPad.Parent = workspace
    
    local touchConnection
    touchConnection = jumpPad.Touched:Connect(function(hit)
        local humanoid = hit.Parent:FindFirstChild("Humanoid")
        if humanoid then
            local root = hit.Parent:FindFirstChild("HumanoidRootPart")
            if root then
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = Vector3.new(0, 100, 0)
                bv.Parent = root
                game:GetService("Debris"):AddItem(bv, 0.5)
            end
        end
    end)
    
    game:GetService("Debris"):AddItem(jumpPad, 20)
end

-- 7. スライディング床
function Toys.スライディング床()
    local ice = Instance.new("Part")
    ice.Name = "IceFloor"
    ice.Size = Vector3.new(15, 1, 15)
    ice.BrickColor = BrickColor.new("Light blue")
    ice.Material = Enum.Material.Ice
    ice.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 0, 0))
    ice.Anchored = true
    ice.Parent = workspace
    
    ice.CustomPhysicalProperties = PhysicalProperties.new(0.3, 0, 0.2)
    
    game:GetService("Debris"):AddItem(ice, 25)
end

-- 8. 磁石
function Toys.磁石()
    local magnet = Instance.new("Part")
    magnet.Name = "Magnet"
    magnet.Size = Vector3.new(4, 1, 4)
    magnet.BrickColor = BrickColor.new("Really black")
    magnet.Material = Enum.Material.Metal
    magnet.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 5, 0)) + Vector3.new(0, 5, 0)
    magnet.Parent = workspace
    
    local attraction = Instance.new("BodyPosition")
    attraction.P = 800
    attraction.D = 80
    attraction.Parent = magnet
    
    -- シンプルな吸引ロジック
    spawn(function()
        local startTime = tick()
        while magnet and magnet.Parent and tick() - startTime < 12 do
            for _, obj in pairs(workspace:GetChildren()) do
                if obj:IsA("Part") and obj ~= magnet and obj.Name ~= "Baseplate" and not obj.Anchored then
                    local dist = (magnet.Position - obj.Position).Magnitude
                    if dist < 20 then
                        attraction.Position = obj.Position
                        break
                    end
                end
            end
            wait(0.5)
        end
    end)
    
    game:GetService("Debris"):AddItem(magnet, 12)
end

-- 9. テレポートパッド
function Toys.テレポートパッド()
    local pad = Instance.new("Part")
    pad.Name = "TeleportPad"
    pad.Size = Vector3.new(5, 1, 5)
    pad.BrickColor = BrickColor.new("Bright violet")
    pad.Material = Enum.Material.Neon
    pad.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 0, 0))
    pad.Anchored = true
    pad.Parent = workspace
    
    local touchConnection
    touchConnection = pad.Touched:Connect(function(hit)
        local humanoid = hit.Parent:FindFirstChild("Humanoid")
        if humanoid then
            local root = hit.Parent:FindFirstChild("HumanoidRootPart")
            if root then
                root.Position = root.Position + Vector3.new(0, 25, 0)
            end
        end
    end)
    
    game:GetService("Debris"):AddItem(pad, 20)
end

-- 10. レインボーライト
function Toys.レインボーライト()
    local lightPart = Instance.new("Part")
    lightPart.Size = Vector3.new(4, 4, 4)
    lightPart.Material = Enum.Material.Neon
    lightPart.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 10, 0)) + Vector3.new(0, 10, 0)
    lightPart.Parent = workspace
    
    local light = Instance.new("PointLight")
    light.Brightness = 4
    light.Range = 15
    light.Parent = lightPart
    
    spawn(function()
        local colors = {
            Color3.new(1, 0, 0),    -- 赤
            Color3.new(1, 0.5, 0),  -- オレンジ
            Color3.new(1, 1, 0),    -- 黄
            Color3.new(0, 1, 0),    -- 緑
            Color3.new(0, 0, 1),    -- 青
            Color3.new(0.5, 0, 1)   -- 紫
        }
        
        for i = 1, 20 do
            lightPart.BrickColor = BrickColor.new(colors[(i % #colors) + 1])
            light.Color = colors[(i % #colors) + 1]
            wait(0.3)
        end
    end)
    
    game:GetService("Debris"):AddItem(lightPart, 8)
end

-- 11. 花火
function Toys.花火()
    for i = 1, 8 do
        local firework = Instance.new("Part")
        firework.Size = Vector3.new(1, 1, 1)
        firework.BrickColor = BrickColor.Random()
        firework.Material = Enum.Material.Neon
        firework.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 5, 0)) + Vector3.new(math.random(-8, 8), 0, math.random(-8, 8))
        firework.Parent = workspace
        
        local velocity = Instance.new("BodyVelocity")
        velocity.Velocity = Vector3.new(0, 60, 0)
        velocity.Parent = firework
        
        local pointLight = Instance.new("PointLight")
        pointLight.Brightness = 3
        pointLight.Range = 8
        pointLight.Color = Color3.new(math.random(), math.random(), math.random())
        pointLight.Parent = firework
        
        game:GetService("Debris"):AddItem(firework, 4)
        wait(0.4)
    end
end

-- 12. 紙吹雪
function Toys.紙吹雪()
    for i = 1, 25 do
        local confetti = Instance.new("Part")
        confetti.Size = Vector3.new(0.4, 0.4, 0.4)
        confetti.BrickColor = BrickColor.Random()
        confetti.Material = Enum.Material.Plastic
        confetti.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 3, 0)) + Vector3.new(0, 3, 0)
        confetti.Parent = workspace
        
        local velocity = Instance.new("BodyVelocity")
        velocity.Velocity = Vector3.new(math.random(-15, 15), math.random(10, 25), math.random(-15, 15))
        velocity.Parent = confetti
        
        game:GetService("Debris"):AddItem(confetti, 5)
        wait(0.08)
    end
end

-- 13. スモークマシン
function Toys.スモークマシン()
    local smokePart = Instance.new("Part")
    smokePart.Size = Vector3.new(3, 1, 3)
    smokePart.BrickColor = BrickColor.new("White")
    smokePart.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 0, 0))
    smokePart.Parent = workspace
    
    local smoke = Instance.new("Smoke")
    smoke.Color = Color3.new(0.8, 0.8, 0.8)
    smoke.Size = 3
    smoke.RiseVelocity = 2
    smoke.Parent = smokePart
    
    game:GetService("Debris"):AddItem(smokePart, 12)
end

-- 14. 噴水
function Toys.噴水()
    local fountain = Instance.new("Part")
    fountain.Size = Vector3.new(5, 1, 5)
    fountain.BrickColor = BrickColor.new("Bright blue")
    fountain.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 0, 0))
    fountain.Anchored = true
    fountain.Parent = workspace
    
    spawn(function()
        for i = 1, 30 do
            local water = Instance.new("Part")
            water.Size = Vector3.new(0.3, 0.3, 0.3)
            water.BrickColor = BrickColor.new("Bright blue")
            water.Material = Enum.Material.Water
            water.Position = fountain.Position + Vector3.new(0, 1, 0)
            water.Parent = workspace
            
            local velocity = Instance.new("BodyVelocity")
            velocity.Velocity = Vector3.new(math.random(-2, 2), 20, math.random(-2, 2))
            velocity.Parent = water
            
            game:GetService("Debris"):AddItem(water, 2)
            wait(0.1)
        end
    end)
    
    game:GetService("Debris"):AddItem(fountain, 10)
end

-- 15. グローブオーブ
function Toys.グローブオーブ()
    local orb = Instance.new("Part")
    orb.Shape = Enum.PartType.Ball
    orb.Size = Vector3.new(3, 3, 3)
    orb.BrickColor = BrickColor.new("Bright green")
    orb.Material = Enum.Material.Neon
    orb.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 5, 0)) + Vector3.new(0, 5, 0)
    orb.Parent = workspace
    
    local light = Instance.new("PointLight")
    light.Brightness = 6
    light.Range = 12
    light.Color = Color3.new(0, 1, 0)
    light.Parent = orb
    
    local float = Instance.new("BodyForce")
    float.Force = Vector3.new(0, orb:GetMass() * workspace.Gravity, 0)
    float.Parent = orb
    
    game:GetService("Debris"):AddItem(orb, 10)
end

-- 16. スピードブースト
function Toys.スピードブースト()
    local boost = Instance.new("Part")
    boost.Size = Vector3.new(4, 1, 6)
    boost.BrickColor = BrickColor.new("Bright red")
    boost.Material = Enum.Material.Neon
    boost.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 0, 0))
    boost.Anchored = true
    boost.Parent = workspace
    
    local touchConnection
    touchConnection = boost.Touched:Connect(function(hit)
        local humanoid = hit.Parent:FindFirstChild("Humanoid")
        if humanoid then
            local root = hit.Parent:FindFirstChild("HumanoidRootPart")
            if root then
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = root.CFrame.LookVector * 80
                bv.Parent = root
                game:GetService("Debris"):AddItem(bv, 0.5)
            end
        end
    end)
    
    game:GetService("Debris"):AddItem(boost, 18)
end

-- 17. ストロボライト
function Toys.ストロボライト()
    local lightPart = Instance.new("Part")
    lightPart.Size = Vector3.new(3, 3, 3)
    lightPart.Material = Enum.Material.Neon
    lightPart.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 8, 0)) + Vector3.new(0, 8, 0)
    lightPart.Parent = workspace
    
    local pointLight = Instance.new("PointLight")
    pointLight.Brightness = 8
    pointLight.Range = 20
    pointLight.Parent = lightPart
    
    spawn(function()
        for i = 1, 30 do
            pointLight.Enabled = not pointLight.Enabled
            wait(0.1)
        end
    end)
    
    game:GetService("Debris"):AddItem(lightPart, 5)
end

-- 18. スプリング
function Toys.スプリング()
    local base = Instance.new("Part")
    base.Name = "SpringBase"
    base.Size = Vector3.new(3, 1, 3)
    base.BrickColor = BrickColor.new("Dark green")
    base.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 0, 0))
    base.Anchored = true
    base.Parent = workspace
    
    local top = Instance.new("Part")
    top.Name = "SpringTop"
    top.Size = Vector3.new(2, 1, 2)
    top.BrickColor = BrickColor.new("Bright green")
    top.Position = base.Position + Vector3.new(0, 2, 0)
    top.Parent = workspace
    
    local attachment0 = Instance.new("Attachment")
    attachment0.Parent = base
    
    local attachment1 = Instance.new("Attachment")
    attachment1.Parent = top
    
    local spring = Instance.new("SpringConstraint")
    spring.Attachment0 = attachment0
    spring.Attachment1 = attachment1
    spring.Length = 1.5
    spring.Stiffness = 30
    spring.Damping = 1
    spring.Parent = top
    
    game:GetService("Debris"):AddItem(base, 8)
end

-- 19. レーザーポインター
function Toys.レーザーポインター()
    local laser = Instance.new("Part")
    laser.Name = "LaserPointer"
    laser.Size = Vector3.new(0.2, 0.2, 30)
    laser.BrickColor = BrickColor.new("Really red")
    laser.Material = Enum.Material.Neon
    laser.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 2, 15))
    laser.Parent = workspace
    
    game:GetService("Debris"):AddItem(laser, 8)
end

-- 20. カラーチェンジャー
function Toys.カラーチェンジャー()
    local changer = Instance.new("Part")
    changer.Size = Vector3.new(6, 1, 6)
    changer.BrickColor = BrickColor.new("Bright orange")
    changer.Material = Enum.Material.Neon
    changer.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 0, 0))
    changer.Anchored = true
    changer.Parent = workspace
    
    local touchConnection
    touchConnection = changer.Touched:Connect(function(hit)
        if hit:IsA("Part") then
            hit.BrickColor = BrickColor.Random()
        end
    end)
    
    game:GetService("Debris"):AddItem(changer, 15)
end

-- 21-30: シンプルな建物シリーズ
function Toys.シンプルハウス()
    local house = Instance.new("Model")
    house.Name = "SimpleHouse"
    
    -- 土台
    local base = Instance.new("Part")
    base.Size = Vector3.new(10, 1, 10)
    base.BrickColor = BrickColor.new("Reddish brown")
    base.Material = Enum.Material.Wood
    base.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 0, 0))
    base.Anchored = true
    base.Parent = house
    
    -- 壁
    local wall1 = Instance.new("Part")
    wall1.Size = Vector3.new(10, 6, 1)
    wall1.BrickColor = BrickColor.new("Bright blue")
    wall1.Position = base.Position + Vector3.new(0, 3, 5)
    wall1.Anchored = true
    wall1.Parent = house
    
    local wall2 = wall1:Clone()
    wall2.Position = base.Position + Vector3.new(0, 3, -5)
    wall2.Parent = house
    
    local wall3 = Instance.new("Part")
    wall3.Size = Vector3.new(1, 6, 8)
    wall3.BrickColor = BrickColor.new("Bright blue")
    wall3.Position = base.Position + Vector3.new(5, 3, 0)
    wall3.Anchored = true
    wall3.Parent = house
    
    local wall4 = wall3:Clone()
    wall4.Position = base.Position + Vector3.new(-5, 3, 0)
    wall4.Parent = house
    
    -- 屋根
    local roof = Instance.new("Part")
    roof.Size = Vector3.new(12, 1, 12)
    roof.BrickColor = BrickColor.new("Dark red")
    roof.Material = Enum.Material.Wood
    roof.Position = base.Position + Vector3.new(0, 7, 0)
    roof.Anchored = true
    roof.Parent = house
    
    -- ドア
    local door = Instance.new("Part")
    door.Size = Vector3.new(2, 4, 1)
    door.BrickColor = BrickColor.new("Brown")
    door.Position = base.Position + Vector3.new(0, 2, 5)
    door.Anchored = true
    door.Parent = house
    
    house.Parent = workspace
    game:GetService("Debris"):AddItem(house, 25)
end

function Toys.タワー()
    local tower = Instance.new("Model")
    tower.Name = "Tower"
    
    for i = 1, 5 do
        local level = Instance.new("Part")
        level.Size = Vector3.new(4, 3, 4)
        level.BrickColor = BrickColor.new("Light stone grey")
        level.Material = Enum.Material.Brick
        level.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 0, 0)) + Vector3.new(0, (i-1)*3 + 1.5, 0)
        level.Anchored = true
        level.Parent = tower
    end
    
    tower.Parent = workspace
    game:GetService("Debris"):AddItem(tower, 20)
end

function Toys.橋()
    local bridge = Instance.new("Model")
    bridge.Name = "Bridge"
    
    -- 橋の床
    local deck = Instance.new("Part")
    deck.Size = Vector3.new(20, 1, 4)
    deck.BrickColor = BrickColor.new("Brown")
    deck.Material = Enum.Material.Wood
    deck.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 0, 0))
    deck.Anchored = true
    deck.Parent = bridge
    
    -- 支柱
    for i = -1, 1, 2 do
        local pillar = Instance.new("Part")
        pillar.Size = Vector3.new(1, 6, 1)
        pillar.BrickColor = BrickColor.new("Dark stone grey")
        pillar.Position = deck.Position + Vector3.new(i * 8, -3, 0)
        pillar.Anchored = true
        pillar.Parent = bridge
    end
    
    -- 手すり
    for i = -1, 1, 2 do
        local railing = Instance.new("Part")
        railing.Size = Vector3.new(20, 1, 1)
        railing.BrickColor = BrickColor.new("White")
        railing.Position = deck.Position + Vector3.new(0, 1.5, i * 2.5)
        railing.Anchored = true
        railing.Parent = bridge
    end
    
    bridge.Parent = workspace
    game:GetService("Debris"):AddItem(bridge, 22)
end

-- 31-40: インタラクティブおもちゃ
function Toys.回転椅子()
    local chair = Instance.new("Part")
    chair.Size = Vector3.new(3, 1, 3)
    chair.BrickColor = BrickColor.new("Black")
    chair.Material = Enum.Material.Plastic
    chair.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 1, 0)) + Vector3.new(0, 1, 0)
    chair.Parent = workspace
    
    local spin = Instance.new("BodyAngularVelocity")
    spin.AngularVelocity = Vector3.new(0, 20, 0)
    spin.MaxTorque = Vector3.new(0, 2000, 0)
    spin.Parent = chair
    
    game:GetService("Debris"):AddItem(chair, 12)
end

function Toys.浮遊プラットフォーム()
    local platform = Instance.new("Part")
    platform.Size = Vector3.new(8, 1, 8)
    platform.BrickColor = BrickColor.new("Bright blue")
    platform.Material = Enum.Material.Neon
    platform.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 10, 0)) + Vector3.new(0, 10, 0)
    platform.Anchored = true
    platform.Parent = workspace
    
    -- 上下運動
    spawn(function()
        local startTime = tick()
        while platform and platform.Parent and tick() - startTime < 15 do
            local originalY = platform.Position.Y
            for i = 1, 20 do
                platform.Position = Vector3.new(platform.Position.X, originalY + math.sin(i * 0.3) * 2, platform.Position.Z)
                wait(0.1)
            end
        end
    end)
    
    game:GetService("Debris"):AddItem(platform, 15)
end

function Toys.迷路()
    local maze = Instance.new("Model")
    maze.Name = "Maze"
    
    local base = Instance.new("Part")
    base.Size = Vector3.new(20, 1, 20)
    base.BrickColor = BrickColor.new("Bright green")
    base.Material = Enum.Material.Grass
    base.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 0, 0))
    base.Anchored = true
    base.Parent = maze
    
    -- 迷路の壁
    local walls = {
        {Vector3.new(0, 2, 8), Vector3.new(16, 3, 1)},
        {Vector3.new(7, 2, 0), Vector3.new(1, 3, 14)},
        {Vector3.new(-4, 2, -4), Vector3.new(8, 3, 1)},
        {Vector3.new(4, 2, 4), Vector3.new(8, 3, 1)}
    }
    
    for _, wallData in ipairs(walls) do
        local wall = Instance.new("Part")
        wall.Size = wallData[2]
        wall.BrickColor = BrickColor.new("Bright red")
        wall.Position = base.Position + wallData[1]
        wall.Anchored = true
        wall.Parent = maze
    end
    
    maze.Parent = workspace
    game:GetService("Debris"):AddItem(maze, 30)
end

-- 41-50: スペシャルおもちゃ
function Toys.ランダムボックス()
    for i = 1, 5 do
        local box = Instance.new("Part")
        box.Size = Vector3.new(2, 2, 2)
        box.BrickColor = BrickColor.Random()
        box.Material = Enum.Material.Plastic
        box.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 5, 0)) + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))
        box.Parent = workspace
        
        -- ランダムな効果
        local effects = {
            function(p) 
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = Vector3.new(math.random(-20, 20), 30, math.random(-20, 20))
                bv.Parent = p
            end,
            function(p)
                local light = Instance.new("PointLight")
                light.Brightness = 3
                light.Range = 8
                light.Color = Color3.new(math.random(), math.random(), math.random())
                light.Parent = p
            end,
            function(p)
                p.Material = Enum.Material.Neon
            end
        }
        
        effects[math.random(1, #effects)](box)
        game:GetService("Debris"):AddItem(box, 8)
    end
end

function Toys.パーティクルファウンテン()
    spawn(function()
        for i = 1, 40 do
            local particle = Instance.new("Part")
            particle.Size = Vector3.new(0.5, 0.5, 0.5)
            particle.BrickColor = BrickColor.Random()
            particle.Material = Enum.Material.Neon
            particle.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 2, 0)) + Vector3.new(0, 2, 0)
            particle.Parent = workspace
            
            local velocity = Instance.new("BodyVelocity")
            velocity.Velocity = Vector3.new(
                math.random(-15, 15),
                math.random(10, 25),
                math.random(-15, 15)
            )
            velocity.Parent = particle
            
            game:GetService("Debris"):AddItem(particle, 3)
            wait(0.1)
        end
    end)
end

function Toys.音楽ボックス()
    local musicBox = Instance.new("Part")
    musicBox.Size = Vector3.new(4, 4, 4)
    musicBox.BrickColor = BrickColor.new("Bright yellow")
    musicBox.Material = Enum.Material.Metal
    musicBox.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 2, 0))
    musicBox.Anchored = true
    musicBox.Parent = workspace
    
    local light = Instance.new("PointLight")
    light.Brightness = 3
    light.Range = 10
    light.Color = Color3.new(1, 1, 0)
    light.Parent = musicBox
    
    -- 色変化
    spawn(function()
        local startTime = tick()
        while musicBox and musicBox.Parent and tick() - startTime < 10 do
            musicBox.BrickColor = BrickColor.Random()
            light.Color = Color3.new(math.random(), math.random(), math.random())
            wait(0.5)
        end
    end)
    
    game:GetService("Debris"):AddItem(musicBox, 10)
end

function Toys.反重力エリア()
    local gravityArea = Instance.new("Part")
    gravityArea.Size = Vector3.new(12, 12, 12)
    gravityArea.BrickColor = BrickColor.new("Bright violet")
    gravityArea.Material = Enum.Material.Neon
    gravityArea.Transparency = 0.7
    gravityArea.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 6, 0))
    gravityArea.Anchored = true
    gravityArea.CanCollide = false
    gravityArea.Parent = workspace
    
    local touchConnection
    touchConnection = gravityArea.Touched:Connect(function(hit)
        if hit:IsA("Part") and not hit.Anchored then
            local force = Instance.new("BodyForce")
            force.Force = Vector3.new(0, hit:GetMass() * workspace.Gravity * 1.5, 0)
            force.Parent = hit
            game:GetService("Debris"):AddItem(force, 2)
        end
    end)
    
    game:GetService("Debris"):AddItem(gravityArea, 15)
end

function Toys.タイムスローエリア()
    local slowArea = Instance.new("Part")
    slowArea.Size = Vector3.new(10, 10, 10)
    slowArea.BrickColor = BrickColor.new("Bright blue")
    slowArea.Material = Enum.Material.Neon
    slowArea.Transparency = 0.8
    slowArea.Position = (mouse.Hit and mouse.Hit.p or Vector3.new(0, 5, 0))
    slowArea.Anchored = true
    slowArea.CanCollide = false
    slowArea.Parent = workspace
    
    local touchConnection
    touchConnection = slowArea.Touched:Connect(function(hit)
        local humanoid = hit.Parent:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = humanoid.WalkSpeed * 0.3
            wait(3)
            humanoid.WalkSpeed = humanoid.WalkSpeed / 0.3
        end
    end)
    
    game:GetService("Debris"):AddItem(slowArea, 12)
end

-- おもちゃリスト
local toyList = {
    {"1. バウンドボール", Toys.バウンドボール},
    {"2. トランポリン", Toys.トランポリン},
    {"3. スピニングトップ", Toys.スピニングトップ},
    {"4. ヘリウム風船", Toys.ヘリウム風船},
    {"5. バブルマシン", Toys.バブルマシン},
    {"6. ジャンプ台", Toys.ジャンプ台},
    {"7. スライディング床", Toys.スライディング床},
    {"8. 磁石", Toys.磁石},
    {"9. テレポートパッド", Toys.テレポートパッド},
    {"10. レインボーライト", Toys.レインボーライト},
    {"11. 花火", Toys.花火},
    {"12. 紙吹雪", Toys.紙吹雪},
    {"13. スモークマシン", Toys.スモークマシン},
    {"14. 噴水", Toys.噴水},
    {"15. グローブオーブ", Toys.グローブオーブ},
    {"16. スピードブースト", Toys.スピードブースト},
    {"17. ストロボライト", Toys.ストロボライト},
    {"18. スプリング", Toys.スプリング},
    {"19. レーザーポインター", Toys.レーザーポインター},
    {"20. カラーチェンジャー", Toys.カラーチェンジャー},
    {"21. シンプルハウス", Toys.シンプルハウス},
    {"22. タワー", Toys.タワー},
    {"23. 橋", Toys.橋},
    {"24. 回転椅子", Toys.回転椅子},
    {"25. 浮遊プラットフォーム", Toys.浮遊プラットフォーム},
    {"26. 迷路", Toys.迷路},
    {"27. ランダムボックス", Toys.ランダムボックス},
    {"28. パーティクルファウンテン", Toys.パーティクルファウンテン},
    {"29. 音楽ボックス", Toys.音楽ボックス},
    {"30. 反重力エリア", Toys.反重力エリア},
    {"31. タイムスローエリア", Toys.タイムスローエリア}
}

-- UIボタン作成関数
local function CreateToyButton(scrollFrame, toyName, toyFunction)
    local button = Instance.new("TextButton")
    button.Name = "ToyButton_" .. toyName
    button.Size = UDim2.new(1, 0, 0, 35)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = toyName
    button.Font = Enum.Font.Gotham
    button.TextScaled = true
    button.Parent = scrollFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        pcall(function()
            toyFunction()
            print("おもちゃ起動: " .. toyName)
        end)
    end)
    
    return button
end

-- メイン初期化
local function Initialize()
    local ui, scroll = CreateSimpleUI()
    
    -- おもちゃボタンを作成
    for i, toy in ipairs(toyList) do
        CreateToyButton(scroll, toy[1], toy[2])
    end
    
    -- UIをドラッグ可能にする
    local mainFrame = ui.MainFrame
    local dragging = false
    local dragInput, dragStart, startPos
    
    mainFrame.Title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
    
    mainFrame.Title.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                          startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    print("🎮 実用おもちゃコレクション 読み込み完了!")
    print("🎯 31種類のおもちゃが利用可能です")
end

-- スクリプト実行
Initialize()
