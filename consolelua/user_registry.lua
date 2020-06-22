--[[
The user registry is simply an association of a user to their command environment.
when a user first appears, they can be registered to have their environment created.
note that for players, this doesn't happen immediately but either on login,
or first use after gaining the correct privileges to use the /lua command.
see commands.lua and login.lua for details.
]]

local registry = {}
local util = {}
local execenv = dofile(_modpath.."execenv.lua")
local wp = minetest.get_worldpath()



--[[
gets an exec environment associated with an opaque ID object.
this could be e.g. a player ref or some some other identifier used to link players.
the implementation object (see user_ref.lua for a description)
allows the env to send textual data.
]]

-- if no env exists for that ID, call the factory to construct the user ref for it
-- (see user_ref.lua), then construct a new environment using that.
local msg_factory_fail = "user_registry get(): ID didn't exist and unable to construct new environment"
local get = function(id, factory)
	assert(id ~= nil, "insanity condition: user_registry get() ID is nil!")
	local reg = registry[id]
	if not reg then
		local impl = factory and factory(id) or nil
		if not impl then error(msg_factory_fail) end
		reg = execenv.new(impl, wp)
		registry[id] = reg
	end
	return reg
end
util.get = get



local remove = function(id, expected)
	if not registry[id] and expected then
		local desc = tostring(id)
		minetest.log("warning", "duplicate player env removal: " .. desc)
	end
	registry[id] = nil
end
util.remove = remove



return registry, util
