--[[

Mod Brazutec 1.5
Desenvolvido por BrunoMine da Comunidade Minetestbr <http://minetestbr.blogspot.com.br/>
Git de colaboração e desenvolvimento <https://github.com/BrunoMine/brazutec/>

]]--

--
-- Inicializando mod
-- 

dofile(minetest.get_modpath("brazutec").."/diretrizes.lua")
dofile(minetest.get_modpath("brazutec").."/itens.lua")
dofile(minetest.get_modpath("brazutec").."/node.lua")
dofile(minetest.get_modpath("brazutec").."/interface.lua")
dofile(minetest.get_modpath("brazutec").."/receitas.lua")

minetest.log('action',"[BRAZUTEC] carregado...")
