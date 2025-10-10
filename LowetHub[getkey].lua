-- Lowet Hub Key System UI - Compact Premium Version
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Premium Color Palette
local Colors = {
    Primary = Color3.fromRGB(255, 87, 34),
    Secondary = Color3.fromRGB(255, 152, 0),
    Background = Color3.fromRGB(25, 25, 35),
    Surface = Color3.fromRGB(35, 35, 45),
    SurfaceLight = Color3.fromRGB(45, 45, 60),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(180, 180, 190),
    Success = Color3.fromRGB(76, 175, 80),
    Error = Color3.fromRGB(244, 67, 54),
    InputBg = Color3.fromRGB(40, 30, 25)
}

-- Create UI
local UI = Instance.new("ScreenGui")
UI.Name = "Lowet Hub"
UI.Parent = CoreGui
UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Container (Smaller Size)
local Main = Instance.new("Frame")
Main.Parent = UI
Main.BackgroundColor3 = Colors.Background
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, -175, 0.5, -190)
Main.Size = UDim2.new(0, 350, 0, 380)
Main.ClipsDescendants = true
Main.ZIndex = 2

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = Main

-- Animated Gradient Background
local GradientBg = Instance.new("Frame")
GradientBg.Parent = Main
GradientBg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GradientBg.BorderSizePixel = 0
GradientBg.Size = UDim2.new(1, 0, 1, 0)
GradientBg.ZIndex = 2

local GradientCorner = Instance.new("UICorner")
GradientCorner.CornerRadius = UDim.new(0, 16)
GradientCorner.Parent = GradientBg

local MainGradient = Instance.new("UIGradient")
MainGradient.Parent = GradientBg
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 40)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 25, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 45))
}
MainGradient.Rotation = 45

-- Glow Border Effect
local GlowBorder = Instance.new("UIStroke")
GlowBorder.Parent = Main
GlowBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
GlowBorder.Color = Colors.Primary
GlowBorder.Thickness = 2
GlowBorder.Transparency = 0.4

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Parent = Main
TopBar.BackgroundTransparency = 1
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.ZIndex = 3

-- Key System Label
local KeySystemLabel = Instance.new("TextLabel")
KeySystemLabel.Parent = TopBar
KeySystemLabel.BackgroundTransparency = 1
KeySystemLabel.Position = UDim2.new(0, 20, 0, 8)
KeySystemLabel.Size = UDim2.new(0, 150, 0, 15)
KeySystemLabel.Font = Enum.Font.Gotham
KeySystemLabel.Text = "🔐 KEY SYSTEM"
KeySystemLabel.TextColor3 = Colors.Primary
KeySystemLabel.TextSize = 11
KeySystemLabel.TextXAlignment = Enum.TextXAlignment.Left
KeySystemLabel.ZIndex = 4

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TopBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(244, 67, 54)
CloseBtn.BorderSizePixel = 0
CloseBtn.Position = UDim2.new(1, -38, 0, 10)
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Colors.Text
CloseBtn.TextSize = 14
CloseBtn.ZIndex = 4

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(Main, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(0.25)
    UI:Destroy()
end)

-- Title Section
local WelcomeText = Instance.new("TextLabel")
WelcomeText.Parent = Main
WelcomeText.BackgroundTransparency = 1
WelcomeText.Position = UDim2.new(0, 0, 0, 55)
WelcomeText.Size = UDim2.new(1, 0, 0, 18)
WelcomeText.Font = Enum.Font.Gotham
WelcomeText.Text = "Welcome to The,"
WelcomeText.TextColor3 = Colors.Text
WelcomeText.TextSize = 14
WelcomeText.ZIndex = 3

