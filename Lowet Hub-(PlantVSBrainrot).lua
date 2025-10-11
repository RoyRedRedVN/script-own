local WindUI=loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:AddTheme({
    Name="POWER",
    Accent=Color3.fromRGB(255,107,53),
    Dialog=Color3.fromRGB(40,20,10),
    Outline=Color3.fromRGB(255,140,66),
    Text=Color3.fromRGB(255,255,255),
    Placeholder=Color3.fromRGB(184,184,184),
    Background=Color3.fromRGB(50,25,10),
    Button=Color3.fromRGB(255,107,53),
    Icon=Color3.fromRGB(255,165,82)
})
WindUI:SetTheme("POWER")

local P=game:GetService("Players").LocalPlayer
local Rep=game:GetService("ReplicatedStorage")
local R=Rep:WaitForChild("Remotes")

local function setupChar()
    local char=P.Character or P.CharacterAdded:Wait()
    return char,char:WaitForChild("Humanoid"),char:WaitForChild("HumanoidRootPart")
end

local c,h,r=setupChar()
P.CharacterAdded:Connect(function()c,h,r=setupChar()end)

local Window=WindUI:CreateWindow({
    Title="Lowet Hub",
    Author="by RedMod",
    Folder="LowetHub",
    NewElements=true,
    OpenButton={
        Title="Open Lowet Hub",
        Icon="door-open",
        CornerRadius=UDim.new(0,16),
        StrokeThickness=2,
        Enabled=true,
        Draggable=true,
        Color=ColorSequence.new(Color3.fromRGB(255,107,53),Color3.fromRGB(255,140,66))
    }
})

Window:Tag({Title="V1.0",Color=Color3.fromRGB(255,107,53)})
Window:Tag({Title="BETA",Color=Color3.fromRGB(255,140,66)})

local function N(t,d)WindUI:Notify({Title=t or"Lowet Hub",Content=d or"",Icon="zap",Duration=3})end

local cfg={ar=500,apb=10,bd=0.001,mhs=0.01,tpo=CFrame.new(0,-0.15,-1.15),tpv=Vector3.zero,ci=2,sm=0.1,ec=1,wc=0.05,eo=0.03,ei=2}
local rarP={Limited=10,Secret=9,Godly=8,Mythic=6,Legendary=4,Epic=2,Rare=1}
local bNS,bRS,sS,gS,eS={},{},{},{},nil
local bat={"Aluminum Bat","Iron Core Bat","Iron Plate Bat","Leather Grip Bat","Basic Bat"}
local cB=nil

local function gP()
    local plots=workspace:FindFirstChild("Plots")
    if not plots then return nil end
    for i=1,6 do
        local pl=plots:FindFirstChild(tostring(i))
        if pl and pl:GetAttribute("Owner")==P.Name then return i,pl end
    end
end

local function aB(br)
    if not br or not br.Parent then return false end
    local s=br:FindFirstChild("Stats")
    local hl=s and s:FindFirstChild("Health")
    local f=hl and hl:FindFirstChild("Filler")
    return f and f:IsA("Frame")and f.Size.X.Scale>cfg.mhs
end

local function bRV(br)
    if not br then return 0 end
    local s=br:FindFirstChild("Stats")
    local rf=s and s:FindFirstChild("Rarity")
    if not rf then return 0 end
    for k,v in pairs(rarP)do if rf:FindFirstChild(k)then return v end end
    return 0
end

local function bN(br)
    if not br then return nil end
    local s=br:FindFirstChild("Stats")
    if not s then return nil end
    local t=s:FindFirstChild("Title")
    if not t then return nil end
    if t:IsA("TextLabel")or t:IsA("TextButton")then return t.Text elseif t:IsA("StringValue")then return t.Value end
end

local function cS(t)
    if type(t)~="table"then return{}end
    if t["None"]then return{}end
    for i,v in ipairs(t)do if v=="None"then return{}end end
    local o={}
    for k,v in pairs(t)do if v and v~="None"then o[k]=v end end
    return o
end

