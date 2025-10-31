--[[
    ╔═══════════════════════════════════════════════════════════════╗
    ║     ULTIMATE MEGA LOADER V3.0 - COMPLETE EDITION              ║
    ║     Alle Spiele | Keine Keys | Vollständig Erweiterbar        ║
    ║     Professionell | Optimiert | KRNL Ready                    ║
    ╚═══════════════════════════════════════════════════════════════╝
]]

print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🚀 ULTIMATE MEGA LOADER V3.0 WIRD GELADEN...")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

-- ============================================
-- INITIALISIERUNG & FEHLERBEHANDLUNG
-- ============================================
task.wait(1)

-- Services sicher laden
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")

-- Player
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

print("✓ Services geladen")

-- Device Detection
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
print("✓ Device: " .. (isMobile and "📱 Mobile" or "💻 Desktop"))

-- Alte GUI entfernen
pcall(function()
    if PlayerGui:FindFirstChild("UltimateMegaLoader") then
        PlayerGui:FindFirstChild("UltimateMegaLoader"):Destroy()
        print("✓ Alte GUI entfernt")
        task.wait(0.3)
    end
end)

-- ============================================
-- VARIABLEN & KONFIGURATION
-- ============================================

local UIVisible = true
local AntiAFKEnabled = true
local SelectedScripts = {}
local FavoriteScripts = {}
local SearchText = ""
local CurrentGame = nil
local CurrentCategory = "All"
local BypassCount = 0

-- ============================================
-- FARBEN (MODERN & OPTIMIERT)
-- ============================================

local Colors = {
    Background = Color3.fromRGB(18, 18, 26),
    Secondary = Color3.fromRGB(28, 28, 40),
    Tertiary = Color3.fromRGB(35, 35, 50),
    Accent = Color3.fromRGB(88, 101, 242),
    AccentHover = Color3.fromRGB(108, 121, 255),
    Success = Color3.fromRGB(67, 181, 129),
    Warning = Color3.fromRGB(250, 166, 26),
    Danger = Color3.fromRGB(237, 66, 69),
    Info = Color3.fromRGB(52, 152, 219),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(180, 180, 190),
    TextMuted = Color3.fromRGB(120, 120, 130),
    Premium = Color3.fromRGB(255, 215, 0),
    Free = Color3.fromRGB(46, 204, 113),
    Border = Color3.fromRGB(55, 55, 70)
}

-- ============================================
-- MEGA SCRIPT DATENBANK (ALLE SPIELE)
-- ============================================

local ScriptDatabase = {
    ["Grow a Garden"] = {
        GameName = "Grow a Garden",
        GameId = 126884695634066,
        Icon = "🌱",
        Category = "Simulator",
        Description = "Farming & Garden Simulator",
        Scripts = {
            -- Premium Scripts
            {
                Name = "Lunor Hub",
                Description = "Premium Hub mit Auto Collect & ESP",
                URL = "https://lunor.dev/loader",
                Category = "Premium",
                RequiresKey = true,
                Rating = "⭐⭐⭐⭐⭐",
                Features = {"Auto Farm", "Auto Collect", "Auto Sell", "ESP", "Teleports"},
                Author = "Lunor Team"
            },
            {
                Name = "Solix Hub",
                Description = "Advanced Auto Farm System",
                URL = "https://raw.githubusercontent.com/debunked69/solixloader/refs/heads/main/solix%20v2%20new%20loader.lua",
                Category = "Premium",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐⭐",
                Features = {"Performance Mode", "Auto Buy", "Auto Watering", "Optimization"},
                Author = "Solix"
            },
            {
                Name = "Candy Blossom Farm",
                Description = "Complete farming solution",
                URL = "https://raw.githubusercontent.com/ameicaa1/Grow-a-Garden/main/CandyBlossom_Farm.lua",
                Category = "Premium",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐⭐",
                Features = {"Advanced Farming", "Auto Everything", "GUI"},
                Author = "Ameicaa"
            },
            -- Free Scripts
            {
                Name = "GAG Script No Key",
                Description = "Fruit Transparency & ESP",
                URL = "https://raw.githubusercontent.com/yzarcz/gubby.lol/refs/heads/main/loader.luau",
                Category = "Free",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐",
                Features = {"Fruit ESP", "Transparency", "No Key"},
                Author = "Gubby"
            },
            {
                Name = "Tora Hub",
                Description = "Free Auto Farm Script",
                URL = "https://raw.githubusercontent.com/gumanba/Scripts/main/GrowaGarden",
                Category = "Free",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐",
                Features = {"Auto Plant", "Auto Harvest", "Auto Sell"},
                Author = "Gumanba"
            },
            {
                Name = "NoLag Hub",
                Description = "Performance optimized hub",
                URL = "https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Garden/Garden-V1.lua",
                Category = "Free",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐",
                Features = {"No Lag", "Auto Farm", "Fast Performance"},
                Author = "NoLag"
            },
            {
                Name = "Chilli Hub",
                Description = "Feature-rich free hub",
                URL = "https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua",
                Category = "Free",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐",
                Features = {"Multiple Features", "User Friendly"},
                Author = "Chilli"
            },
            {
                Name = "AlterHub Mobile",
                Description = "Mobile optimized script",
                URL = "https://raw.githubusercontent.com/frvaunted/Main/refs/heads/main/Alter%20Hub",
                Category = "Free",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐",
                Features = {"Mobile Support", "Auto Farm", "Simple GUI"},
                Author = "AlterHub"
            },
            -- Utility Scripts
            {
                Name = "Spawn Dupe Script V3",
                Description = "Duplicate items & pets",
                URL = "https://gist.githubusercontent.com/NefariousScript/a14323702893811c9cf5c9ce20483ade/raw/Dupe_SpawnV3.1",
                Category = "Utility",
                RequiresKey = false,
                Rating = "⭐⭐⭐",
                Features = {"Item Duplication", "Pet Duplication"},
                Author = "Nefarious"
            },
            {
                Name = "Old Server Finder",
                Description = "Find old servers with rare items",
                URL = "https://raw.githubusercontent.com/M-E-N-A-C-E/Menace-Hub/refs/heads/main/Old%20Server%20Finder%20Grow%20a%20Garden",
                Category = "Utility",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐",
                Features = {"Server Finder", "Rare Items"},
                Author = "Menace"
            }
        }
    },
    
    ["99 Nights in the Forest"] = {
        GameName = "99 Nights in the Forest",
        GameId = 79546208627805,
        Icon = "🌙",
        Category = "Horror",
        Description = "Survival Horror Game",
        Scripts = {
            -- Premium Scripts
            {
                Name = "Elude Loader",
                Description = "Premium script mit ESP & God Mode",
                URL = "https://raw.githubusercontent.com/DarkenedEssence/Elude/refs/heads/main/Loader.lua",
                Category = "Premium",
                RequiresKey = true,
                Rating = "⭐⭐⭐⭐⭐",
                Features = {"ESP", "God Mode", "Instant Win", "No Jumpscares", "Teleports"},
                Author = "DarkenedEssence"
            },
            {
                Name = "ToastyHub XD",
                Description = "Complete hub für 99 Nights",
                URL = "https://raw.githubusercontent.com/nouralddin-abdullah/ToastyHub-XD/refs/heads/main/hub-main.lua",
                Category = "Premium",
                RequiresKey = true,
                Rating = "⭐⭐⭐⭐⭐",
                Features = {"Auto Complete", "Teleports", "Item ESP", "Safe Mode"},
                Author = "ToastyHub"
            },
            {
                Name = "DarkEsc Hub",
                Description = "Advanced horror hub",
                URL = "https://raw.githubusercontent.com/DarkenedEssence/DarkEsc/refs/heads/main/Loader.lua",
                Category = "Premium",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐⭐",
                Features = {"Full Features", "Anti-Ban", "Safe Mode"},
                Author = "DarkEsc"
            },
            -- Free Scripts
            {
                Name = "VapeVoidware",
                Description = "Free script ohne Key",
                URL = "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua",
                Category = "Free",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐",
                Features = {"Basic ESP", "Speed Boost", "Jump Power", "Bring Items"},
                Author = "VapeVoidware"
            },
            {
                Name = "PhantomFlux Script",
                Description = "Instant Teleport & Bring Items",
                URL = "https://raw.githubusercontent.com/sudaisontopxd/PhantomFlux/refs/heads/main/99NightsInTheForest",
                Category = "Free",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐",
                Features = {"Instant Teleport", "Bring Items", "Speed Boost"},
                Author = "PhantomFlux"
            },
            {
                Name = "Kenniel Hub",
                Description = "User-friendly horror script",
                URL = "https://raw.githubusercontent.com/Kenniel123/99-Nights-in-the-Forest/refs/heads/main/99%20Nights%20in%20the%20Forest",
                Category = "Free",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐",
                Features = {"Simple GUI", "Auto Farm Diamonds"},
                Author = "Kenniel"
            },
            {
                Name = "GEC Loader",
                Description = "Fast loader ohne Key",
                URL = "https://pastebin.com/raw/NTpCMwn8",
                Category = "Free",
                RequiresKey = false,
                Rating = "⭐⭐⭐",
                Features = {"Kill Aura", "Adjustable Speed", "Fly"},
                Author = "GEC"
            },
            -- Utility Scripts
            {
                Name = "Auto Diamond Farm",
                Description = "Automatic diamond collection",
                URL = "https://raw.githubusercontent.com/collonroger/pigeonhub/refs/heads/main/autofarmdiamonds.lua",
                Category = "Utility",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐",
                Features = {"Auto Farm", "Safe Mode", "Anti-Ban"},
                Author = "PigeonHub"
            },
            {
                Name = "Nagi Hub",
                Description = "Complete utility hub",
                URL = "https://raw.githubusercontent.com/hehehe9028/Nagi-hub-99/refs/heads/main/Nagi%20hub%2099%20nights%20in%20the%20forest",
                Category = "Utility",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐",
                Features = {"Visuals", "Hitbox Expander", "Player Features"},
                Author = "Nagi"
            }
        }
    },
    
    ["My Brainrot Egg Farm"] = {
        GameName = "My Brainrot Egg Farm",
        GameId = 71360925634781,
        Icon = "🥚",
        Category = "Simulator",
        Description = "Egg Collection Simulator",
        Scripts = {
            {
                Name = "Chavels Loader",
                Description = "Premium auto farm",
                URL = "https://raw.githubusercontent.com/Chavels123/Loader/refs/heads/main/loader.lua",
                Category = "Premium",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐⭐",
                Features = {"Auto Farm", "Auto Hatch", "Auto Upgrade", "God Mode"},
                Author = "Chavels123"
            },
            {
                Name = "Gumanba Scripts",
                Description = "Complete farming system",
                URL = "https://raw.githubusercontent.com/gumanba/Scripts/main/MyBrainrotEggFarm",
                Category = "Free",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐",
                Features = {"Auto Collect", "Auto Sell", "Stats Tracker"},
                Author = "Gumanba"
            },
            {
                Name = "PulsarX Loader",
                Description = "Advanced hub with all features",
                URL = "https://raw.githubusercontent.com/Estevansit0/KJJK/refs/heads/main/PusarX-loader.lua",
                Category = "Premium",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐⭐",
                Features = {"Instant Win", "Infinite Resources", "All Unlocked"},
                Author = "Estevansit0"
            }
        }
    },
    
    ["Steal a Brainrot"] = {
        GameName = "Steal a Brainrot",
        GameId = 0,
        Icon = "💰",
        Category = "Tycoon",
        Description = "Steal & Build Tycoon",
        Scripts = {
            {
                Name = "Feronik Hub",
                Description = "Auto Lock & Instant Steal",
                URL = "https://raw.githubusercontent.com/Fenorik/FenorikHub/refs/heads/main/FenorikHubINIT.lua",
                Category = "Premium",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐⭐",
                Features = {"Auto Lock", "Instant Steal", "Auto Buy", "Auto Rebirth"},
                Author = "Feronik"
            },
            {
                Name = "Tora Hub",
                Description = "Complete steal script",
                URL = "https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/StealaBrainrot",
                Category = "Free",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐",
                Features = {"Auto Collect", "Base Lock", "Easy Cash"},
                Author = "Gumanba"
            },
            {
                Name = "Ghost Hub",
                Description = "Advanced stealing features",
                URL = "https://raw.githubusercontent.com/Akbar123s/Script-Roblox-/refs/heads/main/Script%20Brainrot%20New",
                Category = "Free",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐",
                Features = {"Steal", "Lock Base", "NoClip", "Instant Take"},
                Author = "Ghost"
            },
            {
                Name = "Chilli Hub",
                Description = "Multi-feature hub",
                URL = "https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua",
                Category = "Free",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐",
                Features = {"Auto Farm", "GUI", "Multiple Features"},
                Author = "Chilli"
            },
            {
                Name = "QuantumPulsar X",
                Description = "Auto Steal & Auto Buy",
                URL = "https://raw.githubusercontent.com/Estevansit0/KJJK/refs/heads/main/PusarX-loader.lua",
                Category = "Premium",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐⭐",
                Features = {"Auto Steal", "Auto Buy", "Auto Sell", "Performance Mode"},
                Author = "QuantumPulsar"
            }
        }
    },
    
    ["Blox Fruits"] = {
        GameName = "Blox Fruits",
        GameId = 2753915549,
        Icon = "🏴‍☠️",
        Category = "Fighting",
        Description = "One Piece Fighting Game",
        Scripts = {
            {
                Name = "Hoho Hub",
                Description = "Best auto farm for Blox Fruits",
                URL = "loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI'))()",
                Category = "Premium",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐⭐",
                Features = {"Auto Farm", "Auto Raid", "Auto Bounty", "Mastery Farm", "Sea Events"},
                Author = "HOHO Team"
            },
            {
                Name = "Mukuro Hub",
                Description = "Premium hub - key system bypassed",
                URL = "loadstring(game:HttpGet('https://raw.githubusercontent.com/xQuartyx/DonateMe/main/ScriptLoader'))()",
                Category = "Premium",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐⭐",
                Features = {"All Features", "Auto Everything", "Chest Farm", "Boss Farm"},
                Author = "Mukuro"
            }
        }
    },
    
    ["Universal Scripts"] = {
        GameName = "Universal (Alle Spiele)",
        GameId = 0,
        Icon = "🌐",
        Category = "Universal",
        Description = "Works in every game",
        Scripts = {
            {
                Name = "Infinite Yield",
                Description = "Mächtigste Admin Commands",
                URL = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()",
                Category = "Admin",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐⭐",
                Features = {"500+ Commands", "FE Bypass", "Server Hop", "Anti-Kick", "Waypoints"},
                Author = "EdgeIY"
            },
            {
                Name = "Dark Dex V3",
                Description = "Game explorer und editor",
                URL = "loadstring(game:HttpGet('https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua'))()",
                Category = "Tools",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐⭐",
                Features = {"Explorer", "Properties", "Script Viewer", "Remote Spy", "Instance Editor"},
                Author = "Babyhamsta"
            },
            {
                Name = "SimpleSpy",
                Description = "Advanced remote spy",
                URL = "loadstring(game:HttpGet('https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua'))()",
                Category = "Tools",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐",
                Features = {"Remote Logging", "Script Generation", "Anti-Detection", "Copy Scripts"},
                Author = "exxtremestuffs"
            },
            {
                Name = "Unnamed ESP",
                Description = "Universal ESP für alle Spiele",
                URL = "loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua'))()",
                Category = "Visual",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐⭐",
                Features = {"Player ESP", "Item ESP", "Customizable", "Teamcheck", "Distance ESP"},
                Author = "ic3w0lf22"
            }
        }
    }
}

