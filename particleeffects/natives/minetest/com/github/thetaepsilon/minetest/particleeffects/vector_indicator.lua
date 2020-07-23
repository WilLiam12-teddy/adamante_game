local colourspawner =
	mtrequire("com.github.thetaepsilon.minetest.particleeffects.colourspawner")

-- a dotted straight line indicating a direction vector.
-- useful for debugging direction vectors in mods.

local speed = 10
local mk_indicator = function(cl, __props)
	local props = table.copy(__props)

	local time = props.time
	if (not time) then
		time = 3
		props.time = time
	end
	local amount = props.amount
	if (not amount) then
		amount = 100 * time
		props.amount = amount
	end

	local base = colourspawner.mk(props, cl)
	return function(mt, pos, vec, length, __overrides)
		local overrides = overrides and table.copy(__overrides) or {}
		overrides.minpos = pos
		overrides.maxpos = pos
		length = length or 2
		local vel = vector.multiply(vector.normalize(vec), length*speed)
		overrides.minvel = vel
		overrides.maxvel = vel

		overrides.minacc = nil
		overrides.maxacc = nil

		

		local x = length / speed
		overrides.minexptime = x
		overrides.maxexptime = x

		return base(mt, overrides)
	end
end

local i = {}
i.mk = mk_indicator
return i

