--[[
    ╔═══════════════════════════════════════════════════════════╗
    ║          POWER OFF LOADER v2.1 - KRNL OPTIMIZED          ║
    ║          Vollständig überarbeitet für maximale            ║
    ║          Kompatibilität mit allen Executors               ║
    ╚═══════════════════════════════════════════════════════════╝
]]

-- Initialisierung mit Fehlerbehandlung
print("🚀 Power Off Loader wird gestartet...")
task.wait(1)

-- Services sicher laden
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local StarterGui = game:GetService("StarterGui")

-- Player
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

print("✓ Services geladen")

-- Device Detection
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
print("✓ Device: " .. (isMobile and "Mobile" or "PC"))

-- Alte GUI entfernen
pcall(function()
    if PlayerGui:FindFirstChild("PowerOffLoader") then
        PlayerGui:FindFirstChild("PowerOffLoader"):Destroy()
        print("✓ Alte GUI entfernt")
        task.wait(0.3)
    end
end)

-- Variables
local UIVisible = true
local AntiAFKEnabled = true
local SelectedScripts = {}

-- Colors
local Colors = {
    Background = Color3.fromRGB(20, 20, 30),
    Secondary = Color3.fromRGB(30, 30, 45),
    Accent = Color3.fromRGB(88, 101, 242),
    Success = Color3.fromRGB(67, 181, 129),
    Warning = Color3.fromRGB(250, 166, 26),
    Danger = Color3.fromRGB(237, 66, 69),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(180, 180, 190)
}

-- Script Database (Erweitert)
local ScriptDatabase = {
    ["99 Nights in the Forest"] = {
        GameName = "99 Nights in the Forest",
        GameId = 79546208627805,
        Icon = "🌙",
        Scripts = {
            {
                Name = "Elude Loader",
                Description = "Premium script loader mit ESP",
                URL = "https://raw.githubusercontent.com/DarkenedEssence/Elude/refs/heads/main/Loader.lua",
                RequiresKey = true,
                Category = "Premium",
                Rating = "⭐⭐⭐⭐⭐"
            },
            {
                Name = "ToastyHub XD",
                Description = "Umfangreicher Hub",
                URL = "https://raw.githubusercontent.com/nouralddin-abdullah/ToastyHub-XD/refs/heads/main/hub-main.lua",
                RequiresKey = true,
                Category = "Premium",
                Rating = "⭐⭐⭐⭐"
            },
            {
                Name = "VapeVoidware",
                Description = "Kostenloses Script ohne Key",
                URL = "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua",
                RequiresKey = false,
                Category = "Free",
                Rating = "⭐⭐⭐⭐"
            },
            {
                Name = "GEC Loader",
                Description = "Schneller Loader ohne Key",
                URL = "https://raw.githubusercontent.com/GEC0/gec/refs/heads/main/Gec.Loader",
                RequiresKey = false,
                Category = "Free",
                Rating = "⭐⭐⭐"
            }
        }
    },
    ["My Brainrot Egg Farm"] = {
        GameName = "My Brainrot Egg Farm",
        GameId = 71360925634781,
        Icon = "🥚",
        Scripts = {
            {
                Name = "Chavels Loader",
                Description = "Premium auto farm",
                URL = "https://raw.githubusercontent.com/Chavels123/Loader/refs/heads/main/loader.lua",
                RequiresKey = false,
                Category = "Premium",
                Rating = "⭐⭐⭐⭐⭐"
            },
            {
                Name = "Gumanba Scripts",
                Description = "Complete farming system",
                URL = "https://raw.githubusercontent.com/gumanba/Scripts/main/MyBrainrotEggFarm",
                RequiresKey = false,
                Category = "Free",
                Rating = "⭐⭐⭐⭐"
            },
            {
                Name = "PulsarX Loader",
                Description = "Advanced hub",
                URL = "https://raw.githubusercontent.com/Estevansit0/KJJK/refs/heads/main/PusarX-loader.lua",
                RequiresKey = false,
                Category = "Premium",
                Rating = "⭐⭐⭐⭐⭐"
            }
        }
    },
    ["Grow a Garden"] = {
        GameName = "Grow a Garden",
        GameId = 0,
        Icon = "🌱",
        Scripts = {
            {
                Name = "Lunor Hub",
                Description = "Professioneller Hub",
                URL = "https://lunor.dev/loader",
                RequiresKey = true,
                Category = "Premium",
                Rating = "⭐⭐⭐⭐⭐"
            }
        }
    },
    ["Universal Scripts"] = {
        GameName = "Universal (Alle Spiele)",
        GameId = 0,
        Icon = "🌐",
        Scripts = {
            {
                Name = "Infinite Yield",
                Description = "Admin Commands",
                URL = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source",
                RequiresKey = false,
                Category = "Admin",
                Rating = "⭐⭐⭐⭐⭐"
            },
            {
                Name = "Dark Dex V3",
                Description = "Game Explorer",
                URL = "https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua",
                RequiresKey = false,
                Category = "Tools",
                Rating = "⭐⭐⭐⭐⭐"
            },
            {
                Name = "Unnamed ESP",
                Description = "Universal ESP",
                URL = "https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua",
                RequiresKey = false,
                Category = "Visual",
                Rating = "⭐⭐⭐⭐⭐"
            }
        }
    }
}

