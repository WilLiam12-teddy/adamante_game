if minetest.get_modpath("brazutec") and type(brazutec_laptop)=="table" then
	brazutec_instalar_em_cub("icon_charter.png","brazutec_alvara")
	minetest.register_on_player_receive_fields(function(player, formname, fields)
		--minetest.log("action","formname="..dump(formname))
		--minetest.log("action","fields="..dump(fields))
		if type(fields.brazutec_alvara)~="nil" then
			local playername = player:get_player_name()
  local playerpos = player:getpos()
			minetest.log("action",
     "[TRADELANDS] "
     ..modTradeLands.translate(
         "The player '%s' is trying to use the item '%s' for the brazutec notebook in %s!"
     ):format(
          playername, 
          modTradeLands.translate("Land Protection Permit"), 
          minetest.pos_to_string(playerpos)
     )
  )
			--modCorreio.openinbox(playername)
  modTradeLands.doUseCharter(player)
		end
	end)
end
