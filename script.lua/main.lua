print("thank YOu for executing the script")
-- GUI Creation
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local FlyButton = Instance.new("TextButton")
local SpeedBox = Instance.new("TextBox")
local HeightBox = Instance.new("TextBox")

-- Parent to Player's GUI
ScreenGui.Parent = game:GetService("CoreGui")

-- Frame setup
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0.4, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.BorderSizePixel = 2

-- Fly Button
FlyButton.Parent = Frame
FlyButton.Size = UDim2.new(0, 180, 0, 50)
FlyButton.Position = UDim2.new(0, 10, 0, 10)
FlyButton.Text = "Toggle Fly"
FlyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

-- Speed Box
SpeedBox.Parent = Frame
SpeedBox.Size = UDim2.new(0, 180, 0, 30)
SpeedBox.Position = UDim2.new(0, 10, 0, 70)
SpeedBox.PlaceholderText = "Enter Speed (Default: 50)"

-- Height Box
HeightBox.Parent = Frame
HeightBox.Size = UDim2.new(0, 180, 0, 30)
HeightBox.Position = UDim2.new(0, 10, 0, 110)
HeightBox.PlaceholderText = "Enter Height (Default: 5)"

-- Flight Variables
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = char:FindFirstChild("HumanoidRootPart")
local flying = false
local flightSpeed = 50
local flightHeight = 5

-- Function to start flying
local function startFlying()
    if flying then return end
    flying = true
    FlyButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red when flying
    
    local bodyVelocity = Instance.new("BodyVelocity", humanoidRootPart)
    bodyVelocity.Velocity = Vector3.new(0, flightHeight, 0)
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

    local bodyGyro = Instance.new("BodyGyro", humanoidRootPart)
    bodyGyro.CFrame = humanoidRootPart.CFrame
    bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)

    while flying do
        humanoidRootPart.Velocity = humanoidRootPart.CFrame.LookVector * flightSpeed
        task.wait()
    end

    bodyVelocity:Destroy()
    bodyGyro:Destroy()
end

-- Function to stop flying
local function stopFlying()
    flying = false
    FlyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Green when stopped
end

-- Toggle Fly Button
FlyButton.MouseButton1Click:Connect(function()
    if flying then
        stopFlying()
    else
        startFlying()
    end
end)

-- Update Speed
SpeedBox.FocusLost:Connect(function()
    local newSpeed = tonumber(SpeedBox.Text)
    if newSpeed and newSpeed > 0 then
        flightSpeed = newSpeed
    end
end)

-- Update Height
HeightBox.FocusLost:Connect(function()
    local newHeight = tonumber(HeightBox.Text)
    if newHeight then
        flightHeight = newHeight
    end
end)
