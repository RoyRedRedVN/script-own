local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:AddTheme({
    Name = "POWER",
    Accent = Color3.fromRGB(255, 107, 53),
    Dialog = Color3.fromRGB(40, 20, 10),
    Outline = Color3.fromRGB(255, 140, 82),
    Text = Color3.fromRGB(255, 255, 255),
    Placeholder = Color3.fromRGB(184, 184, 184),
    Background = Color3.fromRGB(50, 25, 10),
    Button = Color3.fromRGB(255, 107, 53),
    Icon = Color3.fromRGB(255, 165, 82)
})

-- Áp dụng theme
WindUI:SetTheme("POWER")

-- Tạo Window Lowet Hub
local Window = WindUI:CreateWindow({
    Title = "Lowet Hub",
    Icon = "door-open",
    Author = "by Lowet",
    Folder = "LowetHub",
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "POWER",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    KeySystem = { 
        Key = { "1234", "5678" },
        Note = "Lowet Hub Key System",
        Thumbnail = {
            Image = "rbxassetid://",
            Title = "Lowet Hub",
        },
        URL = "YOUR LINK TO GET KEY",
        SaveKey = true,
    },
})
