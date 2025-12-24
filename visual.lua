-- MATHS HUB SECURITY GUI
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Criar Interface
local MathsAuthSystem = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local KeyInput = Instance.new("TextBox")
local AuthButton = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")

MathsAuthSystem.Name = "MathsAuthSystem"
MathsAuthSystem.Parent = CoreGui
MathsAuthSystem.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = MathsAuthSystem
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.BorderSizePixel = 0

local FrameCorner = Instance.new("UICorner")
FrameCorner.Parent = MainFrame

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 10)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "MATHS HUB SECURITY"
Title.TextColor3 = Color3.fromRGB(0, 255, 136)
Title.TextSize = 18

KeyInput.Name = "KeyInput"
KeyInput.Parent = MainFrame
KeyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyInput.Position = UDim2.new(0, 25, 0, 60)
KeyInput.Size = UDim2.new(0, 250, 0, 40)
KeyInput.Font = Enum.Font.Gotham
KeyInput.PlaceholderText = "Insira sua Key aqui..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 14

local KeyCorner = Instance.new("UICorner")
KeyCorner.Parent = KeyInput

AuthButton.Name = "AuthButton"
AuthButton.Parent = MainFrame
AuthButton.BackgroundColor3 = Color3.fromRGB(0, 110, 60)
AuthButton.Position = UDim2.new(0, 25, 0, 115)
AuthButton.Size = UDim2.new(0, 250, 0, 45)
AuthButton.Font = Enum.Font.GothamBold
AuthButton.Text = "AUTENTICAR"
AuthButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AuthButton.TextSize = 16

local BtnCorner = Instance.new("UICorner")
BtnCorner.Parent = AuthButton

StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 0, 0, 165)
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.TextSize = 12

--- Lógica de Autenticação ---

AuthButton.MouseButton1Click:Connect(function()
    local key = KeyInput.Text
    if key == "" then
        StatusLabel.Text = "Por favor, insira uma key!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
        return
    end

    StatusLabel.Text = "Verificando..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

    -- Sincronização: Espera o Loader carregar a função global caso haja delay
    local attempts = 0
    while not _G.ValidarUniversal and attempts < 20 do
        task.wait(0.2)
        attempts = attempts + 1
    end

    if _G.ValidarUniversal then
        local sucesso, resultado = _G.ValidarUniversal(key)

        if sucesso then
            StatusLabel.Text = "Acesso Concedido!"
            StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 136)
            task.wait(1)
            MathsAuthSystem:Destroy()
            
            -- Executa o script retornado pela Worker
            local func, err = loadstring(resultado)
            if func then
                func()
            else
                warn("Erro ao carregar script principal: " .. tostring(err))
            end
        else
            -- Se a Worker retornar 404/501, cai aqui
            StatusLabel.Text = "Key Inválida ou IP Bloqueado!"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        end
    else
        StatusLabel.Text = "ERRO: Loader não encontrado!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end)
