local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

dofile(modpath.."/api.lua")

dofile(modpath.."/ceramic_aqua_verde.lua") --verde
dofile(modpath.."/ceramic_black1.lua") --preto
dofile(modpath.."/ceramic_black2.lua") --preto
dofile(modpath.."/ceramic_black3.lua") --preto
dofile(modpath.."/ceramic_marble.lua") --branco
dofile(modpath.."/ceramic_orange.lua") --laranja
dofile(modpath.."/ceramic_pink.lua") --rosa
dofile(modpath.."/ceramic_purple.lua") --violeta/purpura/roxo
dofile(modpath.."/ceramic_red.lua") --vermelho
dofile(modpath.."/ceramic_wood_flower.lua") --marrom
dofile(modpath.."/ceramic_wood_tatame.lua") --marrom
dofile(modpath.."/ceramic_yellow_leaf.lua") --amarelo/dourado

minetest.log('action',"["..modname:upper().."] Carregado!")
