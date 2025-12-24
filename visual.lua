-- MATHS HUB - GUI ANTI-NIL FIX
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MathsAuthSystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 260, 0, 160)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -80)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "MATHS HUB SECURITY"
Title.TextColor3 = Color3.fromRGB(0, 255, 136)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Name = "KeyInput"
KeyInput.Size = UDim2.new(0.8, 0, 0, 30)
KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyInput.PlaceholderText = "INSIRA A SUA KEY AQUI"
KeyInput.Text = ""
KeyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Parent = MainFrame

local AuthButton = Instance.new("TextButton")
AuthButton.Name = "AuthButton"
AuthButton.Size = UDim2.new(0.8, 0, 0, 40)
AuthButton.Position = UDim2.new(0.1, 0, 0.65, 0)
AuthButton.Text = "AUTENTICAR"
AuthButton.BackgroundColor3 = Color3.fromRGB(0, 120, 70)
AuthButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AuthButton.Font = Enum.Font.GothamBold
AuthButton.Parent = MainFrame

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Position = UDim2.new(0, 0, 0.9, 0)
Status.Text = ""
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.fromRGB(255, 0, 0)
Status.Parent = MainFrame

-- O SEGREDO ESTÁ AQUI: Esperar o botão estar pronto
local Button = MainFrame:WaitForChild("AuthButton")

Button.MouseButton1Click:Connect(function()
    local key = KeyInput.Text
    if key == "" then Status.Text = "Digite a key!" return end

    Status.Text = "Verificando..."
    Status.TextColor3 = Color3.fromRGB(255, 255, 0)

    if _G.ValidarUniversal then
        local sucesso, resultado = _G.ValidarUniversal(key)
        
        if sucesso then
            Status.Text = "Acesso concedido!"
            Status.TextColor3 = Color3.fromRGB(0, 255, 0)
            task.wait(0.5)
            ScreenGui:Destroy()
            
            local func, err = loadstring(resultado)
            if func then 
                func() 
            else 
                warn("Erro no script do banco: "..tostring(err))
            end
        else
            Status.Text = tostring(resultado)
            Status.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
    else
        Status.Text = "Erro: Loader nao carregado!"
    end
end)
