-- Lowet Hub V1.0 - Optimized & Compact
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
local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local WS = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Config
local C = {
    AutoFarm = false,
    AutoMoney = false,
    SellBrainrot = false,
    SellPlant = false,
    SelectedRarities = {"Secret", "Limited"},
    SelectedSeeds = {},
    SelectedGears = {},
    AutoBuySeeds = false,
    AutoBuyGears = false,
    AutoBuyAllSeeds = false,
    AutoBuyAllGears = false,
    AutoCollectDelay = 5,
    AutoCollectEnabled = false
}

local Data = {
    Seeds = {"Cactus", "Strawberry", "Pumpkin", "Dragon Fruit", "Eggplant", "Watermelon", "Cocotank", "Grape", "Carnivorous Plant", "Mr carrot", "Shroombino", "Tomatrio", "Mango"},
    Gears = {"Frost Grenade", "Frost Blower", "Banana Gun", "Carrot Launcher", "Water Bucket"},
    Bats = {"Aluminum Bat", "Iron Core Bat", "Iron Plate Bat", "Leather Grip Bat", "Basic Bat"},
    Rarities = {"Common", "Rare", "Epic", "Legendary", "Mythic", "Godly", "Secret", "Limited"}
}

-- Utils
local function Notify(msg) WindUI:Notify({Title = "Notification", Content = msg, Duration = 3, Icon = "house"}) end
local function Safe(func) pcall(func) end
local function GetRemote(path) return RS:WaitForChild("Remotes"):WaitForChild(path) end
local function GetBridge() return RS:FindFirstChild("BridgeNet2") end

-- Create Tabs
local TabHome = Window:Tab({Title = "Home", Icon = "house"})
local TabFarm = Window:Tab({Title = "Auto Farm", Icon = "zap"})
local TabBuy = Window:Tab({Title = "Auto Buy", Icon = "shopping-cart"})
local TabSell = Window:Tab({Title = "Sell", Icon = "dollar-sign"})
local TabBrain = Window:Tab({Title = "Brainrot", Icon = "skull"})
local TabEvent = Window:Tab({Title = "Event", Icon = "hand-coins"})
local TabMisc = Window:Tab({Title = "Misc", Icon = "settings"})

-- Home Tab
TabHome:Paragraph({Title = "Welcome to Lowet Hub! 🎮", Desc = "Premium features for gameplay"})
TabHome:Paragraph({
    Title = "Discord Community",
    Desc = "Join for updates and support!",
    Buttons = {{Icon = "copy", Title = "Copy Discord Link", Callback = function() setclipboard("https://discord.gg/VyQfTtDJnY") Notify("Discord link copied!") end}}
})

-- Auto Farm Tab
TabFarm:Paragraph({Title = "🚀 Auto Farm System", Desc = "Intelligent farming with auto-combat"})
TabFarm:Dropdown({Title = "Target Rarities", Values = Data.Rarities, Value = C.SelectedRarities, Multi = true, AllowNone = true, Callback = function(v) C.SelectedRarities = v end})
TabFarm:Toggle({Title = "Enable Auto Farm", Description = "Auto teleport, combat, and loot", Callback = function(v) C.AutoFarm = v end})
TabFarm:Toggle({Title = "Auto Farm Money", Description = "Auto equip best brainrots every 10s", Callback = function(v) C.AutoMoney = v end})

-- Auto Buy Tab with Sections
local SectionSeeds = TabBuy:Section({Title = "Seeds Shop"})
SectionSeeds:Paragraph({Title = "🌱 Seeds Manager", Desc = "Automated seed purchasing"})
SectionSeeds:Dropdown({Title = "Select Seeds", Values = Data.Seeds, Multi = true, AllowNone = true, Callback = function(v) C.SelectedSeeds = v end})
SectionSeeds:Toggle({Title = "Auto Buy Selected Seeds", Callback = function(v) C.AutoBuySeeds = v end})
SectionSeeds:Toggle({Title = "Auto Buy All Seeds", Callback = function(v) C.AutoBuyAllSeeds = v end})

local SectionGears = TabBuy:Section({Title = "Gears Shop"})
SectionGears:Paragraph({Title = "⚙️ Gear Shop", Desc = "Automated gear purchasing"})
SectionGears:Dropdown({Title = "Select Gears", Values = Data.Gears, Multi = true, AllowNone = true, Callback = function(v) C.SelectedGears = v end})
SectionGears:Toggle({Title = "Auto Buy Selected Gears", Callback = function(v) C.AutoBuyGears = v end})
SectionGears:Toggle({Title = "Auto Buy All Gears", Callback = function(v) C.AutoBuyAllGears = v end})

