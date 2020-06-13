--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
	-- Number nodes
  ]]

local S = cidades.S

cidades.number_node = {}

for i=0, 9 do
	cidades.number_node["cidades:stone_"..i] = i
	minetest.register_node("cidades:stone_"..i, {
		description = S("Stone"),
		paramtype2 = "facedir",
		place_param2 = 0,
		tiles = {"default_stone.png"},
		is_ground_content = false,
		drop = "default:stone",
		groups = {cracky = 3, not_in_creative_inventory = 1},
		sounds = default.node_sound_stone_defaults(),
	})
end


