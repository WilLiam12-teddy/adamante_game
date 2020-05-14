--S = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end
modTradeLands.translate = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

--[[
S("%s moves stuff in %s at %s"):format(
	player:get_player_name(), name, minetest.pos_to_string(pos)
)
--]]
