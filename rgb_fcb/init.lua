local base = "rgb_fcb_redblue_ramp.png"
local b = "rgb_fcb_plaintex.png"
local tiles = {b,b,b,b,b,b}
local hand = {
	oddly_breakable_by_hand=1,
	-- avoid spamming the creative inventory here...
	not_in_creative_inventory=1,
}

local hexbyte = function(v)
	return string.format("%02x", v)
end
local shallowcopy = function(t)
	local r = {}
	for k, v in pairs(t) do
		r[k] = v
	end
	return r
end



-- opaque definition is separate from transparent ones
-- as extra considerations must be taken for transparent ones;
-- this includes drawtype and light trasmittance.
local register_opaque_shade = function(basef, blue)
	assert(blue >= 0)
	assert(blue <= 15)
	assert(blue % 1.0 == 0)

	local name, basedef = basef(blue)
	-- if only there was a way of indicating it was OK to mutate the base table...
	local def = shallowcopy(basedef)
	name = name.."_b"..blue.."a15"

	local bluehex = hexbyte(blue * 17)
	def.palette = base.."^[multiply:#FFFF"..bluehex
	def.paramtype2 = "color"
	def.drawtype = "normal"

	return minetest.register_node(name, def)
end
local register_opaque_spectrum = function(basef)
	for i = 0, 15, 1 do
		register_opaque_shade(basef, i)
	end
end



register_transparent_shade = function(basef, blue, alpha)
	assert(blue >= 0)
	assert(blue <= 15)
	assert(blue % 1.0 == 0)
	assert(alpha >= 1)	-- < completely transparent is invisible!
	assert(alpha <= 14)	-- < full opacity doesn't make sense for this
	assert(alpha % 1.0 == 0)

	local name, basedef = basef(blue, alpha)
	local def = shallowcopy(basedef)
	name = name.."_b"..blue.."a"..alpha

	local bluehex = hexbyte(blue * 17)
	local o = alpha * 17
	def.palette = base.."^[multiply:#FFFF"..bluehex
	def.paramtype = "light"
	def.paramtype2 = "color"
	def.drawtype = "glasslike"
	def.use_texture_alpha = true
	def.sunlight_propogates = (alpha <= 10)

	-- here we patch the textures to use transparency as well;
	-- it seems doing so from the palette doesn't work.
	local tiles = shallowcopy(basedef.tiles)
	for i, v in ipairs(tiles) do
		tiles[i] = "("..v..")^[opacity:"..o
	end
	def.tiles = tiles

	return minetest.register_node(name, def)
end
local register_transparent_spectrum = function(basef, alpha)
	for blue = 0, 15, 1 do
		register_transparent_shade(basef, blue, alpha)
	end
end
local register_transparent_range = function(basef)
	for alpha = 1, 14, 1 do
		register_transparent_spectrum(basef, alpha)
	end
end




local basef = function(blue)
	local basedef = {
		description = "RGB flat colour block (base blue: "..blue..")",
		groups = hand,
		tiles = tiles,
	}
	return "rgb_fcb:rgb", basedef
end
register_opaque_spectrum(basef)



local pre = "RGB flawless glass block"
local puref = function(blue, alpha)
	local desc = pre.." (base blue: "..blue..", opacity: "..alpha.."/15)"
	local basedef = {
		description = desc,
		groups = hand,
		tiles = tiles,
	}
	return "rgb_fcb:transparent", basedef
end
register_transparent_range(puref)



