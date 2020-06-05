local modName = minetest.get_current_modname()
local modPath = minetest.get_modpath(modName)

dofile(modPath.."/config.lua") --Precisa ser carregado antes da 'api.lua'.
dofile(modPath.."/translate.lua")
dofile(modPath.."/api.lua")
dofile(modPath.."/chatcommand.lua")
dofile(modPath.."/item_mailbox.lua")
dofile(modPath.."/item_papermail.lua")
dofile(modPath.."/item_brazutec.lua")

minetest.log('action',"["..modName:upper().."] Carregado!")
