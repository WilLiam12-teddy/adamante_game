--[[
user_ref.lua
When the callbacks for chat commands are invoked,
the passed player ref can be nil if it was the server console who ran the command.
therefore, we need to wrap up and isolate just what we need of a "player" for the purpose of the inner code.
This basically just amounts to a chat send function (or console print),
and optionally the actual player ref for the "me" variable (see rcloader.lua).
]]

local console = print
local print_server = function(self, msg)
	print(msg)
end

local print_player = function(self, msg)
	local name = self.name
	minetest.chat_send_player(name, msg)
end



local i = {}

-- a symbolic object which is used to indicate the "console player".
-- it will always be unique compared to any possible player ref as they must be distinct in memory.
local console = {}
i.console = console



local mk_user_ref_from_player = function(player)
	local result = {}

	result.name = player:get_player_name()
	result.ref = player
	result.sendtext = print_player

	return result
end
i.mk_user_ref_from_player = mk_user_ref_from_player



--[[
Returned interface:
	i:sendtext(msg)
		sends raw, unformatted text to this user.
	i.name, i.ref (optional)
		respectively, name and player ref objects for this player.
		may be nil.
]]

local mk_user_ref = function(player)
	if not player then
		error("mk_user_ref() nil player reference passed!")
	end

	if player ~= console then
		return mk_user_ref_from_player(player)
	else
		return { sendtext = print_server }
	end
end
i.mk_user_ref = mk_user_ref



return i
