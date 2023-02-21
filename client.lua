local Promise = nil

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
    if Promise then
        Promise:resolve(false)
    end
end)

RegisterNUICallback('succeed', function()
    SetNuiFocus(false, false)
    Promise:resolve(true)
end)

RegisterNUICallback('failed', function()
    SetNuiFocus(false, false)
    Promise:resolve(false)
end)

RegisterCommand('lockpicktry', function()
    local result = exports['lockpick']:startLockpick(1)
    print(result, 'lockpicking result')
end)

exports('startLockpick', function(tries)
    SendNUIMessage({
        start = true,
        tries = 1
    })
    SetNuiFocus(true, true)

    Promise = promise.new()

    local result = Citizen.Await(Promise)
    return result
end)