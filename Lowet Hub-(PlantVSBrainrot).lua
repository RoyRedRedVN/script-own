local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

WindUI:AddTheme({
    Name = "POWER",
    Accent = Color3.fromRGB(255, 107, 53),
    Dialog = Color3.fromRGB(40, 20, 10),
    Outline = Color3.fromRGB(255, 140, 66),
    Text = Color3.fromRGB(255, 255, 255),
    Placeholder = Color3.fromRGB(184, 184, 184),
    Background = Color3.fromRGB(50, 25, 10),
    Button = Color3.fromRGB(255, 107, 53),
    Icon = Color3.fromRGB(255, 165, 82)
})

WindUI:SetTheme("POWER")

local Window = WindUI:CreateWindow({
    Title = "Lowet Hub",
    Icon = "door-open",
    Author = "by RedMod",
    Folder = "LowetHub",
    Transparent = true,
    Theme = "POWER",
    Resizable = true,
})

Window:EditOpenButton({
    Title = "Open Hub",
    Icon = "monitor",
    CornerRadius = UDim.new(0, 16),
    StrokeThickness = 2,
    Color = ColorSequence.new(Color3.fromRGB(255, 107, 53), Color3.fromRGB(255, 140, 66)),
    Draggable = true,
})

Window.Icon:SetAnonymous(false)
Window:Tag({Title = "V1.0", Color = Color3.fromRGB(255, 107, 53), Radius = 13})

-- Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Variables
local SelectedSeeds, SelectedGears, SelectedSellPlants, SelectedRarities = {}, {}, {}, {"Secret", "Limited"}
local AutoBuySelectSeed, AutoBuyAllSeeds, AutoBuySelectGear, AutoBuyAllGear = false, false, false, false
local AutoFarmEnabled, AutoFarmMoneyEnabled = false, false

-- Sections
local SectionMain = Window:Section({Title = "Main", Icon = "house", Opened = true})
local SectionGame = Window:Section({Title = "Game", Icon = "gamepad-2", Opened = true})
local SectionSettings = Window:Section({Title = "Settings", Icon = "settings", Opened = true})

-- Home Tab
local TabHome = SectionMain:Tab({Title = "Home", Icon = "house"})
TabHome:Paragraph({Title = "Welcome to Lowet Hub", Desc = "Join our Discord community for updates and support!"})
TabHome:Paragraph({
    Title = "Discord Server",
    Desc = "https://discord.gg/VyQfTtDJnY",
    Buttons = {{
        Icon = "copy",
        Title = "Copy Link",
        Callback = function()
            setclipboard("https://discord.gg/VyQfTtDJnY")
            print("✓ Discord link copied!")
        end
    }}
})

-- Auto Farm Tab
local TabAutoFarm = SectionGame:Tab({Title = "Auto Farm", Icon = "zap"})
TabAutoFarm:Paragraph({Title = "Auto Farm Brainrots", Desc = "Automatically farm brainrots with Frost Grenade"})
TabAutoFarm:Dropdown({
    Title = "Select Rarities to Farm",
    Values = {"Rare", "Epic", "Legendary", "Mythic", "Godly", "Secret", "Limited"},
    Value = {"Secret", "Limited"},
    Multi = true,
    AllowNone = true,
    Callback = function(selected) SelectedRarities = selected end
})
TabAutoFarm:Toggle({
    Title = "Enable Auto Farm",
    Description = "Auto teleport, use Frost Grenade, and auto click bats",
    Callback = function(value) AutoFarmEnabled = value end
})
TabAutoFarm:Toggle({
    Title = "Auto Farm Money",
    Description = "Auto equip best brainrots every 10 seconds",
    Callback = function(value) AutoFarmMoneyEnabled = value end
})

