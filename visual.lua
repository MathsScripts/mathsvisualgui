-- --- MATHS HUB | GUI DE AUTENTICAÇÃO ATUALIZADA ---
local HttpService = game:GetService("HttpService")

local function Notificar(titulo, msg)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = titulo,
        Text = msg,
        Duration = 5
    })
end

-- Criando a Interface
local sg = Instance.new("ScreenGui", gethui and gethui() or game.CoreGui)
sg.Name = "MathsAuth"
sg.ResetOnSpawn = false

local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 280, 0, 180)
f.Position = UDim2.new(0.5, -140, 0.5, -90)
f.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
f.BorderSizePixel = 0
f.Active = true
f.Draggable = true -- Permite mover a GUI

local corner = Instance.new("UICorner", f)
corner.CornerRadius = UDim.new(0, 8)

local stroke = Instance.new("UIStroke", f)
stroke.Color = Color3.fromRGB(0, 255, 136)
stroke.Thickness = 1.8

local title = Instance.new("TextLabel", f)
title.Text = "MATHS HUB SECURITY"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(0, 255, 136)
title.Font = Enum.Font.GothamBold
title.TextSize = 14

local i = Instance.new("TextBox", f)
i.PlaceholderText = "INSIRA A SUA KEY AQUI"
i.Size = UDim2.new(0.85, 0, 0, 40)
i.Position = UDim2.new(0.075, 0, 0.3, 0)
i.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
i.TextColor3 = Color3.new(1, 1, 1)
i.Font = Enum.Font.Gotham
i.TextSize = 12
i.Text = ""

local iCorner = Instance.new("UICorner", i)

local b = Instance.new("TextButton", f)
b.Text = "AUTENTICAR"
b.Size = UDim2.new(0.85, 0, 0, 40)
b.Position = UDim2.new(0.075, 0, 0.65, 0)
b.BackgroundColor3 = Color3.fromRGB(0, 255, 136)
b.Font = Enum.Font.GothamBold
b.TextColor3 = Color3.fromRGB(0, 0, 0)
b.TextSize = 14

local bCorner = Instance.new("UICorner", b)

-- Lógica do Botão
b.MouseButton1Click:Connect(function()
    local inputKey = i.Text:gsub("%s+", "")
    
    if inputKey == "" then
        Notificar("AVISO", "Por favor, cole uma key.")
        return
    end

    b.Text = "A VERIFICAR..."
    b.Active = false

    -- Chamar a função global definida no Loader
    if _G.ValidarUniversal then
        local ok, response, msg = _G.ValidarUniversal(inputKey)
        
        if ok then
            Notificar("SUCESSO", "Acesso concedido! Carregando...")
            sg:Destroy()
            
            -- A 'response' vinda da Worker é o código LUA puro
            local s, err = pcall(function()
                loadstring(response)()
            end)
            
            if not s then
                warn("Erro ao carregar script principal: " .. tostring(err))
            end
        else
            Notificar("FALHA", response) -- 'response' aqui é a mensagem de erro
            b.Text = "AUTENTICAR"
            b.Active = true
        end
    else
        Notificar("ERRO CRÍTICO", "Loader não inicializado corretamente.")
        b.Text = "ERRO"
    end
end)
