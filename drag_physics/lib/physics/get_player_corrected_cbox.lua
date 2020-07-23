--[[
When a player lands on top of a block,
their get_pos() will report right on top of the block (block pos Y + 0.5);
which means that their physics cbox has zero padding underneath their position.
However, the *reported* cbox has a ymin of -1,
meaning that the reported and actually used cbox do not match.
Here we correct this.
]]
local adjust_cbox_mut = function(cbox)
	local bottom = cbox[2]
	local top = cbox[5]
	cbox[2] = 0
	cbox[5] = top - bottom
end
local correct_cbox = function(player)
	-- assumes that this data is copied!
	local props = player:get_properties()
	local cbox = props.collisionbox
	adjust_cbox_mut(cbox)
	return cbox
end

return correct_cbox

