--[[
Implementation functions for cbox_grind (see appropriate lua file)
which do the calculations for surface friction.
]]
local mk_cbox_sampler = mtrequire("ds2.minetest.drag_physics.cbox_grind")

-- cube sampling function:
-- for surface friction, both faces along an axis will always be added anyway.
-- so just do it here to save some time and table inserts.
local mkcube = function(sxmin, symin, szmin, sxmax, symax, szmax)
	return {
		fx = sxmin + sxmax,
		fy = symin + symax,
		fz = szmin + szmax,
		-- extended per-face properties, mostly used in kickoff behaviour
		fxmin = sxmin,
		fxmax = sxmax,
		fymin = symin,
		fymax = symax,
		fzmin = szmin,
		fzmax = szmax,
	}
end

-- the getnode sampling defers to another function to read the friction value
-- (this is MT-specific so not configured here).
-- the face and sign arguments are not relevant, as below they will be averaged.
local mk_getnode = function(friction_at_point)
	assert(type(friction_at_point) == "function")
	return function(face, sign, x, y, z)
		local friction, extradata = friction_at_point(x, y, z)
		return friction, extradata
	end
end

-- mkface performs the arithmetic mean of the four corners.
-- this isn't a perfect representation of friction,
-- but it suffices for small enough objects.
local mkface = function(face, ll, hl, lh, hh)
	return (ll + hl + lh + hh) / 4
end

local impl = {
	mkface = mkface,
	mkcube = mkcube,
}
local mk_cbox_grind_friction_vector_sampler = function(friction_at_point)
	impl.getnode = mk_getnode(friction_at_point)
	return mk_cbox_sampler(impl)
end

return mk_cbox_grind_friction_vector_sampler

