--

-- Services

local PlayerService = game:GetService("Players")

local HttpService = game:GetService("HttpService")

local TeleportService = game:GetService("TeleportService")


-- Local

local User = PlayerService.LocalPlayer


-- Settings

local FileName = "BabScriptInfo.txt"

local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)


-- Functions

function EditFile(Name, Table)
    local JSON = HttpService:JSONEncode(Table)

    writefile(Name, JSON)
end

function ReadFile(Name)
    local JSON = readfile(Name)
    local File = HttpService:JSONDecode(JSON)

    return File
end

function SHop()
    local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

    local Api = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", game.PlaceId)
    local ServersFound = {}
    local Servers = HttpService:JSONDecode(httprequest({Url = Api}).Body)

    if Servers and Servers.data then
        for ServerI, Server in pairs(Servers.data) do
            local JobId = Server.id
            local PlayerCount = tonumber(Server.playing)
            local MaxPlayers = tonumber(Server.maxPlayers)

            if type(Server) == "table" and PlayerCount and MaxPlayers and PlayerCount < MaxPlayers and JobId ~= game.JobId then
                table.insert(ServersFound, Server)
            end
        end
    end

    if #ServersFound > 0 then
        local Info = ReadFile(FileName)
        local HighestServer
        
        for ServerI, Server in pairs(ServersFound) do
            if table.find(Info.Servers, Server) == nil then
                if HighestServer == nil then
                    HighestServer = Server
                end

                if Server.playing > HighestServer.playing then
                    HighestServer = Server
                end
            end
        end

        table.insert(Info.Servers, HighestServer.id)

        EditFile(FileName, Info)

        if queueteleport then
            queueteleport([[
                loadstring(game:HttpGet("https://pastebin.com/raw/bnw1TKPv"))()
            ]])
        end

        TeleportService:TeleportToPlaceInstance(game.PlaceId, HighestServer.id, User)
    end
end


-- BAB Global Auto Steal

if pcall(function() readfile(FileName) end) == false then
    local Default = {
        Servers = {}
    }

    EditFile(FileName, Default)
end

SHop()