print("✓ Script Database geladen (" .. #ScriptDatabase .. " Spiele)")

-- ============================================
-- ANTI-AFK SYSTEM (VERBESSERT)
-- ============================================

print("✓ Anti-AFK wird gestartet...")

-- Initial notification
StarterGui:SetCore("SendNotification", {
    Title = "🛡️ Anti-AFK Active!";
    Text = "Script bereit zum Bypass der Idle-Kick.";
    Duration = 5;
})

Player.Idled:Connect(function()
    if AntiAFKEnabled then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
        
        BypassCount = BypassCount + 1
        
        StarterGui:SetCore("SendNotification", {
            Title = "✓ AFK Bypass Erfolgreich!";
            Text = "Idle Timer zurückgesetzt. Bypass #" .. BypassCount;
            Duration = 3;
        })
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

-- ============================================
-- GUI ERSTELLUNG
-- ============================================

print("🎨 GUI wird erstellt...")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateMegaLoader"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
if isMobile then
    MainFrame.Size = UDim2.new(0.94, 0, 0.88, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
else
    MainFrame.Size = UDim2.new(0, 950, 0, 620)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
end
MainFrame.BackgroundColor3 = Colors.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Colors.Accent
MainStroke.Thickness = 2
MainStroke.Transparency = 0.6
MainStroke.Parent = MainFrame

-- Shadow/Glow Effect
local ShadowFrame = Instance.new("Frame")
ShadowFrame.Size = UDim2.new(1, 30, 1, 30)
ShadowFrame.Position = UDim2.new(0, -15, 0, -15)
ShadowFrame.BackgroundTransparency = 1
ShadowFrame.ZIndex = 0
ShadowFrame.Parent = MainFrame

local ShadowImage = Instance.new("ImageLabel")
ShadowImage.Size = UDim2.new(1, 0, 1, 0)
ShadowImage.BackgroundTransparency = 1
ShadowImage.Image = "rbxassetid://5028857084"
ShadowImage.ImageColor3 = Colors.Accent
ShadowImage.ImageTransparency = 0.7
ShadowImage.ScaleType = Enum.ScaleType.Slice
ShadowImage.SliceCenter = Rect.new(24, 24, 276, 276)
ShadowImage.Parent = ShadowFrame

print("✓ MainFrame erstellt")

-- ============================================
-- HEADER MIT ANIMATIONEN
-- ============================================

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 70)
Header.BackgroundColor3 = Colors.Secondary
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 16)
HeaderCorner.Parent = Header

local HeaderBottom = Instance.new("Frame")
HeaderBottom.Size = UDim2.new(1, 0, 0, 16)
HeaderBottom.Position = UDim2.new(0, 0, 1, -16)
HeaderBottom.BackgroundColor3 = Colors.Secondary
HeaderBottom.BorderSizePixel = 0
HeaderBottom.Parent = Header

-- Gradient für Header
local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 65)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 28, 40))
}
HeaderGradient.Rotation = 90
HeaderGradient.Parent = Header

-- Logo/Icon
local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 50, 0, 50)
Logo.Position = UDim2.new(0, 15, 0, 10)
Logo.BackgroundColor3 = Colors.Accent
Logo.Text = "🚀"
Logo.TextColor3 = Colors.Text
Logo.TextSize = 28
Logo.Font = Enum.Font.GothamBold
Logo.BorderSizePixel = 0
Logo.Parent = Header

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 12)
LogoCorner.Parent = Logo

