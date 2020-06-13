--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
	City Builder
  ]]

local S = cidades.S

-- Area mark node
minetest.register_node("cidades:area_mark", {
	description = "Area mark",
	tiles = {"cidades_area_mark.png"},
	groups = {choppy = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	drop = "",
})

-- Mark area
local mark_area = function(pos)
	local meta = minetest.get_meta(pos)
	local radius = meta:get_float("radius")
	local height = meta:get_float("height")
	local depth = meta:get_float("depth")
	
	local minp = {
		x = pos.x - radius - 1,
		y = pos.y - depth - 1,
		z = pos.z - radius - 1,
	}
	local maxp = {
		x = pos.x + radius + 1,
		y = pos.y + height + 1,
		z = pos.z + radius + 1,
	}
	
	for y = minp.y, maxp.y do
		minetest.set_node({x=maxp.x, y=y, z=maxp.z}, {name="cidades:area_mark"})
		minetest.set_node({x=maxp.x, y=y, z=minp.z}, {name="cidades:area_mark"})
		minetest.set_node({x=minp.x, y=y, z=maxp.z}, {name="cidades:area_mark"})
		minetest.set_node({x=minp.x, y=y, z=minp.z}, {name="cidades:area_mark"})
	end
	
	for x = minp.x, maxp.x do
		minetest.set_node({x=x, y=maxp.y, z=maxp.z}, {name="cidades:area_mark"})
		minetest.set_node({x=x, y=maxp.y, z=minp.z}, {name="cidades:area_mark"})
	end
	for z = minp.z, maxp.z do
		minetest.set_node({x=maxp.x, y=maxp.y, z=z}, {name="cidades:area_mark"})
		minetest.set_node({x=minp.x, y=maxp.y, z=z}, {name="cidades:area_mark"})
	end
	
	-- Remove node mark inside
	cidades.vm.replace(vector.add(minp, 1), vector.subtract(maxp, 1), {["cidades:area_mark"]="air"})
end

-- Export Schematic
local export_city = function(pos)
	local meta = minetest.get_meta(pos)
	local radius = meta:get_float("radius")
	local height = meta:get_float("height")
	local depth = meta:get_float("depth")
	
	local minp = {
		x = pos.x - radius,
		y = pos.y - depth,
		z = pos.z - radius,
	}
	local maxp = {
		x = pos.x + radius,
		y = pos.y + height,
		z = pos.z + radius,
	}	
	
	local filename = meta:get_string("city_id")..".mts"
	
	minetest.mkdir(minetest.get_worldpath().."/cities in work")
	
	if minetest.create_schematic(minp, maxp, {}, minetest.get_worldpath().."/cities in work/"..filename) ~= true then
		return minetest.chat_send_all(S("Export failed."))
	end
	
	minetest.chat_send_all(S("Schematic successfully exported. Restart the world to import it. '@1' file is in the world directory ('cities in work' folder).", filename))
end

-- Import Schematic
local import_city = function(pos)
	local meta = minetest.get_meta(pos)
	local radius = meta:get_float("radius")
	local height = meta:get_float("height")
	local depth = meta:get_float("depth")
	
	local minp = {
		x = pos.x - radius,
		y = pos.y - depth,
		z = pos.z - radius,
	}
	
	local filename = meta:get_string("city_id")..".mts"
	
	if minetest.place_schematic(minp, minetest.get_worldpath().."/cities in work/"..filename) ~= true then
		return minetest.chat_send_all(S("Import failed."))
	end
	
	minetest.chat_send_all(S("Schematic successfully imported."))
end


-- Update formspec
local update_formspec = function(pos)
	local meta = minetest.get_meta(pos)
	
	meta:set_string("formspec", "size[8,8]"
		.."field[1,1;6,1;city_id;"..S("City ID (eg. wood_ville)")..";"..meta:get_string("city_id").."]"
		.."field[1,4;2,1;radius;"..S("Radius")..";"..meta:get_float("radius").."]"
		.."field[3,4;2,1;height;"..S("Height")..";"..meta:get_float("height").."]"
		.."field[5,4;2,1;depth;"..S("Depth")..";"..meta:get_float("depth").."]"
		
		.."label[0.5,5;"..S("This node is the reference for central position.").."]"
		.."label[0.5,5.5;"..S("Spawn position for this city is 6 blocks above this block.").."]"
		
		.."button_exit[1,7;2,1;export;"..S("Export").."]"
		.."button_exit[3,7;2,1;import;"..S("Import").."]"
		.."button_exit[5,7;2,1;mark;"..S("Mark").."]")
end


-- City Builder node
minetest.register_node("cidades:city_builder", {
	description = S("City Builder"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"cidades_city_builder.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2},
	
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", S("City Builder"))
		
		meta:set_string("city_id", "")
		meta:set_int("radius", 80)
		meta:set_int("height", 50)
		meta:set_int("depth", 15)
		
		update_formspec(pos)
	end,
	
	on_receive_fields = function(pos, formname, fields, sender)
		
		-- Check privs
		if minetest.check_player_privs(sender:get_player_name(), {server = true}) ~= true then
			return
		end
		
		-- Save settings
		if fields.export or fields.import or fields.mark then
			local meta = minetest.get_meta(pos)
			meta:set_string("city_id", fields.city_id)
			meta:set_float("radius", tonumber(fields.radius))
			meta:set_float("height", tonumber(fields.height))
			meta:set_float("depth", tonumber(fields.depth))
			update_formspec(pos)
		end
		
		-- Mark area
		if fields.mark then
			mark_area(pos)
		end
		
		-- Import city
		if fields.import then
			import_city(pos)
		end
		
		-- Export city
		if fields.export then
			export_city(pos)
		end
		
	end,
})
