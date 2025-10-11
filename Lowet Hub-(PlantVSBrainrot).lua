local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")
local remotesRoot = ReplicatedStorage:WaitForChild("Remotes")

WindUI:AddTheme({
    Name = "LOWET_ORANGE",
    Accent = Color3.fromRGB(255, 107, 53),
    Dialog = Color3.fromRGB(40, 20, 10),
    Outline = Color3.fromRGB(255, 140, 66),
    Text = Color3.fromRGB(255, 255, 255),
    Placeholder = Color3.fromRGB(184, 184, 184),
    Background = Color3.fromRGB(50, 25, 10),
    Button = Color3.fromRGB(255, 107, 53),
    Icon = Color3.fromRGB(255, 165, 82),
})
WindUI:SetTheme("LOWET_ORANGE")

local Win = WindUI:CreateWindow({
    Title = "Lowet Hub — Plants Vs Brainrot",
    Icon = "zap",
    Author = "By RedMod",
    Folder = "LowetHub",
    Size = UDim2.fromOffset(340, 360),
    Theme = "LOWET_ORANGE"
})
Win:Tag({Title = "v1.0.0", Color = Color3.fromRGB(255,107,53)})

local function Notify(t, d, dur, ic)
    WindUI:Notify({
        Title = t or "Lowet Hub",
        Content = d or "No details provided",
        Icon = ic or "zap",
        Duration = dur or 3,
    })
end

local function setupChar(c)
    char = c
    hum = c:WaitForChild("Humanoid")
    hrp = c:WaitForChild("HumanoidRootPart")
end
setupChar(player.Character)
player.CharacterAdded:Connect(setupChar)

local cfg = {
    ATTACK_RATE = 500,
    ATTACKS_PER_BATCH = 10,
    BUY_DELAY = 0.001,
    CACHE = { plot = 5, char = 1, bp = 1 },
    MIN_HEALTH_SCALE = 0.01,
    TP_OFFSET = CFrame.new(0, -0.15, -1.15),
    TP_VEL = Vector3.zero,
    COLLECT_INTERVAL = 2,
    SELL_MIN = 0.1,
    EVENT_CHECK = 1,
    WANTED_CHECK = 0.05,
    EGG_OPEN = 0.03,
    EQUIP_INTERVAL = 2
}

-- UI setup (tương tự như các lần trước, giữ nguyên)

local autoTab = Win:Tab({ Title = "Automation", Icon = "zap" })
local atkSec = autoTab:Section({ Title = "Auto Attack", Icon = "swords" })

local rarTbl = {"Rare", "Epic", "Legendary", "Mythic", "Godly", "Secret", "Limited"}
local namTbl = {
    "None", "Orcalero Orcala", "Ospedale", "Pipi Kiwi", "Pot Hotspot", "Rhino Toasterino", "Secret Lucky Egg",
    "Squalo Cavallo", "Matteo", "Mattone Rotto", "Meme Lucky Egg", "Noobini Bananini", "Noobini Cactusini",
    "Orangutini Ananassini", "Orangutini Strawberrini", "La Tomatoro", "Las Tralaleritas", "Lirili Larila",
    "Los Mr Carrotitos", "Los Sekolitos", "Los Tralaleritos", "Madung", "Gangster Footera", "Garamararam",
    "Gattolini Owlini", "Giraffa Celeste", "Godly Lucky Egg", "Hotspotini Burrito", "Kiwissimo", "Dragon Cannelloni",
    "Dragonfrutina Dolphinita", "Eggplantini Burbalonini", "Elefanto Cocofanto", "Espresso Signora", "Fluri Flura",
    "Frigo Camelo", "Brri Brri Bicus Dicus Bombicus", "Burbaloni Lulliloli", "Cappuccino Assasino",
    "Carnivourita Tralalerita", "Chef Crabacadabra", "Cocotanko Giraffanto", "Crazylone Pizaione",
    "Bombardilo Watermelondrilo", "Bombardiro Crocodilo", "Bombini Gussini", "Boneca Ambalabu", "Bredda Ratto",
    "Brr Brr Patapim", "Brr Brr Sunflowerim", "Arminini Bodybuilderini", "Baby Peperoncini And Marmellata",
    "Ballerina Cappuccina", "Bambini Crostini", "Bananita Dolphinita", "Bandito Bobrito", "Blueberrinni Octopussini",
    "67", "Agarrini La Palini", "Alessio", "Svinino Bombondino", "Svinino Pumpkinino", "Tim Cheese",
    "Tralalero Tralala", "Trippi Troppi", "Trulimero Trulicina", "Wardenelli Brickatoni"
}
local brRarSel, brNamSel, toolsSel, seedSel, gearSel, eggSel = {}, {}, {}, {}, {}, nil
local rarityPriority = {["Limited"]=10,["Secret"]=9,["Godly"]=8,["Mythic"]=6,["Legendary"]=4,["Epic"]=2, ["Rare"]=1}

