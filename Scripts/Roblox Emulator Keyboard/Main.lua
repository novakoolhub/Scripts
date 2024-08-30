-- Services

local HttpService = game:GetService("HttpService")

local VirtualService = game:GetService("VirtualUser")


-- Locals

getgenv().NovIP = nil


-- Emulator keyboard Main

while true do
    if getgenv().NovIP then
        local KeysDown = HttpService:JSONDecode(game:HttpGet(getgenv().NovIP))
        
        for Key, State in pairs(KeysDown) do
            pcall(function()
                if State == true then
                    VirtualService:SetKeyDown(Key)
                else
                    VirtualService:SetKeyUp(Key)
                end
            end)
        end
    end

    task.wait()
end
