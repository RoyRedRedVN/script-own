-- Lowet Hub Key System UI - Premium Version
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- Color Palette
local Colors = {
    Accent = Color3.fromRGB(255, 107, 53),
    Dialog = Color3.fromRGB(40, 20, 10),
    Outline = Color3.fromRGB(255, 140, 66),
    Text = Color3.fromRGB(255, 255, 255),
    Placeholder = Color3.fromRGB(184, 184, 184),
    Background = Color3.fromRGB(50, 25, 10),
    Button = Color3.fromRGB(255, 107, 53),
    Icon = Color3.fromRGB(255, 165, 82)
}

-- Tạo UI
local UI = Instance.new("ScreenGui")
UI.Name = "LowetHub"
UI.Parent = CoreGui

-- Background Blur
local Blur = Instance.new("Frame")
Blur.Parent = UI
Blur.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Blur.BackgroundTransparency = 0.3
Blur.BorderSizePixel = 0
Blur.Size = UDim2.new(1, 0, 1, 0)

-- Frame chính
local Main = Instance.new("Frame")
Main.Parent = UI
Main.BackgroundColor3 = Colors.Dialog
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, -200, 0.5, -160)
Main.Size = UDim2.new(0, 400, 0, 320)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = Main

-- Outline Glow
local Outline = Instance.new("UIStroke")
Outline.Parent = Main
Outline.Color = Colors.Outline
Outline.Thickness = 2
Outline.Transparency = 0.5

-- Gradient Background
local Gradient = Instance.new("Frame")
Gradient.Parent = Main
Gradient.BackgroundColor3 = Colors.Background
Gradient.BackgroundTransparency = 0.3
Gradient.BorderSizePixel = 0
Gradient.Size = UDim2.new(1, 0, 1, 0)
Gradient.ZIndex = 0

local GradientCorner = Instance.new("UICorner")
GradientCorner.CornerRadius = UDim.new(0, 16)
GradientCorner.Parent = Gradient

local UIGradient = Instance.new("UIGradient")
UIGradient.Parent = Gradient
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 30, 15)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 20, 10))
}
UIGradient.Rotation = 45

-- Nút đóng
local Close = Instance.new("TextButton")
Close.Parent = Main
Close.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
Close.BorderSizePixel = 0
Close.Position = UDim2.new(1, -35, 0, 15)
Close.Size = UDim2.new(0, 25, 0, 25)
Close.Font = Enum.Font.GothamBold
Close.Text = "×"
Close.TextColor3 = Colors.Text
Close.TextSize = 18
Close.ZIndex = 2

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = Close

Close.MouseButton1Click:Connect(function()
    UI:Destroy()
end)

-- Icon/Logo Area
local IconFrame = Instance.new("Frame")
IconFrame.Parent = Main
IconFrame.BackgroundColor3 = Colors.Accent
IconFrame.BorderSizePixel = 0
IconFrame.Position = UDim2.new(0.5, -30, 0, 25)
IconFrame.Size = UDim2.new(0, 60, 0, 60)
IconFrame.ZIndex = 2

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(1, 0)
IconCorner.Parent = IconFrame

local IconStroke = Instance.new("UIStroke")
IconStroke.Parent = IconFrame
IconStroke.Color = Colors.Outline
IconStroke.Thickness = 3

local IconText = Instance.new("TextLabel")
IconText.Parent = IconFrame
IconText.BackgroundTransparency = 1
IconText.Size = UDim2.new(1, 0, 1, 0)
IconText.Font = Enum.Font.GothamBold
IconText.Text = "L"
IconText.TextColor3 = Colors.Text
IconText.TextSize = 32
IconText.ZIndex = 3

-- Tiêu đề
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 95)
Title.Size = UDim2.new(1, 0, 0, 25)
Title.Font = Enum.Font.GothamBold
Title.Text = "Welcome to The"
Title.TextColor3 = Colors.Placeholder
Title.TextSize = 14
Title.ZIndex = 2