atkSec:Dropdown({
    Title = "Choose Brainrot Name",
    Values = namTbl,
    Multi = true,
    Value = {},
    Callback = function(option) brNamSel = option end
})
atkSec:Dropdown({
    Title = "Choose Brainrot Rarity",
    Values = rarTbl,
    Multi = true,
    Value = {},
    Callback = function(option) brRarSel = option end
})
atkSec:Toggle({
    Title = "Only Boss",
    Value = false,
    Callback = function(state) getgenv().AutoAttackBrainrotOnlyBoss = state end
})
atkSec:Toggle({
    Title = "Auto Attack Brainrot",
    Value = false,
    Callback = function(state) getgenv().AutoAttackBrainrot = state end
})

local evtSec = autoTab:Section({ Title = "Auto Event", Icon = "calendar" })
evtSec:Toggle({
    Title = "Auto Give Wanted Brainrot",
    Value = false,
    Callback = function(state) getgenv().AutoGiveWantedBrainrot = state end
})
evtSec:Toggle({
    Title = "Auto Restart Event",
    Desc = "Automatically reset events when needed",
    Value = false,
    Callback = function(state) getgenv().AutoRestartEvent = state end
})

local colSec = autoTab:Section({ Title = "Auto Collect", Icon = "coins" })
local colDly = 0
colSec:Input({
    Title = "Delay Time (seconds)",
    Value = "0",
    Callback = function(value) colDly = math.max(2, tonumber(value) or cfg.COLLECT_INTERVAL) end
})
colSec:Toggle({
    Title = "Auto Collect Money",
    Value = false,
    Callback = function(state) getgenv().AutoCollectMoney = state end
})

local toolsSec = autoTab:Section({ Title = "Auto Tools", Icon = "tool" })
local toolsInfo = {
    ["None"] = {time = 0, mode = "single"},
    ["Frost Grenade"] = {time = 0.5, mode = "single"},
    ["Banana Gun"] = {time = 0.27, mode = "single"},
    ["Frost Blower"] = {time = 0.3, mode = "toggle"},
    ["Carrot Launcher"] = {time = 0.33, mode = "single"},
}
local toolNames = {}
for name in pairs(toolsInfo) do table.insert(toolNames, name) end
toolsSec:Dropdown({
    Title = "Choose Tools",
    Values = toolNames,
    Multi = true,
    Value = {},
    Callback = function(option) toolsSel = option end
})
toolsSec:Toggle({
    Title = "Auto Use Tool",
    Value = false,
    Callback = function(state) getgenv().AutoUseTools = state end
})

local bpTab = Win:Tab({ Title = "Inventory", Icon = "package" })
local brSec = bpTab:Section({ Title = "Auto Brainrot", Icon = "brain" })
local eqDly = 0
brSec:Input({
    Title = "Delay Time (seconds)",
    Value = "0",
    Callback = function(value) eqDly = math.max(2, tonumber(value) or 2) end
})
brSec:Toggle({
    Title = "Auto Equip Best Brainrot",
    Desc = "Automatically equip best brainrot with delay",
    Value = false,
    Callback = function(state) getgenv().AutoEquipBestBrainrot = state end
})

local sellSec = bpTab:Section({ Title = "Auto Sell", Icon = "dollar-sign" })
local sellDly = 0
sellSec:Input({
    Title = "Delay Time (seconds)",
    Value = "0",
    Callback = function(value) sellDly = tonumber(value) or 0 end
})
sellSec:Toggle({
    Title = "Sell Only When Backpack Full",
    Desc = "Only sell when backpack is full",
    Value = false,
    Callback = function(state) getgenv().AllowSellInventoryFull = state end
})
sellSec:Divider()
sellSec:Button({
    Title = "Sell Held Item",
    Icon = "hand",
    Callback = function() remotesRoot.ItemSell:FireServer(true) end
})
sellSec:Button({
    Title = "Sell All",
    Icon = "trash-2",
    Callback = function() remotesRoot.ItemSell:FireServer() end
})
sellSec:Toggle({
    Title = "Auto Sell",
    Desc = "Automatically sell all items",
    Value = false,
    Callback = function(state) getgenv().AutoSell = state end
})