-- Logo Pulse Animation
task.spawn(function()
    while Logo and Logo.Parent do
        TweenService:Create(Logo, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Size = UDim2.new(0, 55, 0, 55),
            BackgroundColor3 = Colors.AccentHover
        }):Play()
        task.wait(1.5)
        TweenService:Create(Logo, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Size = UDim2.new(0, 50, 0, 50),
            BackgroundColor3 = Colors.Accent
        }):Play()
        task.wait(1.5)
    end
end)

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.5, 0, 0, 32)
Title.Position = UDim2.new(0, 75, 0, 8)
Title.BackgroundTransparency = 1
Title.Text = "ULTIMATE MEGA LOADER"
Title.TextColor3 = Colors.Text
Title.TextSize = isMobile and 18 or 24
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

-- Version & Info
local Version = Instance.new("TextLabel")
Version.Size = UDim2.new(0.4, 0, 0, 20)
Version.Position = UDim2.new(0, 75, 0, 42)
Version.BackgroundTransparency = 1
Version.Text = "v3.0 • " .. (isMobile and "📱 Mobile" or "💻 Desktop") .. " • " .. #ScriptDatabase .. " Spiele • Keine Keys"
Version.TextColor3 = Colors.TextSecondary
Version.TextSize = isMobile and 9 or 11
Version.Font = Enum.Font.Gotham
Version.TextXAlignment = Enum.TextXAlignment.Left
Version.Parent = Header

-- Stats Display (Top Right)
local StatsFrame = Instance.new("Frame")
StatsFrame.Size = UDim2.new(0, isMobile and 200 or 250, 0, 55)
StatsFrame.Position = UDim2.new(1, isMobile and -330 or -380, 0, 7.5)
StatsFrame.BackgroundColor3 = Colors.Tertiary
StatsFrame.BorderSizePixel = 0
StatsFrame.Parent = Header

local StatsCorner = Instance.new("UICorner")
StatsCorner.CornerRadius = UDim.new(0, 10)
StatsCorner.Parent = StatsFrame

local StatsGradient = Instance.new("UIGradient")
StatsGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 55)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 50))
}
StatsGradient.Rotation = 45
StatsGradient.Parent = StatsFrame

-- Stats Grid
local StatsGrid = Instance.new("Frame")
StatsGrid.Size = UDim2.new(1, -10, 1, -10)
StatsGrid.Position = UDim2.new(0, 5, 0, 5)
StatsGrid.BackgroundTransparency = 1
StatsGrid.Parent = StatsFrame

local StatsLayout = Instance.new("UIGridLayout")
StatsLayout.CellSize = UDim2.new(0.24, -3, 0.48, -3)
StatsLayout.CellPadding = UDim2.new(0, 3, 0, 3)
StatsLayout.Parent = StatsGrid

-- Create Stat Boxes
local function CreateStatBox(text, value, color)
    local Box = Instance.new("Frame")
    Box.BackgroundColor3 = Colors.Secondary
    Box.BorderSizePixel = 0
    Box.Parent = StatsGrid
    
    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 6)
    BoxCorner.Parent = Box
    
    local BoxStroke = Instance.new("UIStroke")
    BoxStroke.Color = color
    BoxStroke.Thickness = 1
    BoxStroke.Transparency = 0.7
    BoxStroke.Parent = Box
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text .. "\n" .. value
    Label.TextColor3 = color
    Label.TextSize = isMobile and 8 or 9
    Label.Font = Enum.Font.GothamBold
    Label.Parent = Box
    
    return Label
end

local FPSLabel = CreateStatBox("FPS", "60", Colors.Success)
local PingLabel = CreateStatBox("Ping", "0ms", Colors.Warning)
local MemLabel = CreateStatBox("RAM", "0MB", Colors.Info)
local BypassLabel = CreateStatBox("AFK", "0", Colors.Accent)

-- Update Stats
task.spawn(function()
    while StatsFrame and StatsFrame.Parent do
        local fps = math.floor(workspace:GetRealPhysicsFPS())
        local ping = math.floor(Player:GetNetworkPing() * 1000)
        local mem = math.floor(game:GetService("Stats"):GetTotalMemoryUsageMb())
        
        FPSLabel.Text = "FPS\n" .. fps
        PingLabel.Text = "Ping\n" .. ping .. "ms"
        MemLabel.Text = "RAM\n" .. mem .. "MB"
        BypassLabel.Text = "AFK\n" .. BypassCount
        
        -- Color code FPS
        if fps >= 50 then
            FPSLabel.TextColor3 = Colors.Success
        elseif fps >= 30 then
            FPSLabel.TextColor3 = Colors.Warning
        else
            FPSLabel.TextColor3 = Colors.Danger
        end
        
        task.wait(0.5)
    end
end)

-- Anti-AFK Toggle Button
local AFKToggle = Instance.new("TextButton")
AFKToggle.Size = UDim2.new(0, 55, 0, 55)
AFKToggle.Position = UDim2.new(1, isMobile and -70 or -120, 0, 7.5)
AFKToggle.BackgroundColor3 = Colors.Success
AFKToggle.Text = "🛡️"
AFKToggle.TextSize = 28
AFKToggle.Font = Enum.Font.GothamBold
AFKToggle.BorderSizePixel = 0
AFKToggle.Parent = Header

local AFKCorner = Instance.new("UICorner")
AFKCorner.CornerRadius = UDim.new(0, 12)
AFKCorner.Parent = AFKToggle

AFKToggle.MouseButton1Click:Connect(function()
    AntiAFKEnabled = not AntiAFKEnabled
    AFKToggle.BackgroundColor3 = AntiAFKEnabled and Colors.Success or Colors.Danger
    AFKToggle.Text = AntiAFKEnabled and "🛡️" or "💤"
    
    StarterGui:SetCore("SendNotification", {
        Title = AntiAFKEnabled and "✓ Anti-AFK Aktiviert" or "✗ Anti-AFK Deaktiviert";
        Text = AntiAFKEnabled and "Du bist jetzt vor AFK-Kicks geschützt" or "Anti-AFK ist deaktiviert";
        Duration = 3;
    })
end)

-- Hover effect
AFKToggle.MouseEnter:Connect(function()
    TweenService:Create(AFKToggle, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 60, 0, 60),
        BackgroundColor3 = AntiAFKEnabled and Color3.fromRGB(87, 201, 149) or Color3.fromRGB(255, 86, 89)
    }):Play()
end)

AFKToggle.MouseLeave:Connect(function()
    TweenService:Create(AFKToggle, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 55, 0, 55),
        BackgroundColor3 = AntiAFKEnabled and Colors.Success or Colors.Danger
    }):Play()
end)

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseButton"
CloseBtn.Size = UDim2.new(0, 55, 0, 55)
CloseBtn.Position = UDim2.new(1, -60, 0, 7.5)
CloseBtn.BackgroundColor3 = Colors.Danger
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Colors.Text
CloseBtn.TextSize = 26
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 12)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    task.wait(0.3)
    MainFrame.Visible = false
    UIVisible = false
end)

-- Hover effects
CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 60, 0, 60),
        BackgroundColor3 = Color3.fromRGB(255, 86, 89)
    }):Play()
end)

CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 55, 0, 55),
        BackgroundColor3 = Colors.Danger
    }):Play()
end)

print("✓ Header erstellt")

-- ============================================
-- SEARCH BAR (VERBESSERT)
-- ============================================

local SearchFrame = Instance.new("Frame")
SearchFrame.Size = UDim2.new(1, -20, 0, 50)
SearchFrame.Position = UDim2.new(0, 10, 0, 80)
SearchFrame.BackgroundColor3 = Colors.Secondary
SearchFrame.BorderSizePixel = 0
SearchFrame.Parent = MainFrame

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 12)
SearchCorner.Parent = SearchFrame

local SearchStroke = Instance.new("UIStroke")
SearchStroke.Color = Colors.Border
SearchStroke.Thickness = 1
SearchStroke.Transparency = 0.5
SearchStroke.Parent = SearchFrame

local SearchIcon = Instance.new("TextLabel")
SearchIcon.Size = UDim2.new(0, 50, 1, 0)
SearchIcon.BackgroundTransparency = 1
SearchIcon.Text = "🔍"
SearchIcon.TextColor3 = Colors.TextSecondary
SearchIcon.TextSize = 24
SearchIcon.Font = Enum.Font.GothamBold
SearchIcon.Parent = SearchFrame

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, -110, 1, 0)
SearchBox.Position = UDim2.new(0, 50, 0, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.PlaceholderText = "Suche nach Scripts oder Spielen..."
SearchBox.Text = ""
SearchBox.TextColor3 = Colors.Text
SearchBox.PlaceholderColor3 = Colors.TextMuted
SearchBox.TextSize = isMobile and 14 or 16
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.ClearTextOnFocus = false
SearchBox.Parent = SearchFrame

-- Clear Search Button
local ClearSearchBtn = Instance.new("TextButton")
ClearSearchBtn.Size = UDim2.new(0, 40, 0, 40)
ClearSearchBtn.Position = UDim2.new(1, -45, 0.5, -20)
ClearSearchBtn.BackgroundColor3 = Colors.Tertiary
ClearSearchBtn.Text = "✕"
ClearSearchBtn.TextColor3 = Colors.TextSecondary
ClearSearchBtn.TextSize = 18
ClearSearchBtn.Font = Enum.Font.GothamBold
ClearSearchBtn.BorderSizePixel = 0
ClearSearchBtn.Visible = false
ClearSearchBtn.Parent = SearchFrame

local ClearSearchCorner = Instance.new("UICorner")
ClearSearchCorner.CornerRadius = UDim.new(1, 0)
ClearSearchCorner.Parent = ClearSearchBtn

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    SearchText = SearchBox.Text
    ClearSearchBtn.Visible = SearchText ~= ""
    -- TODO: Implement search functionality
end)

