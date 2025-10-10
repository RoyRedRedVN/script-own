-- Lowet Hub Key System UI - Ultra Premium Edition
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Premium Color Palette
local Colors = {
    Primary = Color3.fromRGB(255, 87, 34),
    Secondary = Color3.fromRGB(255, 152, 0),
    Background = Color3.fromRGB(18, 18, 25),
    Surface = Color3.fromRGB(28, 28, 38),
    SurfaceLight = Color3.fromRGB(38, 38, 50),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(180, 180, 190),
    Success = Color3.fromRGB(76, 175, 80),
    Error = Color3.fromRGB(244, 67, 54),
    Glow = Color3.fromRGB(255, 107, 53)
}

-- Create UI
local UI = Instance.new("ScreenGui")
UI.Name = "LowetHubPremium"
UI.Parent = CoreGui
UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Background Blur with Gradient
local Blur = Instance.new("Frame")
Blur.Parent = UI
Blur.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Blur.BackgroundTransparency = 0.2
Blur.BorderSizePixel = 0
Blur.Size = UDim2.new(1, 0, 1, 0)

local BlurGradient = Instance.new("UIGradient")
BlurGradient.Parent = Blur
BlurGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 15)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 10))
}
BlurGradient.Rotation = 135
BlurGradient.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0.3),
    NumberSequenceKeypoint.new(1, 0.6)
}

-- Main Container with Shadow
local Shadow = Instance.new("ImageLabel")
Shadow.Parent = UI
Shadow.BackgroundTransparency = 1
Shadow.Position = UDim2.new(0.5, -235, 0.5, -205)
Shadow.Size = UDim2.new(0, 470, 0, 410)
Shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.7
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10, 10, 10, 10)
Shadow.ZIndex = 1

-- Main Frame
local Main = Instance.new("Frame")
Main.Parent = UI
Main.BackgroundColor3 = Colors.Background
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, -225, 0.5, -195)
Main.Size = UDim2.new(0, 450, 0, 390)
Main.ClipsDescendants = true
Main.ZIndex = 2

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 20)
MainCorner.Parent = Main

-- Animated Gradient Background
local GradientBg = Instance.new("Frame")
GradientBg.Parent = Main
GradientBg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GradientBg.BorderSizePixel = 0
GradientBg.Size = UDim2.new(1, 0, 1, 0)
GradientBg.ZIndex = 2

local GradientCorner = Instance.new("UICorner")
GradientCorner.CornerRadius = UDim.new(0, 20)
GradientCorner.Parent = GradientBg

local MainGradient = Instance.new("UIGradient")
MainGradient.Parent = GradientBg
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 35)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(18, 18, 25)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 28, 38))
}
MainGradient.Rotation = 45

-- Animated gradient rotation
task.spawn(function()
    while Main and Main.Parent do
        for i = 0, 360, 1 do
            if not Main or not Main.Parent then break end
            MainGradient.Rotation = i
            task.wait(0.05)
        end
    end
end)

-- Glow Border Effect
local GlowBorder = Instance.new("UIStroke")
GlowBorder.Parent = Main
GlowBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
GlowBorder.Color = Colors.Primary
GlowBorder.Thickness = 2
GlowBorder.Transparency = 0.3

-- Animated glow effect
task.spawn(function()
    while Main and Main.Parent do
        TweenService:Create(GlowBorder, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Transparency = 0.7}):Play()
        task.wait(3)
    end
end)

-- Top Bar with Glass Effect
local TopBar = Instance.new("Frame")
TopBar.Parent = Main
TopBar.BackgroundColor3 = Colors.Surface
TopBar.BackgroundTransparency = 0.3
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 70)
TopBar.ZIndex = 3

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 20)
TopBarCorner.Parent = TopBar

-- Close Button with Icon
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TopBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(244, 67, 54)
CloseBtn.BorderSizePixel = 0
CloseBtn.Position = UDim2.new(1, -50, 0.5, -15)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Colors.Text
CloseBtn.TextSize = 16
CloseBtn.ZIndex = 4

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    TweenService:Create(Blur, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    task.wait(0.3)
    UI:Destroy()
end)

-- Logo Circle with Glow
local LogoContainer = Instance.new("Frame")
LogoContainer.Parent = Main
LogoContainer.BackgroundColor3 = Colors.Primary
LogoContainer.BorderSizePixel = 0
LogoContainer.Position = UDim2.new(0.5, -40, 0, 90)
LogoContainer.Size = UDim2.new(0, 80, 0, 80)
LogoContainer.ZIndex = 4

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(1, 0)
LogoCorner.Parent = LogoContainer

local LogoGlow = Instance.new("UIStroke")
LogoGlow.Parent = LogoContainer
LogoGlow.Color = Colors.Glow
LogoGlow.Thickness = 4
LogoGlow.Transparency = 0.5

local LogoGradient = Instance.new("UIGradient")
LogoGradient.Parent = LogoContainer
LogoGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Colors.Primary),
    ColorSequenceKeypoint.new(1, Colors.Secondary)
}
LogoGradient.Rotation = 45

