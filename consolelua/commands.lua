local privs = _mod.privdata.privs
local devp = _mod.privdata.devp
local cmd = devp.."lua"
local execreg = _mod.regutil

local playerwrapper = _mod.playerwrapper
local factory = playerwrapper.player_userref_factory(false)
local console = playerwrapper.console
assert(console ~= nil)

local getenv = function(player)
	if not player then
		player = console
	end
	return execreg.get(player, factory)
end



local mk_handle_wrapper = function(f)
	return function(name, ...)
		local player = minetest.get_player_by_name(name)
		return f(player, ...)
	end
end

local reset = function(player, data)
	getenv(player):reset()
end
local reload = function(player, data)
	getenv(player):reload()
end
local exec = function(player, data)
	getenv(player):exec(data)
end



minetest.register_chatcommand(cmd, {
	params = "<lua fragment>",
	description = "evaluates a lua string in your local environment.",
	privs = privs,
	func = mk_handle_wrapper(exec),
})

minetest.register_chatcommand(cmd.."_reload", {
	params = "",
	description = "reloads your lua environment from the rc files",
	privs = privs,
	func = mk_handle_wrapper(reload),
})

minetest.register_chatcommand(cmd.."_reset", {
	params = "",
	description = "re-initialises your lua environment and re-loads the rc files",
	privs = privs,
	func = mk_handle_wrapper(reset),
})

