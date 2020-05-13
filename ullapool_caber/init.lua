local mn = "ullapool_caber"
local n = mn .. ":caber"
local tex = mn .. "__caber.png"


local ve = mtrequire("ds2.minetest.vectorextras")
-- TODO EXTERN: add an averaging operation into vectorextras?
local vadd = ve.add.raw
local vmul = ve.scalar_multiply.raw
local vmulw = ve.scalar_multiply.wrapped
local vnew = ve.wrap
local vunit = ve.unit.raw
local vsub = ve.subtract.raw
local unwrap = ve.unwrap
local vlensq = ve.magnitude.squared_raw

local vavg = function(ax, ay, az, bx, by, bz)
	return vmul(0.5, vadd(ax, ay, az, bx, by, bz))
end


local explosion_power = 800.0
local search_radius = 20.0


-- accelerating players can be done in MT 5.1,
-- but the API for doing the same on entities involves read-write-modify here...
local accel_ent = function(ent, ax, ay, az)
	if ent:is_player() then
		ent:add_player_velocity(vnew(ax, ay, az))
	else
		-- hmm, I wonder, could this be made a "minetest prelude" function?
		local oldv = ent:get_velocity()
		local newv = vnew(vadd(ax, ay, az, unwrap(oldv)))
		ent:set_velocity(newv)
	end
end



local avg = function(x, y) return (x + y) * 0.5 end
-- to approximate an object's centre point,
-- we look at their collision box and extrapolate to the middle point of that.
-- assumes the centre point has already been read for other uses and is passed in.
local function centre_of(entity, cx, cy, cz)
	-- wish there was a way to get the cbox without allocating useless prop tables...
	local cbox = entity:get_properties().collisionbox
	-- unpack lower and higher values for each axis - see MT lua_api.txt
	local ox = avg(cbox[1], cbox[4])
	local oy = avg(cbox[2], cbox[5])
	local oz = avg(cbox[3], cbox[6])

	return vadd(cx, cy, cz, ox, oy, oz)
end



local get_entity_velocity = function(ent)
	if ent:is_player() then
		return ent:get_player_velocity()
	else
		return ent:get_velocity()
	end
end



local particle = {
	texture = "smoke_puff.png",
	glow = 14,
	size = 10,
}
local explosion_fx = function(c)
	local pitch = (math.random()) + 0.3
	minetest.sound_play("tnt_explode", {pos=c,pitch=pitch})
	particle.pos = c
	minetest.add_particle(particle)
end



local min = math.min
local max = math.max
local impulse_time = 0.1
-- used for "integration" below
local time_constant = impulse_time * 0.5
-- try not to reach absurdity.
local impulse_clamp = 0.05







-- code split below: depends on safe mode setting (safe mode ON by default)

-- common to both modes
local push_common = function(cx, cy, cz, ent, ex, ey, ez)
	local ox, oy, oz = vsub(ex, ey, ez, cx, cy, cz)
	local ux, uy, uz, distance = vunit(ox, oy, oz)

	-- step the entity's projected motion (FIXME: acceleration!)
	-- a certain amount of time into the future,
	-- as in reality no explosion occurs in zero time.
	-- the idea here is that in the case of moving towards the explosion,
	-- the later point will recieve much more energy due to being closer.
	-- this has the benefit of making the explosion more useful at breaking falls.
	local r1 = 1 / (distance * distance)
	local vx, vy, vz = unwrap(get_entity_velocity(ent))

	-- work out predicted movement and end positions...
	local prmx, prmy, prmz = vmul(impulse_time, vx, vy, vz)
	-- re-use positions in explosion relative space to avoid recalculating.
	local prx, pry, prz = vadd(ox, oy, oz, prmx, prmy, prmz)
	-- then just calculate distance this time.
	local d2 = vlensq(prx, pry, prz)
	local r2 = 1 / d2

	-- hacky hacky HACKY maths! but it should do for our purposes
	local impulse = (r1 + r2) * time_constant
	local i = min(impulse, impulse_clamp)
	local recieved_power = i * explosion_power

	-- plug everything back together to get effective acceleration...
	local ax, ay, az = vmul(recieved_power, ux, uy, uz)
	-- and PUNT!
	accel_ent(ent, ax, ay, az)
end

-- dangerous mode: affects all nearby entities.
local do_explode_dangerous = function(c, ...)
	local cx, cy, cz = unwrap(c)

	-- then for each entity we find (see notes about radius above)
	-- get a) the unit vector of the entity's offset from the centre,
	-- and b) the distance from the centre point to calculate inverse power.
	for _, ent in ipairs(minetest.get_objects_inside_radius(c, search_radius)) do
		local epos = ent:get_pos()
		-- treat entity's collision centre as it's origin.
		local ex, ey, ez = centre_of(ent, unwrap(epos))

		-- call common code
		push_common(cx, cy, cz, ent, ex, ey, ez)
	end
end

-- safe mode: only affect the user.
local do_explode_safe = function(c, user, ex, ey, ez)
	local cx, cy, cz = unwrap(c)

	-- we already know where the player is, so just use that.
	return push_common(cx, cy, cz, user, ex, ey, ez)
end

local s = minetest.settings:get_bool("ullapool_caber__disable_safe_mode")
local safemode = (s == nil) or (s == false)
local do_explode = safemode and do_explode_safe or do_explode_dangerous







-- search distance for what the caber struck.
local reach = 16.0

local on_use = function(stack, user, pointed)
	-- get the "centre" of the player (roughly their waistline)
	-- and cast a ray from there along the player's look direction,
	-- one that ignores the firer for collision purposes.
	-- when it hits something of interest, use that as the origin point.
	-- if the ray does not find anything then we ignore.
	local px, py, pz = centre_of(user, unwrap(user:get_pos()))
	local lx, ly, lz = unwrap(user:get_look_dir())
	local p2x, p2y, p2z = vadd(px, py, pz, vmul(reach, lx, ly, lz))
	local ray = Raycast(vnew(px, py, pz), vnew(p2x, p2y, p2z), true, false)
	local c	-- centre position, if found
	for pointed in ray do
		if pointed.ref ~= user then
			c = pointed.intersection_point
			break
		end
	end
	if not c then return end

	-- do effects of "explosion" at this location
	explosion_fx(c)

	-- safe or dangerous mode dispatch.
	-- safe mode just uses the player and their centre,
	-- so pass that to re-use it.
	return do_explode(c, user, px, py, pz)
end




minetest.register_craftitem(n, {
	on_use = on_use,
	inventory_image = tex,
	range = reach,
})
