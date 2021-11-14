ESX = nil 

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

local function sendNotification(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(true, false)
end

    local index = {
        items = 1
    }
    local index2 = {
         items = 1
    }
    local percent = 100
    local a = 255
    local nombre = {}  
    local itemmaxi = 15
    Numbers = {}
    

    Citizen.CreateThread(function()
        for i = 1, itemmaxi
        do
            table.insert(Numbers, i)
        end
    end)

    RMenu.Add('irt_shop', 'main', RageUI.CreateMenu("Supérrette", "Supérrette"))
    RMenu.Add('irt_shop', 'nouriture', RageUI.CreateSubMenu(RMenu:Get('irt_shop','main'), "Supérrette", "Supérrette"))
    RMenu.Add('irt_shop', 'boisson', RageUI.CreateSubMenu(RMenu:Get('irt_shop','main'), "Supérrette", "Supérrette"))
    RMenu.Add('irt_shop', 'autre', RageUI.CreateSubMenu(RMenu:Get('irt_shop','main'), "Supérrette", "Supérrette"))

    -- create de la liste des menus et sous menus --

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)

            RageUI.IsVisible(RMenu:Get('irt_shop', 'main'), true, true, true, function()

            RageUI.ButtonWithStyle("Nouriture | 🍕", nil, {RigtLabel = ">>"},true, function()
            end, RMenu:Get('irt_shop', 'nouriture'))

            RageUI.ButtonWithStyle("Boisson | ☕", nil, {RigtLabel = ">>"},true, function()
            end, RMenu:Get('irt_shop', 'boisson'))

            RageUI.ButtonWithStyle("Autre | 📎", nil, {RigtLabel = ">>"},true, function()
            end, RMenu:Get('irt_shop', 'autre'))
        end)
    end
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    for k, v in pairs(ConfigPos.Shop.Apu) do
    ped = CreatePed("PED_TYPE_CIVFEMALE", "mp_m_shopkeep_01", v.x, v.y, v.z, v.a, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    end

end)

    -- Event pour l'achat des items --


Citizen.CreateThread(function()
    while true do

           -- nourriture

        RageUI.IsVisible(RMenu:Get('irt_shop', 'nouriture'), true, true, true, function()
            for k, v in pairs(ConfigPos.Shop.Items.Nourriture) do
                RageUI.List(v.Label .. ' (Prix : ' .. v.Price * (nombre[v.Value] or 1) .. '$)', Numbers, nombre[v.Value] or 1, nil, { }, true, function(hovered, active, selected, Index)
                    nombre[v.Value] = Index
            
                    if selected then
                        local item = v.Value
                        local count = Numbers[Index]
                        local price = v.Price * count
                    
                        TriggerServerEvent('irt_shop:buyitem', v, count)
                    end
                end)
            end
        end, function()
        end)

       -- boissons

        RageUI.IsVisible(RMenu:Get('irt_shop', 'boisson'), true, true, true, function()
            for k, v in pairs(ConfigPos.Shop.Items.Boisson) do
                RageUI.List(v.Label .. ' (Prix : ' .. v.Price * (nombre[v.Value] or 1) .. '$)', Numbers, nombre[v.Value] or 1, nil, { }, true, function(hovered, active, selected, Index)
                    nombre[v.Value] = Index
            
                    if selected then
                        local item = v.Value
                        local count = Numbers[Index]
                        local price = v.Price * count
                
                        TriggerServerEvent('irt_shop:buyitem', v, count)
                    end
                end)
            end
        end, function()
        end)

       -- autres

        RageUI.IsVisible(RMenu:Get('irt_shop', 'autre'), true, true, true, function()
            for k, v in pairs(ConfigPos.Shop.Items.Autre) do
                RageUI.List(v.Label .. ' (Prix : ' .. v.Price * (nombre[v.Value] or 1) .. '$)', Numbers, nombre[v.Value] or 1, nil, { }, true, function(hovered, active, selected, Index)
                    nombre[v.Value] = Index
            
                    if selected then
                        local item = v.Value
                        local count = Numbers[Index]
                        local price = v.Price * count
            
                        TriggerServerEvent('irt_shop:buyitem', v, count)
                    end
                end)
            end
        end, function()
        end)

        Citizen.Wait(0)
    end
end)


        -- blips --

        Citizen.CreateThread(function()
            for k, v in pairs(ConfigPos.Shop.Pos) do
                local blip = AddBlipForCoord(v.x, v.y, v.z)
                SetBlipSprite(blip, 52)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, 0.8)
                SetBlipColour(blip, 43)
                SetBlipAsShortRange(blip, true)
        
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentSubstringPlayerName('Superette | Apu')
                EndTextCommandSetBlipName(blip)
            end
        end)

        -- Markers --

        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
                local playerCoords = GetEntityCoords(PlayerPedId())       
                for k, v in pairs(ConfigPos.Shop.Pos) do
                    local distance = GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true)
        
                    if distance < 5.0 then
                        actualZone = v
                        zoneDistance = GetDistanceBetweenCoords(playerCoords, actualZone.x, actualZone.y, actualZone.z, true)
                        DrawMarker(29, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, false, nil, nil, false)
                    end

                    if distance <= 1.5 then
                        ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour parler au vendeur')
                        if IsControlJustPressed(1, 51)
                         then
                            RageUI.Visible(RMenu:Get('irt_shop', 'main'), not RageUI.Visible(RMenu:Get('irt_shop', 'main')))
                        end
                    end
        
                    if zoneDistance ~= nil then
                        if zoneDistance > 1.5 then
                            RageUI.CloseAll()
                        end
                    end
                end
            end
        end)
