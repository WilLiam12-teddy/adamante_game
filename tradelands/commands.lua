minetest.register_chatcommand("showland", {
	params = "",
	description = modTradeLands.translate("It highlights the limits of the current protected land."),
	privs = {interact=true},
	func = function(playername, param)
		modTradeLands.doShowLand(playername)
	end,
})

minetest.register_chatcommand("sl", {
	params = "",
	description = modTradeLands.translate("It highlights the limits of the current protected land."),
	privs = {interact=true},
	func = function(playername, param)
		modTradeLands.doShowLand(playername)
	end,
})

minetest.register_chatcommand("showarea", {
	params = "",
	description = modTradeLands.translate("It highlights the limits of the current protected land."),
	privs = {interact=true},
	func = function(playername, param)
		modTradeLands.doShowLand(playername)
	end,
})

minetest.register_chatcommand("sa", {
	params = "",
	description = modTradeLands.translate("It highlights the limits of the current protected land."),
	privs = {interact=true},
	func = function(playername, param)
		modTradeLands.doShowLand(playername)
	end,
})
