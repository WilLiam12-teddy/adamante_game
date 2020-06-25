--[[
A small cloud of particles emitted from a point, useful as a marker.
I used this for debugging positions returned by raytracing.
]]

local colourspawner =
	mtrequire("com.github.thetaepsilon.minetest.particleeffects.colourspawner")


local shallowcopy = function(t)
	if not t then return {} end
	local r = {}
	for k, v in pairs(t) do
		r[k] = v
	end
	return r
end

local d = 1.0
local minvel = vector.new(-d, -d, -d)
local maxvel = vector.new(d, d, d)
local zero = vector.new(0, 0, 0)
local t = 0.3
local sz = 1

local i = {}
local mk_indicator = function(cl, __props)
	local props = shallowcopy(__props)

	local time = props.time
	if (not time) then
		time = 5
		props.time = time
	end
	local amount = props.amount
	if (not amount) then
		amount = time * 100
		props.amount = amount
	end

	local base = colourspawner.mk(props, cl)
	return function(mt, pos, __overrides)
		local overrides = __overrides and shallowcopy(__overrides) or {}
		local o = overrides
		o.minpos = pos
		o.maxpos = pos
		o.minvel = minvel
		o.maxvel = maxvel
		o.minacc = zero
		o.maxacc = zero
		o.minexptime = t
		o.maxexptime = t
		o.minsize = sz
		o.maxsize = sz
		return base(mt, overrides)
	end
end
i.mk = mk_indicator



return i

