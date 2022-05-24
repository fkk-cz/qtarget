local Bones = {Options = {}, Vehicle = {'chassis', 'windscreen', 'seat_pside_r', 'seat_dside_r', 'bodyshell', 'suspension_lm', 'suspension_lr', 'platelight', 'attach_female', 'attach_male', 'bonnet', 'boot', 'chassis_dummy', 'chassis_Control', 'door_dside_f', 'door_dside_r', 'door_pside_f', 'door_pside_r', 'Gun_GripR', 'windscreen_f', 'platelight', 'VFX_Emitter', 'window_lf', 'window_lr', 'window_rf', 'window_rr', 'engine', 'gun_ammo', 'ROPE_ATTATCH', 'wheel_lf', 'wheel_lr', 'wheel_rf', 'wheel_rr', 'exhaust', 'overheat', 'seat_dside_f', 'seat_pside_f', 'Gun_Nuzzle', 'seat_r'}}

if Config.EnableDefaultOptions then
	local BackEngineVehicles = {
        [`ninef`] = true,
        [`adder`] = true,
        [`vagner`] = true,
        [`t20`] = true,
        [`infernus`] = true,
        [`zentorno`] = true,
        [`reaper`] = true,
        [`comet2`] = true,
        [`comet3`] = true,
        [`jester`] = true,
        [`jester2`] = true,
        [`cheetah`] = true,
        [`cheetah2`] = true,
        [`prototipo`] = true,
        [`turismor`] = true,
        [`pfister811`] = true,
        [`ardent`] = true,
        [`nero`] = true,
        [`nero2`] = true,
        [`tempesta`] = true,
        [`vacca`] = true,
        [`bullet`] = true,
        [`osiris`] = true,
        [`entityxf`] = true,
        [`turismo2`] = true,
        [`fmj`] = true,
        [`re7b`] = true,
        [`tyrus`] = true,
        [`italigtb`] = true,
        [`penetrator`] = true,
        [`monroe`] = true,
        [`ninef2`] = true,
        [`stingergt`] = true,
        [`surfer`] = true,
        [`surfer2`] = true,
        [`gp1`] = true,
        [`autarch`] = true,
        [`tyrant`] = true
    }

	local function ToggleDoor(vehicle, door)
		if GetVehicleDoorLockStatus(vehicle) ~= 2 then
			if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
                if NetworkGetEntityOwner(vehicle) == PlayerId() then
				    SetVehicleDoorShut(vehicle, door, false)
                else
                    TriggerServerEvent("qtarget:ToggleDoor", VehToNet(vehicle), door, "shut")
                end
			else
                TaskOpenVehicleDoor(PlayerPedId(), vehicle, -1, door - 1, 1.0)
                Citizen.Wait(1500)
                if NetworkGetEntityOwner(vehicle) == PlayerId() then
				    SetVehicleDoorOpen(vehicle, door, false)
                else
                    TriggerServerEvent("qtarget:ToggleDoor", VehToNet(vehicle), door, "open")
                end
                ClearPedTasks(PlayerPedId())
			end
		else
            TaskOpenVehicleDoor(PlayerPedId(), vehicle, -1, door - 1, 1.0)
        end
	end

    -- Front driver
    Bones.Options['seat_dside_f'] = {
        ["Toggle Front Door"] = {
            icon = "fas fa-door-open",
            label = "Toggle Front Door",
            canInteract = function(entity)
                return GetEntityBoneIndexByName(entity, 'door_dside_f') ~= -1
            end,
            action = function(entity)
                ToggleDoor(entity, 0)
            end,
            distance = 1.2
        },
        {
			icon = "fas fa-door-open",
			label = "Enter Trailer Seat",
			action = function(entity)
				TriggerServerEvent("trailer:forceEnterSeat", VehToNet(entity))
			end,
			canInteract = function(entity)
				local model = GetEntityModel(entity)
				return IsVehicleSeatFree(entity, -1) and exports["noire_assets"]:IsVehicleATrailer(veh)
			end,
            distance = 1.5
		},
        {
			event = "police:rackRifle",
			icon = "fas fa-exchange-alt",
			label = "Rack/Unrack Rifle",
			job = {["lspd"] = 0, ["sahp"] = 0},
			canInteract = function(veh)
				return DoesEntityExist(veh) and IsEntityAVehicle(veh) and GetVehicleClass(veh) == 18 and HasPedGotWeapon(PlayerPedId(), `WEAPON_CARBINERIFLE`, false) and GetVehicleDoorAngleRatio(veh, 0) > 0.1
			end,
			index = 0,
            distance = 1.5
		},
		{
			event = "police:rackShotgun",
			icon = "fas fa-exchange-alt",
			label = "Rack/Unrack Shotgun",
			job = {["lspd"] = 0, ["sahp"] = 0},
			canInteract = function(veh)
				return DoesEntityExist(veh) and IsEntityAVehicle(veh) and GetVehicleClass(veh) == 18 and HasPedGotWeapon(PlayerPedId(), `WEAPON_PUMPSHOTGUN`, false) and GetVehicleDoorAngleRatio(veh, 0) > 0.1
			end,
			index = 1,
            distance = 1.5
		},
    }

    -- Front passenger
    Bones.Options['seat_pside_f'] = {
        ["Toggle Front Door"] = {
            icon = "fas fa-door-open",
            label = "Toggle Front Door",
            canInteract = function(entity)
                return GetEntityBoneIndexByName(entity, 'door_pside_f') ~= -1
            end,
            action = function(entity)
                ToggleDoor(entity, 1)
            end,
            distance = 1.2
        },
		{
			event = "police:rackRifle",
			icon = "fas fa-exchange-alt",
			label = "Rack/Unrack Rifle",
			job = {["lspd"] = 0, ["sahp"] = 0},
			canInteract = function(veh)
				return DoesEntityExist(veh) and IsEntityAVehicle(veh) and GetVehicleClass(veh) == 18 and HasPedGotWeapon(PlayerPedId(), `WEAPON_CARBINERIFLE`, false) and GetVehicleDoorAngleRatio(veh, 1) > 0.1
			end,
			index = 0,
            distance = 1.5
		},
		{
			event = "police:rackShotgun",
			icon = "fas fa-exchange-alt",
			label = "Rack/Unrack Shotgun",
			job = {["lspd"] = 0, ["sahp"] = 0},
			canInteract = function(veh)
				return DoesEntityExist(veh) and IsEntityAVehicle(veh) and GetVehicleClass(veh) == 18 and HasPedGotWeapon(PlayerPedId(), `WEAPON_PUMPSHOTGUN`, false) and GetVehicleDoorAngleRatio(veh, 1) > 0.1
			end,
			index = 1,
            distance = 1.5
		}
    }

    -- Rear driver
    Bones.Options['seat_dside_r'] = {
        ["Toggle Rear Door"] = {
            icon = "fas fa-door-open",
            label = "Toggle Rear Door",
            canInteract = function(entity)
                return GetEntityBoneIndexByName(entity, 'door_dside_r') ~= -1
            end,
            action = function(entity)
                ToggleDoor(entity, 2)
            end,
            distance = 1.5
        },
        {
			action = function(entity) if IsEntityAVehicle(entity) then TriggerEvent("police:RemoveIndividualFromVehicle", entity, 1) end end,
			icon = "fas fa-level-down-alt",
			label = "Remove individual from rear seat",
			job = {["lspd"] = 0, ["sahp"] = 0},
			canInteract = function(veh) return DoesEntityExist(veh) and IsEntityAVehicle(veh) and not IsVehicleSeatFree(veh, 1) end,
			index = 2,
		}
    }

    -- Rear passenger
    Bones.Options['seat_pside_r'] = {
        ["Toggle Rear Door"] = {
            icon = "fas fa-door-open",
            label = "Toggle Rear Door",
            canInteract = function(entity)
                return GetEntityBoneIndexByName(entity, 'door_pside_r') ~= -1
            end,
            action = function(entity)
                ToggleDoor(entity, 3)
            end,
            distance = 1.5
        },
        {
			action = function(entity) if IsEntityAVehicle(entity) then TriggerEvent("police:RemoveIndividualFromVehicle", entity, 2) end end,
			icon = "fas fa-level-down-alt",
			label = "Remove individual from rear seat",
			job = {["lspd"] = 0, ["sahp"] = 0},
			canInteract = function(veh) return DoesEntityExist(veh) and IsEntityAVehicle(veh) and not IsVehicleSeatFree(veh, 2) end,
            distance = 1.5
		}
    }

    Bones.Options['bonnet'] = {
        ["Toggle Hood"] = {
            icon = "fa-duotone fa-engine",
            label = "Toggle Hood",
            action = function(entity)
                ToggleDoor(entity, BackEngineVehicles[GetEntityModel(entity)] and 5 or 4)
            end,
            distance = 0.9
        }
    }

    Bones.Options['boot'] = {
        ["Toggle Trunk"] = {
            icon = "fas fa-truck-ramp-box",
            label = "Open/Close Trunk Door",
            action = function(entity)
                ToggleDoor(entity, BackEngineVehicles[GetEntityModel(entity)] and 4 or 5)
            end,
            distance = 1.0
        },
        {
			icon = "fas fa-truck-loading",
			label = "View Trunk Contents",
			event = "openTrunkInventory",
			canInteract = function(veh)
				return Entity(veh).state.usingTrunk == nil
			end,
            distance = 1.0
		},
		{
            action = function(vehicle)
                if GetVehicleDoorAngleRatio(vehicle, 5) < 0.1 then
                    ToggleDoor(vehicle, BackEngineVehicles[GetEntityModel(vehicle)] and 4 or 5)
                end
                TriggerEvent("police:rackRifle")
            end,
			-- event = "police:rackRifle",
			icon = "fas fa-exchange-alt",
			label = "Rack/Unrack Rifle",
			job = {["lspd"] = 0, ["sahp"] = 0},
			canInteract = function(veh)
				return GetVehicleClass(veh) == 18 and HasPedGotWeapon(PlayerPedId(), `WEAPON_CARBINERIFLE`, false)
			end,
            distance = 1.0
		},
		{
			event = "police:rackShotgun",
			icon = "fas fa-exchange-alt",
			label = "Rack/Unrack Shotgun",
			job = {["lspd"] = 0, ["sahp"] = 0},
			canInteract = function(veh)
				return GetVehicleClass(veh) == 18 and HasPedGotWeapon(PlayerPedId(), `WEAPON_PUMPSHOTGUN`, false)
			end,
			distance = 1.0
		},
		{
			event = "shield:ToggleSwatShield",
			icon = "fas fa-user-shield",
			label = "Ballistic Shield",
			job = {["lspd"] = 1, ["sahp"] = 1},
			canInteract = function(veh)
				return GetVehicleClass(veh) == 18 and LocalPlayer.state.SWATAllowed
			end,
            distance = 1.0
		},
		{
			action = function(veh) TriggerEvent("cl:updateTrailer", "open") end,
			icon = "far fa-truck-ramp",
			label = "Open Trailer Ramp",
			canInteract = function(veh)
				return exports["noire_assets"]:IsVehicleATrailer(veh)
			end,
            distance = 1.5
		},
		{
			action = function(veh) TriggerEvent("cl:updateTrailer", "closed") end,
			icon = "far fa-truck-ramp",
			label = "Close Trailer Ramp",
			canInteract = function(veh)
				return exports["noire_assets"]:IsVehicleATrailer(veh)
			end,
            distance = 1.5
		},
    }
end

return Bones