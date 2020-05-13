
local say = minetest.chat_send_all
local lib = modtable("ds2.minetest.libmthelpers")



-- structure used to hold callbacks.
-- essentially we just need to be able to add callbacks to a list
-- then at each step run through them all.
-- what the heck, I felt like a linked list, blame haskell (tm).
-- technically this means that items added last must be run before earlier ones,
-- but really callbacks should not assume order of execution.

local chain = function(current, link)
	return function(...)
		-- look ma, no conditionals or loops!
		current(...)
		return link(...)
	end
end
local endofchain = function(...) end

local noop = function() end
local mk_chain_builder = function(pre_insert_callback)
	pre_insert_callback = pre_insert_callback and assertf(pre_insert_callback) or noop

	-- current linked list head - starts out as empty base recursion case
	local head = endofchain
	local any_ = false

	local insert = function(f)
		assert(type(f) == "function", "callbacks must be a function.")
		pre_insert_callback(f)

		local link = head
		local newlink = chain(f, link)
		head = newlink
		any_ = true
	end

	local execute = function(...)
		return head(...)
	end

	local any = function()
		return any_
	end

	return {
		insert = insert,
		execute = execute,
		any = any,
	}
end







-- creates a set of callback functions that are executed by a parent function.
-- this parent function is in turn registered as a callback somewhere else,
-- but this parent registration only occurs when a child function is added to the set.
-- for example, the child set is the per-player callbacks,
-- and the parent function that runs them is registered via minetest.register_globalstep.
-- the parent function is only registered as a globalstep when at least one per-player function exists;
-- otherwise, it is not registered and never runs at all, having zero impact on the server.