print("✓ Script Database geladen (" .. #ScriptDatabase .. " Spiele)")

-- Anti-AFK System
print("✓ Anti-AFK wird gestartet...")
Player.Idled:Connect(function()
    if AntiAFKEnabled then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

task.spawn(function()
    while task.wait(15) do
        if AntiAFKEnabled then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end
    end
end)

print("✓ Anti-AFK aktiv")

-- GUI Erstellung
print("🎨 GUI wird erstellt...")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PowerOffLoader"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
if isMobile then
    MainFrame.Size = UDim2.new(0.92, 0, 0.82, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
else
    MainFrame.Size = UDim2.new(0, 850, 0, 550)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
end
MainFrame.BackgroundColor3 = Colors.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Colors.Accent
MainStroke.Thickness = 2
MainStroke.Transparency = 0.5
MainStroke.Parent = MainFrame

print("✓ MainFrame erstellt")

-- Header
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 65)
Header.BackgroundColor3 = Colors.Secondary
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 15)
HeaderCorner.Parent = Header

local HeaderBottom = Instance.new("Frame")
HeaderBottom.Size = UDim2.new(1, 0, 0, 15)
HeaderBottom.Position = UDim2.new(0, 0, 1, -15)
HeaderBottom.BackgroundColor3 = Colors.Secondary
HeaderBottom.BorderSizePixel = 0
HeaderBottom.Parent = Header

-- Gradient für Header
local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 45))
}
HeaderGradient.Rotation = 90
HeaderGradient.Parent = Header

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.6, 0, 0, 30)
Title.Position = UDim2.new(0, 15, 0, 8)
Title.BackgroundTransparency = 1
Title.Text = "🎮 POWER OFF LOADER"
Title.TextColor3 = Colors.Text
Title.TextSize = isMobile and 18 or 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Rainbow Title Effect
task.spawn(function()
    local hue = 0
    while Title and Title.Parent do
        hue = (hue + 1) % 360
        Title.TextColor3 = Color3.fromHSV(hue/360, 0.8, 1)
        task.wait(0.05)
    end
end)

-- Version
local Version = Instance.new("TextLabel")
Version.Size = UDim2.new(0.3, 0, 0, 18)
Version.Position = UDim2.new(0, 15, 0, 40)
Version.BackgroundTransparency = 1
Version.Text = "v2.1 • " .. (isMobile and "📱 Mobile" or "💻 Desktop") .. " • KRNL Ready"
Version.TextColor3 = Colors.TextSecondary
Version.TextSize = isMobile and 9 or 11
Version.Font = Enum.Font.Gotham
Version.TextXAlignment = Enum.TextXAlignment.Left
Version.Parent = Header

-- Anti-AFK Indicator
local AFKIndicator = Instance.new("Frame")
AFKIndicator.Size = UDim2.new(0, 120, 0, 35)
AFKIndicator.Position = UDim2.new(1, -250, 0.5, -17.5)
AFKIndicator.BackgroundColor3 = Colors.Success
AFKIndicator.BorderSizePixel = 0
AFKIndicator.Parent = Header

local AFKCorner = Instance.new("UICorner")
AFKCorner.CornerRadius = UDim.new(0, 8)
AFKCorner.Parent = AFKIndicator

local AFKLabel = Instance.new("TextLabel")
AFKLabel.Size = UDim2.new(1, 0, 1, 0)
AFKLabel.BackgroundTransparency = 1
AFKLabel.Text = "🛡️ Anti-AFK"
AFKLabel.TextColor3 = Colors.Text
AFKLabel.TextSize = 11
AFKLabel.Font = Enum.Font.GothamBold
AFKLabel.Parent = AFKIndicator

local AFKBtn = Instance.new("TextButton")
AFKBtn.Size = UDim2.new(1, 0, 1, 0)
AFKBtn.BackgroundTransparency = 1
AFKBtn.Text = ""
AFKBtn.Parent = AFKIndicator

AFKBtn.MouseButton1Click:Connect(function()
    AntiAFKEnabled = not AntiAFKEnabled
    AFKIndicator.BackgroundColor3 = AntiAFKEnabled and Colors.Success or Colors.Danger
    AFKLabel.Text = AntiAFKEnabled and "🛡️ Anti-AFK" or "💤 AFK Off"
    
    local notification = StarterGui:SetCore("SendNotification", {
        Title = "Anti-AFK";
        Text = AntiAFKEnabled and "✓ Aktiviert" or "✗ Deaktiviert";
        Duration = 2;
    })
end)

-- Pulse Animation für AFK Indicator
task.spawn(function()
    while AFKIndicator and AFKIndicator.Parent do
        if AntiAFKEnabled then
            TweenService:Create(AFKIndicator, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                BackgroundColor3 = Color3.fromRGB(87, 201, 149)
            }):Play()
            task.wait(1.5)
            TweenService:Create(AFKIndicator, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                BackgroundColor3 = Colors.Success
            }):Play()
            task.wait(1.5)
        else
            task.wait(1)
        end
    end