local HubTitle = Instance.new("TextLabel")
HubTitle.Parent = Main
HubTitle.BackgroundTransparency = 1
HubTitle.Position = UDim2.new(0, 0, 0, 73)
HubTitle.Size = UDim2.new(1, 0, 0, 28)
HubTitle.Font = Enum.Font.GothamBold
HubTitle.Text = "Lowet Hub"
HubTitle.TextColor3 = Colors.Primary
HubTitle.TextSize = 22
HubTitle.ZIndex = 3

-- Key Label
local KeyLabel = Instance.new("TextLabel")
KeyLabel.Parent = Main
KeyLabel.BackgroundTransparency = 1
KeyLabel.Position = UDim2.new(0, 30, 0, 115)
KeyLabel.Size = UDim2.new(0, 50, 0, 16)
KeyLabel.Font = Enum.Font.Gotham
KeyLabel.Text = "Key"
KeyLabel.TextColor3 = Colors.TextSecondary
KeyLabel.TextSize = 12
KeyLabel.TextXAlignment = Enum.TextXAlignment.Left
KeyLabel.ZIndex = 3

-- Key Input Container
local KeyInputFrame = Instance.new("Frame")
KeyInputFrame.Parent = Main
KeyInputFrame.BackgroundColor3 = Colors.InputBg
KeyInputFrame.BorderSizePixel = 0
KeyInputFrame.Position = UDim2.new(0, 25, 0, 135)
KeyInputFrame.Size = UDim2.new(0, 230, 0, 38)
KeyInputFrame.ZIndex = 3

local KeyInputCorner = Instance.new("UICorner")
KeyInputCorner.CornerRadius = UDim.new(0, 10)
KeyInputCorner.Parent = KeyInputFrame

local KeyInputStroke = Instance.new("UIStroke")
KeyInputStroke.Parent = KeyInputFrame
KeyInputStroke.Color = Colors.SurfaceLight
KeyInputStroke.Thickness = 1.5
KeyInputStroke.Transparency = 0.6

-- Key Input
local KeyInput = Instance.new("TextBox")
KeyInput.Parent = KeyInputFrame
KeyInput.BackgroundTransparency = 1
KeyInput.Position = UDim2.new(0, 12, 0, 0)
KeyInput.Size = UDim2.new(1, -24, 1, 0)
KeyInput.Font = Enum.Font.Gotham
KeyInput.PlaceholderText = "insert your key here"
KeyInput.PlaceholderColor3 = Color3.fromRGB(100, 80, 70)
KeyInput.Text = ""
KeyInput.TextColor3 = Colors.Text
KeyInput.TextSize = 13
KeyInput.TextXAlignment = Enum.TextXAlignment.Left
KeyInput.ClearTextOnFocus = false
KeyInput.ZIndex = 4

-- Paste Button
local PasteBtn = Instance.new("TextButton")
PasteBtn.Parent = Main
PasteBtn.BackgroundColor3 = Colors.Primary
PasteBtn.BorderSizePixel = 0
PasteBtn.Position = UDim2.new(0, 265, 0, 135)
PasteBtn.Size = UDim2.new(0, 60, 0, 38)
PasteBtn.Font = Enum.Font.GothamBold
PasteBtn.Text = "Paste"
PasteBtn.TextColor3 = Colors.Text
PasteBtn.TextSize = 13
PasteBtn.ZIndex = 3

local PasteCorner = Instance.new("UICorner")
PasteCorner.CornerRadius = UDim.new(0, 10)
PasteCorner.Parent = PasteBtn

-- Submit Key Button
local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Parent = Main
SubmitBtn.BackgroundColor3 = Colors.Primary
SubmitBtn.BorderSizePixel = 0
SubmitBtn.Position = UDim2.new(0, 30, 0, 185)
SubmitBtn.Size = UDim2.new(0, 360, 0, 42)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.Text = "Submit Key  ➤"
SubmitBtn.TextColor3 = Colors.Text
SubmitBtn.TextSize = 14
SubmitBtn.ZIndex = 3

local SubmitCorner = Instance.new("UICorner")
SubmitCorner.CornerRadius = UDim.new(0, 10)
SubmitCorner.Parent = SubmitBtn

