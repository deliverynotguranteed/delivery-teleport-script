-- Скрипт телепортации с GUI окном (Delivery Not Guaranteed)
-- by deliverynotguaranteed

local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
local mainFrame = Instance.new("Frame")
local titleBar = Instance.new("Frame")
local title = Instance.new("TextLabel")
local closeBtn = Instance.new("TextButton")
local minimizeBtn = Instance.new("TextButton")
local tpBtn = Instance.new("TextButton")
local distanceLabel = Instance.new("TextLabel")
local slider = Instance.new("Frame") -- для ползунка (простая версия)
local sliderBtn = Instance.new("TextButton")
local miniBtn = Instance.new("TextButton") -- кнопка для восстановления после сворачивания

-- Настройка GUI
screenGui.Name = "TeleportGUI"
screenGui.Parent = game.CoreGui

-- Главное окно
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 250, 0, 150)
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- можно перетаскивать за заголовок

-- Верхняя панель (для перетаскивания и кнопок)
titleBar.Parent = mainFrame
titleBar.Size = UDim2.new(1, 0, 0, 25)
titleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
titleBar.BorderSizePixel = 0

-- Заголовок
title.Parent = titleBar
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 5, 0, 0)
title.Text = "Teleport v1.0"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1

-- Кнопка закрытия
closeBtn.Parent = titleBar
closeBtn.Size = UDim2.new(0, 25, 1, 0)
closeBtn.Position = UDim2.new(1, -25, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.BorderSizePixel = 0

-- Кнопка сворачивания
minimizeBtn.Parent = titleBar
minimizeBtn.Size = UDim2.new(0, 25, 1, 0)
minimizeBtn.Position = UDim2.new(1, -50, 0, 0)
minimizeBtn.Text = "_"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
minimizeBtn.BorderSizePixel = 0

-- Кнопка телепорта
tpBtn.Parent = mainFrame
tpBtn.Size = UDim2.new(0, 200, 0, 40)
tpBtn.Position = UDim2.new(0.5, -100, 0, 60)
tpBtn.Text = "ТЕЛЕПОРТ НА 30K STUDS"
tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
tpBtn.BorderSizePixel = 0

-- Метка с расстоянием
distanceLabel.Parent = mainFrame
distanceLabel.Size = UDim2.new(0, 200, 0, 25)
distanceLabel.Position = UDim2.new(0.5, -100, 0, 30)
distanceLabel.Text = "Расстояние: 30000 studs"
distanceLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
distanceLabel.BackgroundTransparency = 1

-- Простой "ползунок" (кнопки +/-, так как сделать настоящий слайдер дольше)
local decBtn = Instance.new("TextButton")
local incBtn = Instance.new("TextButton")
local valueLabel = Instance.new("TextLabel")

decBtn.Parent = mainFrame
decBtn.Size = UDim2.new(0, 30, 0, 25)
decBtn.Position = UDim2.new(0.5, -80, 0, 30)
decBtn.Text = "-"
decBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
decBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)

incBtn.Parent = mainFrame
incBtn.Size = UDim2.new(0, 30, 0, 25)
incBtn.Position = UDim2.new(0.5, 50, 0, 30)
incBtn.Text = "+"
incBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
incBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)

valueLabel.Parent = mainFrame
valueLabel.Size = UDim2.new(0, 60, 0, 25)
valueLabel.Position = UDim2.new(0.5, -30, 0, 30)
valueLabel.Text = "30000"
valueLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
valueLabel.BackgroundTransparency = 1

-- Маленькая кнопка для восстановления (появляется когда окно свернуто)
miniBtn.Parent = screenGui
miniBtn.Size = UDim2.new(0, 50, 0, 50)
miniBtn.Position = UDim2.new(0, 20, 0, 100)
miniBtn.Text = "TP"
miniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
miniBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
miniBtn.BorderSizePixel = 0
miniBtn.Visible = false

-- Переменные
local distance = 30000
local isMinimized = false

-- Функция телепорта
local function teleport()
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local spawn = workspace:FindFirstChild("SpawnLocation") or 
                  workspace:FindFirstChild("Spawn") or 
                  workspace:FindFirstChild("StartPoint")
    
    if not spawn then
        warn("Спавн не найден!")
        return
    end
    
    local newPos = spawn.Position + (hrp.CFrame.LookVector * distance)
    hrp.CFrame = CFrame.new(newPos)
    
    -- Уведомление
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = "✅ Телепорт на " .. distance .. " studs!",
        Color = Color3.fromRGB(0, 255, 0)
    })
end

-- Обновление меток
local function updateUI()
    valueLabel.Text = tostring(distance)
    distanceLabel.Text = "Расстояние: " .. distance .. " studs"
    tpBtn.Text = "ТЕЛЕПОРТ НА " .. distance .. " STUDS"
end

-- Кнопки +/-
decBtn.MouseButton1Click:Connect(function()
    distance = math.max(20000, distance - 1000)
    updateUI()
end)

incBtn.MouseButton1Click:Connect(function()
    distance = math.min(60000, distance + 1000)
    updateUI()
end)

-- Телепорт
tpBtn.MouseButton1Click:Connect(teleport)

-- Закрытие
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Сворачивание
minimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = true
    mainFrame.Visible = false
    miniBtn.Visible = true
end)

-- Восстановление из свернутого состояния
miniBtn.MouseButton1Click:Connect(function()
    isMinimized = false
    mainFrame.Visible = true
    miniBtn.Visible = false
end)

-- Чтобы можно было перетаскивать окно за заголовок
local dragging = false
local dragStart
local startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

print("GUI скрипт загружен! Используй + и - для изменения расстояния.")