end)

-- Close & Minimize Buttons
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseButton"
CloseBtn.Size = UDim2.new(0, 50, 0, 50)
CloseBtn.Position = UDim2.new(1, -60, 0.5, -25)
CloseBtn.BackgroundColor3 = Colors.Danger
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Colors.Text
CloseBtn.TextSize = 24
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    task.wait(0.3)
    MainFrame.Visible = false
    UIVisible = false
end)

-- Hover Effect für Close Button
CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 86, 89),
        Size = UDim2.new(0, 55, 0, 55)
    }):Play()
end)

CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Colors.Danger,
        Size = UDim2.new(0, 50, 0, 50)
    }):Play()
end)

print("✓ Header erstellt")

-- Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -20, 1, -130)
ContentArea.Position = UDim2.new(0, 10, 0, 75)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- Game Selector (Tabs)
local GameSelector = Instance.new("Frame")
GameSelector.Size = UDim2.new(1, 0, 0, 50)
GameSelector.BackgroundTransparency = 1
GameSelector.Parent = ContentArea

local GameScrollFrame = Instance.new("ScrollingFrame")
GameScrollFrame.Size = UDim2.new(1, 0, 1, 0)
GameScrollFrame.BackgroundTransparency = 1
GameScrollFrame.BorderSizePixel = 0
GameScrollFrame.ScrollBarThickness = 0
GameScrollFrame.ScrollingDirection = Enum.ScrollingDirection.X
GameScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
GameScrollFrame.Parent = GameSelector

local GameLayout = Instance.new("UIListLayout")
GameLayout.FillDirection = Enum.FillDirection.Horizontal
GameLayout.Padding = UDim.new(0, 10)
GameLayout.Parent = GameScrollFrame

-- Scripts Container
local ScriptsContainer = Instance.new("ScrollingFrame")
ScriptsContainer.Size = UDim2.new(1, 0, 1, -115)
ScriptsContainer.Position = UDim2.new(0, 0, 0, 60)
ScriptsContainer.BackgroundTransparency = 1
ScriptsContainer.BorderSizePixel = 0
ScriptsContainer.ScrollBarThickness = isMobile and 8 or 6
ScriptsContainer.ScrollBarImageColor3 = Colors.Accent
ScriptsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
ScriptsContainer.Parent = ContentArea

local ScriptsLayout = Instance.new("UIListLayout")
ScriptsLayout.Padding = UDim.new(0, 10)
ScriptsLayout.SortOrder = Enum.SortOrder.LayoutOrder
ScriptsLayout.Parent = ScriptsContainer

ScriptsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScriptsContainer.CanvasSize = UDim2.new(0, 0, 0, ScriptsLayout.AbsoluteContentSize.Y + 15)
end)

-- Control Panel (Bottom Bar)
local ControlPanel = Instance.new("Frame")
ControlPanel.Size = UDim2.new(1, 0, 0, 50)
ControlPanel.Position = UDim2.new(0, 0, 1, -50)
ControlPanel.BackgroundColor3 = Colors.Secondary
ControlPanel.BorderSizePixel = 0
ControlPanel.Parent = ContentArea

local CPCorner = Instance.new("UICorner")
CPCorner.CornerRadius = UDim.new(0, 10)
CPCorner.Parent = ControlPanel

local CPGradient = Instance.new("UIGradient")
CPGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 45))
}
CPGradient.Rotation = 90
CPGradient.Parent = ControlPanel

-- Selected Counter
local SelectedCounter = Instance.new("TextLabel")
SelectedCounter.Size = UDim2.new(0.35, 0, 1, 0)
SelectedCounter.Position = UDim2.new(0, 15, 0, 0)
SelectedCounter.BackgroundTransparency = 1
SelectedCounter.Text = "📋 0 ausgewählt"
SelectedCounter.TextColor3 = Colors.TextSecondary
SelectedCounter.TextSize = isMobile and 11 or 13
SelectedCounter.Font = Enum.Font.GothamBold
SelectedCounter.TextXAlignment = Enum.TextXAlignment.Left
SelectedCounter.Parent = ControlPanel

-- Execute All Button
local ExecuteAllBtn = Instance.new("TextButton")
ExecuteAllBtn.Size = UDim2.new(0.3, -5, 0, 35)
ExecuteAllBtn.Position = UDim2.new(0.37, 0, 0.5, -17.5)
ExecuteAllBtn.BackgroundColor3 = Colors.Success
ExecuteAllBtn.Text = "▶ ALLE STARTEN"
ExecuteAllBtn.TextColor3 = Colors.Text
ExecuteAllBtn.TextSize = isMobile and 11 or 13
ExecuteAllBtn.Font = Enum.Font.GothamBold
ExecuteAllBtn.BorderSizePixel = 0
ExecuteAllBtn.Parent = ControlPanel

local ExecCorner = Instance.new("UICorner")
ExecCorner.CornerRadius = UDim.new(0, 8)
ExecCorner.Parent = ExecuteAllBtn

