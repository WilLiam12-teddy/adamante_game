local unsaveable = mtrequire("com.github.thetaepsilon.minetest.entityprops.unsaveable")

local modname = minetest.get_current_modname()

-- TODO: look at the minetest settings API
local debugmode = true

--[[
drawtype settings for the pivot and attachment entities.
normally, the entities are made "invisible" by use of a sprite that's transparent.
when debugmode = true, this sprite is replaced by the one specified so the entities can be seen.
]]
local invisible = "entityprops_nodraw.png"
local attachment_drawtype = function(def, debugtex)
	def.drawtype = "sprite"
	local tex = debugmode and debugtex or invisible
	def.textures = { tex }
	return def
end



-- pivot entity:
-- does nothing by itself.
-- it is intended to be used as an anchor point on which other entities may rotate,
-- using the rotation vector that can be passed to set_attach().
-- the position offset may also be used.

--[[
/lua minetest.add_entity(vector.add(me:get_pos(), {x=0,y=-1,z=0}), "entityprops:pivot", "nodata")
]]
local base = {
	on_activate = unsaveable.mk_unsaveable_activate()
}
-- visually shrink the sprite texture without modifying the visual_size property.
-- this avoids the scale being applied to any attached children.
local shrunken = "[combine:64x64:16,16=entityprops_pivot.png"
local def = attachment_drawtype(base, shrunken)
minetest.register_entity(modname..":pivot", def)
