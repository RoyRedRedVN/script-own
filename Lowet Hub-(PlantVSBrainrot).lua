local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local RunService, Players, ReplicatedStorage = game:GetService("RunService"), game:GetService("Players"), game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")
local remotesRoot = ReplicatedStorage:WaitForChild("Remotes")

local function Notify(t, d, dur, ic)
    WindUI:Notify({
        Title = t or "Lowet Hub",
        Content = d or "No details provided",
        Icon = ic or "zap",
        Duration = dur or 3,
    })
end

local Win = WindUI:CreateWindow{
    Title = "Lowet Hub — Plants Vs Brainrot",
    Icon = "zap",
    Author = "Vinreach",
    Folder = "LowetHub",
    Size = UDim2.fromOffset(340, 360),
    Theme = "Dark"
}
Win:Tag{Title = "v1.0.0", Color = Color3.fromHex("#30ff6a")}

local rarTbl = {"Rare", "Epic", "Legendary", "Mythic", "Godly", "Secret", "Limited"}
local namTbl = {...} -- giữ nguyên danh sách tên brainrot như trên
local brNamSel, brRarSel, toolsSel, seedSel, gearSel, eggSel = {}, {}, {}, {}, {}, nil

-- ==== UI SETUP ====
local autoTab = Win:Tab{Title = "Automation", Icon = "zap"}
local atkSec = autoTab:Section{Title = "Auto Attack", Icon = "swords"}
atkSec:Dropdown{Title = "Choose Brainrot Name", Values = namTbl, Multi = true, Value = {}, Callback = function(opt) brNamSel = opt end}
atkSec:Dropdown{Title = "Choose Brainrot Rarity", Values = rarTbl, Multi = true, Value = {}, Callback = function(opt) brRarSel = opt end}
atkSec:Toggle{Title = "Only Boss", Value = false, Callback = function(v) getgenv().AutoAttackBrainrotOnlyBoss = v end}
atkSec:Toggle{Title = "Auto Attack Brainrot", Value = false, Callback = function(v) getgenv().AutoAttackBrainrot = v end}

local evtSec = autoTab:Section{Title = "Auto Event", Icon = "calendar"}
evtSec:Toggle{Title = "Auto Give Wanted Brainrot", Value = false, Callback = function(v) getgenv().AutoGiveWantedBrainrot = v end}
evtSec:Toggle{Title = "Auto Restart Event", Desc = "Automatically reset events when needed", Value = false, Callback = function(v) getgenv().AutoRestartEvent = v end}

local colSec = autoTab:Section{Title = "Auto Collect", Icon = "coins"}
local colDly = 0
colSec:Input{Title = "Delay Time (seconds)", Value = "0", Callback = function(v) colDly = math.max(2, tonumber(v) or 2) end}
colSec:Toggle{Title = "Auto Collect Money", Value = false, Callback = function(v) getgenv().AutoCollectMoney = v end}

local toolsSec = autoTab:Section{Title = "Auto Tools", Icon = "tool"}
local toolsInfo = {["None"]={time=0,mode="single"},["Frost Grenade"]={time=0.5,mode="single"},["Banana Gun"]={time=0.27,mode="single"},["Frost Blower"]={time=0.3,mode="toggle"},["Carrot Launcher"]={time=0.33,mode="single"}}
local toolNames = {}
for n in pairs(toolsInfo) do table.insert(toolNames, n) end
toolsSec:Dropdown{Title = "Choose Tools", Values = toolNames, Multi = true, Value = {}, Callback = function(opt) toolsSel = opt end}
toolsSec:Toggle{Title = "Auto Use Tool", Value = false, Callback = function(v) getgenv().AutoUseTools = v end}

local bpTab = Win:Tab{Title = "Inventory", Icon = "package"}
local brSec = bpTab:Section{Title = "Auto Brainrot", Icon = "brain"}
local eqDly = 0
brSec:Input{Title = "Delay Time (seconds)", Value = "0", Callback = function(v) eqDly = math.max(2, tonumber(v) or 2) end}
brSec:Toggle{Title = "Auto Equip Best Brainrot", Desc = "Automatically equip best brainrot with delay", Value = false, Callback = function(v) getgenv().AutoEquipBestBrainrot = v end}

