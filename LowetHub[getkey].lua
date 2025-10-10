-- Material UI Hub - Giao diện ngắn gọn
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- Tạo UI
local UI = Instance.new("ScreenGui")
UI.Name = "Lowet Hub (Key Version)"
UI.Parent = CoreGui

-- Frame chính
local Main = Instance.new("Frame")
Main.Parent = UI
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, -250, 0.5, -200)
Main.Size = UDim2.new(0, 500, 0, 400)

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- Thanh trên
local Top = Instance.new("Frame")
Top.Parent = Main
Top.BackgroundColor3 = Color3.fromRGB(230, 81, 0)
Top.BorderSizePixel = 0
Top.Size = UDim2.new(1, 0, 0, 45)

Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 10)

local TopFill = Instance.new("Frame")
TopFill.Parent = Top
TopFill.BackgroundColor3 = Color3.fromRGB(230, 81, 0)
TopFill.BorderSizePixel = 0
TopFill.Position = UDim2.new(0, 0, 1, -10)
TopFill.Size = UDim2.new(1, 0, 0, 10)

-- Tiêu đề
local Title = Instance.new("TextLabel")
Title.Parent = Top
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Lowet Hub (Key Version)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Nút đóng
local Close = Instance.new("TextButton")
Close.Parent = Top
Close.BackgroundColor3 = Color3.fromRGB(244, 67, 54)
Close.BorderSizePixel = 0
Close.Position = UDim2.new(1, -35, 0.5, -12)
Close.Size = UDim2.new(0, 24, 0, 24)
Close.Font = Enum.Font.GothamBold
Close.Text = "×"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextSize = 20

Instance.new("UICorner", Close).CornerRadius = UDim.new(1, 0)

Close.MouseButton1Click:Connect(function()
    UI:Destroy()
end)

-- Container
local Container = Instance.new("ScrollingFrame")
Container.Parent = Main
Container.BackgroundTransparency = 1
Container.Position = UDim2.new(0, 10, 0, 55)
Container.Size = UDim2.new(1, -20, 1, -65)
Container.ScrollBarThickness = 4
Container.BorderSizePixel = 0

local Layout = Instance.new("UIListLayout")
Layout.Parent = Container
Layout.Padding = UDim.new(0, 10)
Layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Hàm tạo Button
local function CreateButton(text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Parent = Container
    Btn.BackgroundColor3 = Color3.fromRGB(230, 81, 0)
    Btn.BorderSizePixel = 0
    Btn.Size = UDim2.new(1, 0, 0, 40)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 14
    
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    
    Btn.MouseButton1Click:Connect(callback)
    
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 109, 0)}):Play()
    end)
    
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(98, 0, 238)}):Play()
    end)
end

-- Hàm tạo Toggle
local function CreateToggle(text, callback)
    local Toggle = Instance.new("Frame")
    Toggle.Parent = Container
    Toggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Toggle.BorderSizePixel = 0
    Toggle.Size = UDim2.new(1, 0, 0, 40)
    
    Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 8)
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Toggle
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Font = Enum.Font.Gotham
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local Btn = Instance.new("TextButton")
    Btn.Parent = Toggle
    Btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Btn.BorderSizePixel = 0
    Btn.Position = UDim2.new(1, -45, 0.5, -10)
    Btn.Size = UDim2.new(0, 40, 0, 20)
    Btn.Text = ""
    
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)
    
    local Circle = Instance.new("Frame")
    Circle.Parent = Btn
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Circle.BorderSizePixel = 0
    Circle.Position = UDim2.new(0, 2, 0.5, -8)
    Circle.Size = UDim2.new(0, 16, 0, 16)
    
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)
    
    local enabled = false
    Btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(98, 0, 238)}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0.5, -8)}):Play()
        else
            TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
        end
        callback(enabled)
    end)
end

-- Ví dụ sử dụng
CreateButton("Get Key", function()
    setclipboard("https://discord.gg/yourlink")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Get Key";
        Text = "Link copied to clipboard!";
        Duration = 3;
    })
end)