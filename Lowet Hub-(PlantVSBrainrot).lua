-- Lowet Hub V1.0 - Optimized
repeat task.wait() until game:IsLoaded()
if setfpscap then setfpscap(1000000) end

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- Theme
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

Window:Tag({Title = "V1.0", Color = Color3.fromRGB(255, 107, 53), Radius = 13})
Window:Tag({Title = "BETA", Color = Color3.fromRGB(255, 140, 66), Radius = 13})

-- Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local player = Players.LocalPlayer

-- Config
local Config = {
    AutoFarm = false,
    AutoMoney = false,
    AutoCollect = false,
    SellBrainrot = false,
    SellPlant = false,
    SellEverything = false,
    SelectedRarities = {"Secret", "Limited"},
    SelectedSeeds = {},
    SelectedGears = {},
    AutoBuySeeds = false,
    AutoBuyGears = false,
    AutoBuyAllSeeds = false,
    AutoBuyAllGears = false,
    CollectDelay = 5
}

local Constants = {
    Seeds = {"Cactus", "Strawberry", "Pumpkin", "Dragon Fruit", "Eggplant", "Watermelon", "Cocotank", "Grape", "Carnivorous Plant", "Mr carrot", "Shroombino", "Tomatrio", "Mango"},
    Gears = {"Frost Grenade", "Frost Blower", "Banana Gun", "Carrot Launcher", "Water Bucket"},
    Bats = {"Aluminum Bat", "Iron Core Bat", "Iron Plate Bat", "Leather Grip Bat", "Basic Bat"},
    Rarities = {"Common", "Rare", "Epic", "Legendary", "Mythic", "Godly", "Secret", "Limited"}
}

-- Utils
local function Notify(msg) WindUI:Notify({
    Title = "Notification",
    Content = msg,
    Duration = 3, -- 3 seconds
    Icon = "house",
}) end
local function SafeCall(func) pcall(func) end
local function GetRemote(path) return ReplicatedStorage:WaitForChild("Remotes"):WaitForChild(path) end

-- Sections
local SectionMain = Window:Section({Title = "Main", Icon = "house", Opened = true})
local SectionGame = Window:Section({Title = "Game", Icon = "gamepad-2", Opened = true})
local SectionSettings = Window:Section({Title = "Settings", Icon = "settings", Opened = true})

-- Home Tab
local TabHome = SectionMain:Tab({Title = "Home", Icon = "house"})
TabHome:Paragraph({Title = "Welcome to Lowet Hub! 🎮", Desc = "Premium features for gameplay"})
TabHome:Paragraph({
    Title = "Discord Community",
    Desc = "Join for updates and support!",
    Buttons = {{
        Icon = "copy",
        Title = "Copy Discord Link",
        Callback = function()
            setclipboard("https://discord.gg/VyQfTtDJnY")
            Notify("Discord link copied!")
        end
    }}
})

-- Auto Farm Tab
local TabAutoFarm = SectionGame:Tab({Title = "Auto Farm", Icon = "zap"})
TabAutoFarm:Paragraph({Title = "🚀 Auto Farm System", Desc = "Intelligent farming with auto-combat"})
TabAutoFarm:Dropdown({
    Title = "Target Rarities",
    Values = Constants.Rarities,
    Value = Config.SelectedRarities,
    Multi = true,
    AllowNone = true,
    Callback = function(v) Config.SelectedRarities = v end
})
TabAutoFarm:Toggle({
    Title = "Enable Auto Farm",
    Description = "Auto teleport, combat, and loot",
    Callback = function(v) Config.AutoFarm = v end
})
TabAutoFarm:Toggle({
    Title = "Auto Farm Money",
    Description = "Auto equip best brainrots every 10s",
    Callback = function(v) Config.AutoMoney = v end
})

-- Seeds Tab
local TabSeeds = SectionGame:Tab({Title = "Seeds", Icon = "sprout"})
TabSeeds:Paragraph({Title = "🌱 Seeds Manager", Desc = "Automated seed purchasing"})
TabSeeds:Dropdown({
    Title = "Select Seeds",
    Values = Constants.Seeds,
    Multi = true,
    AllowNone = true,
    Callback = function(v) Config.SelectedSeeds = v end
})
TabSeeds:Toggle({Title = "Auto Buy Selected Seeds", Callback = function(v) Config.AutoBuySeeds = v end})
TabSeeds:Toggle({Title = "Auto Buy All Seeds", Callback = function(v) Config.AutoBuyAllSeeds = v end})