-- Clear Button
local ClearBtn = Instance.new("TextButton")
ClearBtn.Size = UDim2.new(0.3, -5, 0, 35)
ClearBtn.Position = UDim2.new(0.69, 0, 0.5, -17.5)
ClearBtn.BackgroundColor3 = Colors.Danger
ClearBtn.Text = "✕ AUSWAHL LÖSCHEN"
ClearBtn.TextColor3 = Colors.Text
ClearBtn.TextSize = isMobile and 11 or 13
ClearBtn.Font = Enum.Font.GothamBold
ClearBtn.BorderSizePixel = 0
ClearBtn.Parent = ControlPanel

local ClearCorner = Instance.new("UICorner")
ClearCorner.CornerRadius = UDim.new(0, 8)
ClearCorner.Parent = ClearBtn

print("✓ Content Area erstellt")

-- Execute Script Function
local function ExecuteScript(scriptData)
    print("⚡ Executing: " .. scriptData.Name)
    
    local success, err = pcall(function()
        local scriptContent = game:HttpGet(scriptData.URL, true)
        local func = loadstring(scriptContent)
        if func then
            func()
        else
            error("Loadstring failed")
        end
    end)
    
    if success then
        print("✅ Success: " .. scriptData.Name)
        StarterGui:SetCore("SendNotification", {
            Title = "✅ Erfolgreich";
            Text = scriptData.Name .. " wurde geladen!";
            Duration = 3;
        })
    else
        print("❌ Error: " .. scriptData.Name)
        print("Error details: " .. tostring(err))
        StarterGui:SetCore("SendNotification", {
            Title = "❌ Fehler";
            Text = "Fehler beim Laden von " .. scriptData.Name;
            Duration = 4;
        })
    end
end

