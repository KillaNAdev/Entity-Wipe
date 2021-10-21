local webhook = "" -- Add your webhook here

function SendToDiscord(name, msg)
	local embed = {{
        ["color"] = 9109247, -- If you have an issue with the string like this change it to "9109247"
        ["title"] = "**" .. name .. "**",
        ["description"] = msg,
    }}
	PerformHttpRequest(webhook, function(err, text, headers)
	end, 'POST', json.encode({username = "Entity Wipe Log", embeds = embed, avatar_url = "https://cdn.discordapp.com/attachments/891828087912796190/892186680839254086/fcdev.png"}), {['Content-Type'] = 'application/json'})
end

--https://forum.cfx.re/t/how-to-delete-entities-and-vehicles-from-server-side/1687638 Credits (Modified!)
RegisterNetEvent('aspect:deletevehicle', function(playerId)
	local coords = GetEntityCoords(GetPlayerPed(playerId))
	for _, v in pairs(GetAllVehicles()) do
		local objCoords = GetEntityCoords(v)
		local dist = #(coords - objCoords)
		if dist < 2000 then
			if DoesEntityExist(v) then
				DeleteEntity(v)
            end
        end
    end
end)

RegisterCommand('entitywipe', function(source)
	local playerId <const> = source
	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 255, 1); border-radius: 3px;"><i class="fas fa-users"></i> <b>[Entity Wipe!] ' .. GetPlayerName(playerId) .. '</b> <i>Has done an Entity Wipe.</i></div>'
	});
	TriggerEvent('aspect:deletevehicle', tonumber(source))
	SendToDiscord("Entity Wipe", "**" .. GetPlayerName(playerId) .. "** (ID: " .. tostring(playerId) .. ") Has done an Entity Wipe")
end, true) -- Only admins can do the command