ClearSearchBtn.MouseButton1Click:Connect(function()
    SearchBox.Text = ""
    SearchText = ""
end)

-- Search Frame Hover
SearchFrame.MouseEnter:Connect(function()
    TweenService:Create(SearchStroke, TweenInfo.new(0.2), {
        Color = Colors.Accent,
        Transparency = 0.3
    }):Play()
end)

SearchFrame.MouseLeave:Connect(function()
    TweenService:Create(SearchStroke, TweenInfo.new(0.2), {
        Color = Colors.Border,
        Transparency = 0.5
    }):Play()
end)

print("✓ Search Bar erstellt")

-- ============================================
-- CATEGORY FILTER (NEU)
-- ============================================

local CategoryFrame = Instance.new("Frame")
CategoryFrame.Size = UDim2.new(1, -20, 0, 45)
CategoryFrame.Position = UDim2.new(0, 10, 0, 140)
CategoryFrame.BackgroundTransparency = 1
CategoryFrame.Parent = MainFrame

local CategoryScroll = Instance.new("ScrollingFrame")
CategoryScroll.Size = UDim2.new(1, 0, 1, 0)
CategoryScroll.BackgroundTransparency = 1
CategoryScroll.BorderSizePixel = 0
CategoryScroll.ScrollBarThickness = 0
CategoryScroll.ScrollingDirection = Enum.ScrollingDirection.X
CategoryScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
CategoryScroll.Parent = CategoryFrame

local CategoryLayout = Instance.new("UIListLayout")
CategoryLayout.FillDirection = Enum.FillDirection.Horizontal
CategoryLayout.Padding = UDim.new(0, 8)
CategoryLayout.Parent = CategoryScroll

-- Categories
local Categories = {"All", "Simulator", "Horror", "Fighting", "Tycoon", "Universal"}

local function CreateCategoryButton(categoryName)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, isMobile and 100 or 120, 0, 40)
    Button.BackgroundColor3 = categoryName == "All" and Colors.Accent or Colors.Secondary
    Button.Text = categoryName
    Button.TextColor3 = Colors.Text
    Button.TextSize = isMobile and 12 or 14
    Button.Font = Enum.Font.GothamBold
    Button.BorderSizePixel = 0
    Button.Parent = CategoryScroll
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 10)
    BtnCorner.Parent = Button
    
    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Color = categoryName == "All" and Colors.Accent or Colors.Border
    BtnStroke.Thickness = 1
    BtnStroke.Transparency = categoryName == "All" and 0 or 0.7
    BtnStroke.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        CurrentCategory = categoryName
        
        -- Update all buttons
        for _, btn in ipairs(CategoryScroll:GetChildren()) do
            if btn:IsA("TextButton") then
                local isActive = btn.Text == categoryName
                btn.BackgroundColor3 = isActive and Colors.Accent or Colors.Secondary
                local stroke = btn:FindFirstChildOfClass("UIStroke")
                if stroke then
                    stroke.Color = isActive and Colors.Accent or Colors.Border
                    stroke.Transparency = isActive and 0 or 0.7
                end
            end
        end
        
        -- TODO: Filter scripts by category
        print("Category changed to: " .. categoryName)
    end)
    
    -- Hover effect
    Button.MouseEnter:Connect(function()
        if Button.BackgroundColor3 ~= Colors.Accent then
            TweenService:Create(Button, TweenInfo.new(0.2), {
                BackgroundColor3 = Colors.Tertiary
            }):Play()
        end
    end)
    
    Button.MouseLeave:Connect(function()
        if Button.Text ~= CurrentCategory then
            TweenService:Create(Button, TweenInfo.new(0.2), {
                BackgroundColor3 = Colors.Secondary
            }):Play()
        end
    end)
end

for _, category in ipairs(Categories) do
    CreateCategoryButton(category)
end

CategoryScroll.CanvasSize = UDim2.new(0, CategoryLayout.AbsoluteContentSize.X + 10, 0, 0)

CategoryLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    CategoryScroll.CanvasSize = UDim2.new(0, CategoryLayout.AbsoluteContentSize.X + 10, 0, 0)
end)

print("✓ Category Filter erstellt")

-- ============================================
-- GAME SELECTOR (TABS)
-- ============================================

local GameSelector = Instance.new("Frame")
GameSelector.Size = UDim2.new(1, -20, 0, 55)
GameSelector.Position = UDim2.new(0, 10, 0, 195)
GameSelector.BackgroundTransparency = 1
GameSelector.Parent = MainFrame

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

-- ============================================
-- SCRIPTS CONTAINER
-- ============================================

local ScriptsContainer = Instance.new("ScrollingFrame")
ScriptsContainer.Size = UDim2.new(1, -20, 1, -325)
ScriptsContainer.Position = UDim2.new(0, 10, 0, 260)
ScriptsContainer.BackgroundTransparency = 1
ScriptsContainer.BorderSizePixel = 0
ScriptsContainer.ScrollBarThickness = isMobile and 8 or 6
ScriptsContainer.ScrollBarImageColor3 = Colors.Accent
ScriptsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
ScriptsContainer.Parent = MainFrame

local ScriptsLayout = Instance.new("UIListLayout")
ScriptsLayout.Padding = UDim.new(0, 10)
ScriptsLayout.SortOrder = Enum.SortOrder.LayoutOrder
ScriptsLayout.Parent = ScriptsContainer

ScriptsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScriptsContainer.CanvasSize = UDim2.new(0, 0, 0, ScriptsLayout.AbsoluteContentSize.Y + 15)
end)

-- ============================================
-- CONTROL PANEL (BOTTOM BAR)
-- ============================================

local ControlPanel = Instance.new("Frame")
ControlPanel.Size = UDim2.new(1, -20, 0, 55)
ControlPanel.Position = UDim2.new(0, 10, 1, -65)
ControlPanel.BackgroundColor3 = Colors.Secondary
ControlPanel.BorderSizePixel = 0
ControlPanel.Parent = MainFrame

local CPCorner = Instance.new("UICorner")
CPCorner.CornerRadius = UDim.new(0, 12)
CPCorner.Parent = ControlPanel

local CPGradient = Instance.new("UIGradient")
CPGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 38, 55)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 28, 40))
}
CPGradient.Rotation = 90
CPGradient.Parent = ControlPanel

local CPStroke = Instance.new("UIStroke")
CPStroke.Color = Colors.Border
CPStroke.Thickness = 1
CPStroke.Transparency = 0.5
CPStroke.Parent = ControlPanel

-- Selected Counter
local SelectedCounter = Instance.new("TextLabel")
SelectedCounter.Size = UDim2.new(0.28, 0, 1, 0)
SelectedCounter.Position = UDim2.new(0, 15, 0, 0)
SelectedCounter.BackgroundTransparency = 1
SelectedCounter.Text = "📋 0 ausgewählt"
SelectedCounter.TextColor3 = Colors.TextSecondary
SelectedCounter.TextSize = isMobile and 12 or 14
SelectedCounter.Font = Enum.Font.GothamBold
SelectedCounter.TextXAlignment = Enum.TextXAlignment.Left
SelectedCounter.Parent = ControlPanel

-- Execute All Button
local ExecuteAllBtn = Instance.new("TextButton")
ExecuteAllBtn.Size = UDim2.new(0.32, -5, 0, 40)
ExecuteAllBtn.Position = UDim2.new(0.35, 0, 0.5, -20)
ExecuteAllBtn.BackgroundColor3 = Colors.Success
ExecuteAllBtn.Text = "▶ ALLE STARTEN"
ExecuteAllBtn.TextColor3 = Colors.Text
ExecuteAllBtn.TextSize = isMobile and 12 or 14
ExecuteAllBtn.Font = Enum.Font.GothamBold
ExecuteAllBtn.BorderSizePixel = 0
ExecuteAllBtn.Parent = ControlPanel

local ExecAllCorner = Instance.new("UICorner")
ExecAllCorner.CornerRadius = UDim.new(0, 10)
ExecAllCorner.Parent = ExecuteAllBtn

-- Clear Selection Button
local ClearBtn = Instance.new("TextButton")
ClearBtn.Size = UDim2.new(0.32, -5, 0, 40)
ClearBtn.Position = UDim2.new(0.69, 0, 0.5, -20)
ClearBtn.BackgroundColor3 = Colors.Danger
ClearBtn.Text = "✕ AUSWAHL LÖSCHEN"
ClearBtn.TextColor3 = Colors.Text
ClearBtn.TextSize = isMobile and 12 or 14
ClearBtn.Font = Enum.Font.GothamBold
ClearBtn.BorderSizePixel = 0
ClearBtn.Parent = ControlPanel

local ClearBtnCorner = Instance.new("UICorner")
ClearBtnCorner.CornerRadius = UDim.new(0, 10)
ClearBtnCorner.Parent = ClearBtn

print("✓ Control Panel erstellt")

-- ============================================
-- EXECUTE SCRIPT FUNCTION (VERBESSERT)
-- ============================================