-- Create Script Card
local function CreateScriptCard(scriptData, index)
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, -10, 0, isMobile and 115 or 105)
    Card.BackgroundColor3 = Colors.Secondary
    Card.BorderSizePixel = 0
    Card.LayoutOrder = index
    Card.Parent = ScriptsContainer
    
    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 10)
    CardCorner.Parent = Card
    
    local CardGradient = Instance.new("UIGradient")
    CardGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 28, 42))
    }
    CardGradient.Rotation = 45
    CardGradient.Parent = Card
    
    local CardStroke = Instance.new("UIStroke")
    CardStroke.Color = Colors.Accent
    CardStroke.Thickness = 1
    CardStroke.Transparency = 0.8
    CardStroke.Parent = Card
    
    -- Checkbox Frame
    local CheckFrame = Instance.new("Frame")
    CheckFrame.Size = UDim2.new(0, 32, 0, 32)
    CheckFrame.Position = UDim2.new(0, 12, 0, 12)
    CheckFrame.BackgroundColor3 = Colors.Background
    CheckFrame.BorderSizePixel = 2
    CheckFrame.BorderColor3 = Colors.Accent
    CheckFrame.Parent = Card
    
    local CheckCorner = Instance.new("UICorner")
    CheckCorner.CornerRadius = UDim.new(0, 6)
    CheckCorner.Parent = CheckFrame
    
    local CheckBtn = Instance.new("TextButton")
    CheckBtn.Size = UDim2.new(1, 0, 1, 0)
    CheckBtn.BackgroundTransparency = 1
    CheckBtn.Text = ""
    CheckBtn.Parent = CheckFrame
    
    local CheckMark = Instance.new("TextLabel")
    CheckMark.Size = UDim2.new(1, 0, 1, 0)
    CheckMark.BackgroundTransparency = 1
    CheckMark.Text = "✓"
    CheckMark.TextColor3 = Colors.Success
    CheckMark.TextSize = 22
    CheckMark.Font = Enum.Font.GothamBold
    CheckMark.Visible = false
    CheckMark.Parent = CheckFrame
    
    local isSelected = false
    
    CheckBtn.MouseButton1Click:Connect(function()
        isSelected = not isSelected
        CheckMark.Visible = isSelected
        CheckFrame.BackgroundColor3 = isSelected and Colors.Accent or Colors.Background
        CheckFrame.BorderColor3 = isSelected and Colors.Success or Colors.Accent
        
        if isSelected then
            table.insert(SelectedScripts, scriptData)
        else
            for i, s in ipairs(SelectedScripts) do
                if s.Name == scriptData.Name then
                    table.remove(SelectedScripts, i)
                    break
                end
            end
        end
        
        SelectedCounter.Text = "📋 " .. #SelectedScripts .. " ausgewählt"
        
        -- Animation
        TweenService:Create(CheckFrame, TweenInfo.new(0.2, Enum.EasingStyle.Elastic), {
            Size = UDim2.new(0, 36, 0, 36)
        }):Play()
        task.wait(0.1)
        TweenService:Create(CheckFrame, TweenInfo.new(0.2, Enum.EasingStyle.Elastic), {
            Size = UDim2.new(0, 32, 0, 32)
        }):Play()
    end)
    
    -- Script Name
    local Name = Instance.new("TextLabel")
    Name.Size = UDim2.new(1, -180, 0, 24)
    Name.Position = UDim2.new(0, 52, 0, 10)
    Name.BackgroundTransparency = 1
    Name.Text = scriptData.Name
    Name.TextColor3 = Colors.Text
    Name.TextSize = isMobile and 13 or 15
    Name.Font = Enum.Font.GothamBold
    Name.TextXAlignment = Enum.TextXAlignment.Left
    Name.TextTruncate = Enum.TextTruncate.AtEnd
    Name.Parent = Card
    
    -- Rating
    local Rating = Instance.new("TextLabel")
    Rating.Size = UDim2.new(0, 110, 0, 20)
    Rating.Position = UDim2.new(1, -120, 0, 12)
    Rating.BackgroundTransparency = 1
    Rating.Text = scriptData.Rating
    Rating.TextColor3 = Colors.Warning
    Rating.TextSize = isMobile and 10 or 11
    Rating.Font = Enum.Font.Gotham
    Rating.TextXAlignment = Enum.TextXAlignment.Right
    Rating.Parent = Card
    
    -- Description
    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(1, -60, 0, 28)
    Desc.Position = UDim2.new(0, 52, 0, 36)
    Desc.BackgroundTransparency = 1
    Desc.Text = scriptData.Description
    Desc.TextColor3 = Colors.TextSecondary
    Desc.TextSize = isMobile and 10 or 11
    Desc.Font = Enum.Font.Gotham
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextWrapped = true
    Desc.Parent = Card
    
    -- Category Badge
    local CatBadge = Instance.new("Frame")
    CatBadge.Size = UDim2.new(0, 70, 0, 22)
    CatBadge.Position = UDim2.new(0, 52, 0, 72)
    CatBadge.BackgroundColor3 = scriptData.Category == "Free" and Colors.Success or 
                                 scriptData.Category == "Premium" and Colors.Warning or 
                                 scriptData.Category == "Admin" and Colors.Accent or
                                 scriptData.Category == "Tools" and Color3.fromRGB(138, 121, 255) or
                                 scriptData.Category == "Visual" and Color3.fromRGB(255, 121, 198) or
                                 Colors.TextSecondary
    CatBadge.BorderSizePixel = 0
    CatBadge.Parent = Card
    
    local CatCorner = Instance.new("UICorner")
    CatCorner.CornerRadius = UDim.new(0, 5)
    CatCorner.Parent = CatBadge
    
    local CatLbl = Instance.new("TextLabel")
    CatLbl.Size = UDim2.new(1, 0, 1, 0)
    CatLbl.BackgroundTransparency = 1
    CatLbl.Text = scriptData.Category
    CatLbl.TextColor3 = Colors.Text
    CatLbl.TextSize = isMobile and 9 or 10
    CatLbl.Font = Enum.Font.GothamBold
    CatLbl.Parent = CatBadge
    
    -- Key Badge
    local KeyBadge = Instance.new("Frame")
    KeyBadge.Size = UDim2.new(0, 85, 0, 22)
    KeyBadge.Position = UDim2.new(0, 128, 0, 72)
    KeyBadge.BackgroundColor3 = scriptData.RequiresKey and Colors.Danger or Colors.Success
    KeyBadge.BorderSizePixel = 0
    KeyBadge.Parent = Card
    
    local KeyCorner = Instance.new("UICorner")
    KeyCorner.CornerRadius = UDim.new(0, 5)
    KeyCorner.Parent = KeyBadge
    
    local KeyLbl = Instance.new("TextLabel")
    KeyLbl.Size = UDim2.new(1, 0, 1, 0)
    KeyLbl.BackgroundTransparency = 1
    KeyLbl.Text = scriptData.RequiresKey and "🔐 Key" or "✓ No Key"
    KeyLbl.TextColor3 = Colors.Text
    KeyLbl.TextSize = isMobile and 9 or 10
    KeyLbl.Font = Enum.Font.GothamBold
    KeyLbl.Parent = KeyBadge
    
    -- Execute Button
    local ExecBtn = Instance.new("TextButton")
    ExecBtn.Size = UDim2.new(0, isMobile and 110 or 120, 0, 38)
    ExecBtn.Position = UDim2.new(1, isMobile and -120 or -130, 0.5, 10)
    ExecBtn.BackgroundColor3 = Colors.Accent
    ExecBtn.Text = "▶ STARTEN"
    ExecBtn.TextColor3 = Colors.Text
    ExecBtn.TextSize = isMobile and 11 or 13
    ExecBtn.Font = Enum.Font.GothamBold
    ExecBtn.BorderSizePixel = 0
    ExecBtn.Parent = Card
    
    local ExecBtnCorner = Instance.new("UICorner")
    ExecBtnCorner.CornerRadius = UDim.new(0, 8)
    ExecBtnCorner.Parent = ExecBtn
    
    local ExecBtnGradient = Instance.new("UIGradient")
    ExecBtnGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(108, 121, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(88, 101, 242))
    }
    ExecBtnGradient.Rotation = 90
    ExecBtnGradient.Parent = ExecBtn
    
    ExecBtn.MouseButton1Click:Connect(function()
        -- Visual Feedback
        ExecBtn.Text = "⏳ Laden..."
        ExecBtn.BackgroundColor3 = Colors.Warning
        
        ExecuteScript(scriptData)
        
        task.wait(1)
        ExecBtn.Text = "▶ STARTEN"
        ExecBtn.BackgroundColor3 = Colors.Accent
    end)
    
    -- Hover Effects
    ExecBtn.MouseEnter:Connect(function()
        TweenService:Create(ExecBtn, TweenInfo.new(0.2), {
            Size = UDim2.new(0, isMobile and 115 or 125, 0, 38),
            BackgroundColor3 = Color3.fromRGB(108, 121, 255)
        }):Play()
    end)
    
    ExecBtn.MouseLeave:Connect(function()
        TweenService:Create(ExecBtn, TweenInfo.new(0.2), {
            Size = UDim2.new(0, isMobile and 110 or 120, 0, 38),
            BackgroundColor3 = Colors.Accent
        }):Play()
    end)
    
    -- Card Hover Effect
    Card.MouseEnter:Connect(function()
        TweenService:Create(CardStroke, TweenInfo.new(0.2), {
            Transparency = 0.3
        }):Play()
    end)
    
    Card.MouseLeave:Connect(function()
        TweenService:Create(CardStroke, TweenInfo.new(0.2), {
            Transparency = 0.8
        }):Play()
    end)
