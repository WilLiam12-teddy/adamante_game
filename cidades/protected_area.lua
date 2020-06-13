--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
	Protected area
  ]]

local S = cidades.S

-- Protect area
cidades.protect_area = function(ownername, areaname, pos1, pos2)

	if pos1 and pos2 then
		pos1, pos2 = areas:sortPos(pos1, pos2)
	else
		return false
	end
	
	minetest.log("action", "Protected area by buy land. Owner = "..ownername..
		" AreaName = "..areaname..
		" StartPos = "..minetest.pos_to_string(pos1)..
		" EndPos = "  ..minetest.pos_to_string(pos2))
	
	local id = areas:add(ownername, areaname, pos1, pos2, nil)
	areas:save()

	return id
end

-- Unprotect area
cidades.unprotect_area = function(id)
	local id = tonumber(id)

	areas:remove(id)
	areas:save()
	return true
end
