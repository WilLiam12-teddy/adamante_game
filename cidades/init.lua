--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
  ]]

cidades = {}

cidades.money_item = (minetest.settings:get("cidades_money_item") or "default:apple")

cidades.extra_protect_side_area = tonumber(minetest.settings:get("cidades_extra_protect_side_area") or 200)
cidades.extra_protect_top_area = tonumber(minetest.settings:get("cidades_extra_protect_top_area") or 5000)
cidades.extra_protect_bottom_area = tonumber(minetest.settings:get("cidades_extra_protect_bottom_area") or 50)

cidades.max_days_inactive_owner = tonumber(minetest.settings:get("cidades_max_days_inactive_owner") or 60)

cidades.resale_factor = tonumber(minetest.settings:get("cidades_resale_factor") or 0.5)
if cidades.resale_factor > 1 then 
	cidades.resale_factor = 1
end


local modpath = minetest.get_modpath("cidades")

dofile(modpath.."/data_base.lua")
dofile(modpath.."/translator.lua")

dofile(modpath.."/exchange.lua")
dofile(modpath.."/time_count.lua")
dofile(modpath.."/protected_area.lua")
dofile(modpath.."/number_nodes.lua")
dofile(modpath.."/voxelmanip.lua")
dofile(modpath.."/land.lua")

dofile(modpath.."/city.lua")
dofile(modpath.."/city_builder.lua")

dofile(modpath.."/node_fix.lua")

dofile(modpath.."/property.lua")
dofile(modpath.."/property_builder.lua")
dofile(modpath.."/property_stone.lua")

dofile(modpath.."/teleporter.lua")

dofile(modpath.."/seller_node.lua")

dofile(modpath.."/sfinv_menu.lua")