end

-- Load Game Scripts
local currentGame = nil

local function LoadGameScripts(gameName, gameData)
    print("📂 Loading scripts for: " .. gameName)
    
    -- Clear container
    for _, child in ipairs(ScriptsContainer:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    -- Reset selection
    SelectedScripts = {}
    SelectedCounter.Text = "📋 0 ausgewählt"
    
    -- Create cards
    for index, scriptData in ipairs(gameData.Scripts) do
        CreateScriptCard(scriptData, index)
        task.wait(0.02) -- Smooth loading animation
    end
    
    currentGame = gameName
    print("✓ " .. #gameData.Scripts .. " scripts loaded")
end

-- Create Game Buttons
print("🎮 Creating game buttons...")
local gameCount = 0
for gameName, gameData in pairs(ScriptDatabase) do
    gameCount = gameCount + 1
    
    local GameBtn = Instance.new("TextButton")
    GameBtn.Size = UDim2.new(0, isMobile and 160 or 190, 0, 45)
    GameBtn.BackgroundColor3 = Colors.Secondary
    GameBtn.BorderSizePixel = 0
    GameBtn.Parent = GameScrollFrame
    
    local GCorner = Instance.new("UICorner")
    GCorner.CornerRadius = UDim.new(0, 10)
    GCorner.Parent = GameBtn
    
    local GStroke = Instance.new("UIStroke")
    GStroke.Color = Colors.Accent
    GStroke.Thickness = 1.5
    GStroke.Transparency = 0.7
    GStroke.Parent = GameBtn
    
    local GGradient = Instance.new("UIGradient")
    GGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 38, 55)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 45))
    }
    GGradient.Rotation = 90
    GGradient.Parent = GameBtn
    
    -- Button Content
    local BtnIcon = Instance.new("TextLabel")
    BtnIcon.Size = UDim2.new(0, 35, 1, 0)
    BtnIcon.Position = UDim2.new(0, 5, 0, 0)
    BtnIcon.BackgroundTransparency = 1
    BtnIcon.Text = gameData.Icon
    BtnIcon.TextSize = 24
    BtnIcon.Font = Enum.Font.GothamBold
    BtnIcon.Parent = GameBtn
    
    local BtnText = Instance.new("TextLabel")
    BtnText.Size = UDim2.new(1, -45, 1, 0)
    BtnText.Position = UDim2.new(0, 40, 0, 0)
    BtnText.BackgroundTransparency = 1
    
    local displayName = gameName
    local maxLen = isMobile and 12 or 16
    if #displayName > maxLen then
        displayName = displayName:sub(1, maxLen) .. "..."
    end
    
    BtnText.Text = displayName
    BtnText.TextColor3 = Colors.Text
    BtnText.TextSize = isMobile and 11 or 13
    BtnText.Font = Enum.Font.GothamBold
    BtnText.TextXAlignment = Enum.TextXAlignment.Left
    BtnText.Parent = GameBtn
    
    -- Script Count Badge
    local CountBadge = Instance.new("Frame")
    CountBadge.Size = UDim2.new(0, 28, 0, 18)
    CountBadge.Position = UDim2.new(1, -32, 0, 4)
    CountBadge.BackgroundColor3 = Colors.Accent
    CountBadge.BorderSizePixel = 0
    CountBadge.Parent = GameBtn
    
    local CBCorner = Instance.new("UICorner")
    CBCorner.CornerRadius = UDim.new(0, 4)
    CBCorner.Parent = CountBadge
    
    local CountLabel = Instance.new("TextLabel")
    CountLabel.Size = UDim2.new(1, 0, 1, 0)
    CountLabel.BackgroundTransparency = 1
    CountLabel.Text = tostring(#gameData.Scripts)
    CountLabel.TextColor3 = Colors.Text
    CountLabel.TextSize = 10
    CountLabel.Font = Enum.Font.GothamBold
    CountLabel.Parent = CountBadge
    
    -- Button Click
    GameBtn.MouseButton1Click:Connect(function()
        -- Reset all buttons
        for _, btn in ipairs(GameScrollFrame:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = Colors.Secondary
                local stroke = btn:FindFirstChild("UIStroke")
                if stroke then stroke.Transparency = 0.7 end
            end
        end
        
        -- Highlight this button
        GameBtn.BackgroundColor3 = Colors.Accent
        GStroke.Transparency = 0
        
        LoadGameScripts(gameName, gameData)
    end)
    
    -- Hover Effects
    GameBtn.MouseEnter:Connect(function()
        if GameBtn.BackgroundColor3 ~= Colors.Accent then
            TweenService:Create(GameBtn, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(40, 40, 55)
            }):Play()
            TweenService:Create(GStroke, TweenInfo.new(0.2), {
                Transparency = 0.4
            }):Play()
        end
    end)
    
    GameBtn.MouseLeave:Connect(function()
        if GameBtn.BackgroundColor3 ~= Colors.Accent then
            TweenService:Create(GameBtn, TweenInfo.new(0.2), {
                BackgroundColor3 = Colors.Secondary
            }):Play()
            TweenService:Create(GStroke, TweenInfo.new(0.2), {
                Transparency = 0.7
            }):Play()
        end
    end)
    
    print("✓ Game button: " .. gameName)
end

-- Update canvas size for horizontal scroll
GameScrollFrame.CanvasSize = UDim2.new(0, GameLayout.AbsoluteContentSize.X + 10, 0, 0)

GameLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    GameScrollFrame.CanvasSize = UDim2.new(0, GameLayout.AbsoluteContentSize.X + 10, 0, 0)
end)

