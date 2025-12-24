-- MATHS HUB - GUI FIX
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MathsAuthSystem"
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 260, 0, 160)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -80)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "MATHS HUB SECURITY"
Title.TextColor3 = Color3.fromRGB(0, 255, 136)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Caixa de Entrada
local KeyInput = Instance.new("TextBox")
KeyInput.Name = "KeyInput"
KeyInput.Size = UDim2.new(0.8, 0, 0, 30)
KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyInput.PlaceholderText = "INSIRA A SUA KEY AQUI"
KeyInput.Text = ""
KeyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Parent = MainFrame

-- BOTÃO DE AUTENTICAR (Onde dava o erro)
local AuthButton = Instance.new("TextButton")
AuthButton.Name = "AuthButton"
AuthButton.Size = UDim2.new(0.8, 0, 0, 40)
AuthButton.Position = UDim2.new(0.1, 0, 0.65, 0)
AuthButton.Text = "AUTENTICAR"
AuthButton.BackgroundColor3 = Color3.fromRGB(0, 120, 70)
AuthButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AuthButton.Font = Enum.Font.GothamBold
AuthButton.Parent = MainFrame

-- Status de Erro
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Position = UDim2.new(0, 0, 0.9, 0)
Status.Text = ""
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.fromRGB(255, 0, 0)
Status.Font = Enum.Font.Gotham
Status.Parent = MainFrame

-- Lógica de Autenticação
AuthButton.MouseButton1Click:Connect(function()
    local key = KeyInput.Text
    if key == "" then 
        Status.Text = "Insira uma key!" 
        return 
    end

    Status.Text = "Verificando..."
    Status.TextColor3 = Color3.fromRGB(255, 255, 0)

    -- Verifica se a função do Loader está pronta
    if _G.ValidarUniversal then
        local sucesso, resultado = _G.ValidarUniversal(key)
        
        if sucesso then
            Status.Text = "Sucesso! Carregando..."
            Status.TextColor3 = Color3.fromRGB(0, 255, 0)
            task.wait(0.5)
            ScreenGui:Destroy()
            
            -- Executa o script que vem da Worker
            local func, err = loadstring(resultado)
            if func then func() else warn("Erro no script: "..tostring(err)) end
        else
            Status.Text = tostring(resultado) -- Mostra "Mapa Incorreto" ou "Key Invalida"
            Status.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
    else
        Status.Text = "Erro: Loader nao inicializado!"
    end
end)
