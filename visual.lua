-- MATHS HUB - GUI OFICIAL E COMPLETA
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MathsAuthSystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- Frame Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 260, 0, 170)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -85)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Cantos Arredondados
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "MATHS HUB SECURITY"
Title.TextColor3 = Color3.fromRGB(0, 255, 136)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Parent = MainFrame

-- Caixa de Entrada (KeyInput)
local KeyInput = Instance.new("TextBox")
KeyInput.Name = "KeyInput"
KeyInput.Size = UDim2.new(0.85, 0, 0, 35)
KeyInput.Position = UDim2.new(0.075, 0, 0.3, 0)
KeyInput.PlaceholderText = "INSIRA A SUA KEY AQUI"
KeyInput.Text = ""
KeyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 12
KeyInput.Parent = MainFrame

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 6)
KeyCorner.Parent = KeyInput

-- Botão de Autenticar
local AuthButton = Instance.new("TextButton")
AuthButton.Name = "AuthButton"
AuthButton.Size = UDim2.new(0.85, 0, 0, 40)
AuthButton.Position = UDim2.new(0.075, 0, 0.6, 0)
AuthButton.Text = "AUTENTICAR"
AuthButton.BackgroundColor3 = Color3.fromRGB(0, 120, 70)
AuthButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AuthButton.Font = Enum.Font.GothamBold
AuthButton.TextSize = 14
AuthButton.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = AuthButton

-- Texto de Status/Erro
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.Position = UDim2.new(0, 0, 0.85, 0)
StatusLabel.Text = "Aguardando login..."
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 11
StatusLabel.Parent = MainFrame

-- ============================================================
-- LÓGICA DE FUNCIONAMENTO
-- ============================================================

AuthButton.MouseButton1Click:Connect(function()
    local key = KeyInput.Text
    
    if key == "" or key == " " then
        StatusLabel.Text = "Por favor, digite uma key!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        return
    end

    StatusLabel.Text = "Verificando dados..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)

    -- Verifica se o Loader global está presente
    if _G.ValidarUniversal then
        local sucesso, resultado = _G.ValidarUniversal(key)
        
        if sucesso then
            StatusLabel.Text = "ACESSO CONCEDIDO!"
            StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
            
            task.wait(1)
            ScreenGui:Destroy()
            
            -- Executa o script que veio da Worker (coluna source_code)
            local carregar, erro = loadstring(resultado)
            if carregar then
                carregar()
            else
                warn("Erro ao executar script carregado: " .. tostring(erro))
            end
        else
            -- Se falhar, resultado contém a mensagem da Worker (Ex: Mapa Incorreto)
            StatusLabel.Text = tostring(resultado)
            StatusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        end
    else
        StatusLabel.Text = "ERRO: Loader não encontrado!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end)
