local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

dofile(modpath.."/api.lua")

minetest.log('action',"["..modname:upper().."] Carregado!")
