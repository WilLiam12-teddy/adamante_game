--[[
In minetest-specific code: provide definition lookup and node sampling,
based on minetest.registered_nodes and .get_node(), respectively.
]]
local mk_friction_at_point =
	mtrequire("ds2.minetest.drag_physics.friction_at_point_mt_world")
local mk_sampler = mtrequire("ds2.minetest.drag_physics.cbox_friction_vector_sampler")

-- throwaway allocations, whyyyyyy
local pos = {}
local getnodename = function(x, y, z)
	pos.x = x
	pos.y = y
	pos.z = z
	local node = minetest.get_node(pos)
	return node.name
end

local nlookup = function(n) return minetest.registered_nodes[n] end
-- the only real reason we have to do this here
-- is to avoid hard-coding MT function references in portable code.
local minetest_friction_at_point = mk_friction_at_point(getnodename, nlookup)

local i = {}
i.friction_sampler = mk_sampler(minetest_friction_at_point)
return i