local eggSec = bpTab:Section({ Title = "Auto Open Egg", Icon = "egg" })
local eggTbl = {"None", "Godly Lucky Egg", "Secret Lucky Egg", "Meme Lucky Egg"}
eggSec:Dropdown({
    Title = "Choose Egg",
    Values = eggTbl,
    Value = nil,
    Callback = function(option) eggSel = option end
})
eggSec:Toggle({
    Title = "Auto Open Egg",
    Desc = "Automatically open eggs if available",
    Value = false,
    Callback = function(state) getgenv().AutoOpenEgg = state end
})

local shopTab = Win:Tab({ Title = "Shop", Icon = "shopping-cart" })
local seedSec = shopTab:Section({ Title = "Buy Seeds", Icon = "sprout" })
local seedTbl = {
    "None", "Cactus Seed", "Strawberry Seed", "Pumpkin Seed", "Sunflower Seed", "Dragon Fruit Seed",
    "Eggplant Seed", "Watermelon Seed", "Grape Seed", "Cocotank Seed", "Carnivorous Plant Seed",
    "Mr Carrot Seed", "Tomatrio Seed", "Shroombino Seed", "Mango Seed"
}
seedSec:Dropdown({
    Title = "Choose Seeds",
    Values = seedTbl,
    Multi = true,
    Value = {},
    Callback = function(option) seedSel = option end
})
seedSec:Toggle({
    Title = "Auto Buy Selected Seeds",
    Value = false,
    Callback = function(state) getgenv().AutoBuySeedsSelected = state end
})
seedSec:Toggle({
    Title = "Auto Buy All Seeds",
    Value = false,
    Callback = function(state) getgenv().AutoBuyAllSeeds = state end
})
seedSec:Toggle({
    Title = "Auto Buy Best Seeds",
    Value = false,
    Callback = function(state) getgenv().AutoBuyBestSeeds = state end
})

local gearSec = shopTab:Section({ Title = "Buy Gear", Icon = "wrench" })
local gearTbl = {"None", "Water Bucket", "Frost Grenade", "Banana Gun", "Frost Blower", "Carrot Launcher"}
gearSec:Dropdown({
    Title = "Choose Gear",
    Values = gearTbl,
    Multi = true,
    Value = {},
    Callback = function(option) gearSel = option end
})
gearSec:Toggle({
    Title = "Auto Buy Selected Gear",
    Value = false,
    Callback = function(state) getgenv().AutoBuyGearSelected = state end
})
gearSec:Toggle({
    Title = "Auto Buy All Gear",
    Value = false,
    Callback = function(state) getgenv().AutoBuyAllGear = state end
})
gearSec:Toggle({
    Title = "Auto Buy Best Gear",
    Value = false,
    Callback = function(state) getgenv().AutoBuyBestGear = state end
})

local texTab = Win:Tab({ Title = "Textures", Icon = "image" })
local function NotifyCleaner(msg)
    Notify("Map Texture Cleaner", msg)
end
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
texTab:Paragraph({
    Title = "Map Texture Cleaner",
    Desc = "Remove unnecessary map textures to boost performance and reduce lag.",
    Image = "layers",
    ImageSize = 22,
    Color = "Grey",
    Buttons = {
        {
            Title = "🧹 Remove Textures",
            Icon = "trash-2",
            Variant = "Secondary",
            Callback = function()
                local count = cleanTextures()
                NotifyCleaner(("Removed %d textures/decals."):format(count))
            end
        }
    }
})
texTab:Toggle({
    Title = "Auto Remove Textures",
    Value = false,
    Callback = function(state)
        getgenv().AutoRemoveTextures = state
        if state then
            task.spawn(function()
                while getgenv().AutoRemoveTextures do
                    local count = cleanTextures()
                    if count > 0 then
                        NotifyCleaner(("Auto removed %d textures."):format(count))
                    end
                    task.wait(10)
                end
            end)
        end
    end
})



Notify("Lowet Hub Loaded", "Welcome to Plants Vs Brainrot")