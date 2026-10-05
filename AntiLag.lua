-- ============================================================
-- FADED.VS - With Lag Bypass Functions (F KEY TOGGLE)
-- ============================================================
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Clean up old UI
pcall(function()
    for _, old in ipairs(LocalPlayer:WaitForChild("PlayerGui"):GetChildren()) do
        if old.Name == "BananaHubAntiBat" or old.Name == "EternalHubAntiBat" or old.Name == "EthernalHubAntiBat" or old.Name == "QuartzHub" or old.Name == "FadedVS" then
            old:Destroy()
        end
    end
end)

-- ============================================================
-- PALETĂ - BLACK & WHITE THEME
-- ============================================================
local ACCENT_COLOR   = Color3.fromRGB(255, 255, 255) -- White
local GREY_COLOR    = Color3.fromRGB(20, 20, 20)
local MAIN_TEXT     = Color3.fromRGB(255, 255, 255)
local DARK_BG       = Color3.fromRGB(10, 10, 10)
local DARKER_BG     = Color3.fromRGB(15, 15, 15)

-- ============================================================
-- MAIN GUI
-- ============================================================
local gui = Instance.new("ScreenGui")
gui.Name = "FadedVS"
gui.ResetOnSpawn = false
gui.DisplayOrder = 999999
gui.IgnoreGuiInset = true
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local PW, PH = 290, 190

local dp = Instance.new("ImageLabel", gui)
dp.Name = "MainFrame"
dp.Size = UDim2.new(0, PW, 0, PH)
dp.Position = UDim2.new(0.5, -PW/2, 0.5, -PH/2)
dp.BackgroundColor3 = DARK_BG
dp.Image = "rbxassetid://107977050874654"
dp.ScaleType = Enum.ScaleType.Crop
dp.Active = true
dp.ClipsDescendants = true
Instance.new("UICorner", dp).CornerRadius = UDim.new(0, 14)

local dpSt = Instance.new("UIStroke", dp)
dpSt.Color = ACCENT_COLOR
dpSt.Thickness = 1.5

-- HEADER (Drag only on title)
local header = Instance.new("Frame", dp)
header.Size = UDim2.new(1, 0, 0, 36)
header.BackgroundTransparency = 1

local titleLbl = Instance.new("TextLabel", header)
titleLbl.Size = UDim2.new(1, -44, 1, 0)
titleLbl.Position = UDim2.new(0, 12, 0, 0)
titleLbl.BackgroundTransparency = 1
titleLbl.Text = "FADED.VS"
titleLbl.TextColor3 = ACCENT_COLOR
titleLbl.Font = Enum.Font.GothamBlack
titleLbl.TextSize = 14
titleLbl.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -30, 0.5, -11)
closeBtn.BackgroundColor3 = DARKER_BG
closeBtn.BackgroundTransparency = 0.5
closeBtn.Text = "X"
closeBtn.TextColor3 = MAIN_TEXT
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 12
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)
local closeStr = Instance.new("UIStroke", closeBtn)
closeStr.Color = ACCENT_COLOR
closeStr.Thickness = 1

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Decorative Elements
local function createDot(xPos, yPos, size)
    local dot = Instance.new("Frame", dp)
    dot.Size = UDim2.new(0, size, 0, size)
    dot.Position = UDim2.new(0, xPos, 0, yPos)
    dot.BackgroundColor3 = ACCENT_COLOR
    dot.BackgroundTransparency = 0.8
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    return dot
end

createDot(16, 16, 3)
createDot(PW - 42, 16, 3)

-- ============================================================
-- DRAG SYSTEM (Only on Title)
-- ============================================================
local dragging, dragStart, startPos

titleLbl.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = dp.Position
        local conn
        conn = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                conn:Disconnect()
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        dp.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ============================================================
-- LAG BYPASS FUNCTIONS - DUAL SLIDERS
-- ============================================================
local isLagOn = true -- Always on by default
local lagAmount = 0

local isLag2On = true -- Always on by default
local lag2Amount = 0.03

-- Keybind toggle state
local lagEnabled = true

-- Create Slider Function
local function createSlider(y, text)
    local holder = Instance.new("Frame", dp)
    holder.Size = UDim2.new(0, 280, 0, 50)
    holder.Position = UDim2.new(0.5, -140, 0, y)
    holder.BackgroundColor3 = GREY_COLOR
    holder.BackgroundTransparency = 0.3
    Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 8)
    
    local holderStroke = Instance.new("UIStroke", holder)
    holderStroke.Color = ACCENT_COLOR
    holderStroke.Thickness = 1
    holderStroke.Transparency = 0.5

    local label = Instance.new("TextLabel", holder)
    label.Size = UDim2.new(1, 0, 0, 18)
    label.Position = UDim2.new(0, 8, 0, 4)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 11
    label.TextColor3 = MAIN_TEXT
    label.TextXAlignment = Enum.TextXAlignment.Left

    local bar = Instance.new("Frame", holder)
    bar.Size = UDim2.new(1, -16, 0, 16)
    bar.Position = UDim2.new(0, 8, 1, -22)
    bar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    bar.BorderSizePixel = 0
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.fromScale(0, 1)
    fill.BackgroundColor3 = ACCENT_COLOR
    fill.BorderSizePixel = 0
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame", bar)
    knob.Size = UDim2.fromOffset(14, 14)
    knob.AnchorPoint = Vector2.new(0.5, 0.5)
    knob.Position = UDim2.new(0, 0, 0.5, 0)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    
    local knobStroke = Instance.new("UIStroke", knob)
    knobStroke.Color = ACCENT_COLOR
    knobStroke.Thickness = 1.5

    return holder, bar, fill, knob, label
