--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
	Node fix
  ]]

-- Register node fix
local node_list = {}
cidades.registered_node_fix = {}
cidades.register_node_fix = function(nodename, func)
	node_list[nodename] = true
	cidades.registered_node_fix[nodename] = func
end

cidades.register_on_create_city(function(city_id)
	local city_data = cidades.active_cities[city_id]
	
	local nodes = cidades.vm.get(city_data.minp, city_data.maxp, minetest.deserialize(minetest.serialize(node_list)))
	
	for nn,ptb in pairs(nodes) do
		for _,pos in ipairs(ptb) do
			cidades.registered_node_fix[nn](pos, city_id)
		end
	end
end)
