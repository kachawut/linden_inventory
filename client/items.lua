AddEventHandler('linden_inventory:burger', function(item, wait, cb)
	cb(true)
	SetTimeout(wait, function()
		if not cancelled then
			TriggerEvent('mythic_notify:client:SendAlert', {type = 'inform', text = 'You ate a delicious burger', length = 2500})
		end
	end)
end)

AddEventHandler('linden_inventory:water', function(item, wait, cb)
	cb(true)
	SetTimeout(wait, function()
		if not cancelled then
			TriggerEvent('mythic_notify:client:SendAlert', {type = 'inform', text = 'You drank some refreshing water', length = 2500})
		end
	end)
end)

AddEventHandler('linden_inventory:cola', function(item, wait, cb)
	cb(true)
	SetTimeout(wait, function()
		if not cancelled then
			TriggerEvent('mythic_notify:client:SendAlert', {type = 'inform', text = 'You drank some delicious eCola', length = 2500})
		end
	end)
end)

AddEventHandler('linden_inventory:mustard', function(item, wait, cb)
	cb(true)
	SetTimeout(wait, function()
		if not cancelled then
			TriggerEvent('mythic_notify:client:SendAlert', {type = 'inform', text = 'You.. drank mustard', length = 2500})
		end
	end)
end)

AddEventHandler('linden_inventory:bandage', function(item, wait, cb)
	local maxHealth = 200
	local health = GetEntityHealth(ESX.PlayerData.ped)
	if health < maxHealth then
		cb(true)
		SetTimeout(wait, function()
			if not cancelled then
				local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 16))
				SetEntityHealth(ESX.PlayerData.ped, newHealth)
				TriggerEvent('mythic_notify:client:SendAlert', {type = 'inform', text = 'You feel better already', length = 2500})
			end
		end)
	else cb(false) end
end)

AddEventHandler('linden_inventory:lockpick', function(item, wait, cb)
	-- This is just for unlocking car doors - if you want more advanced options either set it up or hope somebody PRs it
	local vehicle, vehicleCoords = ESX.Game.GetVehicleInDirection()
	if vehicle then
		local locked = GetVehicleDoorLockStatus(vehicle)
		if #(vehicleCoords - GetEntityCoords(ESX.PlayerData.ped)) <= 2.0 and locked == 2 or locked == 3 then
			cb(true)
			SetTimeout(wait, function()
				if not cancelled then
					math.randomseed(math.random(1,9999))
					local random = math.random(1,10)
					print(random)
					if random >= 7 then
						TriggerEvent('mythic_notify:client:SendAlert', {type = 'inform', text = 'Successfuly picked the lock', length = 2500})
						SetVehicleAlarm(vehicle, true)
						SetVehicleAlarmTimeLeft(vehicle, 7000)
						SetVehicleDoorsLocked(vehicle, 1)
						SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					elseif random <= 2 then
						TriggerEvent('mythic_notify:client:SendAlert', {type = 'error', text = 'Your lockpick broke', length = 2500})
						TriggerServerEvent('linden_inventory:removeItem', item, 1)
					else
						TriggerEvent('mythic_notify:client:SendAlert', {type = 'error', text = 'You failed to pick the lock', length = 2500})
					end
				end
			end)
		else cb(false) end
	else cb(false) end
end)

AddEventHandler('linden_inventory:armour', function(item, wait, cb)
	cb(true)
	SetTimeout(wait, function()
		if not cancelled then
			SetPlayerMaxArmour(playerID, 100)
			SetPedArmour(ESX.PlayerData.ped, 100)
		end
	end)
end)

parachute = false
AddEventHandler('linden_inventory:parachute', function(item, wait, cb)
	if not parachute then 
		cb(true)
		SetTimeout(wait, function()
			if not cancelled then
				local chute = "GADGET_PARACHUTE"
				GiveWeaponToPed(ESX.PlayerData.ped, chute, 0, true, false)
				SetPedGadget(ESX.PlayerData.ped, chute, true)
				ESX.Streaming.RequestModel(1269906701)
				parachute = CreateParachuteBagObject(ESX.PlayerData.ped, true, true)
			end
		end)
	else cb(false) end
end)