-- Seeds Tab
local TabSeeds = SectionGame:Tab({Title = "Seeds", Icon = "sprout"})
TabSeeds:Paragraph({Title = "Seeds Manager", Desc = "Buy and manage your seeds"})
TabSeeds:Dropdown({
    Title = "Select Seeds",
    Values = {"Cactus", "Strawberry", "Pumpkin", "Dragon Fruit", "Eggplant", "Watermelon", "Cocotank", "Grape", "Carnivorous Plant", "Mr carrot", "Shroombino", "Tomatrio", "Mango"},
    Multi = true,
    AllowNone = true,
    Callback = function(selected) SelectedSeeds = selected end
})
TabSeeds:Toggle({Title = "Auto Buy Selected", Description = "Auto buy selected seeds", Callback = function(value) AutoBuySelectSeed = value end})
TabSeeds:Toggle({Title = "Auto Buy All", Description = "Auto buy all seeds", Callback = function(value) AutoBuyAllSeeds = value end})

-- Gear Tab
local TabGear = SectionGame:Tab({Title = "Gear", Icon = "wrench"})
TabGear:Paragraph({Title = "Gear Shop", Desc = "Buy and equip your gears"})
TabGear:Dropdown({
    Title = "Select Gears",
    Values = {"Frost Grenade", "Frost Blower", "Banana Gun", "Carrot Launcher", "Water Bucket"},
    Multi = true,
    AllowNone = true,
    Callback = function(selected) SelectedGears = selected end
})
TabGear:Toggle({Title = "Auto Buy Selected", Description = "Auto buy selected gears", Callback = function(value) AutoBuySelectGear = value end})
TabGear:Toggle({Title = "Auto Buy All", Description = "Auto buy all gears", Callback = function(value) AutoBuyAllGear = value end})

-- Sell Tab
local TabSell = SectionGame:Tab({Title = "Sell", Icon = "dollar-sign"})
TabSell:Paragraph({Title = "Auto Sell Manager", Desc = "Sell items by rarity"})

local function createSellButton(rarity)
    return {
        Icon = "trash-2",
        Title = "Sell " .. rarity,
        Callback = function()
            pcall(function()
                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("AutoSell"):FireServer(rarity)
                print("✓ Sold all " .. rarity .. " items!")
            end)
        end
    }
end

TabSell:Paragraph({
    Title = "Sell Trash Items",
    Desc = "Quick sell items by rarity",
    Buttons = {
        createSellButton("Common"),
        createSellButton("Epic"),
        createSellButton("Legendary"),
        createSellButton("Godly"),
        createSellButton("Mythic"),
        createSellButton("Secret"),
        createSellButton("Limited")
    }
})

TabSell:Paragraph({
    Title = "Sell All Trash",
    Desc = "Sell multiple rarities at once",
    Buttons = {{
        Icon = "trash",
        Title = "Sell All Trash",
        Callback = function()
            local rarities = {"Common", "Epic", "Legendary", "Godly", "Mythic", "Secret", "Limited"}
            for _, rarity in ipairs(rarities) do
                pcall(function()
                    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("AutoSell"):FireServer(rarity)
                end)
                task.wait(0.1)
            end
            print("✓ Sold all trash!")
        end
    }}
})

TabSell:Paragraph({Title = "Sell Plants", Desc = "Auto equip and sell selected plants"})
TabSell:Dropdown({
    Title = "Select Plants to Sell",
    Values = {"Cactus", "Strawberry", "Pumpkin", "Dragon Fruit", "Eggplant", "Watermelon", "Cocotank", "Grape", "Carnivorous Plant", "Mr carrot", "Shroombino", "Tomatrio", "Mango"},
    Multi = true,
    AllowNone = true,
    Callback = function(selected) SelectedSellPlants = selected end
})
TabSell:Paragraph({
    Title = "Sell Selected Plants",
    Desc = "Auto equip then sell the selected plants",
    Buttons = {{
        Icon = "hand",
        Title = "Sell Plants",
        Callback = function()
            if #SelectedSellPlants == 0 then return warn("✗ No plants selected!") end
            for _, plant in ipairs(SelectedSellPlants) do
                pcall(function()
                    local character = player.Character
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    local plantItem = player.Backpack:FindFirstChild(plant) or character:FindFirstChild(plant)
                    if plantItem and humanoid then
                        humanoid:EquipTool(plantItem)
                        task.wait(0.2)
                        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ItemSell"):FireServer()
                        task.wait(0.2)
                    end
                end)
            end
            print("✓ Plants sold!")
        end
    }}
})

