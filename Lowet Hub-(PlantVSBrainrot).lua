local W=loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local P,R,p=game:GetService("Players"),game:GetService("ReplicatedStorage"),game:GetService("Players").LocalPlayer
local c,h,r,rm=p.Character or p.CharacterAdded:Wait(),nil,nil,R:WaitForChild("Remotes")

local win=W:CreateWindow({Title="Lowet Hub",Icon="zap",Author="Lowet",Folder="LowetHub",Size=UDim2.fromOffset(340,360),Theme="Dark"})
win:Tag({Title="v1.0.0",Color=Color3.fromHex("#30ff6a")})

local function N(t,d)W:Notify({Title=t or"Lowet Hub",Content=d or"",Icon="zap",Duration=3})end
local function sC(ch)c,h,r=ch,ch:WaitForChild("Humanoid"),ch:WaitForChild("HumanoidRootPart")end
sC(c)p.CharacterAdded:Connect(sC)

local cfg={AR=500,APB=10,BD=.001,TPO=CFrame.new(0,-.15,-1.15),TPV=Vector3.zero}
local aT,bT,shT=win:Tab({Title="Automation",Icon="zap"}),win:Tab({Title="Inventory",Icon="package"}),win:Tab({Title="Shop",Icon="shopping-cart"})

local rT={"Rare","Epic","Legendary","Mythic","Godly","Secret","Limited"}
local nT={"None","Orcalero Orcala","Ospedale","Pipi Kiwi","Pot Hotspot","Rhino Toasterino","Secret Lucky Egg","Squalo Cavallo","Matteo","Mattone Rotto","Meme Lucky Egg","Noobini Bananini","Noobini Cactusini","Orangutini Ananassini","Orangutini Strawberrini","La Tomatoro","Las Tralaleritas","Lirili Larila","Los Mr Carrotitos","Los Sekolitos","Los Tralaleritos","Madung","Gangster Footera","Garamararam","Gattolini Owlini","Giraffa Celeste","Godly Lucky Egg","Hotspotini Burrito","Kiwissimo","Dragon Cannelloni","Dragonfrutina Dolphinita","Eggplantini Burbalonini","Elefanto Cocofanto","Espresso Signora","Fluri Flura","Frigo Camelo","Brri Brri Bicus Dicus Bombicus","Burbaloni Lulliloli","Cappuccino Assasino","Carnivourita Tralalerita","Chef Crabacadabra","Cocotanko Giraffanto","Crazylone Pizaione","Bombardilo Watermelondrilo","Bombardiro Crocodilo","Bombini Gussini","Boneca Ambalabu","Bredda Ratto","Brr Brr Patapim","Brr Brr Sunflowerim","Arminini Bodybuilderini","Baby Peperoncini And Marmellata","Ballerina Cappuccina","Bambini Crostini","Bananita Dolphinita","Bandito Bobrito","Blueberrinni Octopussini","Agarrini La Palini","Alessio","Svinino Bombondino","Svinino Pumpkinono","Tim Cheese","Tralalero Tralala","Trippi Troppi","Trulimero Trulicina","Wardenelli Brickatoni"}
local bRS,bNS,rP={},{},{Limited=10,Secret=9,Godly=8,Mythic=6,Legendary=4,Epic=2,Rare=1}

local aS=aT:Section({Title="Auto Attack",Icon="swords"})
aS:Dropdown({Title="Brainrot Name",Values=nT,Multi=true,Value={},Callback=function(o)bNS=o end})
aS:Dropdown({Title="Brainrot Rarity",Values=rT,Multi=true,Value={},Callback=function(o)bRS=o end})
aS:Toggle({Title="Only Boss",Value=false,Callback=function(s)getgenv().AABOb=s end})
aS:Toggle({Title="Auto Attack",Value=false,Callback=function(s)getgenv().AAB=s end})

local eS=aT:Section({Title="Auto Event",Icon="calendar"})
eS:Toggle({Title="Auto Give Wanted",Value=false,Callback=function(s)getgenv().AGW=s end})
eS:Toggle({Title="Auto Restart Event",Value=false,Callback=function(s)getgenv().ARE=s end})

local cS=aT:Section({Title="Auto Collect",Icon="coins"})
local cD=0
cS:Input({Title="Delay (sec)",Value="0",Callback=function(v)cD=math.max(2,tonumber(v)or 2)end})
cS:Toggle({Title="Auto Collect Money",Value=false,Callback=function(s)getgenv().ACM=s end})