-- Gear Tab
local TabGear = SectionGame:Tab({Title = "Gear", Icon = "wrench"})
TabGear:Paragraph({Title = "⚙️ Gear Shop", Desc = "Automated gear purchasing"})
TabGear:Dropdown({
    Title = "Select Gears",
    Values = Constants.Gears,
    Multi = true,
    AllowNone = true,
    Callback = function(v) Config.SelectedGears = v end
})
TabGear:Toggle({Title = "Auto Buy Selected Gears", Callback = function(v) Config.AutoBuyGears = v end})
TabGear:Toggle({Title = "Auto Buy All Gears", Callback = function(v) Config.AutoBuyAllGears = v end})

-- Sell Tab
local TabSell = SectionGame:Tab({Title = "Sell", Icon = "dollar-sign"})
TabSell:Paragraph({Title = "💰 Auto Sell Manager", Desc = "Automated selling system"})
TabSell:Toggle({
    Title = "Auto Sell Brainrots",
    Description = "Keep equipped, auto sell brainrots",
    Callback = function(v) 
        Config.SellBrainrot = v 
        if v then Config.SellPlant = false end
        Notify(v and "Auto sell brainrots enabled!" or "Auto sell brainrots disabled")
    end
})
TabSell:Toggle({
    Title = "Auto Sell Plants", 
    Description = "Keep equipped, auto sell plants",
    Callback = function(v) 
        Config.SellPlant = v 
        if v then Config.SellBrainrot = false end
        Notify(v and "Auto sell plants enabled!" or "Auto sell plants disabled")
    end
})
TabSell:Toggle({
    Title = "Auto Sell Everything",
    Description = "Sell both brainrots and plants",
    Callback = function(v) 
        Config.SellEverything = v 
        Notify(v and "Auto sell everything enabled!" or "Auto sell everything disabled")
    end
})
TabSell:Paragraph({
    Title = "Manual Sell",
    Desc = "One-time sell operations",
    Buttons = {
        {Icon = "trash-2", Title = "Sell Items Now", Callback = function() 
            SafeCall(function() GetRemote("ItemSell"):FireServer() end) 
            Notify("Items sold!") 
        end}
    }
})

-- Brainrot Tab
local TabBrainrot = SectionGame:Tab({Title = "Brainrot", Icon = "skull"})
TabBrainrot:Paragraph({
    Title = "🧠 Brainrot Manager",
    Desc = "Optimize your equipment",
    Buttons = {{
        Icon = "zap",
        Title = "Equip Best",
        Callback = function()
            SafeCall(function() GetRemote("EquipBestBrainrots"):FireServer() end)
            Notify("Equipped best brainrots!")
        end
    }}
})

-- Auto Collect Tab
local TabCollect = SectionGame:Tab({Title = "Auto Collect", Icon = "hand-coins"})
TabCollect:Paragraph({Title = "💸 Auto Collection", Desc = "Automatically collect money from plot"})
TabCollect:Slider({
    Title = "Collect Delay (sec)",
    Value = {Min = 1, Max = 60, Default = 5},
    Step = 1,
    Callback = function(v) Config.CollectDelay = v end
})
TabCollect:Toggle({
    Title = "Auto Collect Money (Event)",
    Description = "Use event-based collection (faster & safer)",
    Callback = function(v) Config.AutoCollect = v end
})

-- Misc Tab
local TabMisc = SectionSettings:Tab({Title = "Misc", Icon = "settings"})
TabMisc:Paragraph({Title = "⚡ Performance", Desc = "Optimize game performance"})
TabMisc:Paragraph({
    Title = "Remove Textures",
    Desc = "Reduce lag by removing visuals",
    Buttons = {{
        Icon = "zap",
        Title = "Optimize Now",
        Callback = function()
            SafeCall(function()
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("Texture") or obj:IsA("Decal") then obj:Destroy()
                    elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then obj.Enabled = false
                    elseif obj:IsA("MeshPart") or obj:IsA("Part") or obj:IsA("UnionOperation") then obj.Material = Enum.Material.SmoothPlastic obj.Reflectance = 0 end
                end
                local Lighting = game:GetService("Lighting")
                Lighting.GlobalShadows = false
                Lighting.FogEnd = 9e9
                Lighting.Brightness = 0
                for _, effect in pairs(Lighting:GetChildren()) do if effect:IsA("PostEffect") then effect.Enabled = false end end
            end)
            Notify("Game optimized!")
        end
    }}
})

