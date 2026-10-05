
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

_G.StealProgress = 0

_G.AutoSteal = {
    StealDuration = 0.1,
    HalfHoldMax = 2.6,
    HalfEntryDelay = 0.3,
    Data = {},
    HalfHoldMin = 1.3,
    AutoStealEnabled = true,
    Mode = 'half',
    StealRadius = 80,
    HalfFireRange = 10
}

local existingGui = PlayerGui:FindFirstChild('AutoStealGui')
if existingGui then
    existingGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoStealGui"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 320, 0, 52)
mainFrame.Position = UDim2.new(0.5, -160, 0.6, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 15, 30)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(0, 150, 255)
uiStroke.Thickness = 2
uiStroke.Transparency = 0.3
uiStroke.Parent = mainFrame

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = mainFrame

local topRow = Instance.new("Frame")
topRow.Name = "TopRow"
topRow.Size = UDim2.new(1, -16, 0, 22)
topRow.Position = UDim2.new(0, 8, 0, 3)
topRow.BackgroundTransparency = 1
topRow.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(0.6, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "CHOCOLATE AUTO GRAB"
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 14
titleLabel.TextColor3 = Color3.fromRGB(200, 230, 255)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextYAlignment = Enum.TextYAlignment.Center
titleLabel.Parent = topRow

local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 255)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 200, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 230, 255))
})
titleGradient.Parent = titleLabel

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Name = "FPSLabel"
fpsLabel.Size = UDim2.new(0.2, 0, 1, 0)
fpsLabel.Position = UDim2.new(0.6, 0, 0, 0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: 0"
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 13
fpsLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
fpsLabel.TextXAlignment = Enum.TextXAlignment.Right
fpsLabel.TextYAlignment = Enum.TextYAlignment.Center
fpsLabel.Parent = topRow

local gearButton = Instance.new("TextButton")
gearButton.Name = "GearBtn"
gearButton.Size = UDim2.new(0, 24, 0, 24)
gearButton.Position = UDim2.new(1, -28, 0.5, -12)
gearButton.BackgroundTransparency = 1
gearButton.Text = "⚙"
gearButton.TextColor3 = Color3.fromRGB(100, 200, 255)
gearButton.TextSize = 18
gearButton.Font = Enum.Font.GothamBlack
gearButton.AutoButtonColor = false
gearButton.Parent = topRow

local progressBarBg = Instance.new("Frame")
progressBarBg.Name = "ProgressBarBg"
progressBarBg.Size = UDim2.new(1, -16, 0, 16)
progressBarBg.Position = UDim2.new(0, 8, 0, 28)
progressBarBg.BackgroundColor3 = Color3.fromRGB(0, 40, 80)
progressBarBg.BackgroundTransparency = 0.3
progressBarBg.BorderSizePixel = 0
progressBarBg.Parent = mainFrame

local progressCorner = Instance.new("UICorner")
progressCorner.CornerRadius = UDim.new(0, 8)
progressCorner.Parent = progressBarBg

local progressFill = Instance.new("Frame")
progressFill.Name = "ProgressFill"
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
progressFill.BorderSizePixel = 0
progressFill.Parent = progressBarBg

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(0, 8)
fillCorner.Parent = progressFill

local fillHighlight = Instance.new("Frame")
fillHighlight.Size = UDim2.new(1, 0, 1, 0)
fillHighlight.BackgroundColor3 = Color3.fromRGB(0, 220, 255)
fillHighlight.BackgroundTransparency = 0.6
fillHighlight.BorderSizePixel = 0
fillHighlight.Parent = progressFill

local percentLabel = Instance.new("TextLabel")
percentLabel.Name = "PercentLabel"
percentLabel.Size = UDim2.new(1, 0, 1, 0)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "0%"
percentLabel.Font = Enum.Font.GothamBlack
percentLabel.TextSize = 14
percentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
percentLabel.TextStrokeTransparency = 0.3
percentLabel.TextXAlignment = Enum.TextXAlignment.Center
percentLabel.TextYAlignment = Enum.TextYAlignment.Center
percentLabel.Parent = progressBarBg

local optionsPanel = Instance.new("Frame")
optionsPanel.Name = "OptionsPanel"
optionsPanel.Size = UDim2.new(1, -16, 0, 56)
optionsPanel.Position = UDim2.new(0, 8, 0, 48)
optionsPanel.BackgroundTransparency = 1
optionsPanel.Visible = false
optionsPanel.Parent = mainFrame

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0, 2)
uiListLayout.Parent = optionsPanel

local radiusRow = Instance.new("Frame")
radiusRow.Name = "RadRow"
radiusRow.Size = UDim2.new(1, 0, 0, 24)
radiusRow.BackgroundTransparency = 1
radiusRow.LayoutOrder = 1
radiusRow.Parent = optionsPanel

local radiusLabel = Instance.new("TextLabel")
radiusLabel.Size = UDim2.new(0, 60, 1, 0)
radiusLabel.BackgroundTransparency = 1
radiusLabel.Text = "RADIO"
radiusLabel.TextColor3 = Color3.fromRGB(180, 220, 255)
radiusLabel.TextSize = 12
radiusLabel.Font = Enum.Font.GothamBold
radiusLabel.TextXAlignment = Enum.TextXAlignment.Left
radiusLabel.Parent = radiusRow

