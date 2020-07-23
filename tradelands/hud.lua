modTradeLands.hudRestTime = 0
modTradeLands.hudPlayer = {}

modTradeLands.changeModProtector = function(player)
	if modTradeLands.autochange_landrush and minetest.get_modpath("landrush") and landrush and landrush.get_owner then
		local playername = player:get_player_name()
		local playerpos = player:getpos()
		local landrush_owner = landrush.get_owner(playerpos)
		
		if type(modTradeLands.hudPlayer[playername])=="nil" 
			then modTradeLands.hudPlayer[playername]={} 
		end
		
		if landrush_owner~=nil 
			and (
				type(modTradeLands.hudPlayer[playername].last_landname)=="nil" 
				or landrush_owner~=modTradeLands.hudPlayer[playername].last_landname
			) 
		then
			modTradeLands.hudPlayer[playername].last_landname = modTradeLands.getLandName(playerpos)
			
			modTradeLands.setOwnerName(playerpos, landrush_owner)
			modTradeLands.setValidate(playerpos, modTradeLands.getNewValidate())
			modTradeLands.setIfDamageInteract(playerpos, true)
			modTradeLands.setPvpType(playerpos, modTradeLands.default_pvp)
			modTradeLands.doShowLand(landrush_owner)
			modTradeLands.doSoundProtector()
			modTradeLands.doSave()

			local chunk = landrush.get_chunk(playerpos)
			landrush.claims[chunk] = nil
			landrush.save_claims()
			
			minetest.chat_send_all("[TRADELANDS] "..modTradeLands.translate(
				"The territory (%s) belonging to '%s' has automatically been granted earth protection with time validity of %02d days!"
			):format(
				modTradeLands.getLandName(playerpos), 
				landrush_owner, 
				modTradeLands.protected_days
			))
		end
	end
end

minetest.register_globalstep(function(dtime)
	modTradeLands.hudRestTime = modTradeLands.hudRestTime + dtime
	if ( modTradeLands.hudRestTime > 2 ) then
		modTradeLands.hudRestTime=0
		local players = minetest.get_connected_players()
		for _,player in ipairs(players) do
			modTradeLands.changeModProtector(player)

			local playername = player:get_player_name()
			local playerpos = player:getpos()
			local ownername = modTradeLands.getOwnerName(playerpos)
			local sameowner = false

			if modTradeLands.hudPlayer[playername]~=nil and modTradeLands.hudPlayer[playername].lastowner==ownername then
				sameowner = true
			end

			if modTradeLands.hudPlayer[playername]~=nil and sameowner==false then
				player:hud_remove(modTradeLands.hudPlayer[playername].hud)
				modTradeLands.hudPlayer[playername].hud = nil
				modTradeLands.hudPlayer[playername].lastowner = nil
			end

			if ownername~="" and sameowner==false then
				modTradeLands.hudPlayer[playername] = {
					hud = player:hud_add({
						hud_elem_type = "text",
						name = "Ownerland",
						number = 0xFFFFFF,
						position = {x=.2, y=.98},
						text="[Territorio de: "..ownername.."]",
						scale = {x=200,y=25},
						alignment = {x=0, y=0},
					}), 
					lastowner=ownername
				}
			end
		end
	end
end) 
