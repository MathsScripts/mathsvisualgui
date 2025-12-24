-- MATHS HUB - FIX DEFINITIVO
local ScreenGui = game.CoreGui:WaitForChild("MathsAuthSystem", 5) or Instance.new("ScreenGui", game.CoreGui)
local MainFrame = ScreenGui:WaitForChild("MainFrame")
local KeyInput = MainFrame:WaitForChild("KeyInput")
local AuthButton = MainFrame:WaitForChild("AuthButton")
local StatusLabel = MainFrame:WaitForChild("StatusLabel")

AuthButton.MouseButton1Click:Connect(function()
    -- Verificação de segurança para não dar erro de nil
    if not KeyInput or not KeyInput.Text then return end
    
    local key = KeyInput.Text
    StatusLabel.Text = "Verificando..."

    if _G.ValidarUniversal then
        local sucesso, resultado = _G.ValidarUniversal(key)
        if sucesso then
            StatusLabel.Text = "Acesso Concedido!"
            task.wait(0.5)
            ScreenGui:Destroy()
            loadstring(resultado)()
        else
            StatusLabel.Text = tostring(resultado) -- Aqui ele mostrará o erro real
        end
    end
end)
