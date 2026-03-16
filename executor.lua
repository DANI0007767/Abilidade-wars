-- Habilit Wars - Display de Habilidades Compacto
-- Execute com: .loadstring(game:HttpGet('https://raw.githubusercontent.com/DANI0007767/Habilit-wars/main/executor.lua'))()

local Players = game:GetService("Players")
local function getHabilidade(p)
    local c = p.Character
    if not c then return "Nenhuma" end
    for _,v in pairs(c:GetChildren()) do if v:IsA("Tool") then return v.Name end end
    local b = p:FindFirstChild("Backpack")
    if b then for _,v in pairs(b:GetChildren()) do if v:IsA("Tool") then return v.Name end end end
    for n,v in pairs(c:GetAttributes()) do if string.find(string.lower(n),"ability") or string.find(string.lower(n),"skill") then return tostring(v) end end
    for _,v in pairs(c:GetChildren()) do if v:IsA("StringValue") and (string.find(string.lower(v.Name),"ability") or string.find(string.lower(v.Name),"skill")) then return tostring(v.Value) end end
    return "Nenhuma"
end
local function createDisplay(p)
    local c = p.Character
    if not c then return end
    local h = c:FindFirstChild("Head")
    if not h or h:FindFirstChild("AbilityDisplay") then return end
    local g = Instance.new("BillboardGui",h)
    g.Name = "AbilityDisplay"
    g.Size = UDim2.new(0,200,0,50)
    g.StudsOffset = Vector3.new(0,3.5,0)
    g.AlwaysOnTop = true
    g.MaxDistance = 200
    local t = Instance.new("TextLabel",g)
    t.Size = UDim2.new(1,0,1,0)
    t.BackgroundTransparency = 1
    t.TextScaled = true
    t.TextStrokeTransparency = 0
    t.Font = Enum.Font.GothamBold
    t.TextColor3 = Color3.new(1,1,1)
    t.TextStrokeColor3 = Color3.new(0,0,0)
    t.TextWrapped = true
    task.spawn(function()
        while g and g.Parent do
            t.Text = p.Name.."\n"..getHabilidade(p)
            task.wait(0.5)
        end
    end)
end
local function setup(p)
    if p.Character then createDisplay(p) end
    p.CharacterAdded:Connect(function() task.wait(1) createDisplay(p) end)
end
for _,p in pairs(Players:GetPlayers()) do setup(p) end
Players.PlayerAdded:Connect(function(p) task.wait(1) setup(p) end)
print("✅ Habilit Wars Display Ativado!")
