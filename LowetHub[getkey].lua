-- Lowet Hub Key System UI
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- Tạo UI
local UI = Instance.new("ScreenGui")
UI.Name = "LowetHub"
UI.Parent = CoreGui

-- Background Blur
local Blur = Instance.new("Frame")
Blur.Parent = UI
Blur.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Blur.BackgroundTransparency = 0.5
Blur.BorderSizePixel = 0
Blur.Size = UDim2.new(1, 0, 1, 0)

-- Frame chính
local Main = Instance.new("Frame")
Main.Parent = UI
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, -180, 0.5, -140)
Main.Size = UDim2.new(0, 360, 0, 280)

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- Nút đóng
local Close = Instance.new("TextButton")
Close.Parent = Main
Close.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Close.BorderSizePixel = 0
Close.Position = UDim2.new(1, -30, 0, 10)
Close.Size = UDim2.new(0, 20, 0, 20)
Close.Font = Enum.Font.GothamBold
Close.Text = "×"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextSize = 16

Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 4)

Close.MouseButton1Click:Connect(function()
    UI:Destroy()
end)

-- Tiêu đề
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 20)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "Welcome to The"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

-- Tên Hub
local HubName = Instance.new("TextLabel")
HubName.Parent = Main
HubName.BackgroundTransparency = 1
HubName.Position = UDim2.new(0, 0, 0, 45)
HubName.Size = UDim2.new(1, 0, 0, 25)
HubName.Font = Enum.Font.GothamBold
HubName.Text = "Lowet Hub (Key Version)"
HubName.TextColor3 = Color3.fromRGB(255, 255, 255)
HubName.TextSize = 16

-- Input Key Box
local KeyBox = Instance.new("TextBox")
KeyBox.Parent = Main
KeyBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
KeyBox.BorderSizePixel = 0
KeyBox.Position = UDim2.new(0.5, -150, 0, 90)
KeyBox.Size = UDim2.new(0, 300, 0, 35)
KeyBox.Font = Enum.Font.Gotham
KeyBox.PlaceholderText = "Insert Code Key here"
KeyBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 13
KeyBox.ClearTextOnFocus = false

Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 6)

-- Check Key Button
local CheckBtn = Instance.new("TextButton")
CheckBtn.Parent = Main
CheckBtn.BackgroundColor3 = Color3.fromRGB(230, 81, 0)
CheckBtn.BorderSizePixel = 0
CheckBtn.Position = UDim2.new(0.5, -150, 0, 135)
CheckBtn.Size = UDim2.new(0, 300, 0, 35)
CheckBtn.Font = Enum.Font.GothamBold
CheckBtn.Text = "Check Key"
CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckBtn.TextSize = 14

Instance.new("UICorner", CheckBtn).CornerRadius = UDim.new(0, 6)

-- Note Text
local Note = Instance.new("TextLabel")
Note.Parent = Main
Note.BackgroundTransparency = 1
Note.Position = UDim2.new(0, 0, 0, 180)
Note.Size = UDim2.new(1, 0, 0, 20)
Note.Font = Enum.Font.Gotham
Note.Text = "Note: Key may take 15s+"
Note.TextColor3 = Color3.fromRGB(200, 200, 200)
Note.TextSize = 11

-- Join Discord
local Discord = Instance.new("TextLabel")
Discord.Parent = Main
Discord.BackgroundTransparency = 1
Position = UDim2.new(0, 0, 0, 200)
Discord.Size = UDim2.new(1, 0, 0, 20)
Discord.Font = Enum.Font.Gotham
Discord.Text = "Join Discord Server?"
Discord.TextColor3 = Color3.fromRGB(200, 200, 200)
Discord.TextSize = 11

-- Buttons Container
local BtnContainer = Instance.new("Frame")
BtnContainer.Parent = Main
BtnContainer.BackgroundTransparency = 1
BtnContainer.Position = UDim2.new(0.5, -150, 1, -45)
BtnContainer.Size = UDim2.new(0, 300, 0, 30)

local BtnLayout = Instance.new("UIListLayout")
BtnLayout.Parent = BtnContainer
BtnLayout.FillDirection = Enum.FillDirection.Horizontal
BtnLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
BtnLayout.Padding = UDim.new(0, 10)

-- Get Key Button
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Parent = BtnContainer
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(230, 81, 0)
GetKeyBtn.BorderSizePixel = 0
GetKeyBtn.Size = UDim2.new(0, 90, 0, 30)
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Text = "Get Key"
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.TextSize = 12

Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 6)

-- Join Discord Button
local JoinBtn = Instance.new("TextButton")
JoinBtn.Parent = BtnContainer
JoinBtn.BackgroundColor3 = Color3.fromRGB(230, 81, 0)
JoinBtn.BorderSizePixel = 0
JoinBtn.Size = UDim2.new(0, 90, 0, 30)
JoinBtn.Font = Enum.Font.GothamBold
JoinBtn.Text = "Join Server"
JoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JoinBtn.TextSize = 12

Instance.new("UICorner", JoinBtn).CornerRadius = UDim.new(0, 6)

-- Copy Link Button
local CopyBtn = Instance.new("TextButton")
CopyBtn.Parent = BtnContainer
CopyBtn.BackgroundColor3 = Color3.fromRGB(230, 81, 0)
CopyBtn.BorderSizePixel = 0
CopyBtn.Size = UDim2.new(0, 90, 0, 30)
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.Text = "Copy Link"
CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyBtn.TextSize = 12

Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0, 6)

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
        Notify("Lowet Hub", "Key Valid! Loading...")
        wait(1)
        UI:Destroy()
        -- Load your main script here
    else
        Notify("Lowet Hub", "Invalid Key!")
        KeyBox.Text = ""
    end
end)

-- Get Key Button
GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://your-key-link.com")
    Notify("Lowet Hub", "Key link copied!")
end)

-- Join Discord
JoinBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/yourlink")
    Notify("Lowet Hub", "Discord link copied!")
end)

-- Copy Link
CopyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://your-key-link.com")
    Notify("Lowet Hub", "Link copied to clipboard!")
end)

-- Hover Effects
local buttons = {CheckBtn, GetKeyBtn, JoinBtn, CopyBtn}
for _, btn in pairs(buttons) do
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 109, 0)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(230, 81, 0)}):Play()
    end)
end