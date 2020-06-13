--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
	Land
  ]]


-- Place poles
cidades.place_poles = function(pos, radius)
	minetest.set_node({x=pos.x+radius, y=pos.y+2, z=pos.z+radius}, {name="default:fence_wood"})
	minetest.set_node({x=pos.x+radius, y=pos.y+2, z=pos.z-radius}, {name="default:fence_wood"})
	minetest.set_node({x=pos.x-radius, y=pos.y+2, z=pos.z+radius}, {name="default:fence_wood"})
	minetest.set_node({x=pos.x-radius, y=pos.y+2, z=pos.z-radius}, {name="default:fence_wood"})
end

-- Retore land
cidades.restore_land = function(pos, data)
	
	local c_air = minetest.get_content_id("air")
	local c_soil = minetest.get_content_id(data.soil_node)
	
	-- Get the vmanip mapgen object and the nodes and VoxelArea
	local vm = minetest.get_voxel_manip()
	local emin, emax = vm:read_from_map(data.minp, data.maxp)
	local vm_data = vm:get_data()
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
 
	-- Clear area
	for i in area:iter(
		data.minp.x, data.minp.y+1, data.minp.z,
		data.maxp.x, data.maxp.y, data.maxp.z
	) do
		vm_data[i] = c_air
	end
	
	-- Set soil
	for i in area:iter(
		data.minp.x, data.minp.y, data.minp.z,
		data.maxp.x, data.minp.y, data.maxp.z
	) do
		vm_data[i] = c_soil
	end
 
	-- Return the changed nodes data, fix light and change map
	vm:set_data(vm_data)
	vm:write_to_map()
	
end


