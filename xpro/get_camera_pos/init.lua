--[[
Get the "camera position" for a given objectref.
Currently only supports players, but will handle non-player entities passed;
an entity which doesn't support the concept will return nil.
May support other entities with the concept in future, if applicable.
]]
local i = {}



-- get the entity's eye offset, relative to their origin.
-- for now, only players are supported.
-- get_eye_offset :: EntityRef -> Maybe Vec3 Num
local get_eye_offset = function(entity)
	if not entity:is_player() then return nil end

	-- note that camera offset is scaled by 10
	local o, _ = entity:get_eye_offset()
	o.x = o.x / 10
	o.y = o.y / 10
	o.z = o.z / 10

	-- upcoming in 5.x: proper eye height in object properties.
	-- if there is no such property, fall back to the old height constant.
	local props = entity:get_properties()
	local height = props.eye_height or 1.625
	o.y = o.y + height

	return o
end
i.get_eye_offset = get_eye_offset



-- convenience routine to get world space camera position,
-- given the entity's base position (if already known from elsewhere).
-- get_eye_position_from_bpos :: EntityRef -> Vec3 Num -> Maybe Vec3 Num
local get_eye_position_from_bpos = function(entity, bp)
	local o = get_eye_offset(entity)
	if o == nil then return nil end

	o.x = o.x + bp.x
	o.y = o.y + bp.y
	o.z = o.z + bp.z
	return o
end
i.get_eye_position_from_bpos = get_eye_position_from_bpos



-- convenience function to auto-retrieve the base pos as well.
-- returns two values, base pos and eye pos, *in that order*.
-- get_base_and_eye_pos :: EntityRef -> (Maybe Vec3 Num, Maybe Vec3 Num)
-- There are three outcomes from this function:
-- bpos = nil, eyepos = nil - :get_pos() failed, is the entity dead?
-- bpos = {...}, eyepos = nil - :get_pos() worked, but unsupported entity.
-- bpos = {...}, eyepos = {...} - everything worked fine.
local get_base_and_eye_pos = function(entity)
	local bpos = entity:get_pos()
	if bpos == nil then return nil, nil end

	local eyepos = get_eye_position_from_bpos(entity, bpos)
	return bpos, eyepos
end
i.get_base_and_eye_pos = get_base_and_eye_pos



-- register time
modtable_register("ds2.minetest.misc_game_routines.get_camera_pos", i)



