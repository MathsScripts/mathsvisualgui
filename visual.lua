-- MATHS HUB - VISUAL GUI (FORCED RENDER)
print("GUI: Iniciando montagem dos objetos")

-- Limpa versões antigas para não dar conflito
if game.CoreGui:FindFirstChild("MathsAuthSystem") then
    game.CoreGui.MathsAuthSystem:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MathsAuthSystem"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true -- Faz a GUI ignorar a barra do Roblox
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 260, 0, 170)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -85)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 136)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true -- GARANTE VISIBILIDADE
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "MATHS HUB SECURITY"
Title.TextColor3 = Color3.fromRGB(0, 255, 136)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Parent = MainFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Name = "KeyInput"
KeyInput.Size = UDim2.new(0.85, 0, 0, 35)
KeyInput.Position = UDim2.new(0.075, 0, 0.35, 0)
KeyInput.PlaceholderText = "INSIRA A KEY AQUI"
KeyInput.Text = ""
KeyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.ClearTextOnFocus = false
KeyInput.Parent = MainFrame

local AuthButton = Instance.new("TextButton")
AuthButton.Name = "AuthButton"
AuthButton.Size = UDim2.new(0.85, 0, 0, 40)
AuthButton.Position = UDim2.new(0.075, 0, 0.65, 0)
AuthButton.Text = "AUTENTICAR"
AuthButton.BackgroundColor3 = Color3.fromRGB(0, 120, 70)
AuthButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AuthButton.Font = Enum.Font.GothamBold
AuthButton.Parent = MainFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.Position = UDim2.new(0, 0, 0.9, 0)
StatusLabel.Text = "Aguardando..."
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Parent = MainFrame

print("GUI: Objetos criados. Conectando botao...")

AuthButton.MouseButton1Click:Connect(function()
    local key = KeyInput.Text
    StatusLabel.Text = "Verificando..."
    
    if _G.ValidarUniversal then
        local sucesso, resultado = _G.ValidarUniversal(key)
        if sucesso then
            StatusLabel.Text = "Sucesso!"
            task.wait(0.5)
            ScreenGui:Destroy()
            loadstring(resultado)()
        else
            StatusLabel.Text = tostring(resultado)
            StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
    else
        StatusLabel.Text = "Erro: Loader nao encontrado"
    end
end)

print("GUI: Script visual finalizado com sucesso!")
