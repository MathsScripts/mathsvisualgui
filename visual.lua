-- --- INTERFACE E LÓGICA DE LOGIN (Hospedado no GitHub) ---
local HttpService = game:GetService("HttpService")
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()

local function Notificar(titulo, msg)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = titulo,
        Text = msg,
        Duration = 5
    })
end

-- Criando a Interface Gráfica
local sg = Instance.new("ScreenGui", gethui and gethui() or game.CoreGui)
local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 260, 0, 160)
f.Position = UDim2.new(0.5, -130, 0.5, -80)
f.BackgroundColor3 = Color3.fromRGB(12,12,12)
f.BorderSizePixel = 0

local corner = Instance.new("UICorner", f)
local stroke = Instance.new("UIStroke", f)
stroke.Color = Color3.fromRGB(0, 255, 136)
stroke.Thickness = 1.5

local i = Instance.new("TextBox", f)
i.PlaceholderText = "COLE SUA KEY AQUI"
i.Size = UDim2.new(0.8, 0, 0, 35)
i.Position = UDim2.new(0.1, 0, 0.25, 0)
i.BackgroundColor3 = Color3.fromRGB(25,25,25)
i.TextColor3 = Color3.new(1,1,1)
i.Text = ""

local b = Instance.new("TextButton", f)
b.Text = "AUTENTICAR"
b.Size = UDim2.new(0.8, 0, 0, 35)
b.Position = UDim2.new(0.1, 0, 0.6, 0)
b.BackgroundColor3 = Color3.fromRGB(0, 255, 136)
b.Font = Enum.Font.GothamBold
b.TextColor3 = Color3.fromRGB(0,0,0)

b.MouseButton1Click:Connect(function()
    local input = i.Text:gsub("%s+", "")
    -- A função ValidarUniversal é definida no Loader que está no App
    local ok, link, prod = ValidarUniversal(input) 
    
    if ok then
        Notificar("LOGIN SUCESSO", "Produto: " .. prod)
        wait(1)
        sg:Destroy()
        -- Carrega o Script final do produto
        loadstring(game:HttpGet(link))()
    else
        Notificar("ERRO", link)
    end
end)