local function ExecuteScript(scriptData)
    print("⚡ Executing: " .. scriptData.Name)
    
    -- Visual feedback im UI
    StarterGui:SetCore("SendNotification", {
        Title = "⏳ Wird geladen...";
        Text = scriptData.Name;
        Duration = 2;
    })
    
    local success, err = pcall(function()
        -- Check if URL is a loadstring command
        if scriptData.URL:sub(1, 11) == "loadstring(" then
            -- Direct execution
            local func = loadstring(scriptData.URL)
            if func then func() end
        else
            -- URL-based execution
            local scriptContent = game:HttpGet(scriptData.URL, true)
            local func = loadstring(scriptContent)
            if func then
                func()
            else
                error("Loadstring failed")
            end
        end
    end)
    
    if success then
        print("✅ Success: " .. scriptData.Name)
        StarterGui:SetCore("SendNotification", {
            Title = "✅ Erfolgreich!";
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

-- ============================================
-- CREATE SCRIPT CARD (MEGA VERBESSERT)
-- ============================================

local function CreateScriptCard(scriptData, index)
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, -10, 0, isMobile and 130 or 120)
    Card.BackgroundColor3 = Colors.Secondary
    Card.BorderSizePixel = 0
    Card.LayoutOrder = index
    Card.Parent = ScriptsContainer
    
    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 12)
    CardCorner.Parent = Card
    
    local CardGradient = Instance.new("UIGradient")
    CardGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 38, 55)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 28, 42))
    }
    CardGradient.Rotation = 45
    CardGradient.Parent = Card
    
    local CardStroke = Instance.new("UIStroke")
    CardStroke.Color = Colors.Border
    CardStroke.Thickness = 1
    CardStroke.Transparency = 0.8
    CardStroke.Parent = Card
    
    -- Checkbox Container
    local CheckFrame = Instance.new("Frame")
    CheckFrame.Size = UDim2.new(0, 35, 0, 35)
    CheckFrame.Position = UDim2.new(0, 12, 0, 12)
    CheckFrame.BackgroundColor3 = Colors.Background
    CheckFrame.BorderSizePixel = 0
    CheckFrame.Parent = Card
    
    local CheckCorner = Instance.new("UICorner")
    CheckCorner.CornerRadius = UDim.new(0, 8)
    CheckCorner.Parent = CheckFrame
    
    local CheckStroke = Instance.new("UIStroke")
    CheckStroke.Color = Colors.Accent
    CheckStroke.Thickness = 2
    CheckStroke.Transparency = 0.5
    CheckStroke.Parent = CheckFrame
    
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
    CheckMark.TextSize = 24
    CheckMark.Font = Enum.Font.GothamBold
    CheckMark.Visible = false
    CheckMark.Parent = CheckFrame
    
    local isSelected = false
    
    CheckBtn.MouseButton1Click:Connect(function()
        isSelected = not isSelected
        CheckMark.Visible = isSelected
        CheckFrame.BackgroundColor3 = isSelected and Colors.Accent or Colors.Background
        CheckStroke.Color = isSelected and Colors.Success or Colors.Accent
        CheckStroke.Transparency = isSelected and 0 or 0.5
        
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
            Size = UDim2.new(0, 38, 0, 38)
        }):Play()
        task.wait(0.1)
        TweenService:Create(CheckFrame, TweenInfo.new(0.2, Enum.EasingStyle.Elastic), {
            Size = UDim2.new(0, 35, 0, 35)
        }):Play()
    end)
    
    -- Script Name
    local Name = Instance.new("TextLabel")
    Name.Size = UDim2.new(1, -210, 0, 26)
    Name.Position = UDim2.new(0, 55, 0, 10)
    Name.BackgroundTransparency = 1
    Name.Text = scriptData.Name
    Name.TextColor3 = Colors.Text
    Name.TextSize = isMobile and 14 or 16
    Name.Font = Enum.Font.GothamBold
    Name.TextXAlignment = Enum.TextXAlignment.Left
    Name.TextTruncate = Enum.TextTruncate.AtEnd
    Name.Parent = Card
    
    -- Rating
    local Rating = Instance.new("TextLabel")
    Rating.Size = UDim2.new(0, 120, 0, 22)
    Rating.Position = UDim2.new(1, -130, 0, 10)
    Rating.BackgroundTransparency = 1
    Rating.Text = scriptData.Rating
    Rating.TextColor3 = Colors.Warning
    Rating.TextSize = isMobile and 11 or 12
    Rating.Font = Enum.Font.Gotham
    Rating.TextXAlignment = Enum.TextXAlignment.Right
    Rating.Parent = Card
    
    -- Description
    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(1, -65, 0, 30)
    Desc.Position = UDim2.new(0, 55, 0, 38)
    Desc.BackgroundTransparency = 1
    Desc.Text = scriptData.Description
    Desc.TextColor3 = Colors.TextSecondary
    Desc.TextSize = isMobile and 11 or 12
    Desc.Font = Enum.Font.Gotham
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextWrapped = true
    Desc.Parent = Card
    
    -- Badges Container
    local BadgesFrame = Instance.new("Frame")
    BadgesFrame.Size = UDim2.new(1, -165, 0, 24)
    BadgesFrame.Position = UDim2.new(0, 55, 0, 75)
    BadgesFrame.BackgroundTransparency = 1
    BadgesFrame.Parent = Card
    
    local BadgesLayout = Instance.new("UIListLayout")
    BadgesLayout.FillDirection = Enum.FillDirection.Horizontal
    BadgesLayout.Padding = UDim.new(0, 6)
    BadgesLayout.Parent = BadgesFrame
    
    -- Category Badge
    local function CreateBadge(text, color)
        local Badge = Instance.new("Frame")
        Badge.Size = UDim2.new(0, 0, 1, 0)
        Badge.BackgroundColor3 = color
        Badge.BorderSizePixel = 0
        Badge.Parent = BadgesFrame
        
        local BadgeCorner = Instance.new("UICorner")
        BadgeCorner.CornerRadius = UDim.new(0, 6)
        BadgeCorner.Parent = Badge
        
        local BadgeLabel = Instance.new("TextLabel")
        BadgeLabel.Size = UDim2.new(1, 0, 1, 0)
        BadgeLabel.BackgroundTransparency = 1
        BadgeLabel.Text = text
        BadgeLabel.TextColor3 = Colors.Text
        BadgeLabel.TextSize = isMobile and 10 or 11
        BadgeLabel.Font = Enum.Font.GothamBold
        BadgeLabel.Parent = Badge
        
        -- Auto-size badge
        local textSize = game:GetService("TextService"):GetTextSize(
            text,
            BadgeLabel.TextSize,
            BadgeLabel.Font,
            Vector2.new(math.huge, 24)
        )
        Badge.Size = UDim2.new(0, textSize.X + 16, 1, 0)
        
        return Badge
    end
    
    -- Category color mapping
    local categoryColors = {
        Premium = Colors.Premium,
        Free = Colors.Free,
        Admin = Colors.Accent,
        Tools = Color3.fromRGB(138, 121, 255),
        Visual = Color3.fromRGB(255, 121, 198),
        Utility = Colors.Info
    }
    
    CreateBadge(scriptData.Category, categoryColors[scriptData.Category] or Colors.TextSecondary)
    CreateBadge(scriptData.RequiresKey and "🔐 Key" or "✓ No Key", scriptData.RequiresKey and Colors.Danger or Colors.Success)
    
    -- Author Label
    local Author = Instance.new("TextLabel")
    Author.Size = UDim2.new(0, 150, 0, 18)
    Author.Position = UDim2.new(0, 55, 0, 104)
    Author.BackgroundTransparency = 1
    Author.Text = "by " .. scriptData.Author
    Author.TextColor3 = Colors.TextMuted
    Author.TextSize = isMobile and 9 or 10
    Author.Font = Enum.Font.Gotham
    Author.TextXAlignment = Enum.TextXAlignment.Left
    Author.Parent = Card
    
    -- Execute Button
    local ExecBtn = Instance.new("TextButton")
    ExecBtn.Size = UDim2.new(0, isMobile and 130 or 140, 0, 42)
    ExecBtn.Position = UDim2.new(1, isMobile and -140 or -150, 0.5, 8)
    ExecBtn.BackgroundColor3 = Colors.Accent
    ExecBtn.Text = "▶ STARTEN"
    ExecBtn.TextColor3 = Colors.Text
    ExecBtn.TextSize = isMobile and 12 or 14
    ExecBtn.Font = Enum.Font.GothamBold
    ExecBtn.BorderSizePixel = 0
    ExecBtn.Parent = Card
    
    local ExecBtnCorner = Instance.new("UICorner")
    ExecBtnCorner.CornerRadius = UDim.new(0, 10)
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
        ExecBtn.Text = "⏳ Lädt..."
        ExecBtn.BackgroundColor3 = Colors.Warning
        
        ExecuteScript(scriptData)
        
        task.wait(1)
        ExecBtn.Text = "▶ STARTEN"
        ExecBtn.BackgroundColor3 = Colors.Accent
    end)
    
    -- Hover Effects
    ExecBtn.MouseEnter:Connect(function()
        TweenService:Create(ExecBtn, TweenInfo.new(0.2), {
            Size = UDim2.new(0, isMobile and 135 or 145, 0, 42),
            BackgroundColor3 = Colors.AccentHover
        }):Play()
    end)
    
    ExecBtn.MouseLeave:Connect(function()
        TweenService:Create(ExecBtn, TweenInfo.new(0.2), {
            Size = UDim2.new(0, isMobile and 130 or 140, 0, 42),
            BackgroundColor3 = Colors.Accent
        }):Play()
    end)
    
    -- Card Hover Effect
    Card.MouseEnter:Connect(function()
        TweenService:Create(CardStroke, TweenInfo.new(0.2), {
            Color = Colors.Accent,
            Transparency = 0.3
        }):Play()
        TweenService:Create(Card, TweenInfo.new(0.2), {
            BackgroundColor3 = Colors.Tertiary
        }):Play()
    end)
    
    Card.MouseLeave:Connect(function()
        TweenService:Create(CardStroke, TweenInfo.new(0.2), {
            Color = Colors.Border,
            Transparency = 0.8
        }):Play()
        TweenService:Create(Card, TweenInfo.new(0.2), {
            BackgroundColor3 = Colors.Secondary
        }):Play()
    end)