-- Auto Buy System
task.spawn(function()
    while task.wait(0.5) do
        if Config.AutoBuySeeds and #Config.SelectedSeeds > 0 then
            for _, seed in ipairs(Config.SelectedSeeds) do
                SafeCall(function() GetRemote("BuyItem"):FireServer(seed .. " Seed", true) end)
                task.wait(0.1)
            end
        end
        if Config.AutoBuyAllSeeds then
            for _, seed in ipairs(Constants.Seeds) do
                SafeCall(function() GetRemote("BuyItem"):FireServer(seed .. " Seed", true) end)
                task.wait(0.1)
            end
        end
        if Config.AutoBuyGears and #Config.SelectedGears > 0 then
            for _, gear in ipairs(Config.SelectedGears) do
                SafeCall(function() GetRemote("BuyGear"):FireServer(gear, true) end)
                task.wait(0.1)
            end
        end
        if Config.AutoBuyAllGears then
            for _, gear in ipairs(Constants.Gears) do
                SafeCall(function() GetRemote("BuyGear"):FireServer(gear, true) end)
                task.wait(0.1)
            end
        end
    end
end)

-- Auto Sell System
task.spawn(function()
    while true do
        task.wait(0.69)
        if Config.SellBrainrot or Config.SellPlant or Config.SellEverything then
            SafeCall(function()
                local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                if remotes and remotes:FindFirstChild("ItemSell") then
                    remotes.ItemSell:FireServer()
                end
            end)
        end
    end
end)

