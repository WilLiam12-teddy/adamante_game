i.fling_player = fling_player

-- to fling a player that might already be in flight,
-- we need to find their root attachment object and move that instead;
-- if that's a regular entity, then we just offset that entity's velocity.
-- returns the actual entity that was altered;
-- this may be a newly created motion entity.
local fling_entity = function(ent, addvel)
	-- seek for the root of the attachment hierachy
	local current = ent
	--debug("initial fling entity: "..tostring(current))
	local iterate = function()
		local parent, bone, pos = current:get_attach()
		if parent then current = parent end
		return parent
	end
	for _ in iterate do end
	-- we will end up with the root entity.
	local vel
	local isp = current:is_player()
	vel = isp and current:get_player_velocity() or current:get_velocity()
	local tvel = vector.add(vel, addvel)
	if isp then
		return fling_player(current, tvel)
	else
		current:set_velocity(tvel)
		return current
	end
end
i.fling_entity = fling_entity

-- an example item using this routine.
local n = "unknown_mod:tool"
local hammer_power = 50
local hammer_throw = function(user, ent)
	local lookdir = user:get_look_dir()
	local vel = vector.multiply(lookdir, hammer_power)
	return fling_entity(ent, vel)
end
local throwme = function(item, user, pointed)
	-- NB: do NOT return something weird from on_* callbacks for items...
	-- that way lies segfaults and sadness
	hammer_throw(user, user)
end



local forbidden_msg = "Node was marked protected, refusing to throw."
local throw_node = function(pos, user)

	-- protection consideration...
	if user:is_player() then
		local name = user:get_player_name()
		if minetest.is_protected(pos, name) then
			minetest.chat_send_player(name, forbidden_msg)
			minetest.record_protection_violation(pos, name)
			return
		end
	end

	-- yes, this is a bit of a hack... but I need the entity ref!
	local ref = minetest.add_entity(pos, "__builtin:falling_node")
	if ref then
		-- finally, an entity with a sane method interface
		local rpc = ref:get_luaentity()
		rpc:set_node(minetest.get_node(pos), minetest.get_meta(pos):to_table())
		minetest.remove_node(pos)
		--debug("node throw ref: "..tostring(ref))
		hammer_throw(user, ref)
	end
end

minetest.register_craftitem(n, {
	description = "Unknown Tool (try punching an object/player)",
	inventory_image = "unknown_tool.png",
	on_use = function(item, user, pointed)
		if pointed.type ~= "object" then
			if pointed.type ~= "node" then return nil end
			throw_node(pointed.under, user)
			return
		end
		local target = pointed.ref
		hammer_throw(user, target)
	end,
	on_place = throwme,
	on_secondary_use = throwme,
})