local sellSec = bpTab:Section{Title = "Auto Sell", Icon = "dollar-sign"}
local sellDly = 0
sellSec:Input{Title = "Delay Time (seconds)", Value = "0", Callback = function(v) sellDly = tonumber(v) or 0 end}
sellSec:Toggle{Title = "Sell Only When Backpack Full", Desc = "Only sell when backpack is full", Value = false, Callback = function(v) getgenv().AllowSellInventoryFull = v end}
sellSec:Divider()
sellSec:Button{Title = "Sell Held Item", Icon = "hand", Callback = function() remotesRoot.ItemSell:FireServer(true) end}
sellSec:Button{Title = "Sell All", Icon = "trash-2", Callback = function() remotesRoot.ItemSell:FireServer() end}
sellSec:Toggle{Title = "Auto Sell", Desc = "Automatically sell all items", Value = false, Callback = function(v) getgenv().AutoSell = v end}

local eggSec = bpTab:Section{Title = "Auto Open Egg", Icon = "egg"}
local eggTbl = {"None", "Godly Lucky Egg", "Secret Lucky Egg", "Meme Lucky Egg"}
eggSec:Dropdown{Title = "Choose Egg", Values = eggTbl, Value = nil, Callback = function(opt) eggSel = opt end}
eggSec:Toggle{Title = "Auto Open Egg", Desc = "Automatically open eggs if available", Value = false, Callback = function(v) getgenv().AutoOpenEgg = v end}

local shopTab = Win:Tab{Title = "Shop", Icon = "shopping-cart"}
local seedSec = shopTab:Section{Title = "Buy Seeds", Icon = "sprout"}
local seedTbl = {
    "None", "Cactus Seed", "Strawberry Seed", "Pumpkin Seed", "Sunflower Seed", "Dragon Fruit Seed",
    "Eggplant Seed", "Watermelon Seed", "Grape Seed", "Cocotank Seed", "Carnivorous Plant Seed",
    "Mr Carrot Seed", "Tomatrio Seed", "Shroombino Seed", "Mango Seed"
}
seedSec:Dropdown{Title = "Choose Seeds", Values = seedTbl, Multi = true, Value = {}, Callback = function(opt) seedSel = opt end}
seedSec:Toggle{Title = "Auto Buy Selected Seeds", Value = false, Callback = function(v) getgenv().AutoBuySeedsSelected = v end}
seedSec:Toggle{Title = "Auto Buy All Seeds", Value = false, Callback = function(v) getgenv().AutoBuyAllSeeds = v end}
seedSec:Toggle{Title = "Auto Buy Best Seeds", Value = false, Callback = function(v) getgenv().AutoBuyBestSeeds = v end}

local gearSec = shopTab:Section{Title = "Buy Gear", Icon = "wrench"}
local gearTbl = {"None", "Water Bucket", "Frost Grenade", "Banana Gun", "Frost Blower", "Carrot Launcher"}
gearSec:Dropdown{Title = "Choose Gear", Values = gearTbl, Multi = true, Value = {}, Callback = function(opt) gearSel = opt end}
gearSec:Toggle{Title = "Auto Buy Selected Gear", Value = false, Callback = function(v) getgenv().AutoBuyGearSelected = v end}
gearSec:Toggle{Title = "Auto Buy All Gear", Value = false, Callback = function(v) getgenv().AutoBuyAllGear = v end}
gearSec:Toggle{Title = "Auto Buy Best Gear", Value = false, Callback = function(v) getgenv().AutoBuyBestGear = v end}

local texTab = Win:Tab{Title = "Textures", Icon = "image"}
local function cleanTextures()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Texture") or obj:IsA("Decal") then
            if not obj:IsDescendantOf(game.Players) and not obj:IsDescendantOf(game:GetService("CoreGui")) then
                obj:Destroy()
                count += 1
            end
        end
    end
    return count
end
texTab:Paragraph{
    Title = "Map Texture Cleaner",
    Desc = "Remove unnecessary map textures to boost performance and reduce lag.",
    Image = "layers", ImageSize = 22, Color = "Grey",
    Buttons = {
        {
            Title = "🧹 Remove Textures",
            Icon = "trash-2",
            Variant = "Secondary",
            Callback = function()
                local count = cleanTextures()
                Notify("Map Texture Cleaner", ("Removed %d textures/decals."):format(count))
            end
        }
    }
}
texTab:Toggle{
    Title = "Auto Remove Textures",
    Value = false,
    Callback = function(state)
        getgenv().AutoRemoveTextures = state
        if state then
            task.spawn(function()
                while getgenv().AutoRemoveTextures do
                    local count = cleanTextures()
                    if count > 0 then
                        Notify("Map Texture Cleaner", ("Auto removed %d textures."):format(count))
                    end
                    task.wait(10)
                end
            end)
        end
    end
}

Notify("Lowet Hub Loaded", "Welcome to Plants Vs Brainrot")