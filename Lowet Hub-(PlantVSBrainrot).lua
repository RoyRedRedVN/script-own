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
local R=game:GetService("ReplicatedStorage").Remotes
local c,h,r=P.Character or P.CharacterAdded:Wait()
h,r=c:WaitForChild("Humanoid"),c:WaitForChild("HumanoidRootPart")
P.CharacterAdded:Connect(function(ch)c,h,r=ch,ch:WaitForChild("Humanoid"),ch:WaitForChild("HumanoidRootPart")end)

local win=W:CreateWindow({
    Title="Lowet Hub",
    Icon="door-open",
    Author="by RedMod",
    Folder="LowetHub",
    Transparent=true,
    Theme="POWER",
    Resizable=true,
    User={Enabled=true,Anonymous=false,Callback=function()print("clicked")end}
})

win:EditOpenButton({
    Title="Open Hub",
    Icon="monitor",
    CornerRadius=UDim.new(0,16),
    StrokeThickness=2,
    Color=ColorSequence.new(Color3.fromRGB(255,107,53),Color3.fromRGB(255,140,66)),
    Draggable=true
})

win:Tag({Title="V1.0",Color=Color3.fromRGB(255,107,53),Radius=13})
win:Tag({Title="BETA",Color=Color3.fromRGB(255,140,66),Radius=13})

local function N(t,d)W:Notify({Title=t or"Lowet",Content=d or"",Icon="zap",Duration=3})end

local cfg={ar=500,apb=10,bd=.001,mhs=.01,tpo=CFrame.new(0,-.15,-1.15),tpv=Vector3.zero,ci=2,sm=.1,ec=1,wc=.05,eo=.03,ei=2}
local rarP={Limited=10,Secret=9,Godly=8,Mythic=6,Legendary=4,Epic=2,Rare=1}
local bNS,bRS,sS,gS,eS={},{},{},{},nil
local bat={"Aluminum Bat","Iron Core Bat","Iron Plate Bat","Leather Grip Bat","Basic Bat"}
local cB=nil

local function gP()for i=1,6 do local pl=workspace.Plots:FindFirstChild(tostring(i))if pl and pl:GetAttribute("Owner")==P.Name then return i,pl end end end
local function aB(br)if not br or not br.Parent then return false end local s=br:FindFirstChild("Stats")local hl=s and s:FindFirstChild("Health")local f=hl and hl:FindFirstChild("Filler")return f and f:IsA("Frame")and f.Size.X.Scale>cfg.mhs end
local function bRV(br)if not br then return 0 end local s=br:FindFirstChild("Stats")local rf=s and s:FindFirstChild("Rarity")if not rf then return 0 end for k,v in pairs(rarP)do if rf:FindFirstChild(k)then return v end end return 0 end
local function bN(br)if not br then return nil end local s=br:FindFirstChild("Stats")if not s then return nil end local t=s:FindFirstChild("Title")return t and(t.Text or t.Value)or nil end
local function cS(t)if type(t)~="table"then return{}end if t["None"]then return{}end for i,v in ipairs(t)do if v=="None"then return{}end end local o={}for k,v in pairs(t)do if v and v~="None"then o[k]=v end end return o end

local function fBT()
    local m=workspace:FindFirstChild("ScriptedMap")local bf=m and m:FindFirstChild("Brainrots")if not bf then return nil,nil end
    local pN=gP()if not pN then return nil,nil end
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
        if next(rF)then local rf=md:FindFirstChild("Stats")and md.Stats:FindFirstChild("Rarity")if rf then for rN in pairs(rF)do if rf:FindFirstChild(rN)then pu(cand.byR,md,ra,nm)goto c end end end end
        pu(cand.norm,md,ra,nm)
        ::c::
    end
    local function sR(l)table.sort(l,function(a,b)return(a.rarity or 0)>(b.rarity or 0)end)end
    for _,g in pairs(cand)do sR(g)end
    if getgenv().AutoAttackBrainrotOnlyBoss then local b=cand.boss[1]return b and b.model,b and b.name end
    local pO={cand.boss,cand.byN,cand.byR,cand.norm}
    for _,g in ipairs(pO)do if #g>0 then return g[1].model,g[1].name end end
    return nil,nil
end

