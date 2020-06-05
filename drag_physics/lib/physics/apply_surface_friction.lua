--[[
Apply surface friction to an entity, given the friction values on each axis.
]]
local vadd = mtrequire("ds2.minetest.vectorextras.add").raw

-- applying friction isn't just a normal subtract,
-- but rather the force opposes the direction of motion.
-- when positive: subtract, when negative: add
-- however, if it would go to zero, clamp it.
local abs_subtract = function(v, d)
	if v > 0 then
		return math.max(v - d, 0)
	else
		return math.min(v + d, 0)
	end
end
local sub = abs_subtract

-- a little utility below to avoid divide by zeroes and infinities cropping up.
-- also incorporates velocity un-signing.
local abs = math.abs
local safediv = function(s, v)
	return (v == 0) and 0 or s / abs(v)
end







-- scale is used to adjust the friction force based on the entity's weight,
-- as well as the time step under question (e.g. 0.1 seconds for per-tick).
-- ef is "entity friction", the friction value of the entity being slowed.
-- it doesn't have axes because to do so would have to consider friction etc.
local push_towards_zero = function(velocity, friction, ef, scale)
	local v, f, s = velocity, friction, scale
	-- motion along each axis is slowed by friction on the other two.
	-- e.g. Y-axis motion can be slowed by friction on the X and Z sides.
	-- slowdown is also proportional to current velocity.
	-- this should really in future also take into account normal force...
	local x = sub(v.x, ((f.fy + f.fz) * ef) * safediv(s, v.x))
	local y = sub(v.y, ((f.fx + f.fz) * ef) * safediv(s, v.y))
	local z = sub(v.z, ((f.fx + f.fy) * ef) * safediv(s, v.z))
	return x, y, z
end







-- yet more heuristics...
-- there previously was a "stuck entity" problem,
-- where entities took a REAAAAAALY long time to fall down against a wall.
-- this is due to a lack of consideration for normal force.
-- to counter this, moving really fast against a wall will push you away from it;
-- this way, gravity along a flat plane still counters it,
-- but eventually the entity will move away from a vertical wall.
-- the exception is in tight spaces barely big enough for an entity;
-- in that case the entity will slowly slide down as before.
local sqrt = math.sqrt
local vel2d = function(a, b)
	return sqrt((a*a) + (b*b))
end
local kick_tweak = 0.01
local kick_exponent = 0.01
local wall_unstick = function(vel, friction)
	local vx, vy, vz = vel.x, vel.y, vel.z
	-- movement lateral to each axis.
	-- e.g. moving fast against a rough surface in x/z will cause Y kick-off;
	-- imagine being lifted up by small bumps.
	local lx = vel2d(vy, vz)
	local ly = vel2d(vx, vz)
	local lz = vel2d(vy, vz)

	-- per-face kick-off.
	-- positive direction of each face kicks downwards in that axis.
	local t = kick_tweak
	local e = kick_exponent
	local kxmin = (t * lx * friction.fxmin) ^ e
	local kxmax = (t * lx * friction.fxmax) ^ e
	local kymin = (t * ly * friction.fymin) ^ e
	local kymax = (t * ly * friction.fymax) ^ e
	local kzmin = (t * lz * friction.fzmin) ^ e
	local kzmax = (t * lz * friction.fzmax) ^ e

	local dx = kxmin - kxmax
	local dy = kymin - kymax
	local dz = kzmin - kzmax

	return dx, dy, dz
end







-- get entity friction and scale based on properties and step dtime.
local def_ef = 50	-- TODO: make configurable?
local def_weight = 5	-- not sure if the API doc's example is the true value for this
local tweak = 200	-- value played around with during development
local get_scales = function(props, dtime)
	local ef = props.friction_surface or def_ef
	local weight = props.weight or def_weight
	local scale = (dtime / weight) * tweak
	return ef, scale
end







local i = {}
local update = function(v, vx, vy, vz)
	v.x = vx
	v.y = vy
	v.z = vz
end

-- entity friction and weighting are retrieved from an already retrieved properties table.
-- returns the modified velocity after applying to the entity.
local apply = function(dtime, entity, props, node_friction_sampler)
	local ef, scale = get_scales(props, dtime)
	local vel = entity:get_velocity()

	-- fextra could be used for e.g. returning nodes that were touched.
	local friction, fextra =
		node_friction_sampler(entity:get_pos(), props.collisionbox)

	local dx, dy, dz = wall_unstick(vel, friction)
	local rx, ry, rz = push_towards_zero(vel, friction, ef, scale)
	local vx, vy, vz = vadd(rx, ry, rz, dx, dy, dz)

	update(vel, vx, vy, vz)
	entity:set_velocity(vel)
	return vel, fextra
end
i.apply = apply



return i

