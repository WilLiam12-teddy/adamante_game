local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

dofile(modpath.."/api.lua")
dofile(modpath.."/fan_desk.lua")

minetest.log('action',"["..modname:upper().."] Carregado!")