local SubmitGradient = Instance.new("UIGradient")
SubmitGradient.Parent = SubmitBtn
SubmitGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Colors.Primary),
    ColorSequenceKeypoint.new(1, Colors.Secondary)
}
SubmitGradient.Rotation = 45

-- Bottom Text Section
local BuyKeyText = Instance.new("TextLabel")
BuyKeyText.Parent = Main
BuyKeyText.BackgroundTransparency = 1
BuyKeyText.Position = UDim2.new(0, 0, 0, 240)
BuyKeyText.Size = UDim2.new(1, 0, 0, 16)
BuyKeyText.Font = Enum.Font.Gotham
BuyKeyText.Text = "Need Buy Key Lifetime? "
BuyKeyText.TextColor3 = Colors.Text
BuyKeyText.TextSize = 11
BuyKeyText.ZIndex = 3

local BuyKeyLink = Instance.new("TextLabel")
BuyKeyLink.Parent = Main
BuyKeyLink.BackgroundTransparency = 1
BuyKeyLink.Position = UDim2.new(0.5, -60, 0, 240)
BuyKeyLink.Size = UDim2.new(0, 120, 0, 16)
BuyKeyLink.Font = Enum.Font.GothamBold
BuyKeyLink.Text = "Click Copy Official Store"
BuyKeyLink.TextColor3 = Colors.Primary
BuyKeyLink.TextSize = 11
BuyKeyLink.ZIndex = 3

local SupportText = Instance.new("TextLabel")
SupportText.Parent = Main
SupportText.BackgroundTransparency = 1
SupportText.Position = UDim2.new(0, 0, 0, 260)
SupportText.Size = UDim2.new(1, 0, 0, 16)
SupportText.Font = Enum.Font.Gotham
SupportText.Text = "Need support? "
SupportText.TextColor3 = Colors.Text
SupportText.TextSize = 11
SupportText.ZIndex = 3

local DiscordLink = Instance.new("TextLabel")
DiscordLink.Parent = Main
DiscordLink.BackgroundTransparency = 1
DiscordLink.Position = UDim2.new(0.5, -35, 0, 260)
DiscordLink.Size = UDim2.new(0, 70, 0, 16)
DiscordLink.Font = Enum.Font.GothamBold
DiscordLink.Text = "Join the Discord"
DiscordLink.TextColor3 = Color3.fromRGB(114, 137, 218)
DiscordLink.TextSize = 11
DiscordLink.ZIndex = 3

-- Bottom Buttons Container
local BtnContainer = Instance.new("Frame")
BtnContainer.Parent = Main
BtnContainer.BackgroundTransparency = 1
BtnContainer.Position = UDim2.new(0, 30, 1, -45)
BtnContainer.Size = UDim2.new(0, 360, 0, 32)
BtnContainer.ZIndex = 3

local BtnLayout = Instance.new("UIListLayout")
BtnLayout.Parent = BtnContainer
BtnLayout.FillDirection = Enum.FillDirection.Horizontal
BtnLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
BtnLayout.Padding = UDim.new(0, 8)

-- Create Bottom Buttons
local function CreateBottomButton(icon, text)
    local btn = Instance.new("TextButton")
    btn.Parent = BtnContainer
    btn.BackgroundColor3 = Colors.Surface
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(0, 113, 0, 32)
    btn.Font = Enum.Font.GothamBold
    btn.Text = icon .. " " .. text
    btn.TextColor3 = Colors.Text
    btn.TextSize = 11
    btn.ZIndex = 3
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    local stroke = Instance.new("UIStroke")
    stroke.Parent = btn
    stroke.Color = Colors.Primary
    stroke.Thickness = 1.5
    stroke.Transparency = 0.7
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.SurfaceLight}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.2), {Transparency = 0.3}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Surface}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.2), {Transparency = 0.7}):Play()
    end)
    
    return btn
