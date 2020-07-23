local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

dofile(modpath.."/config.lua") -- Adicionar esta linha antes da api.lua
dofile(modpath.."/api.lua")
--dofile(modpath.."/commands.lua") --Lista de comando deste mod!

minetest.log('action',"["..modname:upper().."] Carregado!")