-- Execute All Button
ExecuteAllBtn.MouseButton1Click:Connect(function()
    if #SelectedScripts == 0 then
        StarterGui:SetCore("SendNotification", {
            Title = "⚠️ Keine Auswahl";
            Text = "Bitte wähle mindestens ein Script aus!";
            Duration = 3;
        })
        return
    end
    
    ExecuteAllBtn.Text = "⏳ Wird ausgeführt..."
    ExecuteAllBtn.BackgroundColor3 = Colors.Warning
    
    for i, scriptData in ipairs(SelectedScripts) do
        ExecuteScript(scriptData)
        task.wait(0.8)
    end
    
    task.wait(1)
    ExecuteAllBtn.Text = "▶ ALLE STARTEN"
    ExecuteAllBtn.BackgroundColor3 = Colors.Success
end)

ExecuteAllBtn.MouseEnter:Connect(function()
    TweenService:Create(ExecuteAllBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(87, 201, 149)
    }):Play()
end)

ExecuteAllBtn.MouseLeave:Connect(function()
    TweenService:Create(ExecuteAllBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Colors.Success
    }):Play()
end)

-- Clear Button
ClearBtn.MouseButton1Click:Connect(function()
    if #SelectedScripts == 0 then return end
    
    for _, card in ipairs(ScriptsContainer:GetChildren()) do
        if card:IsA("Frame") then
            local checkFrame = card:FindFirstChild("CheckFrame")
            if checkFrame then
                local checkMark = checkFrame:FindFirstChild("CheckMark")
                local checkBtn = checkFrame:FindFirstChild("CheckBtn")
                if checkMark and checkMark.Visible and checkBtn then
                    checkBtn.MouseButton1Click:Fire()
                end
            end
        end
    end
    
    StarterGui:SetCore("SendNotification", {
        Title = "✓ Gelöscht";
        Text = "Alle Auswahlen wurden entfernt";
        Duration = 2;
    })
end)

ClearBtn.MouseEnter:Connect(function()
    TweenService:Create(ClearBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 86, 89)
    }):Play()
end)

ClearBtn.MouseLeave:Connect(function()
    TweenService:Create(ClearBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Colors.Danger
    }):Play()
end)

print("✓ Buttons connected")

-- FLOATING BUTTON
local FloatingButton = Instance.new("Frame")
FloatingButton.Name = "FloatingButton"
FloatingButton.Size = UDim2.new(0, 60, 0, 60)
FloatingButton.Position = UDim2.new(1, -75, isMobile and 0.88 or 0.5, isMobile and -30 or -30)
FloatingButton.BackgroundColor3 = Colors.Accent
FloatingButton.BorderSizePixel = 0
FloatingButton.Active = true
FloatingButton.ZIndex = 10000
FloatingButton.Parent = ScreenGui

local FloatCorner = Instance.new("UICorner")
FloatCorner.CornerRadius = UDim.new(1, 0)
FloatCorner.Parent = FloatingButton

local FloatStroke = Instance.new("UIStroke")
FloatStroke.Color = Color3.fromRGB(255, 255, 255)
FloatStroke.Thickness = 2
FloatStroke.Transparency = 0.8
FloatStroke.Parent = FloatingButton

