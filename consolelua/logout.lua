--[[
Destroy player environments when the player logs out.
This is to avoid address-reuse problems on long-running servers.
]]

local registry = _mod.regutil
minetest.register_on_leaveplayer(function(player, timed_out)
	minetest.log("info",
		"[consolelua] player "..player:get_player_name() ..
		" logged out, destroying environment for player handle " ..
		tostring(player))
	registry.remove(player, false)
end)