local function fBT()
    local m=workspace:FindFirstChild("ScriptedMap")
    local bf=m and m:FindFirstChild("Brainrots")
    if not bf then return nil,nil end
    local pN=gP()
    if not pN then return nil,nil end
    bNS,bRS=cS(bNS),cS(bRS)
    local nF,rF=bNS or{},bRS or{}
    local cand={boss={},byN={},byR={},norm={}}
    local function pu(tb,md,ra,nm)tb[#tb+1]={model=md,rarity=ra,name=nm}end
    for _,md in ipairs(bf:GetChildren())do
        if not md:IsA("Model")then continue end
        if md:GetAttribute("Plot")~=pN then continue end
        if not aB(md)then continue end
        local nm=bN(md)or"Unknown"
        local ra=bRV(md)or 0
        local iB=md:GetAttribute("Boss")==true
        if iB then pu(cand.boss,md,ra,nm)continue end
        if next(nF)and nF[nm]then pu(cand.byN,md,ra,nm)continue end
        if next(rF)then
            local rf=md:FindFirstChild("Stats")and md.Stats:FindFirstChild("Rarity")
            if rf then for rN in pairs(rF)do if rf:FindFirstChild(rN)then pu(cand.byR,md,ra,nm)goto c end end end
        end
        pu(cand.norm,md,ra,nm)
        ::c::
    end
    local function sR(l)table.sort(l,function(a,b)return(a.rarity or 0)>(b.rarity or 0)end)end
    for _,g in pairs(cand)do sR(g)end
    if getgenv().AutoAttackBrainrotOnlyBoss then local b=cand.boss[1]return b and b.model,b and b.name end
    local pO={cand.boss,cand.byN,cand.byR,cand.norm}
    for _,g in ipairs(pO)do if #g>0 then return g[1].model,g[1].name end end
end

local function tpM(m)
    if not m or not m.Parent or not c or not r then return false end
    local tg=m:FindFirstChild("HumanoidRootPart")or m.PrimaryPart or m:FindFirstChildWhichIsA("BasePart",true)
    if not tg then return false end
    return pcall(function()r.CFrame=tg.CFrame*cfg.tpo r.AssemblyLinearVelocity=cfg.tpv r.AssemblyAngularVelocity=cfg.tpv end)
end

local function eqB()
    if not c or not h or h.Health<=0 then return false end
    for _,n in ipairs(bat)do local t=c:FindFirstChild(n)if t and t:IsA("Tool")then cB=t return true end end
    local bp=P:FindFirstChild("Backpack")
    if bp then for _,n in ipairs(bat)do local t=bp:FindFirstChild(n)if t and t:IsA("Tool")then h:EquipTool(t)cB=t return true end end end
end

local function sF(rm,...)if not rm then return false end return pcall(function()rm:FireServer(...)end)end

local FarmSection=Window:Section({Title="Auto Farm",Icon="zap"})
local FarmTab=FarmSection:Tab({Title="Attack Settings",Icon="swords"})

FarmTab:Dropdown({
    Flag="BrainrotName",
    Title="Brainrot Name",
    Values={"None","Orcalero Orcala","Ospedale","Pipi Kiwi","Pot Hotspot","Rhino Toasterino","Matteo"},
    Multi=true,
    Callback=function(o)bNS=o end
})

FarmTab:Dropdown({
    Flag="BrainrotRarity",
    Title="Brainrot Rarity",
    Values={"Rare","Epic","Legendary","Mythic","Godly","Secret","Limited"},
    Multi=true,
    Callback=function(o)bRS=o end
})

FarmTab:Toggle({
    Flag="OnlyBoss",
    Title="Only Boss",
    Default=false,
    Callback=function(s)getgenv().AutoAttackBrainrotOnlyBoss=s end
})

FarmTab:Toggle({
    Flag="AutoAttack",
    Title="Auto Attack Brainrot",
    Default=false,
    Callback=function(s)getgenv().AutoAttackBrainrot=s end
})

local EventTab=FarmSection:Tab({Title="Event",Icon="calendar"})

EventTab:Toggle({
    Flag="AutoGiveWanted",
    Title="Auto Give Wanted",
    Default=false,
    Callback=function(s)getgenv().AutoGiveWantedBrainrot=s end
})

EventTab:Toggle({
    Flag="AutoRestartEvent",
    Title="Auto Restart Event",
    Default=false,
    Callback=function(s)getgenv().AutoRestartEvent=s end
})

local CollectTab=FarmSection:Tab({Title="Collect",Icon="coins"})
local cD=2

CollectTab:Input({
    Flag="CollectDelay",
    Title="Delay (sec)",
    Value="2",
    Callback=function(v)cD=math.max(2,tonumber(v)or cfg.ci)end
})

CollectTab:Toggle({
    Flag="AutoCollect",
    Title="Auto Collect Money",
    Default=false,
    Callback=function(s)getgenv().AutoCollectMoney=s end
})

local InventorySection=Window:Section({Title="Inventory",Icon="package"})
local BrainrotTab=InventorySection:Tab({Title="Brainrot",Icon="brain"})
local eD=2

BrainrotTab:Input({
    Flag="EquipDelay",
    Title="Delay (sec)",
    Value="2",
    Callback=function(v)eD=math.max(2,tonumber(v)or 2)end
})

BrainrotTab:Toggle({
    Flag="AutoEquipBest",
    Title="Auto Equip Best",
    Default=false,
    Callback=function(s)getgenv().AutoEquipBestBrainrot=s end
})

local SellTab=InventorySection:Tab({Title="Sell",Icon="dollar-sign"})
local sD=0

SellTab:Input({
    Flag="SellDelay",
    Title="Delay (sec)",
    Value="0",
    Callback=function(v)sD=tonumber(v)or 0 end
})

SellTab:Toggle({
    Flag="SellWhenFull",
    Title="Sell When Full",
    Default=false,
    Callback=function(s)getgenv().AllowSellInventoryFull=s end
})

SellTab:Button({
    Title="Sell Held Item",
    Icon="hand",
    Justify="Center",
    Callback=function()local sr=R:FindFirstChild("ItemSell")if sr then sF(sr,true)end end
})

SellTab:Button({
    Title="Sell All Items",
    Icon="trash-2",
    Justify="Center",
    Callback=function()local sr=R:FindFirstChild("ItemSell")if sr then sF(sr)end end
})

SellTab:Toggle({
    Flag="AutoSell",
    Title="Auto Sell",
    Default=false,
    Callback=function(s)getgenv().AutoSell=s end
})

local EggTab=InventorySection:Tab({Title="Egg",Icon="egg"})

EggTab:Dropdown({
    Flag="EggSelect",
    Title="Choose Egg",
    Values={"None","Godly Lucky Egg","Secret Lucky Egg","Meme Lucky Egg"},
    Callback=function(o)eS=o end
})

EggTab:Toggle({
    Flag="AutoOpenEgg",
    Title="Auto Open Egg",
    Default=false,
    Callback=function(s)getgenv().AutoOpenEgg=s end
})

local ShopSection=Window:Section({Title="Shop",Icon="shopping-cart"})
local SeedTab=ShopSection:Tab({Title="Seeds",Icon="sprout"})

SeedTab:Dropdown({
    Flag="SeedSelect",
    Title="Choose Seeds",
    Values={"None","Cactus Seed","Strawberry Seed","Pumpkin Seed","Sunflower Seed","Dragon Fruit Seed"},
    Multi=true,
    Callback=function(o)sS=o end
})

SeedTab:Toggle({
    Flag="AutoBuySeeds",
    Title="Auto Buy Selected",
    Default=false,
    Callback=function(s)getgenv().AutoBuySeedsSelected=s end
})

local GearTab=ShopSection:Tab({Title="Gear",Icon="wrench"})

GearTab:Dropdown({
    Flag="GearSelect",
    Title="Choose Gear",
    Values={"None","Water Bucket","Frost Grenade","Banana Gun","Frost Blower","Carrot Launcher"},
    Multi=true,
    Callback=function(o)gS=o end
})

GearTab:Toggle({
    Flag="AutoBuyGear",
    Title="Auto Buy Selected",
    Default=false,
    Callback=function(s)getgenv().AutoBuyGearSelected=s end
})

local ConfigSection=Window:Section({Title="Config",Icon="folder"})
local ConfigTab=ConfigSection:Tab({Title="Config Manager",Icon="file-cog"})
local CM=Window.ConfigManager
local CN="default"

ConfigTab:Input({
    Title="Config Name",
    Icon="file-cog",
    Value="default",
    Callback=function(v)CN=v end
})

ConfigTab:Dropdown({
    Title="All Configs",
    Values=CM:AllConfigs(),
    Callback=function(v)CN=v end
})

ConfigTab:Button({
    Title="Save Config",
    Icon="save",
    Justify="Center",
    Callback=function()
        Window.CurrentConfig=CM:CreateConfig(CN)
        if Window.CurrentConfig:Save()then N("Config Saved","Config '"..CN.."' saved")end
    end
})

ConfigTab:Button({
    Title="Load Config",
    Icon="refresh-cw",
    Justify="Center",
    Callback=function()
        Window.CurrentConfig=CM:CreateConfig(CN)
        if Window.CurrentConfig:Load()then N("Config Loaded","Config '"..CN.."' loaded")end
    end
})

spawn(function()local aD=1/math.max(1,cfg.ar)while true do if not getgenv().AutoAttackBrainrot then task.wait(0.1)else if not cB then eqB()end local tg,tn=fBT()if tg and tn and aB(tg)then local aR=R:FindFirstChild("AttacksServer")aR=aR and aR:FindFirstChild("WeaponAttack")pcall(function()tpM(tg)end)for i=1,cfg.apb do if not getgenv().AutoAttackBrainrot or not aB(tg)then break end if aR then sF(aR,{tn})end task.wait(aD)end else task.wait(0.05)end end end end)

spawn(function()while true do task.wait(cfg.bd)sS,gS=cS(sS),cS(gS)local bR=R:FindFirstChild("BuyItem")local bG=R:FindFirstChild("BuyGear")if getgenv().AutoBuySeedsSelected and next(sS or{})and bR then for s,_ in pairs(sS)do sF(bR,s,true)task.wait(cfg.bd)end end if getgenv().AutoBuyGearSelected and next(gS or{})and bG then for g,_ in pairs(gS)do sF(bG,g,true)task.wait(cfg.bd)end end end end)

spawn(function()while true do task.wait(cfg.ec)if not getgenv().AutoRestartEvent then continue end pcall(function()local g=P.PlayerGui and P.PlayerGui:FindFirstChild("Main")local w=g and g:FindFirstChild("WantedPosterGui")local f=w and w:FindFirstChild("Frame")local cp=f and f:FindFirstChild("Main_Complete")if cp and cp.Visible then local it=R:FindFirstChild("Events")it=it and it:FindFirstChild("Prison")it=it and it:FindFirstChild("Interact")if it then sF(it,"ResetRequest")end end end)end end)

spawn(function()while true do task.wait(cfg.wc)if not getgenv().AutoGiveWantedBrainrot then continue end pcall(function()local g=P.PlayerGui and P.PlayerGui:FindFirstChild("Main")local w=g and g:FindFirstChild("WantedPosterGui")local f=w and w:FindFirstChild("Frame")if not f then return end local mF=f:FindFirstChild("Main")if not mF or not mF.Visible then return end local wI=mF:FindFirstChild("WantedItem")local t=wI and wI:FindFirstChild("WantedItem_Title")local wN=t and(t.Text or t.Value)if not wN or wN==""then return end local bp=P:FindFirstChild("Backpack")if not bp or not c or not h then return end local tg=bp:FindFirstChild(wN)or c:FindFirstChild(wN)if tg then if tg.Parent==bp then h:EquipTool(tg)task.wait(0.05)end local it=R:FindFirstChild("Events")it=it and it:FindFirstChild("Prison")it=it and it:FindFirstChild("Interact")if it then sF(it,"TurnIn")end end end)end end)

spawn(function()while true do task.wait(cfg.eo)if not getgenv().AutoOpenEgg or not eS then continue end pcall(function()local bp=P:FindFirstChild("Backpack")if not bp or not c then return end local eg=bp:FindFirstChild(eS)or c:FindFirstChild(eS)if eg then if h and eg.Parent==bp then h:EquipTool(eg)task.wait(0.02)end local oR=R:FindFirstChild("OpenEgg")if oR then sF(oR)end end end)end end)

spawn(function()local eqR=R:FindFirstChild("EquipBestBrainrots")while true do if getgenv().AutoEquipBestBrainrot and eqR then pcall(function()sF(eqR)end)task.wait(eD or cfg.ei)else task.wait(0.5)end end end)

spawn(function()local slR=R:FindFirstChild("ItemSell")while true do task.wait(math.max(0.1,sD or cfg.sm))if not getgenv().AutoSell then continue end local sS=true if getgenv().AllowSellInventoryFull then local bp=P:FindFirstChild("Backpack")sS=bp and #bp:GetChildren()>=150 end if sS and slR then pcall(function()sF(slR,nil)end)end end end)

spawn(function()local vis={}while true do task.wait(math.max(cfg.ci,cD or cfg.ci))if not getgenv().AutoCollectMoney then vis={}continue end pcall(function()local pN,pl=gP()if not pl then return end local pls=pl:FindFirstChild("Plants")if not pls or not c or not r then return end for _,pt in ipairs(pls:GetChildren())do if not pt:IsA("Model")then continue end local br=pt:FindFirstChild("Brainrot")if not br then continue end local id=tostring(br:GetFullName())local pUI=br:FindFirstChild("PlatformUI")local of=pUI and pUI:FindFirstChild("Offline")if vis[id]and of and of.Visible==false then vis[id]=nil elseif not vis[id]then local tg=br:FindFirstChild("Hitbox")or br.PrimaryPart or br:FindFirstChildWhichIsA("BasePart",true)if tg then r.CFrame=tg.CFrame r.AssemblyLinearVelocity=Vector3.zero task.wait(0.15)if pUI and of and of.Visible==false then vis[id]=true end end end end end)end end)