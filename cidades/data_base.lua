--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
	Data Base
  ]]

cidades.db = {}

cidades.db.ms = minetest.get_mod_storage()

-- Set City def
cidades.db.set_city = function(city_id, data)
	cidades.db.ms:set_string("city_"..city_id, minetest.serialize(data))
end

-- Get City def
cidades.db.get_city = function(city_id)
	return minetest.deserialize(cidades.db.ms:get_string("city_"..city_id))
end


-- Set Property data
cidades.db.set_property = function(owner, data)
	cidades.db.ms:set_string("property_"..owner, minetest.serialize(data))
end

-- Remove Property data
cidades.db.reset_property = function(owner)
	cidades.db.ms:set_string("property_"..owner, "")
end

-- Get Property data
cidades.db.get_property = function(owner)
	return minetest.deserialize(cidades.db.ms:get_string("property_"..owner))
end

-- Check Property
cidades.db.check_property = function(owner)
	if cidades.db.ms:get_string("property_"..owner) ~= "" then
		return true
	end
	return false
end



