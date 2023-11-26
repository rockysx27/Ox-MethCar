RegisterServerEvent('ox-methcar:start')
AddEventHandler('ox-methcar:start', function(posx,posy,posz)


	local _source = source

	--local inv = exports.ox_inventory:GetInventory(_source)

	local ItemAcetone  = exports.ox_inventory:GetItem(_source, Config.Acetone, nil, true)
    local ItemLithium = exports.ox_inventory:GetItem(_source, Config.Lithium, nil, true)

	if ItemAcetone ~= nil and ItemLithium ~= nil then
		if ItemAcetone >= Config.AcetoneAmount and ItemLithium >= Config.LithiumAmount then
			Wait(1000)
			TriggerClientEvent("ox-methcar:startprod", _source)
			exports.ox_inventory:RemoveItem(_source, Config.Acetone, Config.AcetoneAmount)
			exports.ox_inventory:RemoveItem(_source, Config.Lithium, Config.AcetoneAmount)

			TriggerEvent('ox-methcar:make', posx,posy,posz)
			--Player.Functions.RemoveItem(Config.Acetone, Config.AcetoneAmount, false)
			--Player.Functions.RemoveItem(Config.Lithium, Config.LithiumAmount, false)
		else
		TriggerClientEvent('ox-methcar:stop', _source)
		TriggerClientEvent('ox_lib:notify', source, { type = 'error', description = 'You dont have enough ingredients to cook!' })
		end
	else
	TriggerClientEvent('ox-methcar:stop', _source)
	TriggerClientEvent('ox_lib:notify', source, { type = 'error', description = 'Youre missing essential ingredients!' })
	end
end)

RegisterServerEvent('ox-methcar:make')
AddEventHandler('ox-methcar:make', function(posx,posy,posz)
	--local _source = source
	--local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
	--if xPlayer.Functions.GetItemByName(Config.Methlab) ~= nil then
		--if xPlayer.Functions.GetItemByName(Config.Methlab)?.count >= 1 then
			local xPlayers = GetPlayers()
			for i=1, #xPlayers, 1 do
				TriggerClientEvent('ox-methcar:smoke',xPlayers[i],posx,posy,posz, 'a')
			end
	--	else
	--		TriggerClientEvent('ox-methcar:stop', _source)
	--	end
	--else
	--	TriggerClientEvent('ox_lib:notify', source, { type = 'error', description = 'Youre missing a lab!' })
	--end
end)

RegisterServerEvent('ox-methcar:finish')
AddEventHandler('ox-methcar:finish', function(quality)
	local _source = source
	--local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
	local methtype = Config['5']
	if quality > 90 then
		methtype = Config['1']
	else
		if quality > 75 then
			methtype = Config['2']
		else
			if quality > 50 then
				methtype = Config['3']
			else
				if quality > 25 then
					methtype = Config['4']
				else
					methtype = Config['5']
				end
			end
		end
	end
	local rnd = math.random(-5, 5)
	local amount = math.floor(quality / 2) + rnd
	exports.ox_inventory:AddItem(_source, methtype, amount)
	--TriggerClientEvent('inventory:client:ItemBox', _source, QBCore.Shared.Items['meth'], "add", amount)
end)

RegisterServerEvent('ox-methcar:blow')
AddEventHandler('ox-methcar:blow', function(posx, posy, posz)
	--local _source = source
	local xPlayers = Ox:GetPlayers()
	--local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('ox-methcar:blowup', xPlayers[i],posx, posy, posz)
	end
	--xPlayer.Functions.RemoveItem(Config.Methlab, 1)
end)