AddEventHandler('linden_inventory:user_helmet', function(item, wait, cb)
	cb(true)
	local playerPed = PlayerPedId()
	local default = {texture=-1,prop_id=0,drawable=-1}
	local appearance = exports['fivem-appearance']:getPedProps(playerPed)
	local dict = "veh@bicycle@roadfront@base"
	local anim = "put_on_helmet"
	local props = nil
	ClearPedTasks(playerPed)
	for key, value in pairs(appearance) do
		if value.prop_id == 0 then
			if value.drawable == item.metadata.props.drawable then
				props = default
				dict = "missheist_agency2ahelmet"
				anim = "take_off_helmet_stand"
			else
				props = item.metadata.props
			end
		end
	end
	setPedPlayerProps(item, wait, dict, anim, props)
end)

AddEventHandler('linden_inventory:user_glasses', function(item, wait, cb)
	cb(true)
	local playerPed = PlayerPedId()
	local default = {texture=-1,prop_id=1,drawable=-1}
	local appearance = exports['fivem-appearance']:getPedProps(playerPed)
	local dict = "clothingspecs"
	local anim = "try_glasses_positive_a"
	local props = nil
	ClearPedTasks(playerPed)
	for key, value in pairs(appearance) do
		if value.prop_id == 1 then
			if value.drawable == item.metadata.props.drawable then
				props = default
				anim = "take_off"
			else
				props = item.metadata.props
			end
		end
	end
	setPedPlayerProps(item, wait, dict, anim, props)
end)

AddEventHandler('linden_inventory:user_ear', function(item, wait, cb)
	cb(true)
	local playerPed = PlayerPedId()
	local default = { texture = -1, prop_id = 2, drawable = -1 }
	local appearance = exports['fivem-appearance']:getPedProps(playerPed)
	local dict = "mp_cp_stolen_tut"
	local anim = "b_think"
	local props = nil
	ClearPedTasks(playerPed)
	for key, value in pairs(appearance) do
		if value.prop_id == 2 then
			if value.drawable == item.metadata.props.drawable then
				props = default
			else
				props = item.metadata.props
			end
		end
	end
	setPedPlayerProps(item, wait, dict, anim, props)
end)

AddEventHandler('linden_inventory:user_watches', function(item, wait, cb)
	cb(true)
	local playerPed = PlayerPedId()
	local default = { texture = -1, prop_id = 6, drawable = -1 }
	local appearance = exports['fivem-appearance']:getPedProps(playerPed)
	local dict = "nmt_3_rcm-10"
	local anim = "cs_nigel_dual-10"
	local props = nil
	ClearPedTasks(playerPed)
	for key, value in pairs(appearance) do
		if value.prop_id == 6 then
			if value.drawable == item.metadata.props.drawable then
				props = default
			else
				props = item.metadata.props
			end
		end
	end
	setPedPlayerProps(item, wait, dict, anim, props)
end)

AddEventHandler('linden_inventory:user_bracelets', function(item, wait, cb)
	cb(true)
	local playerPed = PlayerPedId()
	local default = { texture = -1, prop_id = 7, drawable = -1 }
	local appearance = exports['fivem-appearance']:getPedProps(playerPed)
	local dict = "nmt_3_rcm-10"
	local anim = "cs_nigel_dual-10"
	local props = nil
	ClearPedTasks(playerPed)
	for key, value in pairs(appearance) do
		if value.prop_id == 7 then
			if value.drawable == item.metadata.props.drawable then
				props = default
			else
				props = item.metadata.props
			end
		end
	end
	setPedPlayerProps(item, wait, dict, anim, props)
end)

setPedPlayerProps = function (item, wait, dict, anim, props)
	exports['mythic_progbar']:Progress({
		name = 'useitem',
		duration = wait,
		label = 'กำลังใช้ '..item.label,
		useWhileDead = false,
		canCancel = false,
		controlDisables = { disableMovement = true, disableCarMovement = false, disableMouse = false, disableCombat = false },
		animation = { animDict = dict, anim = anim, flags = 48, bone = nil },
	}, function(status)
		if status then
			cancelled = true
		end
	end)
	SetTimeout(wait+200, function()
		exports['fivem-appearance']:setPedProp(PlayerPedId(), props)
		ClearPedTasks(PlayerPedId())
	end)
end

function tprint (tbl, indent)
	if not indent then indent = 0 end
	for k, v in pairs(tbl) do
	  formatting = string.rep("  ", indent) .. k .. ": "
	  if type(v) == "table" then
		print(formatting)
		tprint(v, indent+1)
	  elseif type(v) == 'boolean' then
		print(formatting .. tostring(v))      
	  else
		print(formatting .. v)
	  end
	end
end