local radiusDec = Instance.new("TextButton")
radiusDec.Size = UDim2.new(0, 24, 1, 0)
radiusDec.Position = UDim2.new(0, 65, 0, 0)
radiusDec.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
radiusDec.BackgroundTransparency = 0.4
radiusDec.BorderSizePixel = 0
radiusDec.Text = "−"
radiusDec.TextColor3 = Color3.fromRGB(255, 255, 255)
radiusDec.TextSize = 18
radiusDec.Font = Enum.Font.GothamBold
radiusDec.Parent = radiusRow

Instance.new("UICorner", radiusDec).CornerRadius = UDim.new(0, 5)

local radiusValueLabel = Instance.new("TextLabel")
radiusValueLabel.Size = UDim2.new(0, 40, 1, 0)
radiusValueLabel.Position = UDim2.new(0, 92, 0, 0)
radiusValueLabel.BackgroundTransparency = 1
radiusValueLabel.Text = "80"
radiusValueLabel.TextColor3 = Color3.fromRGB(200, 230, 255)
radiusValueLabel.TextSize = 14
radiusValueLabel.Font = Enum.Font.GothamBold
radiusValueLabel.Parent = radiusRow

local radiusInc = Instance.new("TextButton")
radiusInc.Size = UDim2.new(0, 24, 1, 0)
radiusInc.Position = UDim2.new(0, 135, 0, 0)
radiusInc.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
radiusInc.BackgroundTransparency = 0.4
radiusInc.BorderSizePixel = 0
radiusInc.Text = "+"
radiusInc.TextColor3 = Color3.fromRGB(255, 255, 255)
radiusInc.TextSize = 18
radiusInc.Font = Enum.Font.GothamBold
radiusInc.Parent = radiusRow

Instance.new("UICorner", radiusInc).CornerRadius = UDim.new(0, 5)

local scaleRow = Instance.new("Frame")
scaleRow.Name = "ScaleRow"
scaleRow.Size = UDim2.new(1, 0, 0, 24)
scaleRow.BackgroundTransparency = 1
scaleRow.LayoutOrder = 2
scaleRow.Parent = optionsPanel

local scaleLabel = Instance.new("TextLabel")
scaleLabel.Size = UDim2.new(0, 60, 1, 0)
scaleLabel.BackgroundTransparency = 1
scaleLabel.Text = "ESCALA"
scaleLabel.TextColor3 = Color3.fromRGB(180, 220, 255)
scaleLabel.TextSize = 12
scaleLabel.Font = Enum.Font.GothamBold
scaleLabel.TextXAlignment = Enum.TextXAlignment.Left
scaleLabel.Parent = scaleRow

local scaleDec = Instance.new("TextButton")
scaleDec.Size = UDim2.new(0, 24, 1, 0)
scaleDec.Position = UDim2.new(0, 65, 0, 0)
scaleDec.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
scaleDec.BackgroundTransparency = 0.4
scaleDec.BorderSizePixel = 0
scaleDec.Text = "−"
scaleDec.TextColor3 = Color3.fromRGB(255, 255, 255)
scaleDec.TextSize = 18
scaleDec.Font = Enum.Font.GothamBold
scaleDec.Parent = scaleRow

Instance.new("UICorner", scaleDec).CornerRadius = UDim.new(0, 5)

local scaleValueLabel = Instance.new("TextLabel")
scaleValueLabel.Size = UDim2.new(0, 40, 1, 0)
scaleValueLabel.Position = UDim2.new(0, 92, 0, 0)
scaleValueLabel.BackgroundTransparency = 1
scaleValueLabel.Text = "1.0"
scaleValueLabel.TextColor3 = Color3.fromRGB(200, 230, 255)
scaleValueLabel.TextSize = 14
scaleValueLabel.Font = Enum.Font.GothamBold
scaleValueLabel.Parent = scaleRow

local scaleInc = Instance.new("TextButton")
scaleInc.Size = UDim2.new(0, 24, 1, 0)
scaleInc.Position = UDim2.new(0, 135, 0, 0)
scaleInc.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
scaleInc.BackgroundTransparency = 0.4
scaleInc.BorderSizePixel = 0
scaleInc.Text = "+"
scaleInc.TextColor3 = Color3.fromRGB(255, 255, 255)
scaleInc.TextSize = 18
scaleInc.Font = Enum.Font.GothamBold
scaleInc.Parent = scaleRow

Instance.new("UICorner", scaleInc).CornerRadius = UDim.new(0, 5)

local uiScale = Instance.new("UIScale")
uiScale.Scale = 1
uiScale.Parent = mainFrame

scaleDec.Activated:Connect(function()
    uiScale.Scale = 0.9
    scaleValueLabel.Text = "0.9"
    pcall(function() writefile('ChocolateAutoGrabScale.txt', '0.9') end)
end)

scaleInc.Activated:Connect(function()
    uiScale.Scale = 1.1
    scaleValueLabel.Text = "1.1"
    pcall(function() writefile('ChocolateAutoGrabScale.txt', '1.1') end)
end)

pcall(function() writefile('ChocolateAutoGrabScale.txt', '1') end)