-- Sell Tab
TabSell:Paragraph({Title = "💰 Auto Sell Manager", Desc = "Automated selling system"})
TabSell:Toggle({Title = "Auto Sell Brainrots", Description = "Keep equipped, auto sell brainrots only", Callback = function(v) C.SellBrainrot = v Notify(v and "Auto sell brainrots enabled!" or "Auto sell brainrots disabled") end})
TabSell:Toggle({Title = "Auto Sell Plants", Description = "Keep equipped, auto sell plants only", Callback = function(v) C.SellPlant = v Notify(v and "Auto sell plants enabled!" or "Auto sell plants disabled") end})
TabSell:Paragraph({Title = "Manual Sell", Desc = "One-time sell operations", Buttons = {{Icon = "trash-2", Title = "Sell Items Now", Callback = function() Safe(function() GetRemote("ItemSell"):FireServer() end) Notify("Items sold!") end}}})

-- Brainrot Tab
TabBrain:Paragraph({Title = "🧠 Brainrot Manager", Desc = "Optimize your equipment", Buttons = {{Icon = "zap", Title = "Equip Best", Callback = function() Safe(function() GetRemote("EquipBestBrainrots"):FireServer() end) Notify("Equipped best brainrots!") end}}})

-- Event Tab with Section
local SectionCollect = TabEvent:Section({Title = "Auto Collect Money"})
SectionCollect:Paragraph({Title = "💸 Auto Collection", Desc = "Automatically collect money from plot"})
SectionCollect:Slider({Title = "Collect Delay (sec)", Value = {Min = 1, Max = 60, Default = 5}, Step = 1, Callback = function(v) C.AutoCollectDelay = v end})
SectionCollect:Toggle({Title = "Auto Collect Money (Event)", Description = "Use event-based collection (faster & safer)", Callback = function(v) C.AutoCollectEnabled = v end})

-- Misc Tab
TabMisc:Paragraph({Title = "⚡ Performance", Desc = "Optimize game performance"})
TabMisc:Paragraph({
    Title = "Remove Textures",
    Desc = "Reduce lag by removing visuals",
    Buttons = {{Icon = "zap", Title = "Optimize Now", Callback = function()
        Safe(function()
            for _, obj in pairs(WS:GetDescendants()) do
                if obj:IsA("Texture") or obj:IsA("Decal") then obj:Destroy()
                elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then obj.Enabled = false
                elseif obj:IsA("MeshPart") or obj:IsA("Part") or obj:IsA("UnionOperation") then obj.Material = Enum.Material.SmoothPlastic obj.Reflectance = 0 end
            end
            local L = game:GetService("Lighting")
            L.GlobalShadows = false L.FogEnd = 9e9 L.Brightness = 0
            for _, e in pairs(L:GetChildren()) do if e:IsA("PostEffect") then e.Enabled = false end end
        end)
        Notify("Game optimized!")
    end}}
})

-- Auto Buy Loop
task.spawn(function()
    while task.wait(0.5) do
        local bn = GetBridge()
        if not bn or not bn:FindFirstChild("dataRemoteEvent") then continue end
        
        if C.AutoBuySeeds and #C.SelectedSeeds > 0 then
            for _, s in ipairs(C.SelectedSeeds) do Safe(function() bn.dataRemoteEvent:FireServer({{s .. " Seed", "\b"}}) end) task.wait(0.1) end
        end
        if C.AutoBuyAllSeeds then
            for _, s in ipairs(Data.Seeds) do Safe(function() bn.dataRemoteEvent:FireServer({{s .. " Seed", "\b"}}) end) task.wait(0.1) end
        end
        if C.AutoBuyGears and #C.SelectedGears > 0 then
            for _, g in ipairs(C.SelectedGears) do Safe(function() bn.dataRemoteEvent:FireServer({{g, "\026"}}) end) task.wait(0.1) end
        end
        if C.AutoBuyAllGears then
            for _, g in ipairs(Data.Gears) do Safe(function() bn.dataRemoteEvent:FireServer({{g, "\026"}}) end) task.wait(0.1) end
        end
    end
end)

-- Auto Sell Loop
task.spawn(function()
    while task.wait(0.69) do
        if C.SellBrainrot or C.SellPlant then
            Safe(function()
                local remotes = RS:FindFirstChild("Remotes")
                if remotes and remotes:FindFirstChild("ItemSell") then
                    remotes.ItemSell:FireServer()
                end
            end)
        end
    end
end)