local tS=aT:Section({Title="Auto Tools",Icon="tool"})
local tI={["None"]={t=0,m="single"},["Frost Grenade"]={t=.5,m="single"},["Banana Gun"]={t=.27,m="single"},["Frost Blower"]={t=.3,m="toggle"},["Carrot Launcher"]={t=.33,m="single"}}
local tN,tSel={},{}
for n in pairs(tI)do table.insert(tN,n)end
tS:Dropdown({Title="Choose Tools",Values=tN,Multi=true,Value={},Callback=function(o)tSel=o end})
tS:Toggle({Title="Auto Use Tool",Value=false,Callback=function(s)getgenv().AUT=s end})

local brS=bT:Section({Title="Auto Brainrot",Icon="brain"})
local eqD=0
brS:Input({Title="Delay (sec)",Value="0",Callback=function(v)eqD=math.max(2,tonumber(v)or 2)end})
brS:Toggle({Title="Auto Equip Best",Value=false,Callback=function(s)getgenv().AEB=s end})

local sS=bT:Section({Title="Auto Sell",Icon="dollar-sign"})
local sD=0
sS:Input({Title="Delay (sec)",Value="0",Callback=function(v)sD=tonumber(v)or 0 end})
sS:Toggle({Title="Sell When Full",Value=false,Callback=function(s)getgenv().ASIF=s end})
sS:Button({Title="Sell Held",Icon="hand",Callback=function()rm.ItemSell:FireServer(true)end})
sS:Button({Title="Sell All",Icon="trash-2",Callback=function()rm.ItemSell:FireServer()end})
sS:Toggle({Title="Auto Sell",Value=false,Callback=function(s)getgenv().AS=s end})

local egS=bT:Section({Title="Auto Open Egg",Icon="egg"})
local egT={"None","Godly Lucky Egg","Secret Lucky Egg","Meme Lucky Egg"}
local egSel=nil
egS:Dropdown({Title="Choose Egg",Values=egT,Value=nil,Callback=function(o)egSel=o end})
egS:Toggle({Title="Auto Open Egg",Value=false,Callback=function(s)getgenv().AOE=s end})

local sdS=shT:Section({Title="Buy Seeds",Icon="sprout"})
local sdT={"None","Cactus Seed","Strawberry Seed","Pumpkin Seed","Sunflower Seed","Dragon Fruit Seed","Eggplant Seed","Watermelon Seed","Grape Seed","Cocotank Seed","Carnivorous Plant Seed","Mr Carrot Seed","Tomatrio Seed","Shroombino Seed","Mango Seed"}
local sdSel={}
sdS:Dropdown({Title="Choose Seeds",Values=sdT,Multi=true,Value={},Callback=function(o)sdSel=o end})
sdS:Toggle({Title="Auto Buy Selected",Value=false,Callback=function(s)getgenv().ABSS=s end})
sdS:Toggle({Title="Auto Buy All",Value=false,Callback=function(s)getgenv().ABAS=s end})
sdS:Toggle({Title="Auto Buy Best",Value=false,Callback=function(s)getgenv().ABBS=s end})

local gS=shT:Section({Title="Buy Gear",Icon="wrench"})
local gT={"None","Water Bucket","Frost Grenade","Banana Gun","Frost Blower","Carrot Launcher"}
local gSel={}
gS:Dropdown({Title="Choose Gear",Values=gT,Multi=true,Value={},Callback=function(o)gSel=o end})
gS:Toggle({Title="Auto Buy Selected",Value=false,Callback=function(s)getgenv().ABGS=s end})
gS:Toggle({Title="Auto Buy All",Value=false,Callback=function(s)getgenv().ABAG=s end})
gS:Toggle({Title="Auto Buy Best",Value=false,Callback=function(s)getgenv().ABBG=s end})

local txT=win:Tab({Title="Textures",Icon="image"})
local function cT()local ct=0 for _,o in ipairs(workspace:GetDescendants())do if(o:IsA("Texture")or o:IsA("Decal"))and not o:IsDescendantOf(P)and not o:IsDescendantOf(game:GetService("CoreGui"))then o:Destroy()ct+=1 end end return ct end
txT:Paragraph({Title="Texture Cleaner",Desc="Boost performance",Image="layers",ImageSize=22,Color="Grey",Buttons={{Title="🧹 Clean",Icon="trash-2",Variant="Secondary",Callback=function()N("Cleaner",("Removed %d"):format(cT()))end}}})
txT:Toggle({Title="Auto Remove",Value=false,Callback=function(s)getgenv().ART=s if s then task.spawn(function()while getgenv().ART do local ct=cT()if ct>0 then N("Cleaner",("Removed %d"):format(ct))end task.wait(10)end end)end end})