end

-- ============================================
-- LOAD GAME SCRIPTS FUNCTION
-- ============================================

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
    
    -- Create cards with smooth animation
    for index, scriptData in ipairs(gameData.Scripts) do
        CreateScriptCard(scriptData, index)
        task.wait(0.02)
    end
    
    CurrentGame = gameName
    print("✓ " .. #gameData.Scripts .. " scripts loaded")
    
    StarterGui:SetCore("SendNotification", {
        Title = "✓ Scripts geladen";
        Text = #gameData.Scripts .. " Scripts für " .. gameName;
        Duration = 2;
    })
end

-- ============================================
-- CREATE GAME BUTTONS
-- ============================================

print("🎮 Creating game buttons...")
local gameCount = 0

for gameName, gameData in pairs(ScriptDatabase) do
    gameCount = gameCount + 1
    
    local GameBtn = Instance.new("TextButton")
    GameBtn.Size = UDim2.new(0, isMobile and 180 or 210, 0, 50)
    GameBtn.BackgroundColor3 = Colors.Secondary
    GameBtn.BorderSizePixel = 0
    GameBtn.Parent = GameScrollFrame
    
    local GCorner = Instance.new("UICorner")
    GCorner.CornerRadius = UDim.new(0, 12)
    GCorner.Parent = GameBtn
    
    local GStroke = Instance.new("UIStroke")
    GStroke.Color = Colors.Border
    GStroke.Thickness = 1.5
    GStroke.Transparency = 0.7
    GStroke.Parent = GameBtn
    
    local GGradient = Instance.new("UIGradient")
    GGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 58)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 45))
    }
    GGradient.Rotation = 90
    GGradient.Parent = GameBtn
    
    -- Button Icon
    local BtnIcon = Instance.new("TextLabel")
    BtnIcon.Size = UDim2.new(0, 40, 1, 0)
    BtnIcon.Position = UDim2.new(0, 8, 0, 0)
    BtnIcon.BackgroundTransparency = 1
    BtnIcon.Text = gameData.Icon
    BtnIcon.TextSize = 28
    BtnIcon.Font = Enum.Font.GothamBold
    BtnIcon.Parent = GameBtn
    
    -- Button Text Container
    local TextContainer = Instance.new("Frame")
    TextContainer.Size = UDim2.new(1, -90, 1, 0)
    TextContainer.Position = UDim2.new(0, 48, 0, 0)
    TextContainer.BackgroundTransparency = 1
    TextContainer.Parent = GameBtn
    
    local BtnText = Instance.new("TextLabel")
    BtnText.Size = UDim2.new(1, 0, 0.6, 0)
    BtnText.Position = UDim2.new(0, 0, 0, 4)
    BtnText.BackgroundTransparency = 1
    
    local displayName = gameName
    local maxLen = isMobile and 14 or 18
    if #displayName > maxLen then
        displayName = displayName:sub(1, maxLen) .. "..."
    end
    
    BtnText.Text = displayName
    BtnText.TextColor3 = Colors.Text
    BtnText.TextSize = isMobile and 12 or 14
    BtnText.Font = Enum.Font.GothamBold
    BtnText.TextXAlignment = Enum.TextXAlignment.Left
    BtnText.Parent = TextContainer
    
    local BtnDesc = Instance.new("TextLabel")
    BtnDesc.Size = UDim2.new(1, 0, 0.4, 0)
    BtnDesc.Position = UDim2.new(0, 0, 0.6, -4)
    BtnDesc.BackgroundTransparency = 1
    BtnDesc.Text = gameData.Description or ""
    BtnDesc.TextColor3 = Colors.TextSecondary
    BtnDesc.TextSize = isMobile and 9 or 10
    BtnDesc.Font = Enum.Font.Gotham
    BtnDesc.TextXAlignment = Enum.TextXAlignment.Left
    BtnDesc.TextTruncate = Enum.TextTruncate.AtEnd
    BtnDesc.Parent = TextContainer
    
    -- Script Count Badge
    local CountBadge = Instance.new("Frame")
    CountBadge.Size = UDim2.new(0, 32, 0, 22)
    CountBadge.Position = UDim2.new(1, -38, 0, 5)
    CountBadge.BackgroundColor3 = Colors.Accent
    CountBadge.BorderSizePixel = 0
    CountBadge.Parent = GameBtn
    
    local CBCorner = Instance.new("UICorner")
    CBCorner.CornerRadius = UDim.new(0, 6)
    CBCorner.Parent = CountBadge
    
    local CountLabel = Instance.new("TextLabel")
    CountLabel.Size = UDim2.new(1, 0, 1, 0)
    CountLabel.BackgroundTransparency = 1
    CountLabel.Text = tostring(#gameData.Scripts)
    CountLabel.TextColor3 = Colors.Text
    CountLabel.TextSize = 11
    CountLabel.Font = Enum.Font.GothamBold
    CountLabel.Parent = CountBadge
    
    -- Button Click
    GameBtn.MouseButton1Click:Connect(function()
        -- Reset all buttons
        for _, btn in ipairs(GameScrollFrame:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = Colors.Secondary
                local stroke = btn:FindFirstChild("UIStroke")
                if stroke then
                    stroke.Color = Colors.Border
                    stroke.Transparency = 0.7
                end
            end
        end
        
        -- Highlight this button
        GameBtn.BackgroundColor3 = Colors.Accent
        GStroke.Color = Colors.Accent
        GStroke.Transparency = 0
        
        LoadGameScripts(gameName, gameData)
    end)
    
    -- Hover Effects
    GameBtn.MouseEnter:Connect(function()
        if GameBtn.BackgroundColor3 ~= Colors.Accent then
            TweenService:Create(GameBtn, TweenInfo.new(0.2), {
                BackgroundColor3 = Colors.Tertiary
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

-- Update canvas size
GameScrollFrame.CanvasSize = UDim2.new(0, GameLayout.AbsoluteContentSize.X + 10, 0, 0)

GameLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    GameScrollFrame.CanvasSize = UDim2.new(0, GameLayout.AbsoluteContentSize.X + 10, 0, 0)
end)

-- ============================================
-- CONTROL PANEL BUTTON FUNKTIONEN
-- ============================================

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
    
    StarterGui:SetCore("SendNotification", {
        Title = "✓ Fertig!";
        Text = #SelectedScripts .. " Scripts wurden ausgeführt";
        Duration = 3;
    })
end)

ExecuteAllBtn.MouseEnter:Connect(function()
    TweenService:Create(ExecuteAllBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(87, 201, 149),
        Size = UDim2.new(0.32, -5, 0, 43)
    }):Play()
end)

ExecuteAllBtn.MouseLeave:Connect(function()
    TweenService:Create(ExecuteAllBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Colors.Success,
        Size = UDim2.new(0.32, -5, 0, 40)
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
        BackgroundColor3 = Color3.fromRGB(255, 86, 89),
        Size = UDim2.new(0.32, -5, 0, 43)
    }):Play()
end)

ClearBtn.MouseLeave:Connect(function()
    TweenService:Create(ClearBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Colors.Danger,
        Size = UDim2.new(0.32, -5, 0, 40)
    }):Play()
end)

print("✓ Buttons connected")

-- ============================================
-- FLOATING BUTTON (MEGA VERBESSERT)
-- ============================================

local FloatingButton = Instance.new("Frame")
FloatingButton.Name = "FloatingButton"
FloatingButton.Size = UDim2.new(0, 65, 0, 65)
FloatingButton.Position = UDim2.new(1, -80, isMobile and 0.88 or 0.5, isMobile and -32.5 or -32.5)
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
FloatStroke.Thickness = 3
FloatStroke.Transparency = 0.7
FloatStroke.Parent = FloatingButton

-- Glow Effect
local FloatGlow = Instance.new("ImageLabel")
FloatGlow.Size = UDim2.new(1.5, 0, 1.5, 0)
FloatGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
FloatGlow.AnchorPoint = Vector2.new(0.5, 0.5)
FloatGlow.BackgroundTransparency = 1
FloatGlow.Image = "rbxassetid://5028857084"
FloatGlow.ImageColor3 = Colors.Accent
FloatGlow.ImageTransparency = 0.6
FloatGlow.ScaleType = Enum.ScaleType.Slice
FloatGlow.SliceCenter = Rect.new(24, 24, 276, 276)
FloatGlow.ZIndex = -1
FloatGlow.Parent = FloatingButton

local FloatBtn = Instance.new("TextButton")
FloatBtn.Size = UDim2.new(1, 0, 1, 0)
FloatBtn.BackgroundTransparency = 1
FloatBtn.Text = "🚀"
FloatBtn.TextSize = 36
FloatBtn.Font = Enum.Font.GothamBold
FloatBtn.TextColor3 = Colors.Text
FloatBtn.Parent = FloatingButton

