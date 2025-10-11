local W=loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

W:AddTheme({
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
W:SetTheme("POWER")

local P=game:GetService("Players").LocalPlayer
local Rep=game:GetService("ReplicatedStorage")
local R=Rep:WaitForChild("Remotes")

local function setupChar()
    local c=P.Character or P.CharacterAdded:Wait()
    local h=c:WaitForChild("Humanoid")
    local r=c:WaitForChild("HumanoidRootPart")
    return c,h,r
end

local c,h,r=setupChar()
P.CharacterAdded:Connect(function(ch)
    c,h,r=setupChar()
end)

local win=W:CreateWindow({
    Title="Lowet Hub",
    Icon="door-open",
    Author="by RedMod",
    Folder="LowetHub",
    Size=UDim2.fromOffset(340,360),
    Theme="POWER",
    Transparent=true,
    Resizable=true
})

win:EditOpenButton({
    Title="Open Hub",
    Icon="monitor",
    CornerRadius=UDim.new(0,16),
    StrokeThickness=2,
    Color=ColorSequence.new(Color3.fromRGB(255,107,53),Color3.fromRGB(255,140,66)),
    Draggable=true
})

win:Tag({Title="V1.0",Color=Color3.fromRGB(255,107,53)})
win:Tag({Title="BETA",Color=Color3.fromRGB(255,140,66)})

local function N(t,d)
    W:Notify({Title=t or"Lowet",Content=d or"",Icon="zap",Duration=3})
end

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
        if pl and pl:GetAttribute("Owner")==P.Name then
            return i,pl
        end
    end
    return nil
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
    for k,v in pairs(rarP)do
        if rf:FindFirstChild(k)then return v end
    end
    return 0
end

local function bN(br)
    if not br then return nil end
    local s=br:FindFirstChild("Stats")
    if not s then return nil end
    local t=s:FindFirstChild("Title")
    if not t then return nil end
    if t:IsA("TextLabel")or t:IsA("TextButton")then
        return t.Text
    elseif t:IsA("StringValue")then
        return t.Value
    end
    return nil
end

local function cS(t)
    if type(t)~="table"then return{}end
    if t["None"]then return{}end
    for i,v in ipairs(t)do
        if v=="None"then return{}end
    end
    local o={}
    for k,v in pairs(t)do
        if v and v~="None"then o[k]=v end
    end
    return o
end

local function fBT()
    local m=workspace:FindFirstChild("ScriptedMap")
    local bf=m and m:FindFirstChild("Brainrots")
    if not bf then return nil,nil end
    local pN=gP()
    if not pN then return nil,nil end
    
    bNS=cS(bNS)
    bRS=cS(bRS)
    local nF=bNS or{}
    local rF=bRS or{}
    local cand={boss={},byN={},byR={},norm={}}
    
    local function pu(tb,md,ra,nm)
        tb[#tb+1]={model=md,rarity=ra,name=nm}
    end
    
    for _,md in ipairs(bf:GetChildren())do
        if not md:IsA("Model")then continue end
        if md:GetAttribute("Plot")~=pN then continue end
        if not aB(md)then continue end
        
        local nm=bN(md)or"Unknown"
        local ra=bRV(md)or 0
        local iB=md:GetAttribute("Boss")==true
        
        if iB then
            pu(cand.boss,md,ra,nm)
            continue
        end
        
        if next(nF)and nF[nm]then
            pu(cand.byN,md,ra,nm)
            continue
        end
        
        if next(rF)then
            local rf=md:FindFirstChild("Stats")and md.Stats:FindFirstChild("Rarity")
            if rf then
                for rN in pairs(rF)do
                    if rf:FindFirstChild(rN)then
                        pu(cand.byR,md,ra,nm)
                        goto continueLoop
                    end
                end
            end
        end
        
        pu(cand.norm,md,ra,nm)
        ::continueLoop::
    end
    
    local function sR(l)
        table.sort(l,function(a,b)return(a.rarity or 0)>(b.rarity or 0)end)
    end
    for _,g in pairs(cand)do sR(g)end
    
    if getgenv().AutoAttackBrainrotOnlyBoss then
        local b=cand.boss[1]
        return b and b.model,b and b.name
    end
    
    local pO={cand.boss,cand.byN,cand.byR,cand.norm}
    for _,g in ipairs(pO)do
        if #g>0 then return g[1].model,g[1].name end
    end
    return nil,nil
end

local function tpM(m)
    if not m or not m.Parent or not c or not r then return false end
    local tg=m:FindFirstChild("HumanoidRootPart")or m.PrimaryPart or m:FindFirstChildWhichIsA("BasePart",true)
    if not tg then return false end
    local ok=pcall(function()
        r.CFrame=tg.CFrame*cfg.tpo
        r.AssemblyLinearVelocity=cfg.tpv
        r.AssemblyAngularVelocity=cfg.tpv
    end)
    return ok
end

local function eqB()
    if not c or not h or h.Health<=0 then return false end
    for _,n in ipairs(bat)do
        local t=c:FindFirstChild(n)
        if t and t:IsA("Tool")then
            cB=t
            return true
        end
    end
    local bp=P:FindFirstChild("Backpack")
    if bp then
        for _,n in ipairs(bat)do
            local t=bp:FindFirstChild(n)
            if t and t:IsA("Tool")then
                h:EquipTool(t)
                cB=t
                return true
            end
        end
    end
    return false
end

local function sF(rm,...)
    if not rm then return false end
    local ok=pcall(function()rm:FireServer(...)end)
    return ok
end

local aT=win:Tab({Title="Auto Farm",Icon="zap"})
local aS=aT:Section({Title="Auto Attack",Icon="swords"})

aS:Dropdown({
    Title="Brainrot Name",
    Values={"None","Orcalero Orcala","Ospedale","Pipi Kiwi","Pot Hotspot","Rhino Toasterino"},
    Multi=true,
    Value={},
    Callback=function(o)bNS=o end
})

aS:Dropdown({
    Title="Brainrot Rarity",
    Values={"Rare","Epic","Legendary","Mythic","Godly","Secret","Limited"},
    Multi=true,
    Value={},
    Callback=function(o)bRS=o end
})

aS:Toggle({
    Title="Only Boss",
    Value=false,
    Callback=function(s)getgenv().AutoAttackBrainrotOnlyBoss=s end
})

aS:Toggle({
    Title="Auto Attack Brainrot",
    Value=false,
    Callback=function(s)getgenv().AutoAttackBrainrot=s end
})

local eS=aT:Section({Title="Event",Icon="calendar"})
eS:Toggle({
    Title="Auto Give Wanted",
    Value=false,
    Callback=function(s)getgenv().AutoGiveWantedBrainrot=s end
})

eS:Toggle({
    Title="Auto Restart Event",
    Value=false,
    Callback=function(s)getgenv().AutoRestartEvent=s end
})

local cSec=aT:Section({Title="Collect",Icon="coins"})
local cD=2
cSec:Input({
    Title="Delay (sec)",
    Value="2",
    Callback=function(v)cD=math.max(2,tonumber(v)or cfg.ci)end
})

cSec:Toggle({
    Title="Auto Collect Money",
    Value=false,
    Callback=function(s)getgenv().AutoCollectMoney=s end
})

local bT=win:Tab({Title="Inventory",Icon="package"})
local brS=bT:Section({Title="Brainrot",Icon="brain"})
local eD=2

brS:Input({
    Title="Delay (sec)",
    Value="2",
    Callback=function(v)eD=math.max(2,tonumber(v)or 2)end
})

brS:Toggle({
    Title="Auto Equip Best",
    Value=false,
    Callback=function(s)getgenv().AutoEquipBestBrainrot=s end
})

local slS=bT:Section({Title="Sell",Icon="dollar-sign"})
local sD=0

slS:Input({
    Title="Delay (sec)",
    Value="0",
    Callback=function(v)sD=tonumber(v)or 0 end
})

slS:Toggle({
    Title="Sell When Full",
    Value=false,
    Callback=function(s)getgenv().AllowSellInventoryFull=s end
})

slS:Button({
    Title="Sell Held Item",
    Icon="hand",
    Callback=function()
        local sellRem=R:FindFirstChild("ItemSell")
        if sellRem then sF(sellRem,true)end
    end
})

slS:Button({
    Title="Sell All Items",
    Icon="trash-2",
    Callback=function()
        local sellRem=R:FindFirstChild("ItemSell")
        if sellRem then sF(sellRem)end
    end
})

slS:Toggle({
    Title="Auto Sell",
    Value=false,
    Callback=function(s)getgenv().AutoSell=s end
})

local egS=bT:Section({Title="Egg",Icon="egg"})
egS:Dropdown({
    Title="Choose Egg",
    Values={"None","Godly Lucky Egg","Secret Lucky Egg","Meme Lucky Egg"},
    Value=nil,
    Callback=function(o)eS=o end
})

egS:Toggle({
    Title="Auto Open Egg",
    Value=false,
    Callback=function(s)getgenv().AutoOpenEgg=s end
})

local sT=win:Tab({Title="Shop",Icon="shopping-cart"})
local sdS=sT:Section({Title="Seeds",Icon="sprout"})

sdS:Dropdown({
    Title="Choose Seeds",
    Values={"None","Cactus Seed","Strawberry Seed","Pumpkin Seed","Sunflower Seed","Dragon Fruit Seed"},
    Multi=true,
    Value={},
    Callback=function(o)sS=o end
})

sdS:Toggle({
    Title="Auto Buy Selected",
    Value=false,
    Callback=function(s)getgenv().AutoBuySeedsSelected=s end
})

local gSec=sT:Section({Title="Gear",Icon="wrench"})
gSec:Dropdown({
    Title="Choose Gear",
    Values={"None","Water Bucket","Frost Grenade","Banana Gun","Frost Blower","Carrot Launcher"},
    Multi=true,
    Value={},
    Callback=function(o)gS=o end
})

gSec:Toggle({
    Title="Auto Buy Selected",
    Value=false,
    Callback=function(s)getgenv().AutoBuyGearSelected=s end
})

-- Auto Attack Loop
spawn(function()
    local aD=1/math.max(1,cfg.ar)
    while true do
        if not getgenv().AutoAttackBrainrot then
            task.wait(0.1)
        else
            if not cB then eqB()end
            local tg,tn=fBT()
            if tg and tn and aB(tg)then
                local aR=R:FindFirstChild("AttacksServer")
                aR=aR and aR:FindFirstChild("WeaponAttack")
                pcall(function()tpM(tg)end)
                for i=1,cfg.apb do
                    if not getgenv().AutoAttackBrainrot or not aB(tg)then break end
                    if aR then sF(aR,{tn})end
                    task.wait(aD)
                end
                task.wait(0)
            else
                task.wait(0.05)
            end
        end
    end
end)

-- Auto Buy Loop
spawn(function()
    while true do
        task.wait(cfg.bd)
        sS=cS(sS)
        gS=cS(gS)
        local bR=R:FindFirstChild("BuyItem")
        local bG=R:FindFirstChild("BuyGear")
        
        if getgenv().AutoBuySeedsSelected and next(sS or{})and bR then
            for s,_ in pairs(sS)do
                sF(bR,s,true)
                task.wait(cfg.bd)
            end
        end
        
        if getgenv().AutoBuyGearSelected and next(gS or{})and bG then
            for g,_ in pairs(gS)do
                sF(bG,g,true)
                task.wait(cfg.bd)
            end
        end
    end
end)

-- Auto Event Restart
spawn(function()
    while true do
        task.wait(cfg.ec)
        if not getgenv().AutoRestartEvent then continue end
        pcall(function()
            local gui=P.PlayerGui and P.PlayerGui:FindFirstChild("Main")
            local wanted=gui and gui:FindFirstChild("WantedPosterGui")
            local frame=wanted and wanted:FindFirstChild("Frame")
            local complete=frame and frame:FindFirstChild("Main_Complete")
            if complete and complete.Visible then
                local interact=R:FindFirstChild("Events")
                interact=interact and interact:FindFirstChild("Prison")
                interact=interact and interact:FindFirstChild("Interact")
                if interact then sF(interact,"ResetRequest")end
            end
        end)
    end
end)

-- Auto Give Wanted
spawn(function()
    while true do
        task.wait(cfg.wc)
        if not getgenv().AutoGiveWantedBrainrot then continue end
        pcall(function()
            local gui=P.PlayerGui and P.PlayerGui:FindFirstChild("Main")
            local wanted=gui and gui:FindFirstChild("WantedPosterGui")
            local frame=wanted and wanted:FindFirstChild("Frame")
            if not frame then return end
            local mF=frame:FindFirstChild("Main")
            if not mF or not mF.Visible then return end
            local wI=mF:FindFirstChild("WantedItem")
            local t=wI and wI:FindFirstChild("WantedItem_Title")
            local wN=t and(t.Text or t.Value)
            if not wN or wN==""then return end
            local bp=P:FindFirstChild("Backpack")
            if not bp or not c or not h then return end
            local tg=bp:FindFirstChild(wN)or c:FindFirstChild(wN)
            if tg then
                if tg.Parent==bp then
                    h:EquipTool(tg)
                    task.wait(0.05)
                end
                local interact=R:FindFirstChild("Events")
                interact=interact and interact:FindFirstChild("Prison")
                interact=interact and interact:FindFirstChild("Interact")
                if interact then sF(interact,"TurnIn")end
            end
        end)
    end
end)

-- Auto Open Egg
spawn(function()
    while true do
        task.wait(cfg.eo)
        if not getgenv().AutoOpenEgg or not eS then continue end
        pcall(function()
            local bp=P:FindFirstChild("Backpack")
            if not bp or not c then return end
            local eg=bp:FindFirstChild(eS)or c:FindFirstChild(eS)
            if eg then
                if h and eg.Parent==bp then
                    h:EquipTool(eg)
                    task.wait(0.02)
                end
                local oR=R:FindFirstChild("OpenEgg")
                if oR then sF(oR)end
            end
        end)
    end
end)

-- Auto Equip Best
spawn(function()
    local eqR=R:FindFirstChild("EquipBestBrainrots")
    while true do
        if getgenv().AutoEquipBestBrainrot and eqR then
            pcall(function()sF(eqR)end)
            task.wait(eD or cfg.ei)
        else
            task.wait(0.5)
        end
    end
end)

-- Auto Sell
spawn(function()
    local slR=R:FindFirstChild("ItemSell")
    while true do
        task.wait(math.max(0.1,sD or cfg.sm))
        if not getgenv().AutoSell then continue end
        local shouldSell=true
        if getgenv().AllowSellInventoryFull then
            local bp=P:FindFirstChild("Backpack")
            shouldSell=bp and #bp:GetChildren()>=150
        end
        if shouldSell and slR then
            pcall(function()sF(slR,nil)end)
        end
    end
end)

-- Auto Collect Money
spawn(function()
    local visited={}
    while true do
        task.wait(math.max(cfg.ci,cD or cfg.ci))
        if not getgenv().AutoCollectMoney then
            visited={}
            continue
        end
        pcall(function()
            local pN,pl=gP()
            if not pl then return end
            local plants=pl:FindFirstChild("Plants")
            if not plants or not c or not r then return end
            for _,pt in ipairs(plants:GetChildren())do
                if not pt:IsA("Model")then continue end
                local br=pt:FindFirstChild("Brainrot")
                if not br then continue end
                local id=tostring(br:GetFullName())
                local pUI=br:FindFirstChild("PlatformUI")
                local offline=pUI and pUI:FindFirstChild("Offline")
                if visited[id]and offline and offline.Visible==false then
                    visited[id]=nil
                elseif not visited[id]then
                    local tg=br:FindFirstChild("Hitbox")or br.PrimaryPart or br:FindFirstChildWhichIsA("BasePart",true)
                    if tg then
                        r.CFrame=tg.CFrame
                        r.AssemblyLinearVelocity=Vector3.zero
                        task.wait(0.15)
                        if pUI and offline and offline.Visible==false then
                            visited[id]=true
                        end
                    end
                end
            end
        end)
    end
end)
