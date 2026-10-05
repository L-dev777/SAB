local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local function teleportTo(pos)
    local character = player.Character or player.CharacterAdded:Wait()
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local cam = workspace.CurrentCamera
    local savedCFrame = cam.CFrame

    cam.CameraType = Enum.CameraType.Scriptable
    cam.CFrame = savedCFrame

    root.CFrame = CFrame.new(pos)

    task.wait(0.1)

    cam.CFrame = savedCFrame

    task.wait(0.3)

    cam.CameraType = Enum.CameraType.Custom
    local hum = character:FindFirstChildOfClass("Humanoid")
    if hum then cam.CameraSubject = hum end
end

local function teleportWithSit(pos)
    local character = player.Character or player.CharacterAdded:Wait()
    local root = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not root or not humanoid then return end

    local cam = workspace.CurrentCamera
    local savedCFrame = cam.CFrame

    cam.CameraType = Enum.CameraType.Scriptable
    cam.CFrame = savedCFrame

    humanoid.Sit = true
    task.wait(0.05)
    root.CFrame = CFrame.new(pos)
    task.wait(0.05)
    humanoid.Sit = false

    cam.CFrame = savedCFrame

    task.wait(0.3)

    cam.CameraType = Enum.CameraType.Custom
    cam.CameraSubject = humanoid
end

local function makeDraggable(wrapper, dragFrame)
    local dragging = false
    local dragStart
    local startPos

    dragFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = wrapper.Position

            local conn
            conn = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    if conn then conn:Disconnect() end
                end
            end)
        end
    end)

    dragFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            if dragging then
                local delta = input.Position - dragStart
                wrapper.Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            end
        end
    end)
end

local TigysSABNoclip = Instance.new("ScreenGui")
TigysSABNoclip.Name = "TigysSABNoclip"
TigysSABNoclip.ResetOnSpawn = false
TigysSABNoclip.DisplayOrder = 999
TigysSABNoclip.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local NoclipWrapper = Instance.new("Frame")
NoclipWrapper.Name = "NoclipWrapper"
NoclipWrapper.BackgroundTransparency = 1
NoclipWrapper.Position = UDim2.new(0.5, -190, 0.82, 0)
NoclipWrapper.Size = UDim2.new(0, 120, 0, 36)
NoclipWrapper.ZIndex = 100
NoclipWrapper.Parent = TigysSABNoclip

local NoclipDragFrame = Instance.new("TextButton")
NoclipDragFrame.Name = "NoclipDragFrame"
NoclipDragFrame.BackgroundTransparency = 1
NoclipDragFrame.Size = UDim2.new(1, 0, 1, 0)
NoclipDragFrame.ZIndex = 103
NoclipDragFrame.Text = ""
NoclipDragFrame.AutoButtonColor = false
NoclipDragFrame.Parent = NoclipWrapper

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel.BackgroundTransparency = 1
ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel.Size = UDim2.new(1, 40, 1, 40)
ImageLabel.ZIndex = 99
ImageLabel.Image = "rbxassetid://5028857084"
ImageLabel.ImageColor3 = Color3.fromRGB(80, 255, 150)
ImageLabel.ImageTransparency = 0.5
ImageLabel.ScaleType = Enum.ScaleType.Fit
ImageLabel.Parent = NoclipWrapper

local TextButton = Instance.new("TextButton")
TextButton.AnchorPoint = Vector2.new(0.5, 0.5)
TextButton.BackgroundColor3 = Color3.fromRGB(18, 15, 24)
TextButton.Position = UDim2.new(0.5, 0, 0.5, 0)
TextButton.Size = UDim2.new(1, 0, 1, 0)
TextButton.ZIndex = 101
TextButton.AutoButtonColor = false
TextButton.Text = ""
TextButton.Parent = NoclipWrapper

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = TextButton

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Thickness = 1.5
UIStroke.Parent = TextButton
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 255, 120)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 255, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 255, 120))
})
UIGradient.Rotation = 270
UIGradient.Parent = UIStroke

local TextLabel = Instance.new("TextLabel")
TextLabel.BackgroundTransparency = 1
TextLabel.Size = UDim2.new(0, 30, 1, 0)
TextLabel.ZIndex = 102
TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextLabel.Text = "🐯"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 14
TextLabel.Parent = TextButton