local function sF(rm,...)if not rm then return false end local ok=pcall(function()rm:FireServer(...)end)return ok end
local function gCh()return p and p.Character end
local function gBP()return p and p:FindFirstChild("Backpack")end
local function gPP()local pts=workspace:FindFirstChild("Plots")if not pts then return nil end for i=1,6 do local pt=pts:FindFirstChild(tostring(i))if pt and pt:GetAttribute("Owner")==p.Name then return i,pt end end end
local function aBR(br)if not br or not br.Parent then return false end local st=br:FindFirstChild("Stats")local hl=st and st:FindFirstChild("Health")local fl=hl and hl:FindFirstChild("Filler")return fl and fl:IsA("Frame")and fl.Size.X.Scale>.01 end
local function bRV(br)if not br then return 0 end local st=br:FindFirstChild("Stats")local rf=st and st:FindFirstChild("Rarity")if not rf then return 0 end for k,v in pairs(rP)do if rf:FindFirstChild(k)then return v end end return 0 end
local function bN(br)if not br then return nil end local st=br:FindFirstChild("Stats")if not st then return nil end local tt=st:FindFirstChild("Title")local tx if tt then if tt:IsA("TextLabel")or tt:IsA("TextButton")then tx=tt.Text end if tt:IsA("StringValue")then tx=tt.Value end end if not tx or tx==""then return nil end for _,n in pairs(nT)do if tx==n then return n end end return tx end
local rBT={"Aluminum Bat","Iron Core Bat","Iron Plate Bat","Leather Grip Bat","Basic Bat"}
local cBT=nil
local function eBB()local ch=gCh()if not ch then return false end local bp=gBP()local hm=ch:FindFirstChildOfClass("Humanoid")if not hm or hm.Health<=0 then return false end for _,n in ipairs(rBT)do local t=ch:FindFirstChild(n)if t and t:IsA("Tool")then cBT=t return true end end if bp then for _,n in ipairs(rBT)do local t=bp:FindFirstChild(n)if t and t:IsA("Tool")then hm:EquipTool(t)cBT=t return true end end end return false end
local function cSl(tb)if type(tb)~="table"then return{}end if tb["None"]then return{}end for i,v in ipairs(tb)do if v=="None"then return{}end end local out={}for k,v in pairs(tb)do if v~=nil and v~="None"then out[k]=v end end return out end
local function fBT()local mp=workspace:FindFirstChild("ScriptedMap")local bF=mp and mp:FindFirstChild("Brainrots")if not bF then return nil,nil end local pN=gPP()if not pN then return nil,nil end bNS,bRS=cSl(bNS),cSl(bRS)local nF,rF=bNS or{},bRS or{}local cnd={bosses={},byName={},byRarity={},normal={}}local function ph(tb,md,ra,nm)tb[#tb+1]={model=md,rarity=ra,name=nm}end for _,m in ipairs(bF:GetChildren())do if not m:IsA("Model")then continue end if m:GetAttribute("Plot")~=pN then continue end if not aBR(m)then continue end local nm=bN(m)or"Unknown"local ra=bRV(m)or 0 local iB=m:GetAttribute("Boss")==true if iB then ph(cnd.bosses,m,ra,nm)continue end if next(nF)and nF[nm]then ph(cnd.byName,m,ra,nm)continue end if next(rF)then local rf=m:FindFirstChild("Stats")and m.Stats:FindFirstChild("Rarity")if rf then for rN in pairs(rF)do if rf:FindFirstChild(rN)then ph(cnd.byRarity,m,ra,nm)goto cL end end end end ph(cnd.normal,m,ra,nm)::cL::end local function sR(ls)table.sort(ls,function(a,b)return(a.rarity or 0)>(b.rarity or 0)end)end for _,grp in pairs(cnd)do sR(grp)end if getgenv().AABOb then local bs=cnd.bosses[1]return bs and bs.model,bs and bs.name end local pO={cnd.bosses,cnd.byName,cnd.byRarity,cnd.normal}for _,grp in ipairs(pO)do if #grp>0 then return grp[1].model,grp[1].name end end return nil,nil end
local function tTM(m)if not m or not m.Parent then return false end local ch=gCh()if not ch then return false end local hr=ch:FindFirstChild("HumanoidRootPart")if not hr then return false end local tg=m:FindFirstChild("HumanoidRootPart")or m.PrimaryPart or m:FindFirstChildWhichIsA("BasePart",true)if not tg then return false end local ok=pcall(function()hr.CFrame=tg.CFrame*cfg.TPO hr.AssemblyLinearVelocity,hr.AssemblyAngularVelocity=cfg.TPV,cfg.TPV end)return ok end

spawn(function()local aD=1/math.max(1,cfg.AR)while true do if not getgenv().AAB then task.wait(.1)else if not cBT then eBB()end local tg,tn=fBT()if tg and tn and aBR(tg)then local aR=rm and rm:FindFirstChild("AttacksServer")and rm.AttacksServer:FindFirstChild("WeaponAttack")pcall(function()tTM(tg)end)for i=1,cfg.APB do if not getgenv().AAB or not aBR(tg)then break end if aR then sF(aR,{tn})end task.wait(aD)end task.wait(0)else task.wait(.05)end end end end)
spawn(function()while true do task.wait(cfg.BD)sdSel,gSel=cSl(sdSel),cSl(gSel)local bR=rm and rm:FindFirstChild("BuyItem")local bG=rm and rm:FindFirstChild("BuyGear")if getgenv().ABSS and next(sdSel or{})and bR then for s,_ in pairs(sdSel)do sF(bR,s,true)task.wait(cfg.BD)end end if getgenv().ABAS and sdT and #sdT>0 and bR then for _,s in ipairs(sdT)do sF(bR,s,true)task.wait(cfg.BD)end end if getgenv().ABBS and sdT and #sdT>0 and bR then local n=#sdT for i=math.max(1,n-3),n do sF(bR,sdT[i],true)task.wait(cfg.BD)end end if getgenv().ABGS and next(gSel or{})and bG then for g,_ in pairs(gSel)do sF(bG,g,true)task.wait(cfg.BD)end end if getgenv().ABAG and gT and #gT>0 and bG then for _,g in ipairs(gT)do sF(bG,g,true)task.wait(cfg.BD)end end if getgenv().ABBG and gT and #gT>0 and bG then local n=#gT for i=math.max(1,n-1),n do sF(bG,gT[i],true)task.wait(cfg.BD)end end end end)
spawn(function()while true do task.wait(1)if not getgenv().ARE then continue end pcall(function()local gui=p.PlayerGui and p.PlayerGui:FindFirstChild("Main")local wn=gui and gui:FindFirstChild("WantedPosterGui")local fr=wn and wn:FindFirstChild("Frame")local cp=fr and fr:FindFirstChild("Main_Complete")local rq=cp and cp:FindFirstChild("Requirements")local mL=rq and rq:FindFirstChild("Money")if mL and cp.Visible then local function pM(s)if not s or type(s)~="string"then return 0 end s=s:gsub("%$",""):gsub(",",""):upper()local m={K=1e3,M=1e6,B=1e9,T=1e12}for sf,ml in pairs(m)do if s:find(sf)then local n=tonumber(s:match("([%d%.]+)"))return n and n*ml or 0 end end return tonumber(s)or 0 end local rqd=pM(mL.Text)local cr=p.leaderstats and p.leaderstats.Money and p.leaderstats.Money.Value or 0 if cr>=rqd then local it=rm and rm:FindFirstChild("Events")and rm.Events:FindFirstChild("Prison")and rm.Events.Prison:FindFirstChild("Interact")if it then sF(it,"ResetRequest")end end end end)end end)
spawn(function()while true do task.wait(.05)if not getgenv().AGW then continue end pcall(function()local gui=p.PlayerGui and p.PlayerGui:FindFirstChild("Main")local wn=gui and gui:FindFirstChild("WantedPosterGui")local fr=wn and wn:FindFirstChild("Frame")if not fr then return end local mF=fr:FindFirstChild("Main")local cF=fr:FindFirstChild("Main_Complete")if cF and cF.Visible then return end if not mF or not mF.Visible then return end local wI=mF:FindFirstChild("WantedItem")local tt=wI and wI:FindFirstChild("WantedItem_Title")local wNm=tt and(tt.Text or tt.Value)if not wNm or wNm==""then return end local bp,ch=gBP(),gCh()if not bp or not ch then return end local hm=ch:FindFirstChildOfClass("Humanoid")if not hm then return end local tg=bp:FindFirstChild(wNm)or ch:FindFirstChild(wNm)if not tg then for _,it in ipairs(bp:GetChildren())do if it:IsA("Tool")and it:GetAttribute("ItemName")==wNm then tg=it break end end end if tg then if tg.Parent==bp then hm:EquipTool(tg)task.wait(.05)end local it=rm and rm:FindFirstChild("Events")and rm.Events:FindFirstChild("Prison")and rm.Events.Prison:FindFirstChild("Interact")if it then sF(it,"TurnIn")end task.wait(.1)end end)end end)
local bA,lU=false,{}local function gUR()return rm and rm:FindFirstChild("UseItem")end local function gTFCB(tN)local ch,bp=gCh(),gBP()if not ch or not bp then return nil end local t=ch:FindFirstChild(tN)if t and t:IsA("Tool")then return t end t=bp:FindFirstChild(tN)if t and t:IsA("Tool")then local hm=ch:FindFirstChildOfClass("Humanoid")if hm then hm:EquipTool(t)end task.wait(.05)return ch:FindFirstChild(tN)end end local function cU(tN)local inf=tI[tN]if not inf then return false end local ls=lU[tN]or 0 return(tick()-ls)>=inf.t end task.spawn(function()while task.wait(.1)do local au=getgenv().AUT local ch,hm=gCh(),nil if ch then hm=ch:FindFirstChildOfClass("Humanoid")end if not au or not ch or not hm or hm.Health<=0 then if bA then local rM=gUR()local t=ch and ch:FindFirstChild("Frost Blower")if rM and t then sF(rM,{{Tool=t,Toggle=false}})end bA=false end continue end local tg=fBT()if not(tg and aBR(tg))then continue end local ps=(tg.PrimaryPart and tg.PrimaryPart.Position)or(tg.Position)or(tg:FindFirstChildWhichIsA("BasePart")and tg:FindFirstChildWhichIsA("BasePart").Position)if not ps then continue end local rM=gUR()if not rM then continue end local uT,uI,uN for _,tN in ipairs(tSel)do if tN=="None"then continue end if not cU(tN)then continue end local tl=gTFCB(tN)if tl then uT,uI,uN=tl,tI[tN],tN break end end if not uT or not uI then continue end if uI.m=="single"then sF(rM,{{Tool=uT,Toggle=true,Pos=ps}})lU[uN]=tick()elseif uI.m=="toggle"then if not bA then sF(rM,{{Tool=uT,Toggle=true}})bA=true end end end end)
spawn(function()local oR=rm and rm:FindFirstChild("OpenEgg")while true do task.wait(.03)if not getgenv().AOE or not egSel or not oR then continue end pcall(function()local bp,ch=gBP(),gCh()if not bp or not ch then return end local eg=bp:FindFirstChild(egSel)or ch:FindFirstChild(egSel)if eg then local hm=ch:FindFirstChildOfClass("Humanoid")if hm and eg.Parent==bp then hm:EquipTool(eg)task.wait(.02)end sF(oR)end end)end end)
spawn(function()local eR=rm and rm:FindFirstChild("EquipBestBrainrots")while true do if getgenv().AEB and eR then pcall(function()sF(eR)end)task.wait(eqD or 2)else task.wait(.5)end end end)
spawn(function()local sR=rm and rm:FindFirstChild("ItemSell")while true do task.wait(math.max(.1,sD or .1))if not getgenv().AS then continue end local sS=true if getgenv().ASIF then local bp=gBP()sS=bp and #bp:GetChildren()>=150 end if sS and sR then pcall(function()sF(sR,nil)end)end end end)
spawn(function()local vs={}while true do task.wait(math.max(2,cD or 2))if not getgenv().ACM then vs={}continue end pcall(function()local pN,pt=gPP()if not pt then return end local pls=pt:FindFirstChild("Plants")if not pls then return end local ch=gCh()if not ch then return end local hr=ch:FindFirstChild("HumanoidRootPart")if not hr then return end for _,plant in ipairs(pls:GetChildren())do if not plant:IsA("Model")then continue end local br=plant:FindFirstChild("Brainrot")if not br then continue end local id=tostring((pcall(function()return br:GetDebugId()end)and br:GetDebugId())or br:GetAttribute("ID")or br:GetFullName())local platformUI=br:FindFirstChild("PlatformUI")local offline=platformUI and platformUI:FindFirstChild("Offline")if vs[id]and offline and offline.Visible==false then vs[id]=nil elseif not vs[id]then local target=br:FindFirstChild("Hitbox")or br.PrimaryPart or br:FindFirstChildWhichIsA("BasePart",true)if target then hr.CFrame=target.CFrame hr.AssemblyLinearVelocity=Vector3.zero task.wait(.15)if platformUI and offline and offline.Visible==false then vs[id]=true end end end end end)end end)
N("Lowet Hub Loaded","Welcome to Plants Vs Brainrot")