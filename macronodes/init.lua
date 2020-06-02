--[[
	Mod Macronodes para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Inicialização de scripts
  ]]

print(" Carregando mod macronodes... ")
dofile(minetest.get_modpath("macronodes").."/diretrizes.lua")
print("[Macronodes] Diretrizes carregadas!")
dofile(minetest.get_modpath("macronodes").."/craftitens.lua")
print("[Macronodes] Itens de Craftar carregados!")
dofile(minetest.get_modpath("macronodes").."/rosquinha.lua")
print("[Macronodes] Rosquinha de Trigo carregada!")
dofile(minetest.get_modpath("macronodes").."/punhado_farinha.lua")
print("[Macronodes] Punhado de Farinha de Trigo carregado!")
dofile(minetest.get_modpath("macronodes").."/enxofre.lua")
print("[Macronodes] Enxofre carregado!")
dofile(minetest.get_modpath("macronodes").."/garrafa_vidro.lua")
print("[Macronodes] Garrafa de Vidro carregada!")
dofile(minetest.get_modpath("macronodes").."/decor.lua")
print("[Macronodes] Decoracoes carregadas!")
dofile(minetest.get_modpath("macronodes").."/cartolina.lua")
print("[Macronodes] Cartolina carregadas!")
dofile(minetest.get_modpath("macronodes").."/carpetes.lua")
print("[Macronodes] Contador de Macros carregado!")
print("[Macronodes] OK!")


