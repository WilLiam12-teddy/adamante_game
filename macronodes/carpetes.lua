--[[
	Mod Macronodes para Minetest
	Copyright (C) 2019 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Carpetes
  ]]

if not minetest.get_modpath("carpets") then return end

-- Modifica carpetes
local modificar_carpetes = function(nodename, def)
	def = def or {}	
	
	local override_table = {}
	
	override_table.groups = table.copy(minetest.registered_items[nodename].groups)
	override_table.groups["attached_node"] = 1
	
	if def.paramtype2 then
		override_table.paramtype2 = def.paramtype2
	end
	
	override_table.is_ground_content = false
	
	minetest.override_item(nodename, override_table)
end

-- Carpetes do mod wool
if minetest.get_modpath("wool") then
	local nodenames = {
		"carpet:wool_black",
		"carpet:wool_blue",
		"carpet:wool_brown",
		"carpet:wool_cyan",
		"carpet:wool_dark_green",
		"carpet:wool_dark_grey",
		"carpet:wool_green",
		"carpet:wool_grey",
		"carpet:wool_magenta",
		"carpet:wool_orange",
		"carpet:wool_pink",
		"carpet:wool_red",
		"carpet:wool_violet",
		"carpet:wool_white",
		"carpet:wool_yellow",
	}
	for _, nodename in ipairs(nodenames) do
		modificar_carpetes(nodename, {paramtype2 = "none"})
	end
end