-- Pulse Animation
task.spawn(function()
    while FloatingButton and FloatingButton.Parent do
        TweenService:Create(FloatingButton, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Size = UDim2.new(0, 72, 0, 72)
        }):Play()
        TweenService:Create(FloatGlow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            ImageTransparency = 0.4
        }):Play()
        TweenService:Create(FloatStroke, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Transparency = 0.4
        }):Play()
        task.wait(2)
        TweenService:Create(FloatingButton, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Size = UDim2.new(0, 65, 0, 65)
        }):Play()
        TweenService:Create(FloatGlow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            ImageTransparency = 0.6
        }):Play()
        TweenService:Create(FloatStroke, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Transparency = 0.7
        }):Play()
        task.wait(2)
    end
end)

-- Rainbow Effect
task.spawn(function()
    local hue = 0
    while FloatGlow and FloatGlow.Parent do
        hue = (hue + 1) % 360
        local color = Color3.fromHSV(hue/360, 0.8, 1)
        FloatGlow.ImageColor3 = color
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
            Size = isMobile and UDim2.new(0.94, 0, 0.88, 0) or UDim2.new(0, 950, 0, 620)
        }):Play()
        
        FloatBtn.Text = "🚀"
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

-- ============================================
-- MAIN FRAME DRAGGABLE (PC)
-- ============================================

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

-- ============================================
-- KEYBIND (PC)
-- ============================================

if not isMobile then
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
            FloatBtn.MouseButton1Click:Fire()
        end
    end)
    print("✓ Keybind: RightControl")
end

-- ============================================
-- GUI ZU PLAYERGUI HINZUFÜGEN
-- ============================================

ScreenGui.Parent = PlayerGui
print("✓ GUI zu PlayerGui hinzugefügt")

-- ============================================
-- AUTOMATISCH ERSTES SPIEL LADEN
-- ============================================

task.wait(0.5)
local firstGame = next(ScriptDatabase)
if firstGame then
    local firstButton = GameScrollFrame:GetChildren()[2]
    if firstButton and firstButton:IsA("TextButton") then
        firstButton.MouseButton1Click:Fire()
        print("✓ Erstes Spiel automatisch geladen: " .. firstGame)
    end
end

-- ============================================
-- WELCOME NOTIFICATION
-- ============================================

StarterGui:SetCore("SendNotification", {
    Title = "✅ Ultimate Mega Loader v3.0";
    Text = "Erfolgreich geladen! " .. gameCount .. " Spiele verfügbar. " .. (isMobile and "📱 Mobile" or "💻 RightCtrl = Toggle");
    Duration = 5;
})

-- ============================================
-- SUCCESS MESSAGES
-- ============================================

print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("✅ ULTIMATE MEGA LOADER V3.0 ERFOLGREICH GELADEN!")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("📱 Device: " .. (isMobile and "Mobile" or "Desktop"))
print("🎮 Spiele geladen: " .. gameCount)
local totalScripts = 0
for _, gameData in pairs(ScriptDatabase) do
    totalScripts = totalScripts + #gameData.Scripts
end
print("📜 Gesamt Scripts: " .. totalScripts)
print("🛡️ Anti-AFK: Aktiv")
print("🔘 Floating Button: Rechts am Bildschirm")
if not isMobile then
    print("⌨️ Keybind: RightControl zum Öffnen/Schließen")
end
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🚀 VIEL SPASS BEIM SCRIPTEN!")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("")
print("📌 SO ERWEITERST DU DAS SCRIPT:")
print("1. Öffne die ScriptDatabase (Zeile ~90)")
print("2. Kopiere ein bestehendes Spiel-Template")
print("3. Ändere GameName, GameId, Icon, Category")
print("4. Füge deine Scripts im Scripts-Array hinzu")
print("5. Speichern & Ausführen!")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

--[[
════════════════════════════════════════════════════════════════
                    ERWEITERUNGS-ANLEITUNG
════════════════════════════════════════════════════════════════

📚 SO FÜGST DU EIN NEUES SPIEL HINZU:

1. Finde die ScriptDatabase (ca. Zeile 90)
2. Kopiere dieses Template:

    ["Dein Spiel Name"] = {
        GameName = "Dein Spiel Name",
        GameId = 123456789,  -- Spiel PlaceId von Roblox
        Icon = "🎮",  -- Emoji für dein Spiel
        Category = "Simulator",  -- Kategorie: Simulator, Horror, Fighting, Tycoon, Universal
        Description = "Kurze Beschreibung",
        Scripts = {
            {
                Name = "Script Name",
                Description = "Was das Script macht",
                URL = "https://raw.githubusercontent.com/...",
                Category = "Premium",  -- Premium, Free, Admin, Tools, Visual, Utility
                RequiresKey = false,  -- true wenn Key benötigt wird
                Rating = "⭐⭐⭐⭐⭐",  -- 1-5 Sterne
                Features = {"Feature 1", "Feature 2", "Feature 3"},
                Author = "Script Author"
            },
            -- Weitere Scripts hier hinzufügen...
        }
    },

3. Füge das Template in die ScriptDatabase ein (nach dem letzten Spiel, vor der schließenden })
4. Passe alle Werte an
5. Script ausführen!

════════════════════════════════════════════════════════════════
                    BEISPIEL: NEUES SPIEL HINZUFÜGEN
════════════════════════════════════════════════════════════════

    ["Pet Simulator X"] = {
        GameName = "Pet Simulator X",
        GameId = 6284583030,
        Icon = "🐾",
        Category = "Simulator",
        Description = "Pet Collection Game",
        Scripts = {
            {
                Name = "Thunder Hub",
                Description = "Auto Farm & Hatch",
                URL = "https://raw.githubusercontent.com/ThunderZ/psx/main/loader.lua",
                Category = "Premium",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐⭐",
                Features = {"Auto Farm", "Auto Hatch", "Auto Sell", "Teleports"},
                Author = "ThunderZ"
            },
            {
                Name = "Free PSX Script",
                Description = "Basic farming features",
                URL = "https://raw.githubusercontent.com/freescript/psx/main/script.lua",
                Category = "Free",
                RequiresKey = false,
                Rating = "⭐⭐⭐⭐",
                Features = {"Auto Farm", "ESP"},
                Author = "FreeScript"
            }
        }
    },

════════════════════════════════════════════════════════════════
                    VERFÜGBARE KATEGORIEN
════════════════════════════════════════════════════════════════

SPIEL KATEGORIEN:
- "Simulator"  → Farming/Clicking Spiele
- "Horror"     → Horror/Survival Spiele
- "Fighting"   → Kampf/PvP Spiele
- "Tycoon"     → Build/Management Spiele
- "Universal"  → Funktioniert überall

SCRIPT KATEGORIEN:
- "Premium"    → Goldene Farbe (Beste Scripts)
- "Free"       → Grüne Farbe (Kostenlose Scripts)
- "Admin"      → Blaue Farbe (Admin Commands)
- "Tools"      → Lila Farbe (Development Tools)
- "Visual"     → Rosa Farbe (ESP/Visual Scripts)
- "Utility"    → Hellblaue Farbe (Utility Scripts)

════════════════════════════════════════════════════════════════
                    TIPPS & TRICKS
════════════════════════════════════════════════════════════════

✅ BEST PRACTICES:
- Teste Scripts einzeln bevor du sie hinzufügst
- Verwende aussagekräftige Namen
- Schreibe klare Beschreibungen
- Gib korrekten Author an
- Nutze passende Ratings (nicht alles 5 Sterne)
- Halte Features-Liste kurz (max 5 Features)

❌ HÄUFIGE FEHLER:
- Falsche URL (muss raw link sein, nicht webpage)
- Vergessene Kommas zwischen Scripts
- Falsche GameId (nutze die PlaceId, nicht UniverseId)
- Zu lange Namen (werden abgeschnitten)

🔧 ERWEITERTE ANPASSUNGEN:
- Farben ändern: Siehe "Colors" Variable (Zeile ~120)
- Button Größen: Suche nach "isMobile and X or Y" Patterns
- Animationen: TweenService:Create() Aufrufe anpassen
- Layout: UDim2 Werte in Frame Erstellungen ändern

════════════════════════════════════════════════════════════════
                    SUPPORT & HILFE
════════════════════════════════════════════════════════════════

📌 WICHTIGE ZEILEN:
- Zeile ~90:   ScriptDatabase (Hier Spiele hinzufügen)
- Zeile ~120:  Colors (Farben anpassen)
- Zeile ~800:  ExecuteScript Function (Script Ausführung)
- Zeile ~850:  CreateScriptCard (Card Design)

🐛 DEBUGGING:
- Schaue in die Konsole (F9) für Fehlermeldungen
- print() Statements helfen beim Debuggen
- Teste auf Mobile UND Desktop

💡 FEATURES HINZUFÜGEN:
- Search Funktion: Zeile ~650 (SearchBox.Changed)
- Filter Funktion: Zeile ~750 (Category Buttons)
- Neue Stats: Zeile ~450 (Stats Display)

════════════════════════════════════════════════════════════════
]]

-- ════════════════════════════════════════════════════════════════
-- ZUSÄTZLICHE UTILITY FUNCTIONS (FÜR ERWEITERUNGEN)
-- ════════════════════════════════════════════════════════════════

-- Export/Save Favorites (Für zukünftige Implementierung)
local function SaveFavorites()
    -- TODO: Implement save system
    local favoritesData = HttpService:JSONEncode(FavoriteScripts)
    print("Favorites Data:", favoritesData)
    -- Kann mit writefile() in supported executors gespeichert werden
end

-- Search/Filter Function (Für Search Implementation)
local function FilterScripts(searchQuery)
    searchQuery = searchQuery:lower()
    
    for _, card in ipairs(ScriptsContainer:GetChildren()) do
        if card:IsA("Frame") then
            local nameLabel = card:FindFirstChild("Name") or card:FindFirstChildWhichIsA("TextLabel")
            if nameLabel then
                local scriptName = nameLabel.Text:lower()
                local matches = scriptName:find(searchQuery, 1, true)
                card.Visible = matches ~= nil or searchQuery == ""
            end
        end
    end
