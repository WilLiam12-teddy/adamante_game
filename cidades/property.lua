--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
	Property
  ]]

local S = cidades.S

cidades.property = {}


-- Radius
cidades.property.radius = {
	["0"] = 3, 
	["1"] = 4, 
	["2"] = 5, 
	["3"] = 6, 
	["4"] = 7, 
	["5"] = 8, 
	["6"] = 9, 
	["7"] = 10, 
	["8"] = 11, 
	["9"] = 12, 
}
cidades.property.radius_i = {
	["3"] = 0, 
	["4"] = 1, 
	["5"] = 2, 
	["6"] = 3, 
	["7"] = 4, 
	["8"] = 5, 
	["9"] = 6, 
	["10"] = 7, 
	["11"] = 8, 
	["12"] = 9, 
}

-- Height
cidades.property.height = {
	["0"] = 3, 
	["1"] = 5, 
	["2"] = 8, 
	["3"] = 10, 
	["4"] = 12, 
	["5"] = 14, 
	["6"] = 16, 
	["7"] = 18, 
	["8"] = 20, 
	["9"] = 25, 
}
cidades.property.height_i = {
	["3"] = 0, 
	["5"] = 1, 
	["8"] = 2, 
	["10"] = 3, 
	["12"] = 4, 
	["14"] = 5, 
	["16"] = 6, 
	["18"] = 7, 
	["20"] = 8, 
	["25"] = 9, 
}

-- Get data node
cidades.property.get_data_pos = function(pos, data_type, def)
	def = def or 0	
	
	if data_type == "core" then
		return {
			x = pos.x, 
			y = pos.y - def, 
			z = pos.z
		}
	elseif data_type == "cost10x" then
		return {
			x = pos.x - 1, 
			y = pos.y - def, 
			z = pos.z - 1
		}
	elseif data_type == "cost100x" then
		return {
			x = pos.x - 1, 
			y = pos.y - def, 
			z = pos.z
		}
	elseif data_type == "cost1000x" then
		return {
			x = pos.x - 1, 
			y = pos.y - def, 
			z = pos.z + 1
		}
	elseif data_type == "height" then
		return {
			x = pos.x, 
			y = pos.y - def, 
			z = pos.z + 1
		}
	elseif data_type == "radius" then
		return {
			x = pos.x, 
			y = pos.y - def, 
			z = pos.z - 1
		}
	end
end


-- Get resale price
cidades.get_sale_price = function(cost)
	return cost * cidades.resale_factor
end


-- Get property data
cidades.property.get_data = function(pos)
	local height = cidades.property.height[tostring(cidades.number_node[minetest.get_node(cidades.property.get_data_pos(pos, "height")).name])]
	local radius = cidades.property.radius[tostring(cidades.number_node[minetest.get_node(cidades.property.get_data_pos(pos, "radius")).name])]
	local cost10x = tostring(cidades.number_node[minetest.get_node(cidades.property.get_data_pos(pos, "cost10x")).name])
	local cost100x = tostring(cidades.number_node[minetest.get_node(cidades.property.get_data_pos(pos, "cost100x")).name])
	local cost1000x = tostring(cidades.number_node[minetest.get_node(cidades.property.get_data_pos(pos, "cost1000x")).name])
	local cost = tonumber(cost1000x..cost100x..cost10x.."0")
	
	return {
		radius = radius,
		height = height,
		cost = cost,
	}
end


-- Set owner
cidades.set_owner = function(player, pos, data)
	
	local city_id = minetest.get_meta(pos):get_string("city_id")
	
	-- Update property stone
	minetest.set_node(pos, {name="cidades:property_stone_purchased"})
	
	-- Minp & Maxp
	local minp = {
		x=pos.x-data.radius, 
		y=pos.y+1, 
		z=pos.z-data.radius
	}
	local maxp = {
		x=pos.x+data.radius, 
		y=pos.y+1+data.height, 
		z=pos.z+data.radius
	}
	
	-- Protect area
	local area_id = cidades.protect_area(player:get_player_name(), "Property", minp, maxp)
	
	-- Update metadata
	data.pos = pos
	data.city_id = city_id
	data.width = (data.radius * 2) + 1
	data.minp = minp
	data.maxp = maxp
	data.soil_node = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name
	data.owner = player:get_player_name()
	data.area_id = area_id
	data.last_login = cidades.get_date_hash()
	
	-- Update data base
	cidades.db.set_property(data.owner, data)
	
	minetest.get_meta(pos):set_string("stone_data", minetest.serialize(data))
end


-- Reset owner
cidades.reset_property = function(pos, data)
	
	-- Update data base
	cidades.db.reset_property(data.owner)
	
	-- Restore land
	cidades.restore_land(pos, data)
	
	-- Unprotect area
	cidades.unprotect_area(data.area_id)
	
	-- Place poles
	cidades.place_poles(pos, data.radius)
	
	-- Place seller
	minetest.set_node({x=pos.x, y=pos.y+3, z=pos.z}, {name="cidades:seller"})
	
	-- Update property stone
	minetest.set_node(pos, {name="cidades:property_stone_for_sale"})
	
	-- Save city_id
	minetest.get_meta(pos):set_string("city_id", data.city_id)
	
	-- Update metadata
	data.owner = nil
end


minetest.register_chatcommand("sell_property", {
	params = S("None"),
	description = S("Sell property"),
	func = function(name, param)
		if cidades.db.check_property(name) == false then
			return false, S("No property.")
		end
		
		-- Remove registry
		cidades.db.reset_property(name)
	end,
})




