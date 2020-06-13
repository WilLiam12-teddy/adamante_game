--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
	Property Builder
  ]]

local S = cidades.S

-- Create property
local create_property = function(pos)
	local meta = minetest.get_meta(pos)
	local radius = meta:get_float("radius")
	local height = meta:get_float("height")
	local cost = meta:get_float("cost")
	-- Adjust cost
	do
		local i = ""
		if cost < 1000 then i = "0" end
		if cost < 100 then i = "00" end
		cost = i..tonumber(cost)
	end
	
	local cost10x = string.sub(cost, 3, 3)
	local cost100x = string.sub(cost, 2, 2)
	local cost1000x = string.sub(cost, 1, 1)
	
	-- Set data nodes
	minetest.set_node(cidades.property.get_data_pos(pos, "radius", 2), {name = "cidades:stone_"..cidades.property.radius_i[tostring(radius)]})
	minetest.set_node(cidades.property.get_data_pos(pos, "height", 2), {name = "cidades:stone_"..cidades.property.height_i[tostring(height)]})
	minetest.set_node(cidades.property.get_data_pos(pos, "cost10x", 2), {name = "cidades:stone_"..cost10x})
	minetest.set_node(cidades.property.get_data_pos(pos, "cost100x", 2), {name = "cidades:stone_"..cost100x})
	minetest.set_node(cidades.property.get_data_pos(pos, "cost1000x", 2), {name = "cidades:stone_"..cost1000x})
	minetest.set_node(cidades.property.get_data_pos(pos, "core", 2), {name = "cidades:property_stone_for_sale"})
	
	-- Set seller
	minetest.set_node({x=pos.x, y=pos.y+1, z=pos.z}, {name = "cidades:seller"})
	
	-- Place poles
	cidades.place_poles({x=pos.x, y=pos.y-2, z=pos.z}, radius)
	
	-- Remove property builder
	minetest.remove_node(pos)
	
	minetest.chat_send_all("Property created")
end


-- Update formspec
local update_formspec = function(pos)
	local meta = minetest.get_meta(pos)
	
	meta:set_string("formspec", "size[8,8]"
		.."field[1,3;6.5,1;radius;"..S("Radius (3 - 12)")..";"..meta:get_float("radius").."]"
		.."field[1,4.5;6.5,1;height;"..S("Height (3, 5, 8, 10, 12, 14, 16, 18, 20 or 25)")..";"..meta:get_float("height").."]"
		.."field[1,6;6.5,1;cost;"..S("Cost (10 - 9990)")..";"..meta:get_float("cost").."]"
		.."button_exit[1,7;6,1;create;"..S("Create").."]")
end


-- Property Builder node
minetest.register_node("cidades:property_builder", {
	description = S("Property Builder"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"cidades_property_builder.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2},
	
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", S("Property Builder"))
		
		meta:set_int("radius", 4)
		meta:set_int("height", 5)
		meta:set_string("cost", "100")
		
		update_formspec(pos)
	end,
	
	on_receive_fields = function(pos, formname, fields, sender)
		
		-- Check privs
		if minetest.check_player_privs(sender:get_player_name(), {server = true}) ~= true then
			return
		end
		
		-- Save settings
		if fields.create then
			local meta = minetest.get_meta(pos)
			
			if cidades.property.radius_i[fields.radius] then
				meta:set_float("radius", tonumber(fields.radius))
			else
				return minetest.chat_send_all(S("Invalid radius."))
			end
			
			if cidades.property.height_i[fields.height] then
				meta:set_float("height", tonumber(fields.height))
			else
				return minetest.chat_send_all(S("Invalid height."))
			end
			
			if tonumber(fields.cost) <= 9990 and tonumber(fields.cost) >= 10 then
				meta:set_float("cost", tonumber(fields.cost))
			else
				return minetest.chat_send_all(S("Invalid cost."))
			end
			
			update_formspec(pos)
		end
		
		-- Mark area
		if fields.create then
			create_property(pos)
		end
		
	end,
})