end

local LinkvertiseBtn = CreateBottomButton("🔗", "Linkvertise")
local LootLabsBtn = CreateBottomButton("🎁", "LootLabs")
local RinkuBtn = CreateBottomButton("💎", "Rinku.pro")

-- Notification Function
local function Notify(title, text)
    game.StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = 3;
    })
end

-- Focus animation
KeyInput.Focused:Connect(function()
    TweenService:Create(KeyInputStroke, TweenInfo.new(0.2), {Color = Colors.Primary, Transparency = 0.2}):Play()
end)

KeyInput.FocusLost:Connect(function()
    TweenService:Create(KeyInputStroke, TweenInfo.new(0.2), {Color = Colors.SurfaceLight, Transparency = 0.6}):Play()
end)

-- Paste Button Function
PasteBtn.MouseButton1Click:Connect(function()
    KeyInput.Text = tostring(getclipboard and getclipboard() or "")
    Notify("Speed Hub X", "📋 Pasted from clipboard!")
end)

-- Submit Key Function
SubmitBtn.MouseButton1Click:Connect(function()
    local key = KeyInput.Text
    SubmitBtn.Text = "Verifying..."
    
    task.wait(0.8)
    
    if key == "1234" or key == "TESTKEY" or key == "67" then
        SubmitBtn.Text = "✓ Access Granted"
        SubmitBtn.BackgroundColor3 = Colors.Success
        Notify("Speed Hub X", "✓ Key verified successfully!", 3)
        
        task.wait(0.8)
        TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        task.wait(0.3)
        UI:Destroy()
        -- Load your main script here
    else
        SubmitBtn.Text = "✗ Invalid Key"
        SubmitBtn.BackgroundColor3 = Colors.Error
        Notify("LowetHub", "✗ Invalid key! Please try again.", 3)
        
        local originalPos = SubmitBtn.Position
        for i = 1, 6 do
            SubmitBtn.Position = originalPos + UDim2.new(0, math.random(-4, 4), 0, 0)
            task.wait(0.04)
        end
        SubmitBtn.Position = originalPos
        
        task.wait(1.2)
        SubmitBtn.Text = "Submit Key  ➤"
        SubmitBtn.BackgroundColor3 = Colors.Primary
        KeyInput.Text = ""
    end
end)

-- Link Buttons Functions
LinkvertiseBtn.MouseButton1Click:Connect(function()
    setclipboard("https://linkvertise.com/your-link")
    Notify("LowetHub", "🔗 Linkvertise link copied!")
end)

LootLabsBtn.MouseButton1Click:Connect(function()
    setclipboard("https://lootlabs.gg/your-link")
    Notify("LowetHub", "🎁 LootLabs link copied!")
end)

RinkuBtn.MouseButton1Click:Connect(function()
    setclipboard("https://rinku.pro/your-link")
    Notify("LowetHub", "💎 Rinku.pro link copied!")
end)

-- Hover Effects
SubmitBtn.MouseEnter:Connect(function()
    TweenService:Create(SubmitBtn, TweenInfo.new(0.2), {Size = UDim2.new(0, 368, 0, 44)}):Play()
end)

SubmitBtn.MouseLeave:Connect(function()
    TweenService:Create(SubmitBtn, TweenInfo.new(0.2), {Size = UDim2.new(0, 360, 0, 42)}):Play()
end)

PasteBtn.MouseEnter:Connect(function()
    TweenService:Create(PasteBtn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Secondary}):Play()
end)

PasteBtn.MouseLeave:Connect(function()
    TweenService:Create(PasteBtn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Primary}):Play()
end)

-- Entrance Animation
Main.Size = UDim2.new(0, 0, 0, 0)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)

TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 420, 0, 320),
    Position = UDim2.new(0.5, -210, 0.5, -160)
}):Play()

-- Draggable functionality
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)