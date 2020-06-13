--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
	Teleporter
  ]]

local S = cidades.S

-- Cities
local cities_string_list = ""
local cities_list = {}

-- Fosmpec
local formspec = "size[6,5]"
	..default.gui_bg
	..default.gui_bg_img
	.."label[0.5,0;"..S("Choose a city").."]"
	.."textlist[0.5,0.8;4.8,3;city;]"
	.."button_exit[1,4.2;4,1;teleport;"..S("Go").."]"

-- Atualizar lista de vilas
local update_list = function()
	
	cities_string_list = ""
	cities_list = {}
	
	for city_id, city_data in pairs(cidades.active_cities) do
		
		-- Add ','
		if cities_string_list ~= "" then cities_string_list = cities_string_list .. "," end
		
		-- Add city name
		cities_string_list = cities_string_list .. city_data.name
		
		-- Add spawn pos
		table.insert(cities_list, {
			name = city_data.name,
			pos = city_data.spawn,
		})
	end
	
	-- Update formspec
	formspec = "size[6,5]"
		..default.gui_bg
		..default.gui_bg_img
		.."label[0.5,0;"..S("Choose a city").."]"
		.."textlist[0.5,0.8;4.8,3;city;"..cities_string_list.."]"
end
update_list()

local show_formspec = function(player)
	local name = player:get_player_name()
	if player:get_attribute("cidades:teleporter_choose") ~= nil then
		minetest.show_formspec(name, "cidades:teleporter", formspec.."button_exit[1,4.2;4,1;teleport;"..S("Go").."]")
	else
		minetest.show_formspec(name, "cidades:teleporter", formspec)
	end
end



minetest.register_on_player_receive_fields(function(player, formname, fields)

	if formname == "cidades:teleporter" then
	
		if fields.city then
			local n = string.split(fields.city, ":")
			
			player:set_attribute("cidades:teleporter_choose", n[2])
			
			if n[1] == "DCL" then
				fields.teleport = true
			else
				show_formspec(player, n[2])
				return 
			end
			
		end
		
		if fields.teleport then
			local name = player:get_player_name()
			local id = tonumber(player:get_attribute("cidades:teleporter_choose"))
			
			player:set_attribute("cidades:teleporter_choose", nil)
			player:set_pos(cities_list[id].pos)
			
			minetest.close_formspec(name, "cidades:teleporter")
			minetest.chat_send_player(name, S("Welcome to @1", cities_list[id].name))
		end
		
		if fields.quit then
			player:set_attribute("cidades:teleporter_choose", nil)
		end
	end
end)


-- Teleporter
minetest.register_node("cidades:teleporter", {
	description = S("Teleporter"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {
		"default_wood.png",
		"default_wood.png",
		"default_wood.png^cidades_teleporter.png", 
		"default_wood.png^cidades_teleporter.png", 
		"default_wood.png^cidades_teleporter.png", 
		"default_wood.png^cidades_teleporter.png" 
	},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2},
	
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		if cities_list[1] then
			show_formspec(clicker)
		else
			minetest.chat_send_player(clicker:get_player_name(), "No cities avaliable"..dump(cidades.active_cities))
		end
	end,
})