-- Auto Farm System
task.spawn(function()
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    local currentBat = nil
    local attackQueue = {}
    local isAttacking = false
    
    local function GetBestBat()
        for _, bat in ipairs(Constants.Bats) do
            local tool = player.Backpack:FindFirstChild(bat) or character:FindFirstChild(bat)
            if tool then return tool end
        end
    end
    
    local function EquipBat()
        for _, bat in ipairs(Constants.Bats) do
            local equipped = character:FindFirstChild(bat)
            if equipped then currentBat = equipped return true end
        end
        local bat = GetBestBat()
        if bat then SafeCall(function() humanoid:EquipTool(bat) currentBat = bat end) return true end
        return false
    end
    
    -- Attack Loop
    task.spawn(function()
        local attackRemote = GetRemote("AttacksServer"):WaitForChild("WeaponAttack")
        while true do
            task.wait(0.01)
            if #attackQueue > 0 and not isAttacking and Config.AutoFarm then
                isAttacking = true
                local target = table.remove(attackQueue, 1)
                SafeCall(function()
                    local bat = currentBat or GetBestBat()
                    if bat and bat.Parent == character then bat:Activate() end
                    attackRemote:FireServer({target})
                end)
                isAttacking = false
            elseif not Config.AutoFarm then attackQueue = {} end
        end
    end)
    
    -- Auto Equip Bat
    task.spawn(function()
        while true do
            if Config.AutoFarm then
                local brainrotsFolder = Workspace:WaitForChild("ScriptedMap"):WaitForChild("Brainrots")
                local hasTarget = false
                for _, b in ipairs(brainrotsFolder:GetChildren()) do
                    if b:IsA("Model") then
                        local rarity = b:GetAttribute("Rarity")
                        if rarity and table.find(Config.SelectedRarities, rarity) then hasTarget = true break end
                    end
                end
                if hasTarget then EquipBat() else if currentBat and currentBat.Parent == character then SafeCall(function() humanoid:UnequipTools() currentBat = nil end) end end
            end
            task.wait(0.5)
        end
    end)
    
    -- Find Plot
    local myPlot
    for _, plot in ipairs(Workspace:WaitForChild("Plots"):GetChildren()) do
        if plot:GetAttribute("Owner") == player.Name then myPlot = plot break end
    end
    if not myPlot then return end
    
    -- Find Roads
    local roadParts = {}
    if myPlot:FindFirstChild("Other") then
        for _, tier in ipairs(myPlot.Other:GetChildren()) do
            local roadModel = tier:FindFirstChild("Road")
            if roadModel then
                for _, p in ipairs(roadModel:GetDescendants()) do
                    if p:IsA("BasePart") then table.insert(roadParts, p) end
                end
            end
        end
    end
    
    -- Noclip
    local NoclipConnection
    local function Noclip(enable)
        if enable then
            NoclipConnection = RunService.Stepped:Connect(function()
                if character then
                    for _, v in pairs(character:GetDescendants()) do
                        if v:IsA("BasePart") and v.CanCollide and v.Name ~= "HumanoidRootPart" then v.CanCollide = false end
                    end
                end
            end)
        else
            if NoclipConnection then NoclipConnection:Disconnect() NoclipConnection = nil end
        end
    end
    
    local function FindFrostGrenade()
        for _, container in ipairs({character, player.Backpack}) do
            for _, item in ipairs(container:GetChildren()) do
                if item:IsA("Tool") and item.Name:match("Frost Grenade") then return item end
            end
        end
    end
    
    local function FireGrenade(brainrot)
        if not brainrot or not brainrot.Parent then return end
        local progress = brainrot:GetAttribute("Progress") or 0
        if progress > 0.6 then
            local tool = FindFrostGrenade()
            if tool then
                local bp = brainrot.PrimaryPart or brainrot:FindFirstChildWhichIsA("BasePart")
                if bp then
                    humanoid:EquipTool(tool)
                    GetRemote("UseItem"):FireServer({{Toggle = true, Tool = tool, Time = 0.5, Pos = bp.Position}})
                end
            end
        end
    end
    
    local brainrotsFolder = Workspace:WaitForChild("ScriptedMap"):WaitForChild("Brainrots")
    local function FindTarget()
        for _, b in ipairs(brainrotsFolder:GetChildren()) do
            if b:IsA("Model") then
                local rarity = b:GetAttribute("Rarity")
                if rarity and table.find(Config.SelectedRarities, rarity) then
                    local primary = b.PrimaryPart or b:FindFirstChildWhichIsA("BasePart")
                    if primary then
                        for _, roadPart in ipairs(roadParts) do
                            if (primary.Position - roadPart.Position).Magnitude <= 20 then return b end
                        end
                    end
                end
            end
        end
    end
    
    -- Main Farm Loop
    while true do
        if Config.AutoFarm then
            local target = FindTarget()
            if target then
                local targetPart = target.PrimaryPart or target:FindFirstChildWhichIsA("BasePart")
                if targetPart then
                    Noclip(true)
                    hrp.CFrame = CFrame.new(targetPart.Position)
                    local bodyPos = Instance.new("BodyPosition")
                    bodyPos.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                    bodyPos.P = 5000
                    bodyPos.D = 100
                    bodyPos.Position = hrp.Position
                    bodyPos.Parent = hrp
                    local lastFire = 0
                    while target.Parent and Config.AutoFarm do
                        bodyPos.Position = targetPart.Position
                        local progress = target:GetAttribute("Progress") or 0
                        if progress > 0.6 then local tool = FindFrostGrenade() if tool then humanoid:EquipTool(tool) end end
                        local now = tick()
                        if now - lastFire >= 2 then FireGrenade(target) lastFire = now end
                        if target.Name then for i = 1, 3 do table.insert(attackQueue, target.Name) end end
                        task.wait(0.0001)
                    end
                    humanoid:UnequipTools()
                    bodyPos:Destroy()
                    Noclip(false)
                end
            else task.wait(1) end
        else task.wait(1) end
    end
end)

-- Auto Money System
task.spawn(function()
    while true do
        if Config.AutoMoney then SafeCall(function() GetRemote("EquipBestBrainrots"):FireServer() end) task.wait(10) else task.wait(1) end
    end
end)

-- Auto Collect System (Event-based)
task.spawn(function()
    while true do
        if Config.AutoCollect then
            SafeCall(function()
                local bn = ReplicatedStorage:FindFirstChild("BridgeNet2")
                if bn and bn:FindFirstChild("dataRemoteEvent") then
                    local args = {{[2] = "\004"}}
                    bn.dataRemoteEvent:FireServer(unpack(args))
                end
            end)
            task.wait(Config.CollectDelay)
        else
            task.wait(1)
        end
    end
end)

Notify("Lowet Hub V1.0 loaded!")