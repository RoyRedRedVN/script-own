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

-- ==== Caching, Utilities ====
local cache = {
    plot = {v = nil, t = 0, d = cfg.CACHE.plot},
    char = {v = nil, t = 0, d = cfg.CACHE.char},
    bp = {v = nil, t = 0, d = cfg.CACHE.bp}
}
local function getCached(k)
    local c = cache[k]
    if not c then return nil end
    if c.v and tick() - c.t < c.d then return c.v end
    return nil
end
local function updCache(k, v)
    if not cache[k] then return end
    cache[k].v = v; cache[k].t = tick()
end
local function getChar()
    local c = getCached("char")
    if c and c.Parent then return c end
    local ch = player and player.Character or nil
    if ch then updCache("char", ch) end
    return ch
end
local function getBackpack()
    local b = getCached("bp")
    if b and b.Parent then return b end
    local bp = player and player:FindFirstChild("Backpack")
    if bp then updCache("bp", bp) end
    return bp
end
local function getPlayerPlot()
    local p = getCached("plot")
    if p then return p.num, p.plot end
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil end
    for i = 1, 6 do
        local pl = plots:FindFirstChild(tostring(i))
        if pl and pl:GetAttribute("Owner") == player.Name then
            updCache("plot", {num = i, plot = pl})
            return i, pl
        end
    end
    return nil
end
local function sFire(remote, ...)
    if not remote then return false end
    local args = {...}
    local ok, err = pcall(function()
        remote:FireServer(unpack(args))
    end)
    if not ok then warn("[sFire]", err) end
    return ok
end

-- ==== Brainrot Utilities ====
local function aliveBR(br)
    if not br or not br.Parent then return false end
    local stats = br:FindFirstChild("Stats")
    local health = stats and stats:FindFirstChild("Health")
    local filler = health and health:FindFirstChild("Filler")
    return filler and filler:IsA("Frame") and filler.Size.X.Scale > cfg.MIN_HEALTH_SCALE
end
local function brRarityVal(br)
    if not br then return 0 end
    local stats = br:FindFirstChild("Stats")
    local rf = stats and stats:FindFirstChild("Rarity")
    if not rf then return 0 end
    for k,v in pairs(rarityPriority) do
        if rf:FindFirstChild(k) then return v end
    end
    local num = rf and rf:FindFirstChildWhichIsA("IntValue")
    return num and num.Value or 0
end
local function brName(br)
    if not br then return nil end
    local stats = br:FindFirstChild("Stats")
    if not stats then return nil end
    local title = stats:FindFirstChild("Title")
    local text
    if title then
        if title:IsA("TextLabel") or title:IsA("TextButton") then text = title.Text end
        if title:IsA("StringValue") then text = title.Value end
    end
    if not text or text == "" then return nil end
    for _,n in pairs(namTbl) do
        if text == n then return n end
    end
    return text
end
local function cleanSel(tbl)
    if type(tbl) ~= "table" then return {} end
    if tbl["None"] then return {} end
    for i, v in ipairs(tbl) do if v == "None" then return {} end end
    local out = {}
    for k, v in pairs(tbl) do if v and v ~= "None" then out[k] = v end end
    return out
end

-- ==== Auto Equip Bat ====
local rebats = {"Aluminum Bat","Iron Core Bat","Iron Plate Bat","Leather Grip Bat","Basic Bat"}
local curBat = nil
local function equipBestBat()
    local ch = getChar()
    if not ch then return false end
    local bp = getBackpack()
    local hum = ch:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    for _,n in ipairs(rebats) do
        local t = ch:FindFirstChild(n)
        if t and t:IsA("Tool") then curBat = t; return true end
    end
    if bp then
        for _,n in ipairs(rebats) do
            local t = bp:FindFirstChild(n)
            if t and t:IsA("Tool") then hum:EquipTool(t); curBat = t; return true end
        end
    end
    return false
end

