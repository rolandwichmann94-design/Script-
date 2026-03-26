-- 💀 OP BRAINROT SYSTEM FIXED 😎🔥

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

-- 🔗 DATABASE
local URL = "https://roblox-bc44c-default-rtdb.firebaseio.com/servers"

-- 🧠 VALUES
local values = {
    ["Lemonchello"] = 100,
    ["Pizzanini"] = 80,
    ["Los ralaleritos"] = 60,
}

-- ⚙️ SETTINGS
local AUTO_JOIN = true

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

-- ================= SEND DATA (FIXED) =================
local function sendData()
    local brainrots = getBrainrots()

    local data = {
        jobId = game.JobId,
        best = getBest(brainrots),
        time = os.time()
    }

    local userURL = URL .. "/" .. player.UserId .. ".json"

    pcall(function()
        game:HttpPut(userURL, HttpService:JSONEncode(data))
    end)
end

-- ================= LOAD =================
local function loadServers()
    local success, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(URL .. ".json"))
    end)

    if not success or not result then
        return {}
    end

    return result
end

-- ================= AUTO JOIN =================
local function autoJoin()
    local servers = loadServers()

    local bestServer = nil
    local bestValue = 0

    for _,server in pairs(servers) do
        if server 
        and server.jobId 
        and server.best 
        and server.jobId ~= game.JobId
        and os.time() - (server.time or 0) < 30 then

            local val = values[server.best] or 0

            if val > bestValue then
                bestValue = val
                bestServer = server
            end
        end
    end

    if AUTO_JOIN and bestServer then
        TeleportService:TeleportToPlaceInstance(
            game.PlaceId,
            bestServer.jobId,
            player
        )
    end
end

-- ================= LOOP =================
while true do
    sendData()
    autoJoin()
    task.wait(5)
end
