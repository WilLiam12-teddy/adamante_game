--[[
The execution environment for a player may need to be constructed either at login or first use of command.
In either case, here we provide the factory function for the user registry for players in particular.
This is then used by the chat commands (commands.lua) and player join hook (login.lua).
]]

local regutil = _mod.regutil
local userref = dofile(_modpath.."user_ref.lua")

-- symbolic ID used to represent the server's console.
local console = userref.console

--[[
Again note that the callback for a chat command may be given a nil player,
if the command is run from the server console.
However, in some cases (such as the player join/leave callbacks)
nil *cannot* occur when properly called.
]]

local i = {}
i.console = console

-- obtain player's user ref implementation.
local get_env_for_player = function(player, expected)
	-- we have to use the above symbolic ID due to the console user being represented by nil.
	-- nil table keys (the table being the exec env registry) like to cause explosions...
	-- if not passed a player and not necessarily expecting one,
	-- substitute the player ref for the console ID.
	-- else, if expected but still a nil player ref was passed.
	-- let the code in user_ref.lua catch it.
	if (player == nil) then
		if not expected then
			player = console
		else
			error("nil player passed but was expecting valid PlayerRef")
		end
	end

	assert(player ~= nil, "Insanity condition: no player!?")
	return userref.mk_user_ref(player)
end
i.get_env_for_player = get_env_for_player



-- create the factory to pass to the user registry.
-- the command callbacks and login callbacks respectively instantiate one each,
-- the first without player expectation and the second with.
local player_userref_factory = function(isRealPlayerExpected)
	return function(id)
		return get_env_for_player(id, isRealPlayerExpected)
	end
end
i.player_userref_factory = player_userref_factory



return i