-- ==== Target Selection ====
local function findBestTarget()
    local map = workspace:FindFirstChild("ScriptedMap")
    local brFolder = map and map:FindFirstChild("Brainrots")
    if not brFolder then return nil, nil end
    local plotNum = getPlayerPlot()
    if not plotNum then return nil, nil end
    brNamSel = cleanSel(brNamSel)
    brRarSel = cleanSel(brRarSel)
    local nameFilter = brNamSel or {}
    local rarFilter = brRarSel or {}
    local candidates = { bosses = {}, byName = {}, byRarity = {}, normal = {} }
    local function push(tab, model, rarity, name)
        tab[#tab + 1] = { model = model, rarity = rarity, name = name }
    end
    for _, m in ipairs(brFolder:GetChildren()) do
        if not m:IsA("Model") then continue end
        if m:GetAttribute("Plot") ~= plotNum then continue end
        if not aliveBR(m) then continue end
        local name = brName(m) or "Unknown"
        local rarity = brRarityVal(m) or 0
        local isBoss = m:GetAttribute("Boss") == true
        if isBoss then push(candidates.bosses, m, rarity, name); continue end
        if next(nameFilter) and nameFilter[name] then push(candidates.byName, m, rarity, name); continue end
        if next(rarFilter) then
            local rf = m:FindFirstChild("Stats") and m.Stats:FindFirstChild("Rarity")
            if rf then
                for rarName in pairs(rarFilter) do
                    if rf:FindFirstChild(rarName) then push(candidates.byRarity, m, rarity, name); goto continueLoop end
                end
            end
        end
        push(candidates.normal, m, rarity, name)
        ::continueLoop::
    end
    local function sortByRarity(list)
        table.sort(list, function(a, b) return (a.rarity or 0) > (b.rarity or 0) end)
    end
    for _, group in pairs(candidates) do sortByRarity(group) end
    if getgenv().AutoAttackBrainrotOnlyBoss then local boss = candidates.bosses[1]; return boss and boss.model, boss and boss.name end
    local priorityOrder = {candidates.bosses,candidates.byName,candidates.byRarity,candidates.normal}
    for _, group in ipairs(priorityOrder) do if #group > 0 then return group[1].model, group[1].name end end
    return nil, nil
end

-- ==== Safe Teleport ====
local function tpToModel(m)
    if not m or not m.Parent then return false end
    local ch = getChar()
    if not ch then return false end
    local hrp = ch:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    local tgt = m:FindFirstChild("HumanoidRootPart") or m.PrimaryPart or m:FindFirstChildWhichIsA("BasePart", true)
    if not tgt then return false end
    local ok,err = pcall(function()
        hrp.CFrame = tgt.CFrame * cfg.TP_OFFSET
        hrp.AssemblyLinearVelocity = cfg.TP_VEL
        hrp.AssemblyAngularVelocity = cfg.TP_VEL
    end)
    if not ok then warn("[tpToModel]", err) end
    return ok
end

-- ==== AUTO FARM BRAINROT ====
spawn(function()
    local atkDelay = 1 / math.max(1, cfg.ATTACK_RATE)
    while true do
        if not getgenv().AutoAttackBrainrot then
            task.wait(0.1)
        else
            if not curBat then equipBestBat() end
            local target, tname = findBestTarget()
            if target and tname and aliveBR(target) then
                local atkRem = remotesRoot and remotesRoot:FindFirstChild("AttacksServer") and remotesRoot.AttacksServer:FindFirstChild("WeaponAttack")
                pcall(function() tpToModel(target) end)
                for i = 1, cfg.ATTACKS_PER_BATCH do
                    if not getgenv().AutoAttackBrainrot or not aliveBR(target) then break end
                    if atkRem then sFire(atkRem, {tname}) end
                    task.wait(atkDelay)
                end
                task.wait(0)
            else
                task.wait(0.05)
            end
        end
    end
end)

-- ==== AUTO BUY ====
spawn(function()
    while true do
        task.wait(cfg.BUY_DELAY)
        seedSel = cleanSel(seedSel)
        gearSel = cleanSel(gearSel)
        local buyRem = remotesRoot and remotesRoot:FindFirstChild("BuyItem")
        local buyGearRem = remotesRoot and remotesRoot:FindFirstChild("BuyGear")
        if getgenv().AutoBuySeedsSelected and next(seedSel or {}) and buyRem then
            for s,_ in pairs(seedSel) do sFire(buyRem, s, true); task.wait(cfg.BUY_DELAY) end
        end
        if getgenv().AutoBuyAllSeeds and seedTbl and #seedTbl>0 and buyRem then
            for _,s in ipairs(seedTbl) do sFire(buyRem, s, true); task.wait(cfg.BUY_DELAY) end
        end
        if getgenv().AutoBuyBestSeeds and seedTbl and #seedTbl>0 and buyRem then
            local n = #seedTbl
            for i = math.max(1,n-3), n do sFire(buyRem, seedTbl[i], true); task.wait(cfg.BUY_DELAY) end
        end
        if getgenv().AutoBuyGearSelected and next(gearSel or {}) and buyGearRem then
            for g,_ in pairs(gearSel) do sFire(buyGearRem, g, true); task.wait(cfg.BUY_DELAY) end
        end
        if getgenv().AutoBuyAllGear and gearTbl and #gearTbl>0 and buyGearRem then
            for _,g in ipairs(gearTbl) do sFire(buyGearRem, g, true); task.wait(cfg.BUY_DELAY) end
        end
        if getgenv().AutoBuyBestGear and gearTbl and #gearTbl>0 and buyGearRem then
            local n = #gearTbl
            for i = math.max(1,n-1), n do sFire(buyGearRem, gearTbl[i], true); task.wait(cfg.BUY_DELAY) end
        end
    end
end)

-- ==== AUTO RESTART EVENT ====
spawn(function()
    while true do
        task.wait(cfg.EVENT_CHECK)
        if not getgenv().AutoRestartEvent then continue end
        pcall(function()
            local gui = player.PlayerGui and player.PlayerGui:FindFirstChild("Main")
            local wanted = gui and gui:FindFirstChild("WantedPosterGui")
            local frame = wanted and wanted:FindFirstChild("Frame")
            local complete = frame and frame:FindFirstChild("Main_Complete")
            local req = complete and complete:FindFirstChild("Requirements")
            local moneyLabel = req and req:FindFirstChild("Money")
            if moneyLabel and complete.Visible then
                local required = tonumber(moneyLabel.Text:match("%d+")) or 0
                local cur = player.leaderstats and player.leaderstats.Money and player.leaderstats.Money.Value or 0
                if cur >= required then
                    local interact = remotesRoot and remotesRoot:FindFirstChild("Events") and remotesRoot.Events:FindFirstChild("Prison") and remotesRoot.Events.Prison:FindFirstChild("Interact")
                    if interact then sFire(interact, "ResetRequest") end
                end
            end
        end)
    end
end)

-- ==== AUTO GIVE WANTED ITEM ====
spawn(function()
    while true do
        task.wait(cfg.WANTED_CHECK)
        if not getgenv().AutoGiveWantedBrainrot then continue end
        pcall(function()
            local gui = player.PlayerGui and player.PlayerGui:FindFirstChild("Main")
            local wanted = gui and gui:FindFirstChild("WantedPosterGui")
            local frame = wanted and wanted:FindFirstChild("Frame")
            if not frame then return end
            local mainFrame = frame:FindFirstChild("Main")
            local completeFrame = frame:FindFirstChild("Main_Complete")
            if completeFrame and completeFrame.Visible then return end
            if not mainFrame or not mainFrame.Visible then return end
            local wantedItem = mainFrame:FindFirstChild("WantedItem")
            local title = wantedItem and wantedItem:FindFirstChild("WantedItem_Title")
            local wantedName = title and (title.Text or title.Value)
            if not wantedName or wantedName == "" then return end
            local bp = getBackpack()
            local ch = getChar()
            if not bp or not ch then return end
            local hum = ch:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            local target = bp:FindFirstChild(wantedName) or ch:FindFirstChild(wantedName)
            if not target then
                for _,it in ipairs(bp:GetChildren()) do
                    if it:IsA("Tool") and it:GetAttribute("ItemName") == wantedName then target = it; break end
                end
            end
            if target then
                if target.Parent == bp then hum:EquipTool(target); task.wait(0.05) end
                local interact = remotesRoot and remotesRoot:FindFirstChild("Events") and remotesRoot.Events:FindFirstChild("Prison") and remotesRoot.Events.Prison:FindFirstChild("Interact")
                if interact then sFire(interact, "TurnIn") end
                task.wait(0.1)
            end
        end)
    end
end)

-- ==== AUTO TOOL ====
local blowerActive = false
local equippedTool = nil
local currentToolName = nil
local lastUse = {}
local function getUseItemRemote() return remotesRoot and remotesRoot:FindFirstChild("UseItem") end
local function getToolFromCharOrBP(toolName)
    local ch, bp = getChar(), getBackpack()
    if not ch or not bp then return nil end
    local t = ch:FindFirstChild(toolName)
    if t and t:IsA("Tool") then return t end
    t = bp:FindFirstChild(toolName)
    if t and t:IsA("Tool") then
        local hum = ch:FindFirstChildOfClass("Humanoid")
        if hum then hum:EquipTool(t) end
        task.wait(0.05)
        return ch:FindFirstChild(toolName)
    end
    return nil
end
local function canUse(toolName)
    local info = toolsInfo[toolName]
    if not info then return false end
    local last = lastUse[toolName] or 0
    return (tick() - last) >= info.time
end
task.spawn(function()
    while task.wait(0.1) do
        local auto = getgenv().AutoUseTools
        local ch, hum = getChar(), nil
        if ch then hum = ch:FindFirstChildOfClass("Humanoid") end
        if not auto or not ch or not hum or hum.Health <= 0 then
            if blowerActive then
                local rem = getUseItemRemote()
                local t = ch and ch:FindFirstChild("Frost Blower")
                if rem and t then sFire(rem, {{Tool = t, Toggle = false}}) end
                blowerActive = false
            end
            equippedTool, currentToolName = nil, nil
            continue
        end
        local target = findBestTarget()
        if not (target and aliveBR(target)) then continue end
        local pos = (target.PrimaryPart and target.PrimaryPart.Position)
            or (target.Position)
            or (target:FindFirstChildWhichIsA("BasePart") and target:FindFirstChildWhichIsA("BasePart").Position)
        if not pos then continue end
        local rem = getUseItemRemote()
        if not rem then continue end
        local usableTool, usableInfo, usableName
        for _, toolName in ipairs(toolsSel) do
            if toolName == "None" then continue end
            if not canUse(toolName) then continue end
            local tool = getToolFromCharOrBP(toolName)
            if tool then usableTool, usableInfo, usableName = tool, toolsInfo[toolName], toolName; break end
        end
        if not usableTool or not usableInfo then continue end
        currentToolName = usableName
        if usableInfo.mode == "single" then
            sFire(rem, {{Tool = usableTool, Toggle = true, Pos = pos}})
            lastUse[usableName] = tick()
        elseif usableInfo.mode == "toggle" then
            if not blowerActive then
                sFire(rem, {{Tool = usableTool, Toggle = true}})
                blowerActive = true
            end
        end
    end
end)

-- ==== AUTO OPEN EGG ====
spawn(function()
    local openRem = remotesRoot and remotesRoot:FindFirstChild("OpenEgg")
    while true do
        task.wait(cfg.EGG_OPEN)
        if not getgenv().AutoOpenEgg or not eggSel or not openRem then continue end
        pcall(function()
            local bp = getBackpack()
            local ch = getChar()
            if not bp or not ch then return end
            local egg = bp:FindFirstChild(eggSel) or ch:FindFirstChild(eggSel)
            if egg then
                local hum = ch:FindFirstChildOfClass("Humanoid")
                if hum and egg.Parent == bp then hum:EquipTool(egg); task.wait(0.02) end
                sFire(openRem)
            end
        end)
    end
end)

-- ==== AUTO EQUIP BEST BRAINROT ====
spawn(function()
    local equipRem = remotesRoot and remotesRoot:FindFirstChild("EquipBestBrainrots")
    while true do
        if getgenv().AutoEquipBestBrainrot and equipRem then
            pcall(function() sFire(equipRem) end)
            task.wait(eqDly or cfg.EQUIP_INTERVAL)
        else
            task.wait(0.5)
        end
    end
end)

-- ==== AUTO SELL ====
spawn(function()
    local sellRem = remotesRoot and remotesRoot:FindFirstChild("ItemSell")
    while true do
        task.wait(math.max(0.1, sellDly or cfg.SELL_MIN))
        if not getgenv().AutoSell then continue end
        local shouldSell = true
        if getgenv().AllowSellInventoryFull then
            local bp = getBackpack()
            shouldSell = bp and #bp:GetChildren() >= 150
        end
        if shouldSell and sellRem then pcall(function() sFire(sellRem, nil) end) end
    end
end)

-- ==== AUTO COLLECT MONEY ====
spawn(function()
    local visited = {}
    while true do
        task.wait(math.max(cfg.COLLECT_INTERVAL, colDly or cfg.COLLECT_INTERVAL))
        if not getgenv().AutoCollectMoney then visited = {}; continue end
        pcall(function()
            local plotNum, plot = getPlayerPlot()
            if not plot then return end
            local plants = plot:FindFirstChild("Plants")
            if not plants then return end
            local ch = getChar()
            if not ch then return end
            local hrp = ch:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            for _,plant in ipairs(plants:GetChildren()) do
                if not plant:IsA("Model") then goto cont2 end
                local br = plant:FindFirstChild("Brainrot")
                if not br then goto cont2 end
                local id = tostring((pcall(function() return br:GetDebugId() end) and br:GetDebugId()) or br:GetAttribute("ID") or br:GetFullName())
                local platformUI = br:FindFirstChild("PlatformUI")
                local offline = platformUI and platformUI:FindFirstChild("Offline")
                if visited[id] and offline and offline.Visible == false then
                    visited[id] = nil
                elseif not visited[id] then
                    local target = br:FindFirstChild("Hitbox") or br.PrimaryPart or br:FindFirstChildWhichIsA("BasePart", true)
                    if target then
                        hrp.CFrame = target.CFrame
                        hrp.AssemblyLinearVelocity = Vector3.zero
                        task.wait(0.15)
                        if platformUI and offline and offline.Visible == false then
                            visited[id] = true
                        end
                    end
                end
                ::cont2::
            end
        end)
    end
end)

Notify("Lowet Hub Loaded", "Welcome to Plants Vs Brainrot")