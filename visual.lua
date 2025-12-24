-- MATHS HUB - GUI DE AUTENTICAÇÃO
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local KeyInput = Instance.new("TextBox")
local AuthButton = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")

-- Configuração Visual Básica
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "MathsAuthSystem"

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
MainFrame.Size = UDim2.new(0, 250, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "MATHS HUB AUTH"
Title.TextColor3 = Color3.fromRGB(0, 255, 136)
Title.TextSize = 14

KeyInput.Name = "KeyInput"
KeyInput.Parent = MainFrame
KeyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KeyInput.BorderSizePixel = 0
KeyInput.Position = UDim2.new(0.1, 0, 0.3, 0)
KeyInput.Size = UDim2.new(0.8, 0, 0, 30)
KeyInput.Font = Enum.Font.Gotham
KeyInput.PlaceholderText = "Insira sua Key aqui..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 12

AuthButton.Name = "AuthButton"
AuthButton.Parent = MainFrame
AuthButton.BackgroundColor3 = Color3.fromRGB(0, 255, 136)
AuthButton.BorderSizePixel = 0
AuthButton.Position = UDim2.new(0.1, 0, 0.6, 0)
AuthButton.Size = UDim2.new(0.8, 0, 0, 35)
AuthButton.Font = Enum.Font.GothamBold
AuthButton.Text = "AUTENTICAR"
AuthButton.TextColor3 = Color3.fromRGB(0, 0, 0)
AuthButton.TextSize = 14

StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 0, 0.85, 0)
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Aguardando login..."
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextSize = 10

-- ========================================================
-- LÓGICA DE AUTENTICAÇÃO (O QUE FAZ O BOTÃO FUNCIONAR)
-- ========================================================

AuthButton.MouseButton1Click:Connect(function()
    local key = KeyInput.Text
    
    if key == "" then
        StatusLabel.Text = "Por favor, insira uma key!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        return
    end

    StatusLabel.Text = "Verificando..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)

    -- Chama a função global definida no seu LOADER
    if _G.ValidarUniversal then
        local sucesso, resultado = _G.ValidarUniversal(key)
        
        if sucesso then
            StatusLabel.Text = "Acesso concedido! Carregando..."
            StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            
            -- Espera um pouco para o usuário ver o sucesso e fecha a GUI de login
            task.wait(1)
            ScreenGui:Destroy()
            
            -- EXECUTA O SCRIPT QUE VEIO DO BANCO DE DADOS
            local carregar, erro = loadstring(resultado)
            if carregar then
                carregar()
            else
                warn("Erro ao carregar script do banco: " .. tostring(erro))
            end
        else
            -- Exibe o erro retornado pela Worker (Ex: Key Invalida, Mapa Errado)
            StatusLabel.Text = tostring(resultado)
            StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        end
    else
        StatusLabel.Text = "Erro crítico: Loader não encontrado!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end)