-- Brainrot Tab
local TabBrainrot = SectionGame:Tab({Title = "Brainrot", Icon = "skull"})
TabBrainrot:Paragraph({
    Title = "Brainrot Manager",
    Desc = "Equip the best brainrots in your inventory",
    Buttons = {{
        Icon = "zap",
        Title = "Equip Best",
        Callback = function()
            pcall(function()
                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("EquipBestBrainrots"):FireServer()
                print("✓ Equipped best brainrots!")
            end)
        end
    }}
})

-- Event Tab
local TabEvent = SectionGame:Tab({Title = "Event", Icon = "gift"})
TabEvent:Paragraph({Title = "Event Features", Desc = "Special event-related features and activities"})

-- Misc Tab
local TabMisc = SectionSettings:Tab({Title = "Misc", Icon = "settings"})
TabMisc:Paragraph({Title = "Miscellaneous Settings", Desc = "Additional features and settings"})
TabMisc:Paragraph({
    Title = "Performance Optimization",
    Desc = "Remove textures to reduce lag",
    Buttons = {{
        Icon = "zap",
        Title = "Remove Textures",
        Callback = function()
            pcall(function()
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("Texture") or obj:IsA("Decal") then
                        obj:Destroy()
                    elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                        obj.Enabled = false
                    elseif obj:IsA("MeshPart") or obj:IsA("Part") or obj:IsA("UnionOperation") then
                        obj.Material = Enum.Material.SmoothPlastic
                        obj.Reflectance = 0
                    end
                end
                local Lighting = game:GetService("Lighting")
                Lighting.GlobalShadows = false
                Lighting.FogEnd = 9e9
                Lighting.Brightness = 0
                for _, effect in pairs(Lighting:GetChildren()) do
                    if effect:IsA("PostEffect") then effect.Enabled = false end
                end
            end)
            print("✓ Game optimized!")
        end
    }}
})

TabMisc:Toggle({
    Title = "Auto Remove New Textures",
    Description = "Automatically remove textures from new objects",
    Callback = function(value)
        if value then
            Workspace.DescendantAdded:Connect(function(obj)
                task.wait(0.1)
                pcall(function()
                    if obj:IsA("Texture") or obj:IsA("Decal") then
                        obj:Destroy()
                    elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                        obj.Enabled = false
                    end
                end)
            end)
        end
    end
})

-- Auto Buy Logic
task.spawn(function()
    local allSeeds = {"Cactus", "Strawberry", "Pumpkin", "Dragon Fruit", "Eggplant", "Watermelon", "Cocotank", "Grape", "Carnivorous Plant", "Mr carrot", "Shroombino", "Tomatrio", "Mango"}
    local allGears = {"Frost Grenade", "Frost Blower", "Banana Gun", "Carrot Launcher", "Water Bucket"}
    
    while task.wait(0.5) do
        if AutoBuySelectSeed and #SelectedSeeds > 0 then
            for _, seed in ipairs(SelectedSeeds) do
                pcall(function() ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("BuyItem"):FireServer(seed .. " Seed", true) end)
                task.wait(0.1)
            end
        end
        if AutoBuyAllSeeds then
            for _, seed in ipairs(allSeeds) do
                pcall(function() ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("BuyItem"):FireServer(seed .. " Seed", true) end)
                task.wait(0.1)
            end
        end
        if AutoBuySelectGear and #SelectedGears > 0 then
            for _, gear in ipairs(SelectedGears) do
                pcall(function() ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("BuyGear"):FireServer(gear, true) end)
                task.wait(0.1)
            end
        end
        if AutoBuyAllGear then
            for _, gear in ipairs(allGears) do
                pcall(function() ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("BuyGear"):FireServer(gear, true) end)
                task.wait(0.1)
            end
        end
    end
end)

