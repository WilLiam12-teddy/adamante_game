--[[
helpers for the cbox_grind module (see appropriate lua file).
]]

local i = {}

-- reference implementation of mkcube which just assigns the result into a table.
local mkcube_collect = function(sxmin, symin, szmin, sxmax, symax, szmax)
	local r = {}

	r.xmin = sxmin
	r.ymin = symin
	r.zmin = szmin

	r.xmax = sxmax
	r.ymax = symax
	r.zmax = szmax

	return r
end
i.mkcube_collect = mkcube_collect



return i

