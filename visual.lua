-- MATHS HUB | PREMIUM UI (GITHUB)
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

if CoreGui:FindFirstChild("MathsAuth") then CoreGui.MathsAuth:Destroy() end

local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = "MathsAuth"

-- FRAME PRINCIPAL (Design Glassmorphism)
local Main = Instance.new("Frame", Screen)
Main.Name = "Main"
Main.Size = UDim2.new(0, 340, 0, 200)
Main.Position = UDim2.new(0.5, -170, 0.5, -100)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.BackgroundTransparency = 0.1
Main.ClipsDescendants = true

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 12)

-- BORDA COM GRADIENTE NEON
local UIStroke = Instance.new("UIStroke", Main)
UIStroke.Thickness = 2
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
local Gradient = Instance.new("UIGradient", UIStroke)
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 136)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 255))
})

-- BRILHO DE FUNDO (EFEITO VIBRANT)
local Glow = Instance.new("ImageLabel", Main)
Glow.Size = UDim2.new(1.5, 0, 1.5, 0)
Glow.Position = UDim2.new(-0.25, 0, -0.25, 0)
Glow.BackgroundTransparency = 1
Glow.Image = "rbxassetid://7144005282" -- Sombras suaves
Glow.ImageColor3 = Color3.fromRGB(0, 255, 136)
Glow.ImageTransparency = 0.8
Glow.ZIndex = 0

-- TÍTULO
local Title = Instance.new("TextLabel", Main)
Title.Text = "MATHS HUB"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.BackgroundTransparency = 1

-- CAMPO DE ENTRADA (KEY)
local InputFrame = Instance.new("Frame", Main)
InputFrame.Size = UDim2.new(0, 280, 0, 45)
InputFrame.Position = UDim2.new(0.5, -140, 0.4, 0)
InputFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", InputFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", InputFrame).Color = Color3.fromRGB(40, 40, 40)

local Input = Instance.new("TextBox", InputFrame)
Input.Size = UDim2.new(1, -20, 1, 0)
Input.Position = UDim2.new(0, 10, 0, 0)
Input.BackgroundTransparency = 1
Input.PlaceholderText = "Enter your license key..."
Input.Text = ""
Input.TextColor3 = Color3.fromRGB(255, 255, 255)
Input.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
Input.Font = Enum.Font.Gotham
Input.TextSize = 14

-- BOTÃO DE LOGIN
local Btn = Instance.new("TextButton", Main)
Btn.Text = "AUTHENTICATE"
Btn.Size = UDim2.new(0, 280, 0, 45)
Btn.Position = UDim2.new(0.5, -140, 0.7, 0)
Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Btn.Font = Enum.Font.GothamBold
Btn.TextSize = 14
Btn.TextColor3 = Color3.fromRGB(10, 10, 10)
Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)

local BtnGradient = Instance.new("UIGradient", Btn)
BtnGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 136)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 255))
})

-- STATUS
local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Position = UDim2.new(0, 0, 0.9, 0)
Status.Text = "System Ready"
Status.TextColor3 = Color3.fromRGB(150, 150, 150)
Status.Font = Enum.Font.Gotham
Status.TextSize = 11
Status.BackgroundTransparency = 1

-- ANIMAÇÕES DE HOVER (BOTÃO)
Btn.MouseEnter:Connect(function()
    TweenService:Create(Btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(200, 200, 200)}):Play()
end)
Btn.MouseLeave:Connect(function()
    TweenService:Create(Btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)

-- LOGICA DE CHAMADA
Btn.MouseButton1Click:Connect(function()
    if getgenv().ExecuteAuth then
        Status.Text = "Verifying..."
        getgenv().ExecuteAuth(Input.Text, function(success, msg)
            if success then
                Status.Text = "Welcome!"
                Status.TextColor3 = Color3.fromRGB(0, 255, 136)
                task.wait(1)
                Screen:Destroy()
            else
                Status.Text = "Error: " .. tostring(msg)
                Status.TextColor3 = Color3.fromRGB(255, 70, 70)
            end
        end)
    end
end)
