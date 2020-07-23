-- "point tool"
-- a tool to assist users of lua console commands.
-- each player with the relevant privileges can assign callbacks which will run when this is used.



local callbacks = {}

local setup = function(player)
	callbacks[player] = {}
end
minetest.register_on_joinplayer(setup)

local cleanup = function(player)
	callbacks[player] = nil
end



local run_if_player = function(objectref, func, ...)
	if objectref:is_player() then
		return func(objectref, ...)
	end
end

local call_if_exists = function(f, ...)
	if f then return f(...) end
end



local on_player_use = function(playerref, pointed)
	return call_if_exists(callbacks[playerref].punch, playerref, pointed)
end
local on_player_rightclick = function(playerref, pointed)
	return call_if_exists(callbacks[playerref].rightclick, playerref, pointed)
end



local on_use = function(itemstack, objectref, pointed_thing)
	return run_if_player(objectref, on_player_use, pointed_thing)
end
local on_place = function(itemstack, objectref, pointed_thing)
	return run_if_player(objectref, on_player_rightclick, pointed_thing)
end
-- we can handle being passed type = "nothing" for pointed_thing
local on_secondary_use = function(...)
	return on_place(...)
end



minetest.register_craftitem("consolelua:point_tool", {
	description = "Lua callback point tool",
	inventory_image = "consolelua_pointer_tool.png",

	-- all are "itemstack", "placer/user", "pointed_thing"
	-- though secondary use is for pointed_thing = {type="nothing"}
	on_use = on_use,
	on_place = on_place,
	on_secondary_use = on_secondary_use,
})

return callbacks
