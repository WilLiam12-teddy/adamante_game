modTradeLands = {
	filedatabase = minetest.get_worldpath().."/tradelands.db", --File that stores the database of protected lands.
	autochange_landrush = true, --If the admin wants the permanent protections of the mod landrush to be automatically replaced by the temporary protections of the mod tradelands as the player walks by the map.
	time_showarea = 60, --Time in secounds to to show the limit of land size.
	areaSize = {
		side = 16, --16x16 size of land
		high = 200, --100 to up, and 100 to down
	},
	protected_days = 15, --The addition of time on the protection of the land. If the value is 0 (zero) then the protection will be 100 real years (same that permanent).
	price={ --Items that the player must pay to protect the land. (Maximum of 4 item types)
		"default:gold_ingot 3", "default:steel_ingot 3"
		--"minertrade:minermoney 3", "minertrade:minercoin 3" --If you want the mod minertrade do download in: https://github.com/Lunovox/minertrade
	}, 
	damage_interact = 6, --The amount of damage that the player will receive if it forces interact with the terrain. (6 x 0.5 = 3HP)
	auto_flip = true, --Rotate the player on interact with a protected land of other player.
   ChestLocked = {
      replaceProtection = true 
   },
}
