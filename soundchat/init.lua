modname = minetest.get_current_modname()
modpath = minetest.get_modpath(modname)

dofile(modpath.."/api.lua")
dofile(modpath.."/commands.lua")

minetest.log('action',"["..modname:upper().."] Carregado!")
