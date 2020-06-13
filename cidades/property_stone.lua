--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
	Property Stone
  ]]


-- Property Stone for Sale
minetest.register_node("cidades:property_stone_for_sale", {
	description = "Property Stone",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_stone.png"},
	is_ground_content = false,
	drop = "default:stone",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, stone = 1, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults(),
})

cidades.register_node_fix("cidades:property_stone_for_sale", function(pos, city_id)
	minetest.get_meta(pos):set_string("city_id", city_id)
end)


-- Property Stone Purchased
minetest.register_node("cidades:property_stone_purchased", {
	description = "Property Stone Purchased",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_stone.png"},
	is_ground_content = false,
	drop = "default:stone",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, stone = 1, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults(),
})


-- Check property stone
cidades.check_property_stone = function(pos)
	local meta = minetest.get_meta(pos)
	local data = minetest.deserialize(meta:get_string("stone_data"))
	
	-- Check data base registry
	if cidades.db.check_property(data.owner) == false then
		cidades.reset_property(pos, data)
		return
	end
	
	-- Check las login
	local db_data = cidades.db.get_property(data.owner)
	if cidades.get_date_hash() - db_data.last_login > cidades.max_days_inactive_owner then
		cidades.reset_property(pos, data)
	end
end

minetest.register_lbm({
	name = "cidades:check_property",
	nodenames = {"cidades:property_stone_purchased"},
	run_at_every_load = true,
	action = function(pos, node)
		cidades.check_property_stone(pos)
	end,
})

minetest.register_abm{
        label = "check purchased property",
	nodenames = {"cidades:property_stone_purchased"},
	interval = 300,
	chance = 1,
	action = function(pos)
		cidades.check_property_stone(pos)
	end,
}


-- Update last login
local update_last_login = function(player)
	if not player then return end
	local name = player:get_player_name()
	
	if cidades.db.check_property(name) == false then return end
	
	local data = cidades.db.get_property(name)
	data.last_login = cidades.get_date_hash()
end

minetest.register_on_joinplayer(function(player)
	update_last_login(player)
end)
