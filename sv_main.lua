local function getPolApply(pedCoords)
    local distance = #(pedCoords - Config.Coords[1].coords)
    local closest = 1
    for i = 1, #Config.Coords do
        local hall = Config.Coords[i]
        local dist = #(pedCoords - hall.coords)
        if dist < distance then
            distance = dist
            closest = i
        end
    end
    return closest
end

RegisterServerEvent('ld-polapply:sendApply', function(input)
    local src = source
    local ped = GetPlayerPed(src)
    local pedCoords = GetEntityCoords(ped)
    local closestPolApply = getPolApply(pedCoords)
    local applyCoords = Config.Coords[closestPolApply].coords
    if #(pedCoords - applyCoords) >= 20.0 then
        return DropPlayer(src, "Attempted exploit abuse")
    end
    local date = os.date('%d-%m-%Y')
    local embed = {
          {
            ["thumbnail"] = {
                ["url"] = "https://static.wikia.nocookie.net/alterlifepolicedepartement/images/5/51/R_%281%29.png/revision/latest?cb=20220111090530"
            },
            ["color"] = 1127128,
            ["title"] = 'Police application',
            ["description"] = '**First and Last Names:** '..input[1]..'\n **Age:** '..input[2]..'\n **Date of Birth:** '..date..'\n **Phone number:** '..input[4]..'\n **Gender:** '..input[5]..'\n **Do you have experience in this work?:** '..input[6]..'\n **Why you want to become a police officer?:** '..input[7]..'\n\n **Discord: **'..input[8],
          }
      }
    
    PerformHttpRequest(Config.WebHook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end)
