-- MATHS HUB VISUAL (v100%)
local CoreGui = game:GetService("CoreGui")
local ScreenGui = Instance.new("ScreenGui", CoreGui)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 300, 0, 200)
Main.Position = UDim2.new(0.5, -150, 0.5, -100)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

local KeyBox = Instance.new("TextBox", Main)
KeyBox.Size = UDim2.new(0, 250, 0, 40)
KeyBox.Position = UDim2.new(0, 25, 0, 60)
KeyBox.PlaceholderText = "Insira sua Key..."

local Btn = Instance.new("TextButton", Main)
Btn.Size = UDim2.new(0, 250, 0, 40)
Btn.Position = UDim2.new(0, 25, 0, 120)
Btn.Text = "AUTENTICAR"
Btn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)

local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Position = UDim2.new(0, 0, 0, 170)
Status.Text = ""
Status.TextColor3 = Color3.fromRGB(255, 255, 255)

Btn.MouseButton1Click:Connect(function()
    local key = KeyBox.Text
    Status.Text = "Verificando..."
    
    -- Sincronização com o Loader
    local validar = getgenv().ValidarUniversal or _G.ValidarUniversal
    
    if validar then
        local ok, scriptBody = validar(key)
        if ok then
            Status.Text = "Sucesso!"
            ScreenGui:Destroy()
            loadstring(scriptBody)()
        else
            Status.Text = "Key Inválida ou IP Bloqueado!"
            Status.TextColor3 = Color3.fromRGB(255, 50, 50)
        end
    else
        Status.Text = "ERRO: Loader não encontrado!"
    end
end)
