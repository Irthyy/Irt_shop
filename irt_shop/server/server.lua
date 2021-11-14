ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj
end)

RegisterServerEvent('irt_shop:buyitem')
AddEventHandler('irt_shop:buyitem', function(item, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()
    
    if playerMoney >= (item.Price * count) then
        xPlayer.addInventoryItem(item.Value, count)
        xPlayer.removeMoney(item.Price * count)

        TriggerClientEvent('esx:sendNotification', source, "Vous venez d'acheter ~g~" ..count..  " "  ..item.Label.. "~s~ pour ~g~" ..item.Price * count .. "$")
    else
        TriggerClientEvent('esx:sendNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)