-- Auto Farm Logic
task.spawn(function()
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    
    local rebirthBatList = {"Basic Bat", "Leather Grip Bat", "Iron Plate Bat", "Iron Core Bat", "Aluminum Bat"}
    local currentEquippedBat = nil
    
    local function getBestBat()
        local backpack = player:FindFirstChild("Backpack")
        if not character or not backpack then return nil end
        for i = #rebirthBatList, 1, -1 do
            local bat = character:FindFirstChild(rebirthBatList[i]) or backpack:FindFirstChild(rebirthBatList[i])
            if bat then return bat end
        end
        return nil
    end
    
    local function autoEquipBestBat()
        local backpack = player:FindFirstChild("Backpack")
        if not character or not backpack or not humanoid then return false end
        for i = #rebirthBatList, 1, -1 do
            local bat = character:FindFirstChild(rebirthBatList[i])
            if bat then
                currentEquippedBat = bat
                return true
            end
        end
        for i = #rebirthBatList, 1, -1 do
            local bat = backpack:FindFirstChild(rebirthBatList[i])
            if bat then
                pcall(function()
                    humanoid:EquipTool(bat)
                    currentEquippedBat = bat
                end)
                return true
            end
        end
        return false
    end
    
    -- Attack system
    local attackQueue = {}
    local isAttacking = false
    
    task.spawn(function()
        local attackRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("AttacksServer"):WaitForChild("WeaponAttack")
        while true do
            task.wait(0.01)
            if #attackQueue > 0 and not isAttacking and AutoFarmEnabled then
                isAttacking = true
                local targetName = table.remove(attackQueue, 1)
                pcall(function()
                    local bat = currentEquippedBat or getBestBat()
                    if bat and bat.Parent == character then bat:Activate() end
                    attackRemote:FireServer({targetName})
                end)
                isAttacking = false
            elseif not AutoFarmEnabled then
                attackQueue = {}
            end
        end
    end)
    
    -- Auto equip bat
    task.spawn(function()
        while true do
            if AutoFarmEnabled then
                local brainrotsFolder = Workspace:WaitForChild("ScriptedMap"):WaitForChild("Brainrots")
                local hasTarget = false
                for _, b in ipairs(brainrotsFolder:GetChildren()) do
                    if b:IsA("Model") then
                        local rarity = b:GetAttribute("Rarity")
                        if rarity and table.find(SelectedRarities, rarity) then
                            hasTarget = true
                            break
                        end
                    end
                end
                if hasTarget then
                    autoEquipBestBat()
                else
                    if currentEquippedBat and currentEquippedBat.Parent == character then
                        pcall(function()
                            humanoid:UnequipTools()
                            currentEquippedBat = nil
                        end)
                    end
                end
            end
            task.wait(0.5)
        end
    end)
    
    local plotsFolder = Workspace:WaitForChild("Plots")
    local myPlot
    for _, plot in ipairs(plotsFolder:GetChildren()) do
        if plot:GetAttribute("Owner") == player.Name then
            myPlot = plot
            break
        end
    end
    if not myPlot then return end
    
    local tierModel
    local highestTier = 0
    if myPlot:FindFirstChild("Other") then
        for _, candidate in ipairs(myPlot.Other:GetChildren()) do
            local tierNum = candidate.Name:match("^Tier(%d+)$")
            if tierNum then
                tierNum = tonumber(tierNum)
                if tierNum > highestTier and candidate:IsA("Model") then
                    highestTier = tierNum
                    tierModel = candidate
                end
            end
        end
    end
    if not tierModel then return end
    
    local roadModel = tierModel:FindFirstChild("Road")
    if not roadModel then return end
    local roadParts = {}
    for _, p in ipairs(roadModel:GetDescendants()) do
        if p:IsA("BasePart") then table.insert(roadParts, p) end
    end
    
    local Clip = true
    local NoclipConnection
    
    local function noclip()
        Clip = false
        NoclipConnection = RunService.Stepped:Connect(function()
            if not Clip and character then
                for _, v in pairs(character:GetDescendants()) do
                    if v:IsA("BasePart") and v.CanCollide and v.Name ~= "HumanoidRootPart" then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end
    
    local function clip()
        Clip = true
        if NoclipConnection then
            NoclipConnection:Disconnect()
            NoclipConnection = nil
        end
    end
    
    local function findFrostGrenade()
        for _, container in ipairs({character, player:WaitForChild("Backpack")}) do
            for _, item in ipairs(container:GetChildren()) do
                if item:IsA("Tool") and string.match(item.Name, "^%[x%d+%] Frost Grenade$") then
                    return item
                end
            end
        end
        return nil
    end
    
    local function fireFrostGrenade(brainrot)
        if not brainrot or not brainrot.Parent then return end
        local progress = brainrot:GetAttribute("Progress") or 0
        if progress > 0.6 then
            local tool = findFrostGrenade()
            if tool then
                local bp = brainrot.PrimaryPart or brainrot:FindFirstChildWhichIsA("BasePart")
                if bp then
                    humanoid:EquipTool(tool)
                    local useItemRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("UseItem")
                    useItemRemote:FireServer({{Toggle = true, Tool = tool, Time = 0.5, Pos = bp.Position}})
                end
            end
        end
    end
    
    local brainrotsFolder = Workspace:WaitForChild("ScriptedMap"):WaitForChild("Brainrots")
    local DETECT_RADIUS = 20
    local FIRE_INTERVAL = 2
    
    local function findTargetBrainrot(selectedRarities)
        for _, b in ipairs(brainrotsFolder:GetChildren()) do
            if b:IsA("Model") then
                local rarity = b:GetAttribute("Rarity")
                if rarity and table.find(selectedRarities, rarity) then
                    local primary = b.PrimaryPart or b:FindFirstChildWhichIsA("BasePart")
                    if primary then
                        for _, roadPart in ipairs(roadParts) do
                            if (primary.Position - roadPart.Position).Magnitude <= DETECT_RADIUS then
                                return b
                            end
                        end
                    end
                end
            end
        end
        return nil
    end
    
    while true do
        if AutoFarmEnabled then
            local targetBrainrot = findTargetBrainrot(SelectedRarities)
            if targetBrainrot then
                local targetPart = targetBrainrot.PrimaryPart or targetBrainrot:FindFirstChildWhichIsA("BasePart")
                if targetPart then
                    noclip()
                    hrp.CFrame = CFrame.new(targetPart.Position)
                    local bodyPos = Instance.new("BodyPosition")
                    bodyPos.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                    bodyPos.P = 5000
                    bodyPos.D = 100
                    bodyPos.Position = hrp.Position
                    bodyPos.Parent = hrp
                    local lastFire = 0
                    while targetBrainrot.Parent and AutoFarmEnabled do
                        bodyPos.Position = targetPart.Position
                        local progress = targetBrainrot:GetAttribute("Progress") or 0
                        if progress > 0.6 then
                            local tool = findFrostGrenade()
                            if tool then humanoid:EquipTool(tool) end
                        end
                        local now = tick()
                        if now - lastFire >= FIRE_INTERVAL then
                            fireFrostGrenade(targetBrainrot)
                            lastFire = now
                        end
                        if targetBrainrot.Name then
                            for i = 1, 3 do
                                table.insert(attackQueue, targetBrainrot.Name)
                            end
                        end
                        task.wait(0.01)
                    end
                    humanoid:UnequipTools()
                    bodyPos:Destroy()
                    clip()
                end
            else
                task.wait(1)
            end
        else
            task.wait(1)
        end
    end
end)

-- Auto Farm Money Logic
task.spawn(function()
    while true do
        if AutoFarmMoneyEnabled then
            pcall(function()
                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("EquipBestBrainrots"):FireServer()
                print("✓ Equipped best brainrots!")
            end)
            task.wait(10)
        else
            task.wait(1)
        end
    end
end)