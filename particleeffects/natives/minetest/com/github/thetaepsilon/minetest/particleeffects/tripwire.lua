local colourspawner =
	mtrequire("com.github.thetaepsilon.minetest.particleeffects.colourspawner")

local mk_tripwire = function(cl, baseprops)
	local speed = baseprops.speed or 1
	local time = baseprops.time
	local amount = baseprops.amount
	local glow = baseprops.glow
	local vm = vector.multiply
	local vdir = vector.direction

	return function(mt, pos1, pos2)
		local step1 = vm(vdir(pos1, pos2), speed)
		local step2 = vm(vdir(pos2, pos1), speed)
		local lifetime = vector.distance(pos1, pos2) / speed

		local props = {}
		props.collisiondetection = true
		props.collision_removal = true
		props.time = time or lifetime * 2
		props.amount = amount or props.time * 2
		props.minexptime = lifetime
		props.maxexptime = lifetime
		props.glow = glow

		for _, v in ipairs({{pos1, step1}, {pos2, step2}}) do
			props.minpos = v[1]
			props.maxpos = v[1]
			props.minvel = v[2]
			props.maxvel = v[2]
			colourspawner.mk(props, cl)(mt, {})
		end
	end
end

local mk_tripwire_span = function(cl, baseprops)
	local base = mk_tripwire(cl, baseprops)
	return function(mt, pos, radius)
		local pos1 = vector.add(pos, radius)
		local pos2 = vector.subtract(pos, radius)
		return base(mt, pos1, pos2)
	end
end

return {
	mk = mk_tripwire,
	mk_span = mk_tripwire_span,
}

