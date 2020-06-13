--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
	Voxel manip
  ]]

cidades.vm = {}

--Place nodes
cidades.vm.place = function(minp, maxp, nodename)
	
	minp, maxp = vector.round(minp), vector.round(maxp)
	
	local c_node = minetest.get_content_id(nodename)
	
	local vm = minetest.get_voxel_manip()
	local emin, emax = vm:read_from_map(minp, maxp)
	local data = vm:get_data()
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
 
	-- Set nodes
	for i in area:iter(
		minp.x, minp.y, minp.z,
		maxp.x, maxp.y, maxp.z
	) do
		data[i] = c_node
	end
	
	vm:set_data(data)
	vm:write_to_map()
end

-- Replace nodes
cidades.vm.replace = function(minp, maxp, replace)
	
	minp, maxp = vector.round(minp), vector.round(maxp)
	
	local repl = {}
	for old, new in pairs(replace) do
		repl[minetest.get_content_id(old)] = minetest.get_content_id(new)
	end
	
	local vm = minetest.get_voxel_manip()
	local emin, emax = vm:read_from_map(minp, maxp)
	local data = vm:get_data()
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
 
	-- Replace nodes
	for i in area:iter(
		minp.x, minp.y, minp.z,
		maxp.x, maxp.y, maxp.z
	) do
		
		data[i] = repl[data[i]] or data[i]
	end
	
	vm:set_data(data)
	vm:write_to_map()
	
end

-- Get nodes
cidades.vm.get = function(minp, maxp, nodes)
	
	minp, maxp = vector.round(minp), vector.round(maxp)
	
	local mod = {}
	local nodes_found = {}
	for nn,_ in pairs(nodes) do
		mod[minetest.get_content_id(nn)] = nn
		nodes[nn] = {}
	end
	
	local vm = minetest.get_voxel_manip()
	local emin, emax = vm:read_from_map(minp, maxp)
	local data = vm:get_data()
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	
	-- Find area
	for i in area:iter(
		minp.x, minp.y, minp.z,
		maxp.x, maxp.y, maxp.z
	) do
		if mod[data[i]] then
			nodes_found[mod[data[i]]] = nodes_found[mod[data[i]]] or {}
			table.insert(nodes_found[mod[data[i]]], area:position(i))
			
		end
	end
	
	vm:set_data(data)
	vm:write_to_map()
	
	return nodes_found	
end