-- Tên Hub
local HubName = Instance.new("TextLabel")
HubName.Parent = Main
HubName.BackgroundTransparency = 1
HubName.Position = UDim2.new(0, 0, 0, 115)
HubName.Size = UDim2.new(1, 0, 0, 30)
HubName.Font = Enum.Font.GothamBold
HubName.Text = "Lowet Hub"
HubName.TextColor3 = Colors.Text
HubName.TextSize = 20
HubName.ZIndex = 2

-- Input Key Box Container
local KeyBoxContainer = Instance.new("Frame")
KeyBoxContainer.Parent = Main
KeyBoxContainer.BackgroundColor3 = Colors.Background
KeyBoxContainer.BorderSizePixel = 0
KeyBoxContainer.Position = UDim2.new(0.5, -170, 0, 160)
KeyBoxContainer.Size = UDim2.new(0, 340, 0, 40)
KeyBoxContainer.ZIndex = 2

local KeyBoxCorner = Instance.new("UICorner")
KeyBoxCorner.CornerRadius = UDim.new(0, 8)
KeyBoxCorner.Parent = KeyBoxContainer

local KeyBoxStroke = Instance.new("UIStroke")
KeyBoxStroke.Parent = KeyBoxContainer
KeyBoxStroke.Color = Colors.Outline
KeyBoxStroke.Thickness = 1
KeyBoxStroke.Transparency = 0.7

-- Input Key Box
local KeyBox = Instance.new("TextBox")
KeyBox.Parent = KeyBoxContainer
KeyBox.BackgroundTransparency = 1
KeyBox.Position = UDim2.new(0, 15, 0, 0)
KeyBox.Size = UDim2.new(1, -30, 1, 0)
KeyBox.Font = Enum.Font.Gotham
KeyBox.PlaceholderText = "Insert Code Key here"
KeyBox.PlaceholderColor3 = Colors.Placeholder
KeyBox.Text = ""
KeyBox.TextColor3 = Colors.Text
KeyBox.TextSize = 13
KeyBox.TextXAlignment = Enum.TextXAlignment.Left
KeyBox.ClearTextOnFocus = false
KeyBox.ZIndex = 3

-- Check Key Button
local CheckBtn = Instance.new("TextButton")
CheckBtn.Parent = Main
CheckBtn.BackgroundColor3 = Colors.Button
CheckBtn.BorderSizePixel = 0
CheckBtn.Position = UDim2.new(0.5, -170, 0, 210)
CheckBtn.Size = UDim2.new(0, 340, 0, 40)
CheckBtn.Font = Enum.Font.GothamBold
CheckBtn.Text = "✓  Check Key"
CheckBtn.TextColor3 = Colors.Text
CheckBtn.TextSize = 14
CheckBtn.ZIndex = 2

local CheckCorner = Instance.new("UICorner")
CheckCorner.CornerRadius = UDim.new(0, 8)
CheckCorner.Parent = CheckBtn

local CheckStroke = Instance.new("UIStroke")
CheckStroke.Parent = CheckBtn
CheckStroke.Color = Colors.Outline
CheckStroke.Thickness = 0
CheckStroke.Transparency = 0.5

-- Buttons Container
local BtnContainer = Instance.new("Frame")
BtnContainer.Parent = Main
BtnContainer.BackgroundTransparency = 1
BtnContainer.Position = UDim2.new(0.5, -170, 1, -50)
BtnContainer.Size = UDim2.new(0, 340, 0, 35)
BtnContainer.ZIndex = 2

local BtnLayout = Instance.new("UIListLayout")
BtnLayout.Parent = BtnContainer
BtnLayout.FillDirection = Enum.FillDirection.Horizontal
BtnLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
BtnLayout.Padding = UDim.new(0, 8)

-- Get Key Button
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Parent = BtnContainer
GetKeyBtn.BackgroundColor3 = Colors.Background
GetKeyBtn.BorderSizePixel = 0
GetKeyBtn.Size = UDim2.new(0, 105, 0, 35)
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Text = "🔑 Get Key"
GetKeyBtn.TextColor3 = Colors.Text
GetKeyBtn.TextSize = 12
GetKeyBtn.ZIndex = 2

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 8)
GetKeyCorner.Parent = GetKeyBtn

