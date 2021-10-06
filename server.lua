local webhook = "";
function SendToDiscord(name, msg, col)
	local embed = {
		{
			["color"] = 9109247, -- If you have an issue with the string like this change it to "9109247"
			["title"] = "**"..name.."**",
			["description"] = msg,
		}
	}
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Entity Wipe Log", embeds = embed, avatar_url = "https://cdn.discordapp.com/attachments/891828087912796190/892186680839254086/fcdev.png"}), {['Content-Type'] = 'application/json'})
end
--https://forum.cfx.re/t/how-to-delete-entities-and-vehicles-from-server-side/1687638 Credits (Modifed!)
RegisterNetEvent('aspect:deletevehicle')
AddEventHandler('aspect:deletevehicle', function()
    if  IsPlayerAceAllowed(source, "Staff") then  -- Edit the ace are modify this part up to you!
        local coordFrom = GetEntityCoords(GetPlayerPed(source))
        local info = {}
        for k,v in pairs(GetAllVehicles()) do
            local objCoord = GetEntityCoords(v)
            local dist = #(coordFrom - objCoord)

            if info.dist == nil and DoesEntityExist(v) then
                info.dist = dist
                info.obj = v
            end

            if DoesEntityExist(v) and info.dist > dist then
                info.dist = dist
                info.obj = v
            end
        end

        if info.dist < 2000 then
            DeleteEntity(info.obj)
            if DoesEntityExist(info.obj) then
            xPlayer.showNotification('Vehicle Deleted!')
            end
        else
            xPlayer.showNotification('Vehicle Not Found!')
        end
    end
end)
RegisterCommand('entitywipe', function()

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 255, 1); border-radius: 3px;"><i class="fas fa-users"></i> <b>[Entity Wipe!] '.. GetPlayerName(source) ..'</b> <i>Has done an Entity Wipe.</i></div>'
    });
TriggerServerEvent('aspect:deletevehicle')
SendToDiscord("Entity Wipe", "**"..GetPlayerName(source).."** (ID: "..source..") Has done an Entity Wipe")
end, false)







function startup()
    print([[^2
    _____                                __   
    /  _  \   ____________   ____   _____/  |_ 
   /  /_\  \ /  ___/\____ \_/ __ \_/ ___\   __\
  /    |    \\___ \ |  |_> >  ___/\  \___|  |  
  \____|__  /____  >|   __/ \___  >\___  >__|  
          \/     \/ |__|        \/     \/     
		Start Up!
    ]])	
end
Citizen.CreateThread(function()
    startup()
    print("^2[Aspect] Script Loaded. Support? https://discord.gg/vAyNySyXCx")
end)
