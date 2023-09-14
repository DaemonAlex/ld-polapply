CreateThread(function()
    for k, v in pairs(Config.Coords) do
        if Config.Target == 'OX' then
            exports.ox_target:addBoxZone({
            	name = v.name,
            	coords = vec3(v.coords.x, v.coords.y, v.coords.z-1),
            	size = vec3(2, 0.9, 6),
            	rotation = 0.0,
                options = {
                    {
                        name = 'pol_apply',
                        event = 'ld-polapply:openApply',
                        icon = 'fa-solid fa-shield',
                        label = Config.TargetLabel,
                    }
                }
            })
        elseif Config.Target == 'QB' then
            exports['qb-target']:AddBoxZone(v.name, vector3(v.coords.x, v.coords.y, v.coords.z-2), 2, 0.9, {
                name = v.name,
                heading = v.coords.w,
                debugPoly = false,
                minZ = v.coords.z-1,
                maxZ = v.coords.z+1,
            }, {
                options = {
                    {
                        name = 'pol_apply',
                        event = 'ld-polapply:openApply',
                        icon = 'fa-solid fa-shield',
                        label = Config.TargetLabel,
                    }
                },
                distance = 1
            })
        end
    end
end)

RegisterNetEvent('ld-polapply:openApply', function()
    local input = lib.inputDialog('Application for Police Job', {
        {type = 'input', label = 'First and last names', description = 'Your names here...', required = true},
        {type = 'number', label = 'Whats your age?', description = 'Your age here..', required = true},
        {type = 'date', label = 'Date Of Birth', icon = {'far', 'calendar'}, format = "DD/MM/YYYY", required = true},
        {type = 'input', label = 'Your phone number', description = 'Your phone number here...', required = true},
        {type = 'select', label = 'Gender', options = {
            {value = 'Male', label = 'Male'},
            {value = 'Woman', label = 'Woman'}
        }, required = true},
        {type = 'select', label = 'Do you have experience in this work?', options = {
            {value = 'Yes', label = 'Yes'},
            {value = 'No', label = 'No'}
        }, required = true},
        {type = 'textarea', label = 'Why you want to become a police officer?', required = true, min = 10, max = 300},
        {type = 'input', label = 'Discord:', required = true},
      })

     TriggerServerEvent('ld-polapply:sendApply', input)
end)