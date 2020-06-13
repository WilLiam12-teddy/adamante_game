--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
	City Builder
  ]]

local S = cidades.S

-- Registered cities
cidades.registered_cities = {}

-- Register city
cidades.register_city = function(city_id, def)
	cidades.registered_cities[city_id] = def
end

-- Active cities
cidades.active_cities = cidades.db.ms:get_string("active_cities")
if cidades.active_cities == "" then
	cidades.active_cities = {}
else
	cidades.active_cities = minetest.deserialize(cidades.active_cities)
end

-- Insert active city
cidades.insert_active_city = function(city_id, def)
	
	cidades.active_cities[city_id] = def
	cidades.db.ms:set_string("active_cities", minetest.serialize(cidades.active_cities))
end

-- Remove active city
cidades.remove_active_city = function(city_id, def)
	cidades.active_cities[city_id] = nil
	cidades.db.ms:set_string("active_cities", minetest.serialize(cidades.active_cities))
end

-- On create city callback
cidades.registered_on_create_city = {}
cidades.register_on_create_city = function(func)
	table.insert(cidades.registered_on_create_city, func)
end

-- Create city
cidades.create_city = function(city_id, pos)
	
	local city = cidades.registered_cities[city_id]
	
	-- Minp & Maxp
	local minp = {
		x = pos.x - city.radius,
		y = pos.y - city.depth,
		z = pos.z - city.radius,
	}
	local maxp = {
		x = pos.x + city.radius,
		y = pos.y + city.height,
		z = pos.z + city.radius,
	}
	
	-- Place schem	
	minetest.place_schematic(minp, city.schem_path)
	
	local epa = city.extra_protected_area or {}
	
	-- Protect area
	local area_id = cidades.protect_area("Server city", city.name, 
		{
			x = minp.x - (epa.xn or epa.x or cidades.extra_protect_side_area), 
			y = minp.y - (epa.yn or epa.y or cidades.extra_protect_bottom_area),
			z = minp.z - (epa.zn or epa.z or cidades.extra_protect_side_area)
		}, 
		{
			x = maxp.x + (epa.xp or epa.x or cidades.extra_protect_side_area), 
			y = maxp.y + (epa.yp or epa.y or cidades.extra_protect_top_area),
			z = maxp.z + (epa.zp or epa.z or cidades.extra_protect_side_area)
		}
	)
	
	-- Insert active city
	cidades.insert_active_city(city_id, {
		name = city.name,
		minp = minp,
		maxp = maxp,
		spawn = {x=pos.x, y=pos.y+6, z=pos.z},
		area_id = area_id,
	})
	
	-- Run on create city callback
	for _,f in ipairs(cidades.registered_on_create_city) do
		f(city_id)
	end
	
end

minetest.register_chatcommand("create_city", {
	params = S("City ID"),
	description = S("Create an active city"),
	func = function(name, param)
		if not param or param == "" or not cidades.registered_cities[param] then
			minetest.chat_send_player(name, S("Invalid City ID"))
			return
		end
		
		cidades.create_city(param, vector.round(minetest.get_player_by_name(name):get_pos()))
		minetest.chat_send_player(name, S("@1 created.", cidades.registered_cities[param].name))
		
	end,
})