local function tpM(m)if not m or not m.Parent then return false end if not c or not r then return false end local tg=m:FindFirstChild("HumanoidRootPart")or m.PrimaryPart or m:FindFirstChildWhichIsA("BasePart",true)if not tg then return false end pcall(function()r.CFrame=tg.CFrame*cfg.tpo r.AssemblyLinearVelocity=cfg.tpv r.AssemblyAngularVelocity=cfg.tpv end)return true end
local function eqB()if not c or not h or h.Health<=0 then return false end for _,n in ipairs(bat)do local t=c:FindFirstChild(n)if t and t:IsA("Tool")then cB=t return true end end local bp=P:FindFirstChild("Backpack")if bp then for _,n in ipairs(bat)do local t=bp:FindFirstChild(n)if t and t:IsA("Tool")then h:EquipTool(t)cB=t return true end end end return false end
local function sF(rm,...)if not rm then return false end local ok=pcall(function()rm:FireServer(...)end)return ok end

local aT=win:Tab({Title="Auto Farm",Icon="zap"})
local aS=aT:Section({Title="Auto Attack",Icon="swords"})
aS:Dropdown({Title="Brainrot Name",Values={"None","Orcalero Orcala","Ospedale","Pipi Kiwi","Pot Hotspot","Rhino Toasterino","Secret Lucky Egg","Squalo Cavallo","Matteo","Mattone Rotto","Meme Lucky Egg","Noobini Bananini","Noobini Cactusini","Orangutini Ananassini","Orangutini Strawberrini","La Tomatoro","Las Tralaleritas","Lirili Larila","Los Mr Carrotitos","Los Sekolitos","Los Tralaleritos","Madung","Gangster Footera","Garamararam","Gattolini Owlini","Giraffa Celeste","Godly Lucky Egg","Hotspotini Burrito","Kiwissimo","Dragon Cannelloni","Dragonfrutina Dolphinita","Eggplantini Burbalonini","Elefanto Cocofanto","Espresso Signora","Fluri Flura","Frigo Camelo","Brri Brri Bicus Dicus Bombicus","Burbaloni Lulliloli","Cappuccino Assasino","Carnivourita Tralalerita","Chef Crabacadabra","Cocotanko Giraffanto","Crazylone Pizaione","Bombardilo Watermelondrilo","Bombardiro Crocodilo","Bombini Gussini","Boneca Ambalabu","Bredda Ratto","Brr Brr Patapim","Brr Brr Sunflowerim","Arminini Bodybuilderini","Baby Peperoncini And Marmellata","Ballerina Cappuccina","Bambini Crostini","Bananita Dolphinita","Bandito Bobrito","Blueberrinni Octopussini","Agarrini La Palini","Alessio","Svinino Bombondino","Svinino Pumpkinono","Tim Cheese","Tralalero Tralala","Trippi Troppi","Trulimero Trulicina","Wardenelli Brickatoni"},Multi=true,Value={},Callback=function(o)bNS=o end})
aS:Dropdown({Title="Brainrot Rarity",Values={"Rare","Epic","Legendary","Mythic","Godly","Secret","Limited"},Multi=true,Value={},Callback=function(o)bRS=o end})
aS:Toggle({Title="Only Boss",Value=false,Callback=function(s)getgenv().AutoAttackBrainrotOnlyBoss=s end})
aS:Toggle({Title="Auto Attack Brainrot",Value=false,Callback=function(s)getgenv().AutoAttackBrainrot=s end})

local eS=aT:Section({Title="Event",Icon="calendar"})
eS:Toggle({Title="Auto Give Wanted",Value=false,Callback=function(s)getgenv().AutoGiveWantedBrainrot=s end})
eS:Toggle({Title="Auto Restart Event",Value=false,Callback=function(s)getgenv().AutoRestartEvent=s end})

local cS=aT:Section({Title="Collect",Icon="coins"})
local cD=0
cS:Input({Title="Delay (sec)",Value="2",Callback=function(v)cD=math.max(2,tonumber(v)or cfg.ci)end})
cS:Toggle({Title="Auto Collect Money",Value=false,Callback=function(s)getgenv().AutoCollectMoney=s end})