-- the parent function is passed the child chain's execute function (as defined above),
-- followed by whatever the registar passes in (e.g. register_globalstep's dtime).
-- it then must do what it needs with the arguments the registrar passes it,
-- retrieving extra info, and then calling the child chain
-- (potentially many times in the case of per-player callbacks).

-- interface ICallbackRegistrar:
-- .register(f): registers a callback function taking some arguments determined by the registrar.
--	e.g. for minetest.register_globalstep, there would be the usual sole dtime argument.
local assertf = function(v)
	assert(type(v) == "function")
	return v
end
local create_child_set_callback = function(ICallbackRegistrar, executor)
	assertf(ICallbackRegistrar.register)
	assertf(executor)

	local chain = mk_chain_builder()
	local chain_execute = chain.execute

	-- actual function passed to the registrar.
	local wrapper = function(...)
		return executor(chain_execute, ...)
	end

	-- wrapped insert that lazily sets up the wrapper with the Registrar,
	-- but only for the first time that someone wants to add to our chain.
	local insert = function(f)
		local wasempty = not chain.any()
		chain.insert(f)
		if wasempty then
			ICallbackRegistrar.register(wrapper)
		end
	end

	return {
		register = insert,
	}
end



-- the core minetest callback registar - execution starts here.
local MinetestGlobalstepCallbackRegistrar = {
	register = minetest.register_globalstep,
}

-- then, the per-player globalstep callbacks.
-- callbacks are passed player ref and dtime in that order;
-- the ordering is that way to allow easy composition with the player memory stuff further down.
local getplayers = minetest.get_connected_players
local per_player = function(chain_execute, dtime)
	for i, player in ipairs(getplayers()) do
		chain_execute(player, dtime)
	end
end
local PerPlayerCallbackRegistrar = 
	create_child_set_callback(MinetestGlobalstepCallbackRegistrar, per_player)





-- constructs a per-player callback function that takes care of remembering state on a per-player basis.
-- internally a table mapping players to memory objects is maintained.
-- at each invocation, the player's memory data is looked up
-- (if any had yet been set been set by a previous invocation).
-- the inner callback is then passed the memory data and the current player ref object.
-- the inner callback may then return a new memory object kept for the next time the callback runs on that player.
-- this new memory data may be any value, including nil,
-- which is guaranteed to clear out that player's memory so it looks like they were new on the next invocation.
-- to make this callback, as well as the inner callback to which the player and memory are passed,
-- you must additionally provide access to an IPlayerLeftGameCallbackRegistrar.
-- the constructor will subscribe a function to player leave events so their memory can be reset to new.

-- interface IPlayerLeftGameCallbackRegistrar:
-- an ICallbackRegistrar where the passed parameter is a player ref object,
-- and callbacks are invoked when a player leaves the game
-- (e.g. this could be implemented with minetest.register_on_leaveplayer).

-- the inner callback must return new memory (if any) first.
-- any extra return values following that are returned from the outer callback.
-- arguments to inner callback: memory, player, ... (any extra args passed to outer callback)
local make_memory_callback = function(inner_callback, IPlayerLeftGameCallbackRegistrar)
	assertf(inner_callback)

	-- internal store of memory objects.
	-- maps player refs (assumed to be unique while the player is connected)
	-- to their memory values.
	local player_memories = {}

	-- update a player's memory data.
	-- this is a separate function as a hack to allow perfect vararg returns.
	local update_player = function(player, newdata, ...)
		--say("newdata: " .. tostring(newdata))
		player_memories[player] = newdata
		return ...
	end
	
	-- actual wrapped callback that is returned.
	-- mildly convoluted to support perfect vararg forwarding and returns.
	local wrapper = function(player, ...)
		local memory = player_memories[player]
		--say("memory: " .. tostring(memory))
		return update_player(player, inner_callback(memory, player, ...))
	end

	-- internal disconnect subscription.
	IPlayerLeftGameCallbackRegistrar.register(function(player)
		player_memories[player] = nil
	end)

	-- assuming nothing blew up...
	return wrapper
end



-- little utility: get a registrar constructor (mind the levels of depth!)
-- which returns registrars whose register function can take any kind of argument(s).
-- when a registrar is constructed, a wrapper factory is invoked to get a wrap function;
-- this wrap function takes arguments passed to register() and creates a callback function.
-- this callback function is then registered with a parent backing registrar.
local wrapper_registrar_constructor_factory_ = function(wrapper_factory)
	local registrar_constructor = function(parent, ...)
		assertf(parent.register)
		local wrap = wrapper_factory(...)

		return {
			register = function(...)
				local callback = wrap(...)
				parent.register(callback)
			end
		}
	end

	return registrar_constructor
end

local memory_wrapper_factory = function(IPlayerLeftGameCallbackRegistrar)
	assertf(IPlayerLeftGameCallbackRegistrar.register)

	local wrap = function(memory_type_callback)
		return make_memory_callback(
			memory_type_callback,
			IPlayerLeftGameCallbackRegistrar)
	end

	return wrap
end
local make_memory_per_player_callback_registrar = 
	wrapper_registrar_constructor_factory_(memory_wrapper_factory)





-- dafty twest tiyme.
-- core minetest player leave registrar
local leave_registrar = {
	register = minetest.register_on_leaveplayer,
}
local memory_registrar =
	make_memory_per_player_callback_registrar(
		PerPlayerCallbackRegistrar, leave_registrar)

-- cheaty place for other mods to use...
minetest.register_globalstep_perplayer_memory = memory_registrar.register



-- nodes that are painful to stand on.
local ouch_nodes = {
	["default:cactus"] = 1,
	["default:lava_source"] = 1,
}
-- interval between taking hits from that node.
local cooldowns = {
	["default:cactus"] = 0.5,
	["default:lava_source"] = 0.5,
}

memory_registrar.register(function(memory, player, dtime)
	local pos = player:get_pos()
	-- memory is per-node cool-off time.
	if memory == nil then
		--say("reset")
		memory = {}
	end

	-- ensure we don't run into rounding problems...
	pos.y = pos.y - 1
	local node = minetest.get_node(pos)

	local n = node.name
	--say(n)
	local dmg = ouch_nodes[n]
	if dmg then
		-- check if there exists remaining cooldown for this node in memory.
		-- if there is, dock it then skip.
		local cooldown = memory[n]
		if cooldown then
			cooldown = cooldown - dtime
			if cooldown <= 0 then
				cooldown = nil
			end
			memory[n] = cooldown
		end
		-- if there remains cooldown, don't damage the player
		if cooldown ~= nil then return memory end
	
		local hp = player:get_hp()
		-- don't spam callbacks going into the negative.
		if hp <= 0 then return memory end
		
		hp = math.max(0, hp - dmg)
		-- FIXME: upcoming minetest will set the node name in hp change reasons.
		-- we probably don't want to crash mods listening to this when that happens.
		player:set_hp(hp, {type="node_damage"})

		-- set any cooldown for this node after taking damage.
		local c = cooldowns[n]
		--say(tostring(c))
		memory[n] = c
	end

	return memory
end)













-- up next we have something that uses the memory callback to check if something changed.
-- an extractor function is passed all arguments to the outer callback,
-- including the existing memory data passed first.
-- if it returns null, nothing happens and the memory is retained;
-- any extra parameters returned by the extractor are returned after the memory.
-- if it returns non-null, then a "change" callback is invoked with player, old memory, and this data
-- (followed by any arguments from the extractor; it's a bit backwards to avoid mangling varargs).
-- the returned data from the extractor is then passed out as new memory data.
-- in this case, any returns from the *change callback* are returned after the new memory data.
-- NB: the change callback itself *DOES NOT* return new memory.
local make_on_change_callback = function(extractor, on_change)
	assertf(extractor)
	assertf(on_change)
	
	local memory_callback = function(oldmemory, player, ...)
		-- yet more vararg hacks.
		-- it gets a bit tricky here as we may have to hold on to arguments.
		local result = { extractor(oldmemory, player, ...) }
		local newmemory = result[1]
		if newmemory == nil then
			result[1] = oldmemory	-- place old memory as first return value
			return unpack(result)
		end
		
		-- if new data is found, run inner callback with old and new data.
		-- note that the first arg of the extractor result vararg is the new memory.
		return newmemory, on_change(player, oldmemory, unpack(result))
	end

	return memory_callback
end

local const = function(v) return function() return v end end
local on_change_wrapper_factory = const(function(extractor, on_change)
	return make_on_change_callback(extractor, on_change)
end)

-- parent registrar must be memory capable.
local make_per_player_on_change_callback_registrar = 
	wrapper_registrar_constructor_factory_(on_change_wrapper_factory)







-- Now we get to the interesting part.
-- Callbacks that watch for standing on and off of a block.
-- These aren't registrars as they make more sense to call a block's own callbacks instead.

-- First bind to MT...
local PerPlayerOnChangeCallbackRegistrar =
	make_per_player_on_change_callback_registrar(memory_registrar)



local round = lib.coords.round_to_node_mut
local equal = mtrequire("ds2.minetest.vectorextras.equality")
local fmt = lib.coords.format

local extractor = function(oldmemory, player, dtime)
	-- check what position is currently just beneath the player's feet.
	local pos = player:get_pos()
	-- rounding boundaries...
	pos.y = pos.y - 0.001

	-- round this to the nearest node,
	-- then compare it against the last node position (stored in oldmemory).
	-- if if differs, that's a hit and we should return it.
	round(pos)
	-- if no oldmemory, assume different and return new position.
	if not oldmemory then return pos end

	-- if different, return new position also.
	if not equal(oldmemory, pos) then
		return pos
	end

	-- otherwise hold current position and don't fire callbacks.
	return nil
end

local get = minetest.get_node
local nodes = minetest.registered_nodes
local get_callback_off = function(def)
	return def.on_stood_off
end
local get_callback_on = function(def)
	return def.on_stood_on
end

local runcallback = function(player, pos, node, def, get_callback)
	-- don't catch fire on unknown nodes.
	if not def then return end

	local callback = get_callback(def)
	if not callback then return end

	callback(player, pos, node, def)
end

local on_change = function(player, oldpos, newpos)
	local oldnode
	-- if there wasn't a previous node then evidently step-off makes no sense...
	if oldpos then oldnode = get(oldpos) end
	local newnode = get(newpos)

	local olddef = oldpos and nodes[oldnode.name] or nil
	local newdef = nodes[newnode.name]

	runcallback(player, oldpos, oldnode, olddef, get_callback_off)
	runcallback(player, newpos, newnode, newdef, get_callback_on)
end
PerPlayerOnChangeCallbackRegistrar.register(extractor, on_change)




-- just for fun... (aren't I evil? >:D )
--if tnt then
--	minetest.override_item("tnt:tnt", {
--		on_stood_on = function(player, pos, node, def)
--			tnt.boom(pos, {radius=2,damage_radius=2})
--		end
--	})
--end



-- DEPLOY AH TELEPORTAH HERE
local stone = minetest.registered_nodes["default:stone"]
minetest.register_node("player_onstep_hooks:teleporter", {
	description = "DEPLOY AH TELEPORTAH HERE (step on me after setting meta)",
	tiles = stone and stone.tiles or nil,
	on_stood_on = function(player, pos, node, def)
		local m = minetest.get_meta(pos)
		local p = player:get_pos()

		p.x = p.x + m:get_float("x")
		p.y = p.y + m:get_float("y")
		p.z = p.z + m:get_float("z")

		player:set_pos(p)
	end,
})


























