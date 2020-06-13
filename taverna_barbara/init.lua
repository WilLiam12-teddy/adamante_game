--[[
	Mod Taverna_Barbara para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Inicialização de scripts
	
  ]]

-- Notificador de Inicializador
local notificar = function(msg)
	if minetest.setting_get("log_mods") then
		minetest.debug("[TAVERNA BARBARA]"..msg)
	end
end

local modpath = minetest.get_modpath("taverna_barbara")

-- Variavel global
taverna_barbara = {}

-- Versao
taverna_barbara.versao = "1"

-- Plagen
taverna_barbara.plagen = dofile(modpath.."/lib/plagen.lua")

-- Tror
taverna_barbara.tror = dofile(modpath.."/lib/tror.lua")

dofile(modpath.."/tradutor.lua")

-- Carregar scripts
notificar("Carregando...")
dofile(modpath.."/diretrizes.lua")
dofile(modpath.."/protetor.lua")
dofile(modpath.."/craftitens.lua")
dofile(modpath.."/nodes.lua")
dofile(modpath.."/barman.lua")
dofile(modpath.."/trambiqueiro.lua")
dofile(modpath.."/carpete.lua")
dofile(modpath.."/mapgen.lua")
notificar("OK")