local bT=win:Tab({Title="Inventory",Icon="package"})
local brS=bT:Section({Title="Brainrot",Icon="brain"})
local eD=0
brS:Input({Title="Delay (sec)",Value="2",Callback=function(v)eD=math.max(2,tonumber(v)or 2)end})
brS:Toggle({Title="Auto Equip Best",Value=false,Callback=function(s)getgenv().AutoEquipBestBrainrot=s end})

local slS=bT:Section({Title="Sell",Icon="dollar-sign"})
local sD=0
slS:Input({Title="Delay (sec)",Value="0",Callback=function(v)sD=tonumber(v)or 0 end})
slS:Toggle({Title="Sell When Full",Value=false,Callback=function(s)getgenv().AllowSellInventoryFull=s end})
slS:Button({Title="Sell Held Item",Icon="hand",Callback=function()R.ItemSell:FireServer(true)end})
slS:Button({Title="Sell All Items",Icon="trash-2",Callback=function()R.ItemSell:FireServer()end})
slS:Toggle({Title="Auto Sell",Value=false,Callback=function(s)getgenv().AutoSell=s end})

local egS=bT:Section({Title="Egg",Icon="egg"})
egS:Dropdown({Title="Choose Egg",Values={"None","Godly Lucky Egg","Secret Lucky Egg","Meme Lucky Egg"},Value=nil,Callback=function(o)eS=o end})
egS:Toggle({Title="Auto Open Egg",Value=false,Callback=function(s)getgenv().AutoOpenEgg=s end})

local sT=win:Tab({Title="Shop",Icon="shopping-cart"})
local sdS=sT:Section({Title="Seeds",Icon="sprout"})
sdS:Dropdown({Title="Choose Seeds",Values={"None","Cactus Seed","Strawberry Seed","Pumpkin Seed","Sunflower Seed","Dragon Fruit Seed","Eggplant Seed","Watermelon Seed","Grape Seed","Cocotank Seed","Carnivorous Plant Seed","Mr Carrot Seed","Tomatrio Seed","Shroombino Seed","Mango Seed"},Multi=true,Value={},Callback=function(o)sS=o end})
sdS:Toggle({Title="Auto Buy Selected",Value=false,Callback=function(s)getgenv().AutoBuySeedsSelected=s end})
sdS:Toggle({Title="Auto Buy All",Value=false,Callback=function(s)getgenv().AutoBuyAllSeeds=s end})
sdS:Toggle({Title="Auto Buy Best",Value=false,Callback=function(s)getgenv().AutoBuyBestSeeds=s end})

local gS=sT:Section({Title="Gear",Icon="wrench"})
gS:Dropdown({Title="Choose Gear",Values={"None","Water Bucket","Frost Grenade","Banana Gun","Frost Blower","Carrot Launcher"},Multi=true,Value={},Callback=function(o)gS=o end})
gS:Toggle({Title="Auto Buy Selected",Value=false,Callback=function(s)getgenv().AutoBuyGearSelected=s end})
gS:Toggle({Title="Auto Buy All",Value=false,Callback=function(s)getgenv().AutoBuyAllGear=s end})
gS:Toggle({Title="Auto Buy Best",Value=false,Callback=function(s)getgenv().AutoBuyBestGear=s end})

spawn(function()local aD=1/math.max(1,cfg.ar)while true do if not getgenv().AutoAttackBrainrot then task.wait(.1)else if not cB then eqB()end local tg,tn=fBT()if tg and tn and aB(tg)then local aR=R.AttacksServer and R.AttacksServer:FindFirstChild("WeaponAttack")pcall(function()tpM(tg)end)for i=1,cfg.apb do if not getgenv().AutoAttackBrainrot or not aB(tg)then break end if aR then sF(aR,{tn})end task.wait(aD)end task.wait(0)else task.wait(.05)end end end end)

spawn(function()while true do task.wait(cfg.bd)sS,gS=cS(sS),cS(gS)local bR=R:FindFirstChild("BuyItem")local bG=R:FindFirstChild("BuyGear")if getgenv().AutoBuySeedsSelected and next(sS or{})and bR then for s,_ in pairs(sS)do sF(bR,s,true)task.wait(cfg.bd)end end if getgenv().AutoBuyGearSelected and next(gS or{})and bG then for g,_ in pairs(gS)do sF(bG,g,true)task.wait(cfg.bd)end end end end)

