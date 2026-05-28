-- Скрипт телепортации для Delivery Not Guaranteed (РАБОЧАЯ ВЕРСИЯ)

local distance = 30000  -- Меняй здесь (20000 - 60000)

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- Поиск спавна
local spawn = workspace:FindFirstChild("SpawnLocation")
if not spawn then
    spawn = workspace:FindFirstChild("Spawn")
end
if not spawn then
    spawn = workspace:FindFirstChild("StartPoint")
end

if not spawn then
    warn("Спавн не найден! Использую текущую позицию.")
    spawn = hrp
end

-- Телепорт
local newPos = spawn.Position + (hrp.CFrame.LookVector * distance)
hrp.CFrame = CFrame.new(newPos)

-- РАБОТАЮЩЕЕ уведомление для эксплойтов
game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
    Text = "✅ Телепорт на " .. distance .. " studs от спавна!",
    Color = Color3.fromRGB(0, 255, 0)
})

-- Альтернативный способ (если ChatMakeSystemMessage не работает)
print("Телепорт выполнен! Расстояние: " .. distance .. " studs")