-- Auto Farm Loop
task.spawn(function()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    local bat, queue, attacking = nil, {}, false
    
    local function GetBat()
        for _, b in ipairs(Data.Bats) do
            local t = player.Backpack:FindFirstChild(b) or char:FindFirstChild(b)
            if t then return t end
        end
    end
    
    local function EquipBat()
        for _, b in ipairs(Data.Bats) do if char:FindFirstChild(b) then bat = char:FindFirstChild(b) return true end end
        local t = GetBat() if t then Safe(function() hum:EquipTool(t) bat = t end) return true end return false
    end
    
    task.spawn(function()
        local atk = GetRemote("AttacksServer"):WaitForChild("WeaponAttack")
        while task.wait(0.01) do
            if #queue > 0 and not attacking and C.AutoFarm then
                attacking = true
                Safe(function()
                    local b = bat or GetBat()
                    if b and b.Parent == char then b:Activate() end
                    atk:FireServer({table.remove(queue, 1)})
                end)
                attacking = false
            elseif not C.AutoFarm then queue = {} end
        end
    end)
    
    task.spawn(function()
        while task.wait(0.5) do
            if C.AutoFarm then
                local hasTarget = false
                for _, b in ipairs(WS:WaitForChild("ScriptedMap"):WaitForChild("Brainrots"):GetChildren()) do
                    if b:IsA("Model") and table.find(C.SelectedRarities, b:GetAttribute("Rarity")) then hasTarget = true break end
                end
                if hasTarget then EquipBat() else if bat and bat.Parent == char then Safe(function() hum:UnequipTools() bat = nil end) end end
            end
        end
    end)
    
    local plot
    for _, p in ipairs(WS:WaitForChild("Plots"):GetChildren()) do
        if p:GetAttribute("Owner") == player.Name then plot = p break end
    end
    if not plot then return end
    
    local roads = {}
    if plot:FindFirstChild("Other") then
        for _, t in ipairs(plot.Other:GetChildren()) do
            local r = t:FindFirstChild("Road")
            if r then for _, p in ipairs(r:GetDescendants()) do if p:IsA("BasePart") then table.insert(roads, p) end end end
        end
    end
    
    local nc
    local function Noclip(e)
        if e then nc = RunService.Stepped:Connect(function() if char then for _, v in pairs(char:GetDescendants()) do if v:IsA("BasePart") and v.CanCollide and v.Name ~= "HumanoidRootPart" then v.CanCollide = false end end end end)
        else if nc then nc:Disconnect() nc = nil end end
    end
    
    local function FindGrenade()
        for _, c in ipairs({char, player.Backpack}) do
            for _, i in ipairs(c:GetChildren()) do if i:IsA("Tool") and i.Name:match("Frost Grenade") then return i end end
        end
    end
    
    local function FireGrenade(b)
        if not b or not b.Parent then return end
        if (b:GetAttribute("Progress") or 0) > 0.6 then
            local t = FindGrenade()
            if t then
                local bp = b.PrimaryPart or b:FindFirstChildWhichIsA("BasePart")
                if bp then hum:EquipTool(t) GetRemote("UseItem"):FireServer({{Toggle = true, Tool = t, Time = 0.5, Pos = bp.Position}}) end
            end
        end
    end
    
    local bFolder = WS:WaitForChild("ScriptedMap"):WaitForChild("Brainrots")
    local function FindTarget()
        for _, b in ipairs(bFolder:GetChildren()) do
            if b:IsA("Model") and table.find(C.SelectedRarities, b:GetAttribute("Rarity")) then
                local p = b.PrimaryPart or b:FindFirstChildWhichIsA("BasePart")
                if p then for _, r in ipairs(roads) do if (p.Position - r.Position).Magnitude <= 20 then return b end end end
            end
        end
    end
    
    while true do
        if C.AutoFarm then
            local t = FindTarget()
            if t then
                local tp = t.PrimaryPart or t:FindFirstChildWhichIsA("BasePart")
                if tp then
                    Noclip(true)
                    hrp.CFrame = CFrame.new(tp.Position)
                    local bp = Instance.new("BodyPosition")
                    bp.MaxForce = Vector3.new(1e5, 1e5, 1e5) bp.P = 5000 bp.D = 100 bp.Position = hrp.Position bp.Parent = hrp
                    local lf = 0
                    while t.Parent and C.AutoFarm do
                        bp.Position = tp.Position
                        if (t:GetAttribute("Progress") or 0) > 0.6 then local g = FindGrenade() if g then hum:EquipTool(g) end end
                        local n = tick()
                        if n - lf >= 2 then FireGrenade(t) lf = n end
                        if t.Name then for i = 1, 3 do table.insert(queue, t.Name) end end
                        task.wait(0.0001)
                    end
                    hum:UnequipTools() bp:Destroy() Noclip(false)
                end
            else task.wait(1) end
        else task.wait(1) end
    end
end)

-- Auto Money Loop
task.spawn(function()
    while task.wait(C.AutoMoney and 10 or 1) do
        if C.AutoMoney then Safe(function() GetRemote("EquipBestBrainrots"):FireServer() end) end
    end
end)

-- Auto Collect Loop
task.spawn(function()
    while task.wait(C.AutoCollectEnabled and C.AutoCollectDelay or 1) do
        if C.AutoCollectEnabled then
            Safe(function()
                local bn = GetBridge()
                if bn and bn:FindFirstChild("dataRemoteEvent") then
                    bn.dataRemoteEvent:FireServer({{[2] = "\004"}})
                end
            end)
        end
    end
end)

Notify("Lowet Hub V1.0 loaded!")
