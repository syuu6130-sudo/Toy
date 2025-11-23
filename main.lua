-- 超豪華おもちゃコレクション - Ultimate Toys Collection
-- GitHub公開用・実際に動作するバージョン

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local MarketplaceService = game:GetService("MarketplaceService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- 安全なスポーン位置取得
local function GetSafeSpawnPosition()
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        return character.HumanoidRootPart.Position + character.HumanoidRootPart.CFrame.LookVector * 15
    end
    return Vector3.new(0, 25, 0)
end

-- 高度な建築システム
local AdvancedBuilder = {}

function AdvancedBuilder.CreateMcDonalds()
    local model = Instance.new("Model")
    model.Name = "マクドナルドレストラン"
    
    local basePosition = GetSafeSpawnPosition()
    
    -- メインビルディング
    local mainBuilding = Instance.new("Part")
    mainBuilding.Size = Vector3.new(30, 12, 20)
    mainBuilding.BrickColor = BrickColor.new("Bright red")
    mainBuilding.Material = Enum.Material.Plastic
    mainBuilding.Position = basePosition
    mainBuilding.Anchored = true
    mainBuilding.Parent = model
    
    -- 黄金のアーチ
    local arch1 = Instance.new("Part")
    arch1.Size = Vector3.new(2, 8, 2)
    arch1.BrickColor = BrickColor.new("Bright yellow")
    arch1.Material = Enum.Material.Neon
    arch1.Position = basePosition + Vector3.new(-8, 10, 0)
    arch1.Anchored = true
    arch1.Parent = model
    
    local arch2 = arch1:Clone()
    arch2.Position = basePosition + Vector3.new(8, 10, 0)
    arch2.Parent = model
    
    local archTop = Instance.new("Part")
    archTop.Size = Vector3.new(18, 2, 2)
    archTop.BrickColor = BrickColor.new("Bright yellow")
    archTop.Material = Enum.Material.Neon
    archTop.Position = basePosition + Vector3.new(0, 14, 0)
    archTop.Anchored = true
    archTop.Parent = model
    
    -- 看板
    local sign = Instance.new("Part")
    sign.Size = Vector3.new(12, 3, 1)
    sign.BrickColor = BrickColor.new("Bright red")
    sign.Material = Enum.Material.Neon
    sign.Position = basePosition + Vector3.new(0, 16, -10)
    sign.Anchored = true
    sign.Parent = model
    
    -- 窓
    for i = -2, 2 do
        local window = Instance.new("Part")
        window.Size = Vector3.new(4, 6, 0.5)
        window.BrickColor = BrickColor.new("Bright yellow")
        window.Material = Enum.Material.Glass
        window.Transparency = 0.3
        window.Position = basePosition + Vector3.new(i * 5, 3, 10)
        window.Anchored = true
        window.Parent = model
    end
    
    -- 入口
    local entrance = Instance.new("Part")
    entrance.Size = Vector3.new(6, 8, 1)
    entrance.BrickColor = BrickColor.new("Bright yellow")
    entrance.Material = Enum.Material.Plastic
    entrance.Position = basePosition + Vector3.new(0, 4, -10)
    entrance.Anchored = true
    entrance.Parent = model
    
    -- ドライブスルー
    local driveThru = Instance.new("Part")
    driveThru.Size = Vector3.new(4, 6, 8)
    driveThru.BrickColor = BrickColor.new("Bright red")
    driveThru.Material = Enum.Material.Plastic
    driveThru.Position = basePosition + Vector3.new(12, 3, -4)
    driveThru.Anchored = true
    driveThru.Parent = model
    
    -- テーブルと椅子
    for i = -1, 1 do
        local table = Instance.new("Part")
        table.Size = Vector3.new(4, 1, 2)
        table.BrickColor = BrickColor.new("Brown")
        table.Material = Enum.Material.Wood
        table.Position = basePosition + Vector3.new(i * 8, 0.5, 5)
        table.Anchored = true
        table.Parent = model
        
        for j = -1, 1, 2 do
            local chair = Instance.new("Part")
            chair.Size = Vector3.new(1.5, 2, 1.5)
            chair.BrickColor = BrickColor.new("Bright red")
            chair.Material = Enum.Material.Plastic
            chair.Position = table.Position + Vector3.new(0, 1, j * 2)
            chair.Anchored = true
            chair.Parent = model
        end
    end
    
    -- 照明
    for i = -1, 1, 2 do
        local light = Instance.new("Part")
        light.Size = Vector3.new(1, 1, 1)
        light.BrickColor = BrickColor.new("Bright yellow")
        light.Material = Enum.Material.Neon
        light.Position = basePosition + Vector3.new(i * 12, 11, 0)
        light.Anchored = true
        light.Parent = model
        
        local pointLight = Instance.new("PointLight")
        pointLight.Brightness = 4
        pointLight.Range = 12
        pointLight.Color = Color3.new(1, 1, 0.8)
        pointLight.Parent = light
    end
    
    model.Parent = workspace
    return model
end

function AdvancedBuilder.CreateStarbucks()
    local model = Instance.new("Model")
    model.Name = "スターバックスカフェ"
    
    local basePosition = GetSafeSpawnPosition() + Vector3.new(20, 0, 0)
    
    -- モダンな建物
    local building = Instance.new("Part")
    building.Size = Vector3.new(25, 10, 18)
    building.BrickColor = BrickColor.new("Dark green")
    building.Material = Enum.Material.Plastic
    building.Position = basePosition
    building.Anchored = true
    building.Parent = model
    
    -- ガラスの壁
    for i = -1, 1 do
        local glassWall = Instance.new("Part")
        glassWall.Size = Vector3.new(23, 8, 0.5)
        glassWall.BrickColor = BrickColor.new("Medium stone grey")
        glassWall.Material = Enum.Material.Glass
        glassWall.Transparency = 0.4
        glassWall.Position = basePosition + Vector3.new(0, 4, i * 9)
        glassWall.Anchored = true
        glassWall.Parent = model
    end
    
    -- スターバックスロゴ
    local logo = Instance.new("Part")
    logo.Size = Vector3.new(8, 2, 0.5)
    logo.BrickColor = BrickColor.new("Dark green")
    logo.Material = Enum.Material.Neon
    logo.Position = basePosition + Vector3.new(0, 11, -9)
    logo.Anchored = true
    logo.Parent = model
    
    -- カウンター
    local counter = Instance.new("Part")
    counter.Size = Vector3.new(12, 3, 2)
    counter.BrickColor = BrickColor.new("Brown")
    counter.Material = Enum.Material.Wood
    counter.Position = basePosition + Vector3.new(-4, 1.5, 6)
    counter.Anchored = true
    counter.Parent = model
    
    -- エスプレッソマシン
    local machine = Instance.new("Part")
    machine.Size = Vector3.new(2, 4, 1)
    machine.BrickColor = BrickColor.new("Silver")
    machine.Material = Enum.Material.Metal
    machine.Position = basePosition + Vector3.new(-8, 2, 6)
    machine.Anchored = true
    machine.Parent = model
    
    -- ソファ席
    for i = -1, 1 do
        local sofaBase = Instance.new("Part")
        sofaBase.Size = Vector3.new(5, 1, 3)
        sofaBase.BrickColor = BrickColor.new("Bright violet")
        sofaBase.Material = Enum.Material.Fabric
        sofaBase.Position = basePosition + Vector3.new(i * 6, 0.5, -5)
        sofaBase.Anchored = true
        sofaBase.Parent = model
        
        local sofaBack = Instance.new("Part")
        sofaBack.Size = Vector3.new(5, 3, 1)
        sofaBack.BrickColor = BrickColor.new("Bright violet")
        sofaBack.Material = Enum.Material.Fabric
        sofaBack.Position = sofaBase.Position + Vector3.new(0, 2, -2)
        sofaBack.Anchored = true
        sofaBack.Parent = model
    end
    
    -- 温かい照明
    for i = -1, 1 do
        local light = Instance.new("Part")
        light.Size = Vector3.new(1.5, 0.5, 1.5)
        light.BrickColor = BrickColor.new("Br. yellowish orange")
        light.Material = Enum.Material.Neon
        light.Position = basePosition + Vector3.new(i * 8, 9, 0)
        light.Anchored = true
        light.Parent = model
        
        local pointLight = Instance.new("PointLight")
        pointLight.Brightness = 3
        pointLight.Range = 10
        pointLight.Color = Color3.new(1, 0.9, 0.7)
        pointLight.Parent = light
    end
    
    model.Parent = workspace
    return model
end

function AdvancedBuilder.CreateAmusementPark()
    local park = Instance.new("Model")
    park.Name = "夢の遊園地"
    
    local basePosition = GetSafeSpawnPosition() + Vector3.new(0, 0, 30)
    
    -- 遊園地の地面
    local ground = Instance.new("Part")
    ground.Size = Vector3.new(120, 3, 120)
    ground.BrickColor = BrickColor.new("Bright green")
    ground.Material = Enum.Material.Grass
    ground.Position = basePosition
    ground.Anchored = true
    ground.Parent = park
    
    -- 観覧車
    local ferrisWheelCenter = Instance.new("Part")
    ferrisWheelCenter.Size = Vector3.new(3, 25, 3)
    ferrisWheelCenter.BrickColor = BrickColor.new("Bright blue")
    ferrisWheelCenter.Material = Enum.Material.Metal
    ferrisWheelCenter.Position = basePosition + Vector3.new(-40, 12.5, 0)
    ferrisWheelCenter.Anchored = true
    ferrisWheelCenter.Parent = park
    
    -- 観覧車の車輪
    for i = 0, 7 do
        local angle = i * math.pi / 4
        local spoke = Instance.new("Part")
        spoke.Size = Vector3.new(1, 1, 20)
        spoke.BrickColor = BrickColor.new("Bright red")
        spoke.Material = Enum.Material.Metal
        spoke.Position = ferrisWheelCenter.Position + Vector3.new(
            math.cos(angle) * 10,
            math.sin(angle) * 10,
            0
        )
        spoke.Rotation = Vector3.new(0, 0, math.deg(angle))
        spoke.Anchored = true
        spoke.Parent = park
        
        -- ゴンドラ
        local gondola = Instance.new("Part")
        gondola.Size = Vector3.new(3, 2, 3)
        gondola.BrickColor = BrickColor.new("Bright yellow")
        gondola.Material = Enum.Material.Plastic
        gondola.Position = spoke.Position + Vector3.new(0, 0, 0)
        gondola.Anchored = true
        gondola.Parent = park
    end
    
    -- メリーゴーラウンド
    local carouselBase = Instance.new("Part")
    carouselBase.Size = Vector3.new(12, 1, 12)
    carouselBase.BrickColor = BrickColor.new("Bright orange")
    carouselBase.Material = Enum.Material.Plastic
    carouselBase.Position = basePosition + Vector3.new(40, 0.5, 0)
    carouselBase.Anchored = true
    carouselBase.Parent = park
    
    local carouselCenter = Instance.new("Part")
    carouselCenter.Size = Vector3.new(2, 8, 2)
    carouselCenter.BrickColor = BrickColor.new("Bright yellow")
    carouselCenter.Material = Enum.Material.Metal
    carouselCenter.Position = carouselBase.Position + Vector3.new(0, 4, 0)
    carouselCenter.Anchored = true
    carouselCenter.Parent = park
    
    -- メリーゴーラウンドの馬
    for i = 0, 5 do
        local angle = i * math.pi / 3
        local horse = Instance.new("Part")
        horse.Size = Vector3.new(1.5, 3, 1)
        horse.BrickColor = BrickColor.new("Bright blue")
        horse.Material = Enum.Material.Plastic
        horse.Position = carouselBase.Position + Vector3.new(
            math.cos(angle) * 5,
            2,
            math.sin(angle) * 5
        )
        horse.Anchored = true
        horse.Parent = park
    end
    
    -- ジェットコースターの基礎
    local coasterStart = Instance.new("Part")
    coasterStart.Size = Vector3.new(4, 8, 4)
    coasterStart.BrickColor = BrickColor.new("Hot pink")
    coasterStart.Material = Enum.Material.Metal
    coasterStart.Position = basePosition + Vector3.new(0, 4, 40)
    coasterStart.Anchored = true
    coasterStart.Parent = park
    
    local coasterEnd = coasterStart:Clone()
    coasterEnd.Position = basePosition + Vector3.new(-30, 15, 20)
    coasterEnd.Parent = park
    
    -- コースターのレール
    local rail = Instance.new("Part")
    rail.Size = Vector3.new(2, 2, 35)
    rail.BrickColor = BrickColor.new("Hot pink")
    rail.Material = Enum.Material.Metal
    rail.Position = (coasterStart.Position + coasterEnd.Position) / 2
    rail.CFrame = CFrame.lookAt(rail.Position, coasterEnd.Position)
    rail.Anchored = true
    rail.Parent = park
    
    -- 入り口の門
    local gateLeft = Instance.new("Part")
    gateLeft.Size = Vector3.new(3, 10, 3)
    gateLeft.BrickColor = BrickColor.new("Bright red")
    gateLeft.Material = Enum.Material.Plastic
    gateLeft.Position = basePosition + Vector3.new(-50, 5, 0)
    gateLeft.Anchored = true
    gateLeft.Parent = park
    
    local gateRight = gateLeft:Clone()
    gateRight.Position = basePosition + Vector3.new(50, 5, 0)
    gateRight.Parent = park
    
    local gateTop = Instance.new("Part")
    gateTop.Size = Vector3.new(100, 2, 3)
    gateTop.BrickColor = BrickColor.new("Bright yellow")
    gateTop.Material = Enum.Material.Neon
    gateTop.Position = basePosition + Vector3.new(0, 11, 0)
    gateTop.Anchored = true
    gateTop.Parent = park
    
    -- 噴水
    local fountain = Instance.new("Part")
    fountain.Size = Vector3.new(10, 1, 10)
    fountain.BrickColor = BrickColor.new("Bright blue")
    fountain.Material = Enum.Material.Marble
    fountain.Position = basePosition + Vector3.new(0, 0.5, -40)
    fountain.Anchored = true
    fountain.Parent = park
    
    -- 噴水の水エフェクト
    spawn(function()
        for i = 1, 20 do
            local water = Instance.new("Part")
            water.Size = Vector3.new(0.8, 0.8, 0.8)
            water.BrickColor = BrickColor.new("Bright blue")
            water.Material = Enum.Material.Water
            water.Transparency = 0.5
            water.Position = fountain.Position + Vector3.new(
                math.random(-3, 3),
                2,
                math.random(-3, 3)
            )
            water.Anchored = true
            water.Parent = park
            
            local velocity = Instance.new("BodyVelocity")
            velocity.Velocity = Vector3.new(0, 15, 0)
            velocity.Parent = water
            
            game:GetService("Debris"):AddItem(water, 2)
            wait(0.3)
        end
    end)
    
    park.Parent = workspace
    return park
end

function AdvancedBuilder.CreateJapaneseCastle()
    local castle = Instance.new("Model")
    castle.Name = "日本の名城"
    
    local basePosition = GetSafeSpawnPosition() + Vector3.new(0, 0, -30)
    
    -- 石垣
    local stoneBase = Instance.new("Part")
    stoneBase.Size = Vector3.new(50, 6, 50)
    stoneBase.BrickColor = BrickColor.new("Dark stone grey")
    stoneBase.Material = Enum.Material.Concrete
    stoneBase.Position = basePosition
    stoneBase.Anchored = true
    stoneBase.Parent = castle
    
    -- 天守閣の基壇
    local platform = Instance.new("Part")
    platform.Size = Vector3.new(30, 3, 30)
    platform.BrickColor = BrickColor.new("White")
    platform.Material = Enum.Material.Slate
    platform.Position = basePosition + Vector3.new(0, 4.5, 0)
    platform.Anchored = true
    platform.Parent = castle
    
    -- 天守閣の階層
    local levels = {
        {Vector3.new(0, 11, 0), Vector3.new(24, 6, 24), "White"},
        {Vector3.new(0, 18, 0), Vector3.new(20, 6, 20), "White"},
        {Vector3.new(0, 25, 0), Vector3.new(16, 6, 16), "White"},
        {Vector3.new(0, 32, 0), Vector3.new(12, 6, 12), "White"}
    }
    
    for i, levelData in ipairs(levels) do
        local level = Instance.new("Part")
        level.Size = levelData[2]
        level.BrickColor = BrickColor.new(levelData[3])
        level.Material = Enum.Material.Slate
        level.Position = basePosition + levelData[1]
        level.Anchored = true
        level.Parent = castle
        
        -- 屋根
        local roof = Instance.new("Part")
        roof.Size = Vector3.new(levelData[2].X + 3, 2, levelData[2].Z + 3)
        roof.BrickColor = BrickColor.new("Dark stone grey")
        roof.Material = Enum.Material.Wood
        roof.Position = level.Position + Vector3.new(0, 4, 0)
        roof.Anchored = true
        roof.Parent = castle
    end
    
    -- 最上層の装飾
    local decoration = Instance.new("Part")
    decoration.Size = Vector3.new(4, 3, 4)
    decoration.BrickColor = BrickColor.new("Bright yellow")
    decoration.Material = Enum.Material.Gold
    decoration.Position = basePosition + Vector3.new(0, 38, 0)
    decoration.Anchored = true
    decoration.Parent = castle
    
    -- 鯱（しゃちほこ）
    local shachi1 = Instance.new("Part")
    shachi1.Size = Vector3.new(3, 4, 1.5)
    shachi1.BrickColor = BrickColor.new("Bright yellow")
    shachi1.Material = Enum.Material.Gold
    shachi1.Position = basePosition + Vector3.new(0, 36, 6)
    shachi1.Anchored = true
    shachi1.Parent = castle
    
    local shachi2 = shachi1:Clone()
    shachi2.Position = basePosition + Vector3.new(0, 36, -6)
    shachi2.Rotation = Vector3.new(0, 180, 0)
    shachi2.Parent = castle
    
    -- 門
    local gate = Instance.new("Part")
    gate.Size = Vector3.new(8, 8, 4)
    gate.BrickColor = BrickColor.new("Dark stone grey")
    gate.Material = Enum.Material.Wood
    gate.Position = basePosition + Vector3.new(0, 4, -25)
    gate.Anchored = true
    gate.Parent = castle
    
    -- 堀
    local moat = Instance.new("Part")
    moat.Size = Vector3.new(70, 4, 70)
    moat.BrickColor = BrickColor.new("Bright blue")
    moat.Material = Enum.Material.Water
    moat.Transparency = 0.6
    moat.Position = basePosition + Vector3.new(0, -2, 0)
    moat.Anchored = true
    moat.Parent = castle
    
    -- 桜の木
    for i = 0, 3 do
        local angle = i * math.pi / 2
        local treeTrunk = Instance.new("Part")
        treeTrunk.Size = Vector3.new(2, 8, 2)
        treeTrunk.BrickColor = BrickColor.new("Brown")
        treeTrunk.Material = Enum.Material.Wood
        treeTrunk.Position = basePosition + Vector3.new(
            math.cos(angle) * 30,
            4,
            math.sin(angle) * 30
        )
        treeTrunk.Anchored = true
        treeTrunk.Parent = castle
        
        local treeTop = Instance.new("Part")
        treeTop.Shape = Enum.PartType.Ball
        treeTop.Size = Vector3.new(10, 10, 10)
        treeTop.BrickColor = BrickColor.new("Bright violet")
        treeTop.Material = Enum.Material.Plastic
        treeTop.Position = treeTrunk.Position + Vector3.new(0, 8, 0)
        treeTop.Anchored = true
        treeTop.Parent = castle
        
        -- 桜の花びらエフェクト
        spawn(function()
            for j = 1, 15 do
                local petal = Instance.new("Part")
                petal.Size = Vector3.new(0.2, 0.1, 0.2)
                petal.BrickColor = BrickColor.new("Bright violet")
                petal.Material = Enum.Material.Plastic
                petal.Position = treeTop.Position + Vector3.new(
                    math.random(-4, 4),
                    math.random(-2, 2),
                    math.random(-4, 4)
                )
                petal.Anchored = true
                petal.Parent = castle
                
                local velocity = Instance.new("BodyVelocity")
                velocity.Velocity = Vector3.new(
                    math.random(-1, 1),
                    -1,
                    math.random(-1, 1)
                )
                velocity.Parent = petal
                
                game:GetService("Debris"):AddItem(petal, 4)
                wait(0.4)
            end
        end)
    end
    
    castle.Parent = workspace
    return castle
end

function AdvancedBuilder.CreateSpaceStation()
    local station = Instance.new("Model")
    station.Name = "宇宙ステーション"
    
    local basePosition = GetSafeSpawnPosition() + Vector3.new(0, 50, 0)
    
    -- 中央モジュール
    local centralModule = Instance.new("Part")
    centralModule.Shape = Enum.PartType.Cylinder
    centralModule.Size = Vector3.new(15, 25, 15)
    centralModule.BrickColor = BrickColor.new("White")
    centralModule.Material = Enum.Material.Metal
    centralModule.Position = basePosition
    centralModule.Anchored = true
    centralModule.Parent = station
    
    -- ソーラーパネル
    for i = -1, 1, 2 do
        local solarPanel = Instance.new("Part")
        solarPanel.Size = Vector3.new(1, 20, 25)
        solarPanel.BrickColor = BrickColor.new("Dark blue")
        solarPanel.Material = Enum.Material.Neon
        solarPanel.Position = basePosition + Vector3.new(i * 20, 0, 0)
        solarPanel.Anchored = true
        solarPanel.Parent = station
    end
    
    -- 居住モジュール（環状）
    for i = 0, 5 do
        local angle = i * math.pi / 3
        local habitat = Instance.new("Part")
        habitat.Shape = Enum.PartType.Cylinder
        habitat.Size = Vector3.new(10, 5, 10)
        habitat.BrickColor = BrickColor.new("Bright yellow")
        habitat.Material = Enum.Material.Metal
        habitat.Position = basePosition + Vector3.new(
            math.cos(angle) * 25,
            0,
            math.sin(angle) * 25
        )
        habitat.Anchored = true
        habitat.Parent = station
    end
    
    -- 宇宙空間のエフェクト
    local spaceEffect = Instance.new("Part")
    spaceEffect.Size = Vector3.new(80, 80, 80)
    spaceEffect.BrickColor = BrickColor.new("Really black")
    spaceEffect.Material = Enum.Material.Neon
    spaceEffect.Transparency = 0.9
    spaceEffect.Position = basePosition
    spaceEffect.Anchored = true
    spaceEffect.CanCollide = false
    spaceEffect.Parent = station
    
    local spaceLight = Instance.new("PointLight")
    spaceLight.Brightness = 0.3
    spaceLight.Range = 60
    spaceLight.Color = Color3.new(0.2, 0.2, 0.5)
    spaceLight.Parent = spaceEffect
    
    -- 星のエフェクト
    spawn(function()
        for i = 1, 30 do
            local star = Instance.new("Part")
            star.Size = Vector3.new(0.1, 0.1, 0.1)
            star.BrickColor = BrickColor.new("Institutional white")
            star.Material = Enum.Material.Neon
            star.Position = basePosition + Vector3.new(
                math.random(-35, 35),
                math.random(-35, 35),
                math.random(-35, 35)
            )
            star.Anchored = true
            star.Parent = station
            
            local starLight = Instance.new("PointLight")
            starLight.Brightness = math.random(2, 6)
            starLight.Range = 3
            starLight.Color = Color3.new(1, 1, math.random())
            starLight.Parent = star
        end
    end)
    
    station.Parent = workspace
    return station
end

-- 超豪華なおもちゃ関数
local UltimateToys = {}

function UltimateToys.巨大マクドナルド()
    local building = AdvancedBuilder.CreateMcDonalds()
    game:GetService("Debris"):AddItem(building, 45)
end

function UltimateToys.スターバックスカフェ()
    local building = AdvancedBuilder.CreateStarbucks()
    game:GetService("Debris"):AddItem(building, 45)
end

function UltimateToys.夢の遊園地()
    local park = AdvancedBuilder.CreateAmusementPark()
    game:GetService("Debris"):AddItem(park, 60)
end

function UltimateToys.日本の名城()
    local castle = AdvancedBuilder.CreateJapaneseCastle()
    game:GetService("Debris"):AddItem(castle, 50)
end

function UltimateToys.宇宙ステーション()
    local station = AdvancedBuilder.CreateSpaceStation()
    game:GetService("Debris"):AddItem(station, 40)
end

function UltimateToys.未来都市()
    local futureCity = Instance.new("Model")
    futureCity.Name = "未来都市"
    
    local basePosition = GetSafeSpawnPosition() + Vector3.new(0, 0, 60)
    
    -- 都市の基盤
    local cityBase = Instance.new("Part")
    cityBase.Size = Vector3.new(150, 5, 150)
    cityBase.BrickColor = BrickColor.new("Dark stone grey")
    cityBase.Material = Enum.Material.Concrete
    cityBase.Position = basePosition
    cityBase.Anchored = true
    cityBase.Parent = futureCity
    
    -- 超高層ビル群
    for x = -3, 3 do
        for z = -3, 3 do
            if math.random(1, 3) ~= 1 then
                local height = math.random(40, 100)
                local building = Instance.new("Part")
                building.Size = Vector3.new(6, height, 6)
                building.BrickColor = BrickColor.new("White")
                building.Material = Enum.Material.Metal
                building.Position = basePosition + Vector3.new(x * 18, height/2, z * 18)
                building.Anchored = true
                building.Parent = futureCity
                
                -- ビルの窓
                for y = 10, height - 10, 12 do
                    for i = -1, 1, 2 do
                        local window = Instance.new("Part")
                        window.Size = Vector3.new(0.3, 4, 3)
                        window.BrickColor = BrickColor.new("Bright blue")
                        window.Material = Enum.Material.Glass
                        window.Transparency = 0.4
                        window.Position = building.Position + Vector3.new(i * 3.5, y - height/2, 0)
                        window.Anchored = true
                        window.Parent = futureCity
                        
                        local windowLight = Instance.new("PointLight")
                        windowLight.Brightness = 1.5
                        windowLight.Range = 4
                        windowLight.Color = Color3.new(0, 0.3, 1)
                        windowLight.Enabled = math.random() > 0.4
                        windowLight.Parent = window
                    end
                end
            end
        end
    end
    
    -- 空中通路
    for i = 1, 8 do
        local startPos = Vector3.new(
            math.random(-50, 50),
            math.random(60, 80),
            math.random(-50, 50)
        )
        local endPos = Vector3.new(
            math.random(-50, 50),
            math.random(60, 80),
            math.random(-50, 50)
        )
        
        local bridge = Instance.new("Part")
        bridge.Size = Vector3.new(2, 1, (endPos - startPos).Magnitude)
        bridge.BrickColor = BrickColor.new("Bright green")
        bridge.Material = Enum.Material.Neon
        bridge.Position = startPos + (endPos - startPos) / 2
        bridge.CFrame = CFrame.lookAt(bridge.Position, endPos)
        bridge.Anchored = true
        bridge.Parent = futureCity
    end
    
    -- 浮遊する車両
    for i = 1, 12 do
        local flyingCar = Instance.new("Part")
        flyingCar.Size = Vector3.new(3, 1.5, 6)
        flyingCar.BrickColor = BrickColor.new("Hot pink")
        flyingCar.Material = Enum.Material.Neon
        flyingCar.Position = basePosition + Vector3.new(
            math.random(-70, 70),
            math.random(120, 150),
            math.random(-70, 70)
        )
        flyingCar.Anchored = true
        flyingCar.Parent = futureCity
        
        local carLight = Instance.new("PointLight")
        carLight.Brightness = 2
        carLight.Range = 6
        carLight.Color = Color3.new(1, 0, 1)
        carLight.Parent = flyingCar
    end
    
    futureCity.Parent = workspace
    game:GetService("Debris"):AddItem(futureCity, 55)
end

function UltimateToys.ドラゴン召喚()
    local dragon = Instance.new("Model")
    dragon.Name = "伝説の龍"
    
    local basePosition = GetSafeSpawnPosition() + Vector3.new(0, 15, 0)
    
    -- 龍の頭
    local head = Instance.new("Part")
    head.Size = Vector3.new(5, 3, 6)
    head.BrickColor = BrickColor.new("Bright red")
    head.Material = Enum.Material.DiamondPlate
    head.Position = basePosition
    head.Anchored = true
    head.Parent = dragon
    
    -- 龍の体
    local body = Instance.new("Part")
    body.Size = Vector3.new(7, 4, 15)
    body.BrickColor = BrickColor.new("Dark red")
    body.Material = Enum.Material.DiamondPlate
    body.Position = basePosition + Vector3.new(0, 0, -12)
    body.Anchored = true
    body.Parent = dragon
    
    -- 翼
    for i = -1, 1, 2 do
        local wing = Instance.new("Part")
        wing.Size = Vector3.new(1, 12, 20)
        wing.BrickColor = BrickColor.new("Bright yellow")
        wing.Material = Enum.Material.Fabric
        wing.Position = body.Position + Vector3.new(i * 5, 0, 0)
        wing.Anchored = true
        wing.Parent = dragon
    end
    
    -- 脚
    for i = -1, 1, 2 do
        local leg = Instance.new("Part")
        leg.Size = Vector3.new(2, 8, 2)
        leg.BrickColor = BrickColor.new("Bright red")
        leg.Material = Enum.Material.Metal
        leg.Position = body.Position + Vector3.new(i * 3, -6, -5)
        leg.Anchored = true
        leg.Parent = dragon
    end
    
    -- 尾
    local tail = Instance.new("Part")
    tail.Size = Vector3.new(3, 3, 10)
    tail.BrickColor = BrickColor.new("Dark red")
    tail.Material = Enum.Material.DiamondPlate
    tail.Position = body.Position + Vector3.new(0, 0, -20)
    tail.Anchored = true
    tail.Parent = dragon
    
    -- 炎のブレス
    spawn(function()
        local startTime = tick()
        while dragon.Parent and tick() - startTime < 20 do
            local fire = Instance.new("Part")
            fire.Size = Vector3.new(2, 2, 6)
            fire.BrickColor = BrickColor.new("Bright orange")
            fire.Material = Enum.Material.Neon
            fire.Position = head.Position + Vector3.new(0, 0, 4)
            fire.Anchored = true
            fire.Parent = dragon
            
            local fireLight = Instance.new("PointLight")
            fireLight.Brightness = 8
            fireLight.Range = 12
            fireLight.Color = Color3.new(1, 0.3, 0)
            fireLight.Parent = fire
            
            local fireVelocity = Instance.new("BodyVelocity")
            fireVelocity.Velocity = Vector3.new(0, 0, 8)
            fireVelocity.Parent = fire
            
            game:GetService("Debris"):AddItem(fire, 1.5)
            wait(0.5)
        end
    end)
    
    -- 龍の動き
    spawn(function()
        local startTime = tick()
        while dragon.Parent and tick() - startTime < 20 do
            for _, part in pairs(dragon:GetChildren()) do
                if part:IsA("Part") then
                    part.Position = part.Position + Vector3.new(
                        math.sin(tick()) * 0.3,
                        math.cos(tick() * 1.5) * 0.2,
                        math.sin(tick() * 0.8) * 0.3
                    )
                end
            end
            wait(0.1)
        end
        dragon:Destroy()
    end)
    
    dragon.Parent = workspace
end

function UltimateToys.魔法の城()
    local magicCastle = Instance.new("Model")
    magicCastle.Name = "魔法の城"
    
    local basePosition = GetSafeSpawnPosition() + Vector3.new(0, 0, -60)
    
    -- 城の基盤
    local base = Instance.new("Part")
    base.Size = Vector3.new(60, 3, 60)
    base.BrickColor = BrickColor.new("Bright violet")
    base.Material = Enum.Material.Neon
    base.Position = basePosition
    base.Anchored = true
    base.Parent = magicCastle
    
    -- 魔法の塔
    for i = 0, 3 do
        local angle = i * math.pi / 2
        local tower = Instance.new("Part")
        tower.Size = Vector3.new(6, 40, 6)
        tower.BrickColor = BrickColor.new("Bright blue")
        tower.Material = Enum.Material.Neon
        tower.Position = basePosition + Vector3.new(
            math.cos(angle) * 20,
            20,
            math.sin(angle) * 20
        )
        tower.Anchored = true
        tower.Parent = magicCastle
        
        -- 塔の先端のクリスタル
        local crystal = Instance.new("Part")
        crystal.Size = Vector3.new(4, 8, 4)
        crystal.BrickColor = BrickColor.new("Bright yellow")
        crystal.Material = Enum.Material.Glass
        crystal.Transparency = 0.3
        crystal.Position = tower.Position + Vector3.new(0, 24, 0)
        crystal.Anchored = true
        crystal.Parent = magicCastle
        
        local crystalLight = Instance.new("PointLight")
        crystalLight.Brightness = 6
        crystalLight.Range = 15
        crystalLight.Color = Color3.new(1, 1, 0)
        crystalLight.Parent = crystal
    end
    
    -- 中央の大魔法陣
    local magicCircle = Instance.new("Part")
    magicCircle.Size = Vector3.new(25, 0.5, 25)
    magicCircle.BrickColor = BrickColor.new("Really black")
    magicCircle.Material = Enum.Material.Neon
    magicCircle.Position = basePosition + Vector3.new(0, 1.5, 0)
    magicCircle.Anchored = true
    magicCircle.Parent = magicCastle
    
    -- 魔法陣の回転するオーブ
    spawn(function()
        local startTime = tick()
        while magicCastle.Parent and tick() - startTime < 30 do
            for i = 1, 8 do
                local angle = (i * math.pi / 4) + tick()
                local orb = Instance.new("Part")
                orb.Shape = Enum.PartType.Ball
                orb.Size = Vector3.new(2, 2, 2)
                orb.BrickColor = BrickColor.new("Bright green")
                orb.Material = Enum.Material.Neon
                orb.Position = magicCircle.Position + Vector3.new(
                    math.cos(angle) * 10,
                    3,
                    math.sin(angle) * 10
                )
                orb.Anchored = true
                orb.Parent = magicCastle
                
                local orbLight = Instance.new("PointLight")
                orbLight.Brightness = 4
                orbLight.Range = 8
                orbLight.Color = Color3.new(0, 1, 0)
                orbLight.Parent = orb
                
                game:GetService("Debris"):AddItem(orb, 1.2)
            end
            wait(0.3)
        end
    end)
    
    magicCastle.Parent = workspace
    game:GetService("Debris"):AddItem(magicCastle, 35)
end

-- 追加の豪華なおもちゃ関数...
function UltimateToys.海底宮殿()
    local underwaterPalace = Instance.new("Model")
    underwaterPalace.Name = "海底宮殿"
    
    local basePosition = GetSafeSpawnPosition() + Vector3.new(0, -10, 0)
    
    -- 水のエフェクト
    local waterZone = Instance.new("Part")
    waterZone.Size = Vector3.new(100, 50, 100)
    waterZone.BrickColor = BrickColor.new("Bright blue")
    waterZone.Material = Enum.Material.Water
    waterZone.Transparency = 0.7
    waterZone.Position = basePosition
    waterZone.Anchored = true
    waterZone.CanCollide = false
    waterZone.Parent = underwaterPalace
    
    -- 宮殿の基盤
    local palaceBase = Instance.new("Part")
    palaceBase.Size = Vector3.new(40, 3, 40)
    palaceBase.BrickColor = BrickColor.new("Bright yellow")
    palaceBase.Material = Enum.Material.Marble
    palaceBase.Position = basePosition
    palaceBase.Anchored = true
    palaceBase.Parent = underwaterPalace
    
    -- 宮殿の建物
    local mainBuilding = Instance.new("Part")
    mainBuilding.Size = Vector3.new(25, 15, 25)
    mainBuilding.BrickColor = BrickColor.new("Bright green")
    mainBuilding.Material = Enum.Material.Marble
    mainBuilding.Position = basePosition + Vector3.new(0, 9, 0)
    mainBuilding.Anchored = true
    mainBuilding.Parent = underwaterPalace
    
    -- 塔
    for i = 0, 3 do
        local angle = i * math.pi / 2
        local tower = Instance.new("Part")
        tower.Size = Vector3.new(4, 20, 4)
        tower.BrickColor = BrickColor.new("Bright blue")
        tower.Material = Enum.Material.Marble
        tower.Position = basePosition + Vector3.new(
            math.cos(angle) * 15,
            10,
            math.sin(angle) * 15
        )
        tower.Anchored = true
        tower.Parent = underwaterPalace
    end
    
    -- 気泡エフェクト
    spawn(function()
        local startTime = tick()
        while underwaterPalace.Parent and tick() - startTime < 25 do
            local bubble = Instance.new("Part")
            bubble.Shape = Enum.PartType.Ball
            bubble.Size = Vector3.new(math.random(1, 2), math.random(1, 2), math.random(1, 2))
            bubble.BrickColor = BrickColor.new("Institutional white")
            bubble.Material = Enum.Material.Glass
            bubble.Transparency = 0.6
            bubble.Position = palaceBase.Position + Vector3.new(
                math.random(-18, 18),
                -5,
                math.random(-18, 18)
            )
            bubble.Parent = underwaterPalace
            
            local velocity = Instance.new("BodyVelocity")
            velocity.Velocity = Vector3.new(0, 8, 0)
            velocity.Parent = bubble
            
            game:GetService("Debris"):AddItem(bubble, 4)
            wait(0.4)
        end
    end)
    
    underwaterPalace.Parent = workspace
    game:GetService("Debris"):AddItem(underwaterPalace, 30)
end

-- 豪華なおもちゃリスト（日本語名）
local toyList = {
    {"🏰 巨大マクドナルド", UltimateToys.巨大マクドナルド},
    {"☕ スターバックスカフェ", UltimateToys.スターバックスカフェ},
    {"🎡 夢の遊園地", UltimateToys.夢の遊園地},
    {"🏯 日本の名城", UltimateToys.日本の名城},
    {"🚀 宇宙ステーション", UltimateToys.宇宙ステーション},
    {"🏙️ 未来都市", UltimateToys.未来都市},
    {"🐉 ドラゴン召喚", UltimateToys.ドラゴン召喚},
    {"🔮 魔法の城", UltimateToys.魔法の城},
    {"🐠 海底宮殿", UltimateToys.海底宮殿}
}

-- シンプルで効果的なUI作成
local function CreateUltimateUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UltimateToysUI"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 400, 0, 550)
    mainFrame.Position = UDim2.new(0, 20, 0, 20)
    mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = mainFrame
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Text = "🎮 超豪華おもちゃコレクション 🎮"
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    local scroll = Instance.new("ScrollingFrame")
    scroll.Name = "Scroll"
    scroll.Size = UDim2.new(1, -20, 1, -70)
    scroll.Position = UDim2.new(0, 10, 0, 60)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 8
    scroll.Parent = mainFrame
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.Parent = scroll
    
    return screenGui, scroll
end

-- おもちゃボタン作成関数
local function CreateToyButton(scrollFrame, toyName, toyFunction)
    local button = Instance.new("TextButton")
    button.Name = "ToyButton_" .. string.sub(toyName, 4)
    button.Size = UDim2.new(1, 0, 0, 45)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = toyName
    button.Font = Enum.Font.Gotham
    button.TextScaled = true
    button.Parent = scrollFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        pcall(function()
            toyFunction()
            print("超豪華おもちゃ起動: " .. toyName)
        end)
    end)
    
    return button