local LogoText = Instance.new("TextLabel")
LogoText.Parent = LogoContainer
LogoText.BackgroundTransparency = 1
LogoText.Size = UDim2.new(1, 0, 1, 0)
LogoText.Font = Enum.Font.GothamBold
LogoText.Text = "L"
LogoText.TextColor3 = Colors.Text
LogoText.TextSize = 42
LogoText.ZIndex = 5

-- Animated logo pulse
task.spawn(function()
    while LogoContainer and LogoContainer.Parent do
        TweenService:Create(LogoContainer, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Size = UDim2.new(0, 85, 0, 85)}):Play()
        task.wait(2)
    end
end)

-- Title Section
local WelcomeText = Instance.new("TextLabel")
WelcomeText.Parent = Main
WelcomeText.BackgroundTransparency = 1
WelcomeText.Position = UDim2.new(0, 0, 0, 180)
WelcomeText.Size = UDim2.new(1, 0, 0, 20)
WelcomeText.Font = Enum.Font.Gotham
WelcomeText.Text = "WELCOME TO"
WelcomeText.TextColor3 = Colors.TextSecondary
WelcomeText.TextSize = 12
WelcomeText.TextTransparency = 0.4
WelcomeText.ZIndex = 3

local HubTitle = Instance.new("TextLabel")
HubTitle.Parent = Main
HubTitle.BackgroundTransparency = 1
HubTitle.Position = UDim2.new(0, 0, 0, 200)
HubTitle.Size = UDim2.new(1, 0, 0, 35)
HubTitle.Font = Enum.Font.GothamBold
HubTitle.Text = "LOWET HUB"
HubTitle.TextColor3 = Colors.Text
HubTitle.TextSize = 28
HubTitle.ZIndex = 3

local HubGradient = Instance.new("UIGradient")
HubGradient.Parent = HubTitle
HubGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Colors.Primary),
    ColorSequenceKeypoint.new(1, Colors.Secondary)
}
HubGradient.Rotation = 0

-- Key Input Container
local KeyInputFrame = Instance.new("Frame")
KeyInputFrame.Parent = Main
KeyInputFrame.BackgroundColor3 = Colors.Surface
KeyInputFrame.BorderSizePixel = 0
KeyInputFrame.Position = UDim2.new(0.5, -190, 0, 250)
KeyInputFrame.Size = UDim2.new(0, 380, 0, 50)
KeyInputFrame.ZIndex = 3

local KeyInputCorner = Instance.new("UICorner")
KeyInputCorner.CornerRadius = UDim.new(0, 12)
KeyInputCorner.Parent = KeyInputFrame

local KeyInputStroke = Instance.new("UIStroke")
KeyInputStroke.Parent = KeyInputFrame
KeyInputStroke.Color = Colors.SurfaceLight
KeyInputStroke.Thickness = 2
KeyInputStroke.Transparency = 0.5

-- Key Icon
local KeyIcon = Instance.new("TextLabel")
KeyIcon.Parent = KeyInputFrame
KeyIcon.BackgroundTransparency = 1
KeyIcon.Position = UDim2.new(0, 15, 0.5, -12)
KeyIcon.Size = UDim2.new(0, 24, 0, 24)
KeyIcon.Font = Enum.Font.GothamBold
KeyIcon.Text = "🔑"
KeyIcon.TextColor3 = Colors.Primary
KeyIcon.TextSize = 18
KeyIcon.ZIndex = 4

-- Key Input
local KeyInput = Instance.new("TextBox")
KeyInput.Parent = KeyInputFrame
KeyInput.BackgroundTransparency = 1
KeyInput.Position = UDim2.new(0, 50, 0, 0)
KeyInput.Size = UDim2.new(1, -60, 1, 0)
KeyInput.Font = Enum.Font.Gotham
KeyInput.PlaceholderText = "Enter your key here..."
KeyInput.PlaceholderColor3 = Colors.TextSecondary
KeyInput.Text = ""
KeyInput.TextColor3 = Colors.Text
KeyInput.TextSize = 14
KeyInput.TextXAlignment = Enum.TextXAlignment.Left
KeyInput.ClearTextOnFocus = false
KeyInput.ZIndex = 4

-- Focus animation
KeyInput.Focused:Connect(function()
    TweenService:Create(KeyInputStroke, TweenInfo.new(0.2), {Color = Colors.Primary, Transparency = 0}):Play()
end)

KeyInput.FocusLost:Connect(function()
    TweenService:Create(KeyInputStroke, TweenInfo.new(0.2), {Color = Colors.SurfaceLight, Transparency = 0.5}):Play()
end)

-- Check Key Button
local CheckButton = Instance.new("TextButton")
CheckButton.Parent = Main
CheckButton.BackgroundColor3 = Colors.Primary
CheckButton.BorderSizePixel = 0
CheckButton.Position = UDim2.new(0.5, -190, 0, 315)
CheckButton.Size = UDim2.new(0, 380, 0, 48)
CheckButton.Font = Enum.Font.GothamBold
CheckButton.Text = "VERIFY KEY"
CheckButton.TextColor3 = Colors.Text
CheckButton.TextSize = 15
CheckButton.ZIndex = 3

local CheckCorner = Instance.new("UICorner")
CheckCorner.CornerRadius = UDim.new(0, 12)
CheckCorner.Parent = CheckButton

local CheckGradient = Instance.new("UIGradient")
CheckGradient.Parent = CheckButton
CheckGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Colors.Primary),
    ColorSequenceKeypoint.new(1, Colors.Secondary)
}
CheckGradient.Rotation = 45

local CheckGlow = Instance.new("UIStroke")
CheckGlow.Parent = CheckButton
CheckGlow.Color = Colors.Glow
CheckGlow.Thickness = 0
CheckGlow.Transparency = 0.5

-- Button Container
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Parent = Main
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Position = UDim2.new(0.5, -190, 1, -45)
ButtonContainer.Size = UDim2.new(0, 380, 0, 35)
ButtonContainer.ZIndex = 3

local ButtonLayout = Instance.new("UIListLayout")
ButtonLayout.Parent = ButtonContainer
ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ButtonLayout.Padding = UDim.new(0, 10)

-- Create Small Buttons Function
local function CreateSmallButton(text, icon)
    local btn = Instance.new("TextButton")
    btn.Parent = ButtonContainer
    btn.BackgroundColor3 = Colors.Surface
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(0, 118, 0, 35)
    btn.Font = Enum.Font.GothamBold
    btn.Text = icon .. " " .. text
    btn.TextColor3 = Colors.Text
    btn.TextSize = 11
    btn.ZIndex = 3
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn
    
    local stroke = Instance.new("UIStroke")
    stroke.Parent = btn
    stroke.Color = Colors.Primary
    stroke.Thickness = 1.5
    stroke.Transparency = 0.7
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.SurfaceLight}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.2), {Transparency = 0.2, Thickness = 2}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Surface}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.2), {Transparency = 0.7, Thickness = 1.5}):Play()
    end)
    
    return btn
end

local GetKeyBtn = CreateSmallButton("Get Key", "🔑")
local DiscordBtn = CreateSmallButton("Discord", "💬")
local CopyBtn = CreateSmallButton("Copy Link", "📋")

-- Notification Function
local function Notify(title, text, duration, color)
    game.StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = duration or 3;
    })
end

-- Check Key Function
CheckButton.MouseButton1Click:Connect(function()
    local key = KeyInput.Text
    CheckButton.Text = "VERIFYING..."
    
    task.wait(1)
    
    if key == "1234" or key == "TESTKEY" or key == "LOWETHUB" then
        CheckButton.Text = "✓ ACCESS GRANTED"
        CheckButton.BackgroundColor3 = Colors.Success
        Notify("Lowet Hub", "✓ Key verified successfully!", 3)
        
        task.wait(1)
        TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        TweenService:Create(Blur, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        task.wait(0.4)
        UI:Destroy()
        -- Load your main script here
    else
        CheckButton.Text = "✗ INVALID KEY"
        CheckButton.BackgroundColor3 = Colors.Error
        Notify("Lowet Hub", "✗ Invalid key! Please try again.", 3)
        
        -- Shake animation
        local originalPos = CheckButton.Position
        for i = 1, 8 do
            CheckButton.Position = originalPos + UDim2.new(0, math.random(-5, 5), 0, 0)
            task.wait(0.05)
        end
        CheckButton.Position = originalPos
        
        task.wait(1.5)
        CheckButton.Text = "VERIFY KEY"
        CheckButton.BackgroundColor3 = Colors.Primary
        KeyInput.Text = ""
    end
end)

-- Button Actions
GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://your-key-link.com")
    Notify("Lowet Hub", "🔑 Key link copied to clipboard!", 3)
end)

DiscordBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/yourlink")
    Notify("Lowet Hub", "💬 Discord invite copied!", 3)
end)

CopyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://your-key-link.com")
    Notify("Lowet Hub", "📋 Link copied to clipboard!", 3)
end)

-- Check Button Hover Effect
CheckButton.MouseEnter:Connect(function()
    TweenService:Create(CheckButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 390, 0, 50)}):Play()
    TweenService:Create(CheckGlow, TweenInfo.new(0.2), {Thickness = 3}):Play()
end)

CheckButton.MouseLeave:Connect(function()
    TweenService:Create(CheckButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 380, 0, 48)}):Play()
    TweenService:Create(CheckGlow, TweenInfo.new(0.2), {Thickness = 0}):Play()
end)

-- Entrance Animation
Main.Size = UDim2.new(0, 0, 0, 0)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Blur.BackgroundTransparency = 1

TweenService:Create(Blur, TweenInfo.new(0.5), {BackgroundTransparency = 0.2}):Play()
TweenService:Create(Main, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 450, 0, 390),
    Position = UDim2.new(0.5, -225, 0.5, -195)
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