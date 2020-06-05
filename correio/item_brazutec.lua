if minetest.get_modpath("brazutec") and type(brazutec_laptop)=="table" then
	brazutec_instalar_em_cub("obj_mail.png","brazutec_abrirmsg")
	minetest.register_on_player_receive_fields(function(player, formname, fields)
		--minetest.log("action","formname="..dump(formname))
		--minetest.log("action","fields="..dump(fields))
		if fields.brazutec_abrirmsg~=nil then
			local playername = player:get_player_name()
			minetest.log("action","[CORREIO] "..modCorreio.translate(
         "Player '% s' is trying to open the mailbox via the brazutec notebook!"
      ):format(playername))
			modCorreio.openinbox(playername)
		end
	end)
end