local TextLabel_2 = Instance.new("TextLabel")
TextLabel_2.BackgroundTransparency = 1
TextLabel_2.Position = UDim2.new(0, 30, 0, 0)
TextLabel_2.Size = UDim2.new(1, -30, 1, 0)
TextLabel_2.ZIndex = 102
TextLabel_2.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextLabel_2.Text = "Noclip"
TextLabel_2.TextColor3 = Color3.fromRGB(240, 255, 245)
TextLabel_2.TextSize = 10
TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_2.Parent = TextButton

local NoclipV2Wrapper = Instance.new("Frame")
NoclipV2Wrapper.Name = "NoclipV2Wrapper"
NoclipV2Wrapper.BackgroundTransparency = 1
NoclipV2Wrapper.Position = UDim2.new(0.5, -60, 0.82, 0)
NoclipV2Wrapper.Size = UDim2.new(0, 120, 0, 36)
NoclipV2Wrapper.ZIndex = 100
NoclipV2Wrapper.Parent = TigysSABNoclip

local NoclipV2DragFrame = Instance.new("TextButton")
NoclipV2DragFrame.Name = "NoclipV2DragFrame"
NoclipV2DragFrame.BackgroundTransparency = 1
NoclipV2DragFrame.Size = UDim2.new(1, 0, 1, 0)
NoclipV2DragFrame.ZIndex = 103
NoclipV2DragFrame.Text = ""
NoclipV2DragFrame.AutoButtonColor = false
NoclipV2DragFrame.Parent = NoclipV2Wrapper

local ImageLabel_2 = Instance.new("ImageLabel")
ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel_2.BackgroundTransparency = 1
ImageLabel_2.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel_2.Size = UDim2.new(1, 40, 1, 40)
ImageLabel_2.ZIndex = 99
ImageLabel_2.Image = "rbxassetid://5028857084"
ImageLabel_2.ImageColor3 = Color3.fromRGB(80, 255, 150)
ImageLabel_2.ImageTransparency = 0.5
ImageLabel_2.ScaleType = Enum.ScaleType.Fit
ImageLabel_2.Parent = NoclipV2Wrapper

local TextButton_2 = Instance.new("TextButton")
TextButton_2.AnchorPoint = Vector2.new(0.5, 0.5)
TextButton_2.BackgroundColor3 = Color3.fromRGB(18, 15, 24)
TextButton_2.Position = UDim2.new(0.5, 0, 0.5, 0)
TextButton_2.Size = UDim2.new(1, 0, 1, 0)
TextButton_2.ZIndex = 101
TextButton_2.AutoButtonColor = false
TextButton_2.Text = ""
TextButton_2.Parent = NoclipV2Wrapper

local UICorner_2 = Instance.new("UICorner")
UICorner_2.CornerRadius = UDim.new(1, 0)
UICorner_2.Parent = TextButton_2

local UIStroke_2 = Instance.new("UIStroke")
UIStroke_2.Color = Color3.fromRGB(255, 255, 255)
UIStroke_2.Thickness = 1.5
UIStroke_2.Parent = TextButton_2

local UIGradient_2 = Instance.new("UIGradient")
UIGradient_2.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 255, 120)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 255, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 255, 120))
})
UIGradient_2.Rotation = 266
UIGradient_2.Parent = UIStroke_2

local TextLabel_3 = Instance.new("TextLabel")
TextLabel_3.BackgroundTransparency = 1
TextLabel_3.Size = UDim2.new(0, 30, 1, 0)
TextLabel_3.ZIndex = 102
TextLabel_3.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextLabel_3.Text = "🐯"
TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.TextSize = 14
TextLabel_3.Parent = TextButton_2

local TextLabel_4 = Instance.new("TextLabel")
TextLabel_4.BackgroundTransparency = 1
TextLabel_4.Position = UDim2.new(0, 30, 0, 0)
TextLabel_4.Size = UDim2.new(1, -30, 1, 0)
TextLabel_4.ZIndex = 102
TextLabel_4.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextLabel_4.Text = "Noclip V2"
TextLabel_4.TextColor3 = Color3.fromRGB(240, 255, 245)
TextLabel_4.TextSize = 10
TextLabel_4.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_4.Parent = TextButton_2

NoclipDragFrame.MouseButton1Click:Connect(function()
    teleportTo(Vector3.new(-99999, -99999, -99999))
end)

NoclipV2DragFrame.MouseButton1Click:Connect(function()
    teleportWithSit(Vector3.new(-99999, -99999, -99999))
end)

makeDraggable(NoclipWrapper, NoclipDragFrame)
makeDraggable(NoclipV2Wrapper, NoclipV2DragFrame)

TigysSABNoclip.Parent = player:WaitForChild("PlayerGui")

return TigysSABNoclip