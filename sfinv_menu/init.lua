--[[
	Mod Sfinv_menu for Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	You have received a copy of the GNU Lesser 
	General Public License with this software,
	if not, see <http://www.gnu.org/licenses/>. 
	
	initializer
  ]]

-- Notify
local notify = function(msg)
	if minetest.setting_get("log_mods") then
		minetest.debug("[Sfinv_menu]"..msg)
	end
end

local modpath = minetest.get_modpath("sfinv_menu")

-- Global index
sfinv_menu = {}

-- Load scripts
notify("Loading scripts...")

dofile(modpath.."/tradutor.lua")

-- API
dofile(modpath.."/api.lua")

notify("OK")