local FloatGlow = Instance.new("ImageLabel")
FloatGlow.Size = UDim2.new(1.4, 0, 1.4, 0)
FloatGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
FloatGlow.AnchorPoint = Vector2.new(0.5, 0.5)
FloatGlow.BackgroundTransparency = 1
FloatGlow.Image = "rbxassetid://5028857084"
FloatGlow.ImageColor3 = Colors.Accent
FloatGlow.ImageTransparency = 0.7
FloatGlow.ScaleType = Enum.ScaleType.Slice
FloatGlow.SliceCenter = Rect.new(24, 24, 276, 276)
FloatGlow.ZIndex = -1
FloatGlow.Parent = FloatingButton

local FloatBtn = Instance.new("TextButton")
FloatBtn.Size = UDim2.new(1, 0, 1, 0)
FloatBtn.BackgroundTransparency = 1
FloatBtn.Text = "🎮"
FloatBtn.TextSize = 32
FloatBtn.Font = Enum.Font.GothamBold
FloatBtn.TextColor3 = Colors.Text
FloatBtn.Parent = FloatingButton

-- Floating Button Pulse Animation
task.spawn(function()
    while FloatingButton and FloatingButton.Parent do
        TweenService:Create(FloatingButton, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Size = UDim2.new(0, 66, 0, 66)
        }):Play()
        TweenService:Create(FloatGlow, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            ImageTransparency = 0.5
        }):Play()
        task.wait(1.8)
        TweenService:Create(FloatingButton, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Size = UDim2.new(0, 60, 0, 60)
        }):Play()
        TweenService:Create(FloatGlow, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            ImageTransparency = 0.7
        }):Play()
        task.wait(1.8)
    end
end)

-- Rainbow Glow Effect
task.spawn(function()
    local hue = 0
    while FloatGlow and FloatGlow.Parent do
        hue = (hue + 1) % 360
        FloatGlow.ImageColor3 = Color3.fromHSV(hue/360, 0.8, 1)
        FloatingButton.BackgroundColor3 = Color3.fromHSV(hue/360, 0.7, 0.95)
        task.wait(0.05)
    end
end)

FloatBtn.MouseButton1Click:Connect(function()
    UIVisible = not UIVisible
    
    if UIVisible then
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
            Size = isMobile and UDim2.new(0.92, 0, 0.82, 0) or UDim2.new(0, 850, 0, 550)
        }):Play()
        
        FloatBtn.Text = "🎮"
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        
        task.wait(0.3)
        MainFrame.Visible = false
        FloatBtn.Text = "👁️"
    end
    
    StarterGui:SetCore("SendNotification", {
        Title = UIVisible and "✓ Menu Geöffnet" or "✗ Menu Geschlossen";
        Text = UIVisible and "Viel Spaß beim Scripten!" or "Klicke den Button zum Öffnen";
        Duration = 2;
    })
end)

-- Floating Button Draggable
local floatDrag = false
local floatInput, floatMousePos, floatFramePos

FloatingButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        floatDrag = true
        floatMousePos = input.Position
        floatFramePos = FloatingButton.Position
        
        FloatingButton.BackgroundColor3 = Colors.Success
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                floatDrag = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and floatDrag then
        local delta = input.Position - floatMousePos
        FloatingButton.Position = UDim2.new(
            floatFramePos.X.Scale,
            floatFramePos.X.Offset + delta.X,
            floatFramePos.Y.Scale,
            floatFramePos.Y.Offset + delta.Y
        )
    end
end)

print("✓ Floating Button erstellt")

-- Main Frame Draggable (PC only)
if not isMobile then
    local dragging = false
    local dragInput, mousePos, framePos
    
    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - mousePos
            MainFrame.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)
    
    print("✓ Drag & Drop aktiviert")
end

-- Keybind (PC only)
if not isMobile then
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
            FloatBtn.MouseButton1Click:Fire()
        end
    end)
    print("✓ Keybind: RightControl")
end

-- Add ScreenGui to PlayerGui
ScreenGui.Parent = PlayerGui

print("✓ GUI zu PlayerGui hinzugefügt")

-- Load first game automatically
task.wait(0.5)
local firstGame = next(ScriptDatabase)
if firstGame then
    local firstButton = GameScrollFrame:GetChildren()[2] -- Skip UIListLayout
    if firstButton and firstButton:IsA("TextButton") then
        firstButton.MouseButton1Click:Fire()
        print("✓ Erstes Spiel automatisch geladen: " .. firstGame)
    end
end

-- Welcome Notification
StarterGui:SetCore("SendNotification", {
    Title = "✅ Power Off Loader v2.1";
    Text = "Erfolgreich geladen! " .. (isMobile and "📱 Mobile Mode" or "💻 RightCtrl = Toggle");
    Duration = 5;
})

-- Final Success Messages
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("✅ POWER OFF LOADER V2.1 ERFOLGREICH GELADEN!")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("📱 Device: " .. (isMobile and "Mobile" or "Desktop"))
print("🎮 Spiele: " .. gameCount)
print("🛡️ Anti-AFK: Aktiv")
print("🔘 Floating Button: Zum Öffnen/Schließen klicken")
if not isMobile then
    print("⌨️ Keybind: RightControl")
end
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🚀 Viel Spaß beim Scripten!")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