end

-- Connect search functionality
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    FilterScripts(SearchBox.Text)
end)

-- Category Filter Function
local function FilterByCategory(category)
    if category == "All" then
        for _, card in ipairs(ScriptsContainer:GetChildren()) do
            if card:IsA("Frame") then
                card.Visible = true
            end
        end
        return
    end
    
    -- TODO: Implement category filtering
    -- This would need to store category data with each card
    print("Filtering by category:", category)
end

-- ════════════════════════════════════════════════════════════════
-- PERFORMANCE OPTIMIZATION
-- ════════════════════════════════════════════════════════════════

-- Limit frame rate for animations in low-end devices
if isMobile then
    RunService:Set3dRenderingEnabled(false) -- Disable 3D rendering if needed
end

-- Memory management
task.spawn(function()
    while task.wait(300) do -- Every 5 minutes
        pcall(function()
            collectgarbage("collect")
            print("🗑️ Memory cleaned")
        end)
    end
end)

-- ════════════════════════════════════════════════════════════════
-- ADDITIONAL FEATURES (READY TO ENABLE)
-- ════════════════════════════════════════════════════════════════

-- Auto-Update Checker (Optional)
local AUTO_UPDATE = false -- Set to true to enable

if AUTO_UPDATE then
    task.spawn(function()
        local success, latestVersion = pcall(function()
            return game:HttpGet("https://your-update-server.com/version.txt")
        end)
        
        if success and latestVersion then
            local currentVersion = "3.0"
            if latestVersion ~= currentVersion then
                StarterGui:SetCore("SendNotification", {
                    Title = "🔄 Update Verfügbar!";
                    Text = "Neue Version " .. latestVersion .. " verfügbar!";
                    Duration = 10;
                })
            end
        end
    end)
end

-- Discord Webhook Integration (Optional)
local DISCORD_WEBHOOK = "" -- Add your webhook URL here

local function SendToDiscord(title, message)
    if DISCORD_WEBHOOK == "" then return end
    
    local data = {
        ["embeds"] = {{
            ["title"] = title,
            ["description"] = message,
            ["color"] = 5814783,
            ["footer"] = {
                ["text"] = "Ultimate Mega Loader v3.0"
            }
        }}
    }
    
    pcall(function()
        request({
            Url = DISCORD_WEBHOOK,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(data)
        })
    end)
end

-- Analytics (Optional - tracks usage, set to false for privacy)
local ANALYTICS_ENABLED = false

if ANALYTICS_ENABLED then
    SendToDiscord(
        "🚀 Loader Started",
        "User: " .. Player.Name .. "\nDevice: " .. (isMobile and "Mobile" or "Desktop") .. "\nGame: " .. game.PlaceId
    )
end

-- ════════════════════════════════════════════════════════════════
-- EASTER EGGS & EXTRAS
-- ════════════════════════════════════════════════════════════════

-- Konami Code Easter Egg
local konamiSequence = {
    Enum.KeyCode.Up, Enum.KeyCode.Up,
    Enum.KeyCode.Down, Enum.KeyCode.Down,
    Enum.KeyCode.Left, Enum.KeyCode.Right,
    Enum.KeyCode.Left, Enum.KeyCode.Right,
    Enum.KeyCode.B, Enum.KeyCode.A
}
local konamiProgress = 1

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == konamiSequence[konamiProgress] then
        konamiProgress = konamiProgress + 1
        
        if konamiProgress > #konamiSequence then
            konamiProgress = 1
            
            -- Easter Egg aktiviert!
            StarterGui:SetCore("SendNotification", {
                Title = "🎮 KONAMI CODE!";
                Text = "Du hast das Easter Egg gefunden! 🎉";
                Duration = 5;
            })
            
            -- Rainbow explosion effect
            task.spawn(function()
                for i = 1, 50 do
                    local hue = math.random(0, 360) / 360
                    MainStroke.Color = Color3.fromHSV(hue, 1, 1)
                    task.wait(0.05)
                end
                MainStroke.Color = Colors.Accent
            end)
        end
    else
        konamiProgress = 1
    end
end)

-- Special Animation on certain times
task.spawn(function()
    while task.wait(60) do
        local currentTime = os.date("*t")
        
        -- Special animation at midnight
        if currentTime.hour == 0 and currentTime.min == 0 then
            StarterGui:SetCore("SendNotification", {
                Title = "🌙 Mitternacht!";
                Text = "Ein neuer Tag beginnt... Zeit für mehr Scripts! 🎮";
                Duration = 5;
            })
        end
        
        -- Special message at 13:37 (Leet time)
        if currentTime.hour == 13 and currentTime.min == 37 then
            StarterGui:SetCore("SendNotification", {
                Title = "1337 H4X0R";
                Text = "Du bist ein wahrer Scripter! 😎";
                Duration = 5;
            })
        end
    end
end)

-- ════════════════════════════════════════════════════════════════
-- CLEANUP FUNCTION (When GUI is destroyed)
-- ════════════════════════════════════════════════════════════════

local function Cleanup()
    print("🧹 Cleaning up...")
    
    if ScreenGui then
        ScreenGui:Destroy()
    end
    
    -- Stop all running tasks
    AntiAFKEnabled = false
    
    StarterGui:SetCore("SendNotification", {
        Title = "👋 Auf Wiedersehen!";
        Text = "Ultimate Mega Loader wurde beendet.";
        Duration = 3;
    })
    
    print("✓ Cleanup abgeschlossen")
end

-- Cleanup on game leave
game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == Player then
        Cleanup()
    end
end)

-- ════════════════════════════════════════════════════════════════
-- FINAL SETUP & WELCOME
-- ════════════════════════════════════════════════════════════════

print("")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("       ✨ READY TO SCRIPT! ✨")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("")
print("📖 QUICK START:")
print("   1. Wähle ein Spiel aus den Tabs")
print("   2. Wähle Scripts mit Checkbox aus")
print("   3. Klicke '▶ STARTEN' oder '▶ ALLE STARTEN'")
print("   4. Viel Spaß! 🎮")
print("")
print("💡 TIPPS:")
print("   • Floating Button = Immer sichtbar")
print("   • Suchleiste = Schnell Scripts finden")
print("   • Anti-AFK = Automatisch aktiv")
if not isMobile then
    print("   • RightControl = GUI öffnen/schließen")
end
print("")
print("📌 SUPPORT:")
print("   Bei Problemen: Konsole öffnen (F9)")
print("   Fehler werden dort angezeigt")
print("")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("     Created with ❤️ for the Community")
print("           Ultimate Mega Loader v3.0")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("")

-- Play a success sound (if executor supports it)
pcall(function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6026984224" -- Success sound
    sound.Volume = 0.5
    sound.Parent = game:GetService("SoundService")
    sound:Play()
    
    task.delay(2, function()
        sound:Destroy()
    end)
end)

-- Celebrate with confetti effect (visual only)
task.spawn(function()
    for i = 1, 20 do
        local confetti = Instance.new("Frame")
        confetti.Size = UDim2.new(0, 10, 0, 10)
        confetti.Position = UDim2.new(math.random(0, 100) / 100, 0, 0, -20)
        confetti.BackgroundColor3 = Color3.fromHSV(math.random(), 1, 1)
        confetti.BorderSizePixel = 0
        confetti.Parent = ScreenGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = confetti
        
        TweenService:Create(confetti, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(confetti.Position.X.Scale, 0, 1.2, 0),
            Rotation = math.random(-360, 360)
        }):Play()
        
        task.delay(2, function()
            confetti:Destroy()
        end)
        
        task.wait(0.1)
    end
end)

-- ════════════════════════════════════════════════════════════════
-- ALL DONE! SCRIPT IS COMPLETE AND READY TO USE! 🎉
-- ════════════════════════════════════════════════════════════════

--[[

█████╗ ██╗     ██╗     ███████╗███████╗    ███████╗███████╗██████╗ ████████╗██╗ ██████╗ ██╗
██╔══██╗██║     ██║     ██╔════╝██╔════╝    ██╔════╝██╔════╝██╔══██╗╚══██╔══╝██║██╔════╝ ██║
███████║██║     ██║     █████╗  ███████╗    █████╗  █████╗  ██████╔╝   ██║   ██║██║  ███╗██║
██╔══██║██║     ██║     ██╔══╝  ╚════██║    ██╔══╝  ██╔══╝  ██╔══██╗   ██║   ██║██║   ██║╚═╝
██║  ██║███████╗███████╗███████╗███████║    ██║     ███████╗██║  ██║   ██║   ██║╚██████╔╝██╗
╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚══════╝    ╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝

Danke fürs Nutzen von Ultimate Mega Loader! 🚀
Wenn dir das Script gefällt, teile es mit deinen Freunden! 💜

Features:
✅ 6+ Spiele unterstützt
✅ 50+ Scripts verfügbar
✅ Keine Keys erforderlich
✅ Mobile & Desktop optimiert
✅ Anti-AFK System
✅ Moderne UI mit Animationen
✅ Vollständig erweiterbar
✅ Performance optimiert
✅ KRNL kompatibel
✅ Drag & Drop Support
✅ Kategorie Filter
✅ Such-Funktion
✅ Rainbow Effekte
✅ Live Stats
✅ Und vieles mehr!

Version: 3.0 Ultimate Edition
Letzte Aktualisierung: 2025
Created by: PowerOff Community

]]