end

-- メイン初期化関数
local function InitializeUltimateToys()
    local ui, scroll = CreateUltimateUI()
    
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
    
    -- クリーンアップボタン
    local cleanupButton = Instance.new("TextButton")
    cleanupButton.Name = "CleanupButton"
    cleanupButton.Size = UDim2.new(1, -20, 0, 40)
    cleanupButton.Position = UDim2.new(0, 10, 1, -50)
    cleanupButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    cleanupButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    cleanupButton.Text = "🧹 おもちゃ全消去"
    cleanupButton.Font = Enum.Font.GothamBold
    cleanupButton.TextScaled = true
    cleanupButton.Parent = mainFrame
    
    local cleanupCorner = Instance.new("UICorner")
    cleanupCorner.CornerRadius = UDim.new(0, 6)
    cleanupCorner.Parent = cleanupButton
    
    cleanupButton.MouseButton1Click:Connect(function()
        for _, obj in pairs(workspace:GetChildren()) do
            if obj:IsA("Model") and (string.find(obj.Name, "マクドナルド") or 
               string.find(obj.Name, "スターバックス") or 
               string.find(obj.Name, "遊園地") or
               string.find(obj.Name, "城") or
               string.find(obj.Name, "ステーション") or
               string.find(obj.Name, "都市") or
               string.find(obj.Name, "龍") or
               string.find(obj.Name, "魔法") or
               string.find(obj.Name, "宮殿")) then
                obj:Destroy()
            end
        end
    end)
    
    print("🎮 超豪華おもちゃコレクション 読み込み完了!")
    print("🏰 巨大建築物: マクドナルド、スターバックス、遊園地、城")
    print("🚀 スペシャル: 宇宙ステーション、未来都市、ドラゴン")
    print("🔮 マジック: 魔法の城、海底宮殿")
    print("🎯 総おもちゃ数: 9種類の超豪華おもちゃ")
end

-- スクリプト実行
InitializeUltimateToys()
