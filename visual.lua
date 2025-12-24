-- MATHS HUB - GUI ESTÁVEL (FIX ANTI-NIL)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MathsAuthSystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 260, 0, 160)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -80)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Parent = ScreenGui

local KeyInput = Instance.new("TextBox")
KeyInput.Name = "KeyInput"
KeyInput.Size = UDim2.new(0.8, 0, 0, 30)
KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyInput.PlaceholderText = "INSIRA A SUA KEY AQUI"
KeyInput.Parent = MainFrame

local AuthButton = Instance.new("TextButton")
AuthButton.Name = "AuthButton"
AuthButton.Size = UDim2.new(0.8, 0, 0, 40)
AuthButton.Position = UDim2.new(0.1, 0, 0.65, 0)
AuthButton.Text = "AUTENTICAR"
AuthButton.Parent = MainFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Position = UDim2.new(0, 0, 0.9, 0)
StatusStatusLabel.Text = "Aguardando..."
StatusLabel.Parent = MainFrame

-- Aguarda o carregamento completo para evitar o erro de 'nil'
task.wait(0.5)

if AuthButton then
    AuthButton.MouseButton1Click:Connect(function()
        local key = KeyInput.Text
        if key == "" then StatusLabel.Text = "Digite a key!" return end

        if _G.ValidarUniversal then
            local sucesso, resultado = _G.ValidarUniversal(key)
            if sucesso then
                StatusLabel.Text = "Sucesso!"
                task.wait(0.5)
                ScreenGui:Destroy()
                loadstring(resultado)() 
            else
                StatusLabel.Text = tostring(resultado) -- Mostra erro da Worker
            end
        else
            StatusLabel.Text = "Erro: Loader não encontrado"
        end
    end)
end