spawn(function()while true do task.wait(cfg.ec)if not getgenv().AutoRestartEvent then continue end pcall(function()local g=P.PlayerGui and P.PlayerGui:FindFirstChild("Main")local w=g and g:FindFirstChild("WantedPosterGui")local f=w and w:FindFirstChild("Frame")local cp=f and f:FindFirstChild("Main_Complete")local rq=cp and cp:FindFirstChild("Requirements")local mL=rq and rq:FindFirstChild("Money")if mL and cp.Visible then local req=tonumber(mL.Text:gsub("[^%d]",""))or 0 local cur=P.leaderstats and P.leaderstats.Money and P.leaderstats.Money.Value or 0 if cur>=req then local it=R.Events and R.Events.Prison and R.Events.Prison:FindFirstChild("Interact")if it then sF(it,"ResetRequest")end end end end)end end)

spawn(function()while true do task.wait(cfg.wc)if not getgenv().AutoGiveWantedBrainrot then continue end pcall(function()local g=P.PlayerGui and P.PlayerGui:FindFirstChild("Main")local w=g and g:FindFirstChild("WantedPosterGui")local f=w and w:FindFirstChild("Frame")if not f then return end local mF=f:FindFirstChild("Main")local cF=f:FindFirstChild("Main_Complete")if cF and cF.Visible then return end if not mF or not mF.Visible then return end local wI=mF:FindFirstChild("WantedItem")local t=wI and wI:FindFirstChild("WantedItem_Title")local wN=t and(t.Text or t.Value)if not wN or wN==""then return end local bp=P:FindFirstChild("Backpack")if not bp or not c or not h then return end local tg=bp:FindFirstChild(wN)or c:FindFirstChild(wN)if tg then if tg.Parent==bp then h:EquipTool(tg)task.wait(.05)end local it=R.Events and R.Events.Prison and R.Events.Prison:FindFirstChild("Interact")if it then sF(it,"TurnIn")end task.wait(.1)end end)end end)

spawn(function()while true do task.wait(cfg.eo)if not getgenv().AutoOpenEgg or not eS then continue end pcall(function()local bp=P:FindFirstChild("Backpack")if not bp or not c then return end local eg=bp:FindFirstChild(eS)or c:FindFirstChild(eS)if eg then if h and eg.Parent==bp then h:EquipTool(eg)task.wait(.02)end local oR=R:FindFirstChild("OpenEgg")if oR then sF(oR)end end end)end end)

spawn(function()local eqR=R:FindFirstChild("EquipBestBrainrots")while true do if getgenv().AutoEquipBestBrainrot and eqR then pcall(function()sF(eqR)end)task.wait(eD or cfg.ei)else task.wait(.5)end end end)

spawn(function()local slR=R:FindFirstChild("ItemSell")while true do task.wait(math.max(.1,sD or cfg.sm))if not getgenv().AutoSell then continue end local sS=true if getgenv().AllowSellInventoryFull then local bp=P:FindFirstChild("Backpack")sS=bp and #bp:GetChildren()>=150 end if sS and slR then pcall(function()sF(slR,nil)end)end end end)

spawn(function()local vis={}while true do task.wait(math.max(cfg.ci,cD or cfg.ci))if not getgenv().AutoCollectMoney then vis={}continue end pcall(function()local pN,pl=gP()if not pl then return end local pls=pl:FindFirstChild("Plants")if not pls or not c or not r then return end for _,pt in ipairs(pls:GetChildren())do if not pt:IsA("Model")then continue end local br=pt:FindFirstChild("Brainrot")if not br then continue end local id=tostring(br:GetFullName())local pUI=br:FindFirstChild("PlatformUI")local of=pUI and pUI:FindFirstChild("Offline")if vis[id]and of and of.Visible==false then vis[id]=nil elseif not vis[id]then local tg=br:FindFirstChild("Hitbox")or br.PrimaryPart or br:FindFirstChildWhichIsA("BasePart",true)if tg then r.CFrame=tg.CFrame r.AssemblyLinearVelocity=Vector3.zero task.wait(.15)if pUI and of and of.Visible==false then vis[id]=true end end end end end)end end)

N("Lowet Hub","Loaded with POWER theme! 🔥")