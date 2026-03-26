-- 💀 ULTRA OP BRAINROT SYSTEM 😎🔥

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

-- 🔗 DATABASE
local URL = "https://roblox-bc44c-default-rtdb.firebaseio.com/servers.json"

-- 🧠 VALUES
local values = {
    ["Lemonchello"] = 100,
    ["Pizzanini"] = 80,
    ["Los ralaleritos"] = 60,
}

-- ⚙️ SETTINGS
local AUTO_JOIN = true
local X_RAY = true

-- ================= GUI =================
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "OPBrainrotUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 330, 0, 400)
frame.Position = UDim2.new(0.5, -165, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(15,10,5)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 18)

-- 🔥 ULTRA GLOW (MEHRERE LAYER)
for i = 1,4 do
    local glow = Instance.new("ImageLabel", frame)
    glow.Size = UDim2.new(1, 60 + i*10, 1, 60 + i*10)
    glow.Position = UDim2.new(0, -30 - i*5, 0, -30 - i*5)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://5028857084"
    glow.ImageColor3 = Color3.fromRGB(255,120,0)
    glow.ImageTransparency = 0.6 - (i*0.1)
    glow.ScaleType = Enum.ScaleType.Slice
    glow.SliceCenter = Rect.new(24,24,276,276)
end

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 4

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,50)
title.Text = "🔥 OP BRAINROT 🔥"
title.TextColor3 = Color3.fromRGB(255,180,80)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBlack
title.TextScaled = true

local list = Instance.new("ScrollingFrame", frame)
list.Size = UDim2.new(1,-10,1,-60)
list.Position = UDim2.new(0,5,0,55)
list.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", list)
layout.Padding = UDim.new(0,8)

-- 🌈 ULTRA ANIMATION
task.spawn(function()
    local t = 0
    while true do
        t += 0.08

        stroke.Color = Color3.fromRGB(
            255,
            120 + math.sin(t)*80,
            0
        )

        stroke.Thickness = 4 + math.abs(math.sin(t))*4

        frame.BackgroundColor3 = Color3.fromRGB(
            20 + math.sin(t)*10,
            10,
            5
        )

        task.wait()
    end
end)

-- ================= BRAINROT =================
local function getBrainrots()
    local found = {}
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return found end

    for _,plot in pairs(plots:GetChildren()) do
        for _,obj in pairs(plot:GetDescendants()) do
            if obj.Name == "BrainrotRootPartAttachment" then
                local model = obj.Parent and obj.Parent.Parent
                if model then
                    table.insert(found, model.Name)
                end
            end
        end
    end

    return found
end

local function getBest(brainrots)
    local best, bestValue = "None", 0
    for _,name in pairs(brainrots) do
        local val = values[name] or 0
        if val > bestValue then
            bestValue = val
            best = name
        end
    end
    return best
end

-- ================= SEND =================
local function sendData()
    local brainrots = getBrainrots()

    local data = {
        jobId = game.JobId,
        best = getBest(brainrots)
    }

    pcall(function()
        game:HttpPost(URL, HttpService:JSONEncode(data))
    end)
end

local function loadServers()
    local success, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(URL))
    end)
    return success and result or {}
end

-- ================= UI =================
local function createItem(server)
    local item = Instance.new("Frame")
    item.Size = UDim2.new(1,0,0,60)
    item.BackgroundColor3 = Color3.fromRGB(40,20,10)
    Instance.new("UICorner", item)

    local text = Instance.new("TextLabel", item)
    text.Size = UDim2.new(0.6,0,1,0)
    text.Text = server.best.." 🔥"
    text.TextColor3 = Color3.new(1,1,1)
    text.BackgroundTransparency = 1
    text.TextScaled = true

    local btn = Instance.new("TextButton", item)
    btn.Size = UDim2.new(0.4,-5,0.8,0)
    btn.Position = UDim2.new(0.6,5,0.1,0)
    btn.Text = "JOIN"
    btn.BackgroundColor3 = Color3.fromRGB(255,120,0)

    btn.MouseButton1Click:Connect(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, server.jobId, player)
    end)

    return item
end

-- ================= ESP =================
local function playerESP()
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            if not p.Character:FindFirstChild("ESP") then
                local h = Instance.new("Highlight")
                h.Name = "ESP"
                h.FillColor = Color3.fromRGB(0,255,150)
                h.FillTransparency = 0.5
                h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                h.Parent = p.Character
            end
        end
    end
end

-- ================= XRAY =================
local function applyXray()
    if not X_RAY then return end
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return end

    for _,plot in pairs(plots:GetChildren()) do
        for _,obj in pairs(plot:GetDescendants()) do
            if obj.Name == "BrainrotRootPartAttachment" then
                local model = obj.Parent and obj.Parent.Parent
                if model and not model:FindFirstChild("Xray") then
                    local h = Instance.new("Highlight")
                    h.FillColor = Color3.fromRGB(255,140,0)
                    h.FillTransparency = 0.4
                    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    h.Parent = model
                end
            end
        end
    end
end

-- ================= UPDATE =================
local function update()
    list:ClearAllChildren()

    local servers = loadServers()

    local bestServer = nil
    local bestValue = 0

    for _,server in pairs(servers) do
        if server and server.jobId and server.best and server.jobId ~= game.JobId then
            
            local val = values[server.best] or 0

            if val > bestValue then
                bestValue = val
                bestServer = server
            end

            local item = createItem(server)
            item.Parent = list
        end
    end

    if AUTO_JOIN and bestServer then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, bestServer.jobId, player)
    end
end

-- ================= LOOP =================
while true do
    sendData()
    update()
    playerESP()
    applyXray()
    task.wait(5)
end