end

-- ============================================================
-- SLIDER 1 (Original Lag Bypass)
-- ============================================================
local lagHolder, lagBar, lagFill, lagKnob, lagLabel = createSlider(48, "LAG BYPASS 1: 0%")

-- Slider Update Function
local function updateSlider(bar, fill, knob, mouseX)
    local rel = math.clamp((mouseX - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
    fill.Size = UDim2.fromScale(rel, 1)
    knob.Position = UDim2.new(rel, 0, 0.5, 0)
    return rel
end

-- Slider 1 Dragging
local draggingSlider1 = false

local function startSlider1Drag(input)
    draggingSlider1 = true
    local rel = updateSlider(lagBar, lagFill, lagKnob, input.Position.X)
    lagAmount = rel * 0.03
    local status = lagEnabled and "ON" or "OFF"
    lagLabel.Text = "LAG BYPASS 1: " .. math.floor(rel * 100) .. "% (" .. status .. ")"
end

lagBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        startSlider1Drag(input)
    end
end)

lagKnob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        startSlider1Drag(input)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if draggingSlider1 then
            local rel = updateSlider(lagBar, lagFill, lagKnob, input.Position.X)
            lagAmount = rel * 0.03
            local status = lagEnabled and "ON" or "OFF"
            lagLabel.Text = "LAG BYPASS 1: " .. math.floor(rel * 100) .. "% (" .. status .. ")"
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSlider1 = false
    end
end)

-- ============================================================
-- SLIDER 2 (Standalone Lag Bypass)
-- ============================================================
local lag2Holder, lag2Bar, lag2Fill, lag2Knob, lag2Label = createSlider(108, "LAG BYPASS 2: 0%")

-- Slider 2 Dragging
local draggingSlider2 = false

local function startSlider2Drag(input)
    draggingSlider2 = true
    local rel = updateSlider(lag2Bar, lag2Fill, lag2Knob, input.Position.X)
    lag2Amount = rel * 0.04
    local status = lagEnabled and "ON" or "OFF"
    lag2Label.Text = "LAG BYPASS 2: " .. math.floor(rel * 100) .. "% (" .. status .. ")"
end

lag2Bar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        startSlider2Drag(input)
    end
end)

lag2Knob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        startSlider2Drag(input)
    end
end)

-- Add second slider to input handling
UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if draggingSlider2 then
            local rel = updateSlider(lag2Bar, lag2Fill, lag2Knob, input.Position.X)
            lag2Amount = rel * 0.04
            local status = lagEnabled and "ON" or "OFF"
            lag2Label.Text = "LAG BYPASS 2: " .. math.floor(rel * 100) .. "% (" .. status .. ")"
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSlider2 = false
    end
end)

-- ============================================================
-- F KEY TOGGLE (Turns both lag bypasses on/off)
-- ============================================================
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then
        lagEnabled = not lagEnabled
        isLagOn = lagEnabled
        isLag2On = lagEnabled
        
        local status = lagEnabled and "ON" or "OFF"
        local rel1 = lagAmount / 0.04
        local rel2 = lag2Amount / 0.04
        lagLabel.Text = "LAG BYPASS 1: " .. math.floor(rel1 * 100) .. "% (" .. status .. ")"
        lag2Label.Text = "LAG BYPASS 2: " .. math.floor(rel2 * 100) .. "% (" .. status .. ")"
        
        print("Faded.VS - Lag Bypass " .. status)
    end
end)

-- ============================================================
-- LAG BYPASS 1 (Slider Controlled)
-- ============================================================
RunService.RenderStepped:Connect(function()
    if isLagOn and lagAmount > 0 then
        local t = tick()
        while tick() - t < lagAmount do end
    end
end)

-- ============================================================
-- LAG BYPASS 2 (Standalone Slider)
-- ============================================================
RunService.RenderStepped:Connect(function()
    if isLag2On and lag2Amount > 0 then
        local startTime = tick()
        while tick() - startTime < lag2Amount do end
    end
end)

print("Faded.VS - Loaded with Dual Lag Bypass! Press F to toggle")