local GetKeyStroke = Instance.new("UIStroke")
GetKeyStroke.Parent = GetKeyBtn
GetKeyStroke.Color = Colors.Outline
GetKeyStroke.Thickness = 1.5

-- Join Discord Button
local JoinBtn = Instance.new("TextButton")
JoinBtn.Parent = BtnContainer
JoinBtn.BackgroundColor3 = Colors.Background
JoinBtn.BorderSizePixel = 0
JoinBtn.Size = UDim2.new(0, 105, 0, 35)
JoinBtn.Font = Enum.Font.GothamBold
JoinBtn.Text = "💬 Discord"
JoinBtn.TextColor3 = Colors.Text
JoinBtn.TextSize = 12
JoinBtn.ZIndex = 2

local JoinCorner = Instance.new("UICorner")
JoinCorner.CornerRadius = UDim.new(0, 8)
JoinCorner.Parent = JoinBtn

local JoinStroke = Instance.new("UIStroke")
JoinStroke.Parent = JoinBtn
JoinStroke.Color = Colors.Outline
JoinStroke.Thickness = 1.5

-- Copy Link Button
local CopyBtn = Instance.new("TextButton")
CopyBtn.Parent = BtnContainer
CopyBtn.BackgroundColor3 = Colors.Background
CopyBtn.BorderSizePixel = 0
CopyBtn.Size = UDim2.new(0, 105, 0, 35)
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.Text = "📋 Copy"
CopyBtn.TextColor3 = Colors.Text
CopyBtn.TextSize = 12
CopyBtn.ZIndex = 2

local CopyCorner = Instance.new("UICorner")
CopyCorner.CornerRadius = UDim.new(0, 8)
CopyCorner.Parent = CopyBtn

local CopyStroke = Instance.new("UIStroke")
CopyStroke.Parent = CopyBtn
CopyStroke.Color = Colors.Outline
CopyStroke.Thickness = 1.5

-- Hàm thông báo
local function Notify(title, text)
    game.StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = 3;
    })
end

-- Check Key Logic
CheckBtn.MouseButton1Click:Connect(function()
    local key = KeyBox.Text
    if key == "1234" or key == "TESTKEY" then
        Notify("Lowet Hub", "✓ Key Valid! Loading...")
        TweenService:Create(Main, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        wait(0.3)
        UI:Destroy()
        -- Load your main script here
    else
        Notify("Lowet Hub", "✗ Invalid Key!")
        KeyBox.Text = ""
        local shake = TweenService:Create(Main, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, true, 0), {Position = UDim2.new(0.5, -195, 0.5, -160)})
        shake:Play()
        shake.Completed:Wait()
        Main.Position = UDim2.new(0.5, -200, 0.5, -160)
    end
end)

-- Get Key Button
GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://your-key-link.com")
    Notify("Lowet Hub", "🔑 Key link copied!")
end)

-- Join Discord
JoinBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/yourlink")
    Notify("Lowet Hub", "💬 Discord link copied!")
end)

-- Copy Link
CopyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://your-key-link.com")
    Notify("Lowet Hub", "📋 Link copied!")
end)

-- Hover Effects
CheckBtn.MouseEnter:Connect(function()
    TweenService:Create(CheckBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 140, 80)}):Play()
    TweenService:Create(CheckStroke, TweenInfo.new(0.2), {Thickness = 2}):Play()
end)
CheckBtn.MouseLeave:Connect(function()
    TweenService:Create(CheckBtn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Button}):Play()
    TweenService:Create(CheckStroke, TweenInfo.new(0.2), {Thickness = 0}):Play()
end)

local smallButtons = {GetKeyBtn, JoinBtn, CopyBtn}
for _, btn in pairs(smallButtons) do
    local stroke = btn:FindFirstChildOfClass("UIStroke")
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Button}):Play()
        if stroke then
            TweenService:Create(stroke, TweenInfo.new(0.2), {Thickness = 2}):Play()
        end
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Background}):Play()
        if stroke then
            TweenService:Create(stroke, TweenInfo.new(0.2), {Thickness = 1.5}):Play()
        end
    end)
end

-- Animation mở UI
Main.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 400, 0, 320)}